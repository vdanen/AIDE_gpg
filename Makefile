VERSION = 1.0
PACKAGE = aide+gpg

MANPAGES = aideinit.8
SCRIPTS = aideinit aidecheck aideupdate

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
	sed -e 's|@pkg_version@|$(VERSION)|g' aidecheck >$(PACKAGE)-$(VERSION)/aidecheck
	tar cfj $(PACKAGE)-$(VERSION).tar.bz2 $(PACKAGE)-$(VERSION)
	rm -rf $(PACKAGE)-$(VERSION)

clean:
	-find . -name '*~' | xargs rm -f
	rm -f *.bz2
	rm -rf $(PACKAGE)-$(VERSION)

changelog:
	svn update
	svn2cl --authors=../../common/trunk/username.xml

install:
	for script in $(SCRIPTS); do \
	cp -p $$script $(PREFIX)$(SBINDIR)/ ; \
	done
	for manpage in $(MANPAGES); do \
	cp -p $$manpage $(PREFIX)$(MANDIR)/man8/ ; \
	done
