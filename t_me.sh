#!/bin/bash
#   t_me: Simplest Message Sender for Telegram
# author: Seven.issimo <seven.issimo(at)gmail.com>

# Load configuration file within T_ME_TOKEN and T_ME_CHAT vars
source "${CONF:=/etc/t_me.rc}"

curl -s -X POST \
	 -d "chat_id=${T_ME_CHAT:?Missing Telegram CHAT_ID}" \
	 -d "disable_web_page_preview=1&parse_mode=markdown" \
	 --data-urlencode "text${1:+=}${1:-@-}" \
	 "https://api.telegram.org/bot${T_ME_TOKEN:?Missing Telegram API-TOKEN}/sendMessage" > /dev/null

# Note for my future self
# ${1:+=}	-> if $1 is defined append "="
# ${1:-@-}	-> if $1 is defined append "$1", else "@-" that means stdin
