## This file is for redundant-use flag checking in Gentoo Portage.


# Accumulates flags in the associative array named by ${1}.
accumulate() {
	declare -Ag ${1?}
	local -n var=${1} ; shift
	local flag ; for flag in "${@}" ; do
		case ${flag} in
			'-*') var=( ['*']=0 ) ;;
			-*) var[${flag:1}]=0 ;;
			*) var[${flag}]=1 ;;
		esac
	done
}

# Outputs a pre-order traversal of profile dirs starting at ${1}.
collect_profile_dirs() {
	local dir ; for dir in "${@}" ; do
		dir=$(readlink -e -- "${dir}")
		if [[ -s ${dir}/parent ]] ; then
			local parent ; while read -r parent ; do
				collect_profile_dirs "${dir}/${parent}"
			done < "${dir}/parent"
		fi
		echo "${dir}"
	done
}

# Outputs a pre-order traversal of active profile files named in ${@}.
collect_profile_files() {
	local -a dirs ; mapfile -t dirs <<< "$(collect_profile_dirs "${PORTAGE_CONFIGROOT%/}/etc/portage/"{make.,}profile)"
	local file ; for file in "${@}" ; do
		local dir ; for dir in "${dirs[@]}" ; do
			[[ -e ${dir}/${file} ]] && echo "${dir}/${file}"
		done
	done
}

# Parses and splits a package atom into its constituent components.
#
# split_atom '>=dev-lang/python-3.4.3-r7:3.4/3.4m::gentoo'
#	OP='>='
#	CATEGORY=dev-lang
#	PF=python-3.4.3-r7
#	P=python-3.4.3
#	PN=python
#	PV=3.4.3
#	PVR=3.4.3-r7
#	PR=r7
#	SLOT=3.4
#	SUBSLOT=3.4m
#	REPO=gentoo
split_atom() {
	PF=${1?}
	case ${PF} in
		'>='*) OP='>=' ; PF=${PF#'>='} ;;
		'>'*) OP='>' ; PF=${PF#'>'} ;;
		'~'*) OP='~' ; PF=${PF#'~'} ;;
		'='*) OP='=' ; PF=${PF#'='} ;;
		'<='*) OP='<=' ; PF=${PF#'<='} ;;
		'<'*) OP='<' ; PF=${PF#'<'} ;;
		*) OP= ;;
	esac
	if [[ ${PF} == *::* ]] ; then
		REPO=${PF##*::} ; PF=${PF%::*}
	else
		REPO=
	fi
	if [[ ${PF} == *:* ]] ; then
		SLOT=${PF##*:} ; PF=${PF%:*}
		if [[ ${SLOT} == */* ]] ; then
			SUBSLOT=${SLOT#*/} ; SLOT=${SLOT%%/*}
		else
			SUBSLOT=
		fi
	else
		SLOT= ; SUBSLOT=
	fi
	if [[ ${PF} == */* ]] ; then
		CATEGORY=${PF%/*} ; PF=${PF##*/}
	else
		CATEGORY=
	fi
	PR=${PF##*-}
	if [[ ${PR} == r[0-9]* ]] ; then
		P=${PF%-*} ; PVR=${PR}
	else
		PR=r0 ; P=${PF} ; PVR=
	fi
	PV=${P##*-}
	if [[ ${PV} == [0-9]* ]] ; then
		PN=${P%-*}
	else
		PV= ; PR= ; PN=${P}
	fi
	PVR=${PV}${PVR:+-${PVR}}
}

# Compares two versions according to PMS rules. Outputs -1, 0, or 1.
compare_versions() {
	local shopt=$(shopt -p extglob) ; shopt -s extglob
	local v1=${1?} v2=${2?} r1 r2 p1 p2 ret=0
	while [[ ${v1} || ${v2} ]] ; do
		r1=${v1##*([[:digit:]])} ; p1=${v1%${r1}}
		r2=${v2##*([[:digit:]])} ; p2=${v2%${r2}}
		if [[ ${p1} == 0* || ${p2} == 0* ]] ; then
			p1=${p1%%*(0)} ; p2=${p2%%*(0)}
			if [[ ${p1} > ${p2} ]] ; then
				ret=1 ; break
			elif [[ ${p1} < ${p2} ]] ; then
				ret=-1 ; break
			fi
		else
			if (( p1 > p2 )) ; then
				ret=1 ; break
			elif (( p1 < p2 )) ; then
				ret=-1 ; break
			fi
		fi
		v1=${r1##*([[:alpha:][:punct:]])} ; p1=${r1%${v1}}
		v2=${r2##*([[:alpha:][:punct:]])} ; p2=${r2%${v2}}
		case ${p1} in
			_alpha) p1='!0' ;; _beta) p1='!1' ;; _pre) p1='!2' ;; _rc) p1='!3' ;;
		esac
		case ${p2} in
			_alpha) p2='!0' ;; _beta) p2='!1' ;; _pre) p2='!2' ;; _rc) p2='!3' ;;
		esac
		[[ ! ${p1} && ${p2} == '!'* ]] && p1='!9'
		[[ ! ${p2} && ${p1} == '!'* ]] && p2='!9'
		if [[ ${p1} > ${p2} ]] ; then
			ret=1 ; break
		elif [[ ${p1} < ${p2} ]] ; then
			ret=-1 ; break
		fi
	done
	echo "${ret}"
	eval "${shopt}"
}

