# T_me - Telegram me

t_me is primary a Bash script to send/forward notifications to system's admin through a Telegram bot.

# Installation
A Makefile with install target(s) is provvided.

# Configuration
At today state initial configuration is pretty manual:
you need to create your own Telegram bot using @botfather bot and get an API Token.

Then use `curl -s -G https://api.telegram.org/bot${token}/getUpdates` to get your `chat_id`

Place both values in /etc/t_me.rc to work system-wide (remeber: PAM and Systemd runs as _root_ or _nobody_).
If you respect `: ${var:=val} syntax`, these values can be overridden by environment/session/local variables.

# Usage
You can send to yourself (or system admin) whatever text you want.
```
$ t_me "Hello World!"
$ echo "Hello World!" | t_me
```
t_me is designed to accept text input as first argument or through stdin.

# Extras

## PAM
t_me could be particularly useful for reporting logins (attempted / successful / failed) to system administrator.
To achieve this, PAM is used with appropriate configuration in conjunction with a script that invokes t_me with further details.

Makefile provides `install-pam` target for PAM-helper script. Configuration is manual.
You just need to edit PAM Policy of your interest to include follow:
```
session optional pam_exec.so /etc/pam.scripts/pam_t_me.sh"
```

TODO insert example.

## Systemd
t_me could also be usefull for reporting Systemd Unit failure (or success) to system admin.
To achieve this, Systemd Unit `OnFailure=` (or `OnSuccess=`) attribute is used.
But, as long as `OnFailure=` starts another Systemd Unit (not a command!) a reusable Systemd Service is provided alognside a script.

Makefile provides a `install-systemd` target.
After installation, you need to edit each Systemd Unit(s) of your interest, to include follow:
```
[Unit]
OnFailure=report-t_me@%n.service
```
Please note `[Unit]` section.

Since Systemd 251 some [variables](https://www.freedesktop.org/software/systemd/man/systemd.exec.html#%24MONITOR_SERVICE_RESULT) are passed to triggered service.
By now, the script will report these variables.

---
Original idea comes from [here](https://northernlightlabs.se/2014-07-05/systemd-status-mail-on-unit-failure.html).
