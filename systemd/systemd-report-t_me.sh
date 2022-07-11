#!/bin/bash

: ${MONITOR_UNIT:=${1:?'Missing operand'}}

t_me << EOF
*⚠️ Systemd Unit Failure on $HOSTNAME*
Unit: $MONITOR_UNIT
${MONITOR_SERVICE_RESULT:+Result: $MONITOR_SERVICE_RESULT${MONITOR_EXIT_CODE:+ / $MONITOR_EXIT_CODE ($MONITOR_EXIT_STATUS)}
}Date: $(date)
EOF

# https://www.freedesktop.org/software/systemd/man/systemd.exec.html#%24MONITOR_SERVICE_RESULT