# Returns whether package atom ${2} is a subset of package atom ${1}.
atom_matches() {
	local atom1=${1?} atom2=${2?} OP CATEGORY PF P PN PV PVR_ PVR PR SLOT SUBSLOT REPO
	split_atom "${atom1}" ; PV=${PV%'*'} ; PVR_=${PVR} ; PVR=${PVR%'*'}
	local OP1=${OP} CATEGORY1=${CATEGORY} PN1=${PN} PV1=${PV} PVR1_=${PVR_} PVR1=${PVR} SLOT1=${SLOT} SUBSLOT1=${SUBSLOT} REPO1=${REPO}
	split_atom "${atom2}" ; PV=${PV%'*'} ; PVR_=${PVR} ; PVR=${PVR%'*'}
	[[ ( ${CATEGORY} == '*' || ${CATEGORY1} == '*' || ${CATEGORY} == ${CATEGORY1} ) &&
			( ${PN} == '*' || ${PN1} == '*' || ${PN} == ${PN1} ) &&
			( ! ${SLOT1} || ${SLOT:-0} == ${SLOT1} ) && ( ! ${SUBSLOT1} || ${SUBSLOT:-0} == ${SUBSLOT1} ) &&
			( ! ${REPO1} || ${REPO} == ${REPO1} ) ]] || return
	if [[ ${OP1} == '' ]] ; then
		return
	elif [[ ${OP1} == '~' ]] ; then
		[[ ${OP} == @(''|'~'|'=') ]] && (( $(compare_versions "${PV}" "${PV1}") == 0 )) ; return
	elif [[ ${OP1} == '=' && ${PVR1_} == *'*' ]] ; then
		[[ ${OP} == @(''|'~'|'=') ]] && [[ ${PVR} == ${PVR1}* ]] ; return
	fi
	local cmp=$(compare_versions "${PVR}" "${PVR1}")
	case ${OP1} in
		'>=') (( cmp >= 0 )) && [[ ${OP} == @(''|'>='|'>'|'~'|'=') ]] ;;
		'>') (( cmp > 0 )) && [[ ${OP} == @(''|'>='|'>'|'~'|'=') ]] || { (( cmp == 0 )) && [[ ${OP} == '>' ]] ; } ;;
		'=') (( cmp == 0 )) && [[ ${OP} == @(''|'=') && ${PVR_} != *'*' ]] ;;
		'<=') (( cmp <= 0 )) && [[ ${OP} == @(''|'<='|'<'|'~'|'=') ]] ;;
		'<') (( cmp < 0 )) && [[ ${OP} == @(''|'<='|'<'|'~'|'=') ]] || { (( cmp == 0 )) && [[ ${OP} == '<' ]] ; } ;;
	esac
}
