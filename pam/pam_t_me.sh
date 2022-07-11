#!/bin/bash

case $PAM_TYPE in
	 auth ) PAM_ACTION="⚠️ Login attempt️";;
	 open*) PAM_ACTION="✅ Successful login";;
	     *) exit 0;;
esac

t_me << EOF
${PAM_ACTION:-PAM $PAM_TYPE} on $HOSTNAME [$PAM_SERVICE]
${PAM_USER:+User: $PAM_USER
}${PAM_RHOST:+Host: $PAM_RHOST
}Date: $(date)
EOF
