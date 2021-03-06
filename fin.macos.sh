#!/bin/bash

#
#       fin - a macos finale for bash 
#
# options:
#   -t|--title: title (default 'done')
#   -m[Z]|--message[-nonzero] : message to print [only when return code is non-zero]
#   -s[Z]|--sticky[-nonzero] : stick. [only when return code is non-zero]
#

# compute elapsed time if $PPREV_SECONDS is set (this works with timed)
if [ x"$PPREV_SECONDS" != "x" ]; then
    PPREV=$PPREV_SECONDS
    CURRENT=$(date "+%s")
    elapsed=$((CURRENT-PPREV))
fi

function usage {
    echo "usage: fin exitcode [options]"
    echo ""
    echo "options:"
    echo "    -t|--title                : title (default 'done')"
    echo "    -m[Z]|--message[-nonzero] : message to print [only when return code is non-zero]"
    echo "    -s[Z]|--sticky[-nonzero]  : stick. [only when return code is non-zero]"
    echo ""
}

GROWL="/usr/local/bin/growlnotify"
NOTIFY="$GROWL"
#osascript -e 'display notification "Notification text" with title "Title"'

# usage
if [ $# -lt 1 ]; then
    usage
    exit 1
fi

result_passed=$1
shift

msg=''
msg_on_nonzero=''
title="done"
sticky=''
stick_on_nonzero=0


# parse argument 
while [ "$#" -gt "0" ]; do
    case $1 in
        -m|--message)
            [ $# -ge 2 ] || return 2
            shift
            msg=$1
            ;;
        -mZ|--message-nonzero)
            [ $# -ge 2 ] || return 2
            shift
            msg_on_nonzero=$1
            ;;
        -t|--title)
            [ $# -ge 2 ] || return 2
            shift
            title=$1
            ;;
        -s|--sticky)
            sticky=$1
            ;;
        -sZ|--sticky-nonzero)
            stick_on_nonzero=1
    esac
    shift
done


function default_message() {
    local _msg='job finished'

    # add smilely if exit with zero.
    if [ $result_passed -ne 0 ]; then 
        _msg="${_msg} with status $result_passed"
    else
        _msg="${_msg} :)"
    fi

    if [ x"$elapsed" != "x" ]; then
        _msg="${_msg} - ${elapsed} s"
    fi

    echo $_msg
}

# message
if [ x"$msg" == "x" ]; then
	msg=$(default_message)
fi
if [ x"$msg_on_nonzero" != "x" ]; then
    if [ $result_passed -ne 0 ]; then
        msg="$msg_on_nonzero [$result_passed]"
    fi
fi

# sticky
if [ $stick_on_nonzero -eq 1 ]; then
    if [ $result_passed -ne 0 ]; then
        sticky="-s"
    else
        sticky=""
    fi
fi

# add ! to title if sticky
if [ x"$sticky" != "x" ]; then
    title="${title} [!]"
fi

# notify
#echo $GROWL -t "\"${title}\"" -m "\"${msg}\"" "$sticky"
#$GROWL -t "${title}" -m "${msg}" "$sticky"
echo osascript -e "display notification \"${msg}\" with title \"${title}\""
osascript -e "display notification \"${msg}\" with title \"${title}\""

# return
exit $result_passed

