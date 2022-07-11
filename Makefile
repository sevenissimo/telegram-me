PREFIX := /usr/local
BINDIR := $(PREFIX)/bin

CONFDIR := /etc
PAMDIR  := $(CONFDIR)/pam.scripts
SYSDDIR := $(CONFDIR)/systemd/system

default:

install:
	install -Dm 755 t_me.sh $(DESTDIR)$(BINDIR)/t_me
	install -Dm 644 --backup=simple -t $(DESTDIR)$(CONFDIR) t_me.rc

install-pam:
	install -Dm 755 -t $(DESTDIR)$(PAMDIR) pam/pam_t_me.sh
	@echo -e "Please edit PAM Policy of interest to include follow:\n\
	session optional pam_exec.so $(PAMDIR)/pam_t_me.sh"

install-systemd:
	install -Dm 755 -t $(DESTDIR)$(BINDIR) systemd/systemd-report-t_me.sh
	install -Dm 644 -t $(DESTDIR)$(SYSDDIR) systemd/report-t_me@.service
	@echo -e "Please edit Systemd Units of interest to include follow:\n\
	[Unit] ... OnFailure=report-t_me@%n.service"

uninstall:
	-$(RM) $(DESTDIR)$(BINDIR)/t_me
	-$(RM) $(DESTDIR)$(PAMDIR)/pam_t_me.sh
	-$(RM) $(DESTDIR)$(BINDIR)/systemd-report-t_me.sh
	-$(RM) $(DESTDIR)$(SYSDDIR)/report-t_me@.service

.PHONY: install install-pam install-systemd uninstall
