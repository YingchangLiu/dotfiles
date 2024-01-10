https://web.archive.org/web/20190207210108/http://stevelorek.com/how-to-shrink-a-git-repository.html

How to Shrink a Git Repository
如何收缩 Git 存储库

Our main Git repository had suddenly ballooned in size. It had grown overnight to 180MB (compressed) and was taking forever to clone.
我们的主要 Git 存储库的大小突然膨胀了。它在一夜之间增长到 180MB（压缩），并且需要很长时间才能克隆。

The reason was obvious; somebody, somewhere, somewhen, somehow, had committed some massive files. But we had no idea what those files where.
原因很明显;有人，在某个地方，在某个时间，以某种方式，提交了一些大量文件。但我们不知道这些文件在哪里。

After a few hours of trial, error and research, I was able to nail down a process to:
经过几个小时的试验、错误和研究，我能够确定一个流程：

    Discover the large files
    发现大文件
    Clean them from the repository
    从存储库中清除它们
    Modify the remote (GitHub) repository so that the files are never downloaded again
    修改远程 （GitHub） 存储库，以便不再下载文件

This process should never be attempted unless you can guarantee that all team members can produce a fresh clone. It involves altering the history and requires anyone who is contributing to the repository to pull down the newly cleaned repository before they push anything to it.
除非您可以保证所有团队成员都可以生成新的克隆，否则不应尝试此过程。它涉及更改历史记录，并要求任何为存储库做出贡献的人在将任何内容推送到存储库之前拉下新清理的存储库。
Deep Clone the Repository
深度克隆存储库

If you don't already have a local clone of the repository in question, create one now:
如果您还没有相关存储库的本地克隆，请立即创建一个：

$ git clone remote-url

Now—you may have cloned the repository, but you don't have all of the remote branches. This is imperative to ensure a proper 'deep clean'. To do this, we'll need a little Bash script:
现在，您可能已经克隆了存储库，但您没有所有远程分支。这对于确保适当的“深度清洁”至关重要。为此，我们需要一个小的 Bash 脚本：

