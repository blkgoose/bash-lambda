#!/usr/bin/env bash

function lambda {
    local input=$@
    read pipeinput

    local arg=${input%:*}
    local arg=${arg%% *}
    local body=${input#*:}

    #TODO: use lambda pattern as hash,
    # if it exists use existing function
    # instead of polluting the environement
    local uid=$(for i in {1..10}; do echo -n $RANDOM; done)

    local function_name="lambda-${uid}"

    eval "
        IFS=\$'\n'
        function ${function_name} {
            $arg=\"\${1}\"
            $body
        }
    "

    type ${function_name} >&2

    ${function_name} ${pipeinput}

    unset pipeinput
}
