VERSION = 1.0.4
PACKAGE = aide+gpg

MANPAGES = aideinit.8
SCRIPTS = aideinit aidecheck aideupdate aide-edit-conf

PREFIX = 
MANDIR = /usr/share/man
SBINDIR = /usr/sbin

FILES = Makefile AUTHORS COPYING ChangeLog $(SCRIPTS) $(MANPAGES)

dist: clean changelog
	mkdir -p $(PACKAGE)-$(VERSION)
	for file in $(FILES); do \
	cp -p $$file $(PACKAGE)-$(VERSION)/ ; \
	done
	find $(PACKAGE)-$(VERSION) -type d -name .svn | xargs rm -rf
	for file in $(SCRIPTS); do \
	sed -e 's|@pkg_version@|$(VERSION)|g' $$file >$(PACKAGE)-$(VERSION)/$$file ; \
	done
	tar cfj $(PACKAGE)-$(VERSION).tar.bz2 $(PACKAGE)-$(VERSION)
	rm -rf $(PACKAGE)-$(VERSION)

clean:
	-find . -name '*~' | xargs rm -f
	rm -f *.bz2
	rm -f ChangeLog
	rm -rf $(PACKAGE)-$(VERSION)

changelog:
	svn update
	svn2cl --authors=../../common/trunk/username.xml

install:
	mkdir -p $(PREFIX)/$(SBINDIR)
	mkdir -p $(PREFIX)/$(MANDIR)/man8
	for script in $(SCRIPTS); do \
		install -m 0750 $$script $(PREFIX)$(SBINDIR); \
	done
	for manpage in $(MANPAGES); do \
		install -m 0644 $$manpage $(PREFIX)$(MANDIR)/man8; \
	done