#!/bin/bash
for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
    git branch --track ${branch##*/} $branch
done

Thanks to bigfish on StackOverflow for this script, which is copied verbatim.
感谢 StackOverflow 上的 bigfish 提供的这个脚本，它是逐字复制的。

Copy this code into a file, chmod +x filename.sh, and then execute it with ./filename.sh. You will now have all of the remote branches as well (it's a shame Git doesn't provide this functionality).
将此代码复制到文件中， chmod +x filename.sh 然后使用 ./filename.sh 执行它。您现在也将拥有所有远程分支（很遗憾 Git 不提供此功能）。
Discovering the large files
发现大文件

Credit is due to Antony Stubbs here - his Bash script identifies the largest files in a local Git repository, and is reproduced verbatim below:
这里要感谢 Antony Stubbs - 他的 Bash 脚本标识了本地 Git 存储库中最大的文件，并在下面逐字复制：

#!/bin/bash
#set -x 

# Shows you the largest objects in your repo's pack file.
# Written for osx.
#
# @see http://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-pack-objects-and-trim-your-waist-line/
# @author Antony Stubbs

# set the internal field spereator to line break, so that we can iterate easily over the verify-pack output
IFS=$'\n';

# list all objects including their size, sort by size, take top 10
objects=`git verify-pack -v .git/objects/pack/pack-*.idx | grep -v chain | sort -k3nr | head`

echo "All sizes are in kB. The pack column is the size of the object, compressed, inside the pack file."

output="size,pack,SHA,location"
for y in $objects
do
	# extract the size in bytes
	size=$((`echo $y | cut -f 5 -d ' '`/1024))
	# extract the compressed size in bytes
	compressedSize=$((`echo $y | cut -f 6 -d ' '`/1024))
	# extract the SHA
	sha=`echo $y | cut -f 1 -d ' '`
	# find the objects location in the repository tree
	other=`git rev-list --all --objects | grep $sha`
	#lineBreak=`echo -e "\n"`
	output="${output}\n${size},${compressedSize},${other}"
done

echo -e $output | column -t -s ', '

Execute this script as before, and you'll see some output similar to the below:
像以前一样执行此脚本，你将看到类似于下面的一些输出：

All sizes are in kB. The pack column is the size of the object, compressed, inside the pack file.
size     pack    SHA                                       location
1111686  132987  a561d25105c79aa4921fb742745de0e791483afa  08-05-2012.sql
5002     392     e501b79448b9e970ab89b048b3218c2853fdfc88  foo.sql
266      249     73fa731bb90b04dcf79eeea8fdd637ba7df4c089  app/assets/images/fw/iphone.fw.png
265      43      939b31c563bd40b1ca70e4f4a9f7d67c27c936c0  doc/models_complete.svg
247      39      03514d9e84418573f26b205bae7e4e57057c036f  unprocessed_email_replies.sql
193      49      6e601c4067aaddb26991c4bd5fbddef003800e70  public/assets/jquery-ui.min-0424e108178defa1cc794ee24fc92d24.js
178      30      c014b20b6fed9f17a0b2809ac410d74f291da26e  foo.sql
158      158     15f9e56bc0865f4f303deff053e21909661a716b  app/assets/images/iphone.png
103      36      3135e15c5cec75a4c85a0636b154b83221020c97  public/assets/application-c65733a4a64a1a885b1c32694574b12a.js
99       85      c1c80bc4c09e692d5e2127e39c87ecacdb1e816f  app/assets/images/fw/lovethis_logo_sprint.fw.png

Yep - looks like someone has been pushing some rather unnecessary files somewhere! Including a lovely 1.1GB present in the form of a SQL dump file.
是的 - 看起来有人一直在将一些相当不必要的文件推送到某个地方！包括一个可爱的 1.1GB，以 SQL 转储文件的形式呈现。
Cleaning the files 清理文件

Cleaning the file will take a while, depending on how busy your repository has been. You just need one command to begin the process:
清理文件需要一段时间，具体取决于存储库的繁忙程度。您只需要一个命令即可开始该过程：

$ git filter-branch --tag-name-filter cat --index-filter 'git rm -r --cached --ignore-unmatch filename' --prune-empty -f -- --all

This command is adapted from other sources—the principal addition is --tag-name-filter cat which ensures tags are rewritten as well.
此命令改编自其他来源，主要添加的内容是 --tag-name-filter cat 确保标记也被重写。

After this command has finished executing, your repository should now be cleaned, with all branches and tags in tact.
此命令执行完毕后，您的存储库现在应该被清理干净，所有分支和标签都处于正常状态。
Reclaim space 回收空间

While we may have rewritten the history of the repository, those files still exist in there, stealing disk space and generally making a nuisance of themselves. Let's nuke the bastards:
虽然我们可能已经重写了存储库的历史记录，但这些文件仍然存在于其中，窃取磁盘空间并通常会给自己带来麻烦。让我们用核武器对付这些混蛋：

$ rm -rf .git/refs/original/

$ git reflog expire --expire=now --all

$ git gc --prune=now

$ git gc --aggressive --prune=now

Now we have a fresh, clean repository. In my case, it went from 180MB to 7MB.
现在我们有了一个全新、干净的存储库。就我而言，它从 180MB 增加到 7MB。
Push the cleaned repository
推送已清理的存储库

Now we need to push the changes back to the remote repository, so that nobody else will suffer the pain of a 180MB download.
现在我们需要将更改推送回远程存储库，这样其他人就不会遭受 180MB 下载的痛苦。

$ git push origin --force --all

The --all argument pushes all your branches as well. That's why we needed to clone them at the start of the process.
该 --all 参数也会推送您的所有分支。这就是为什么我们需要在流程开始时克隆它们。

Then push the newly-rewritten tags:
然后推送新重写的标签：

$ git push origin --force --tags

Tell your teammates 告诉你的队友

Anyone else with a local clone of the repository will need to either use git rebase, or create a fresh clone, otherwise when they push again, those files are going to get pushed along with it and the repository will be reset to the state it was in before.
拥有存储库本地克隆的任何其他人都需要使用 git rebase 或创建一个新的克隆，否则当他们再次推送时，这些文件将随之推送，并且存储库将重置为以前的状态。
