#!/bin/bash

result=$(ps ax|grep -v grep|grep trayer)
if [ "$result" == "" ]; then
  eval  "trayer                 \
    --transparent   true        \
    --expand        false       \
    --padding       10          \
    --iconspacing   5           \
    --margin        10          \
    --align         right       \
    --edge          top         \
    --distance      5           \
    --distancefrom  top         \
    --widthtype     percent     \
    --width         20          \
    --SetDockType   false       \
    --tint          0x88888888  &"
else
  eval "killall trayer"
fi
