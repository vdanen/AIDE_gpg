VERSION = 1.0
PACKAGE = aide+gpg

clean:
	-find . -name '*~' | xargs rm -f
	rm -f *.bz2
	rm -rf $(PACKAGE)-$(VERSION)

dist: clean changelog
	find . -not -name '*.bz2'|cpio -pd $(PACKAGE)-$(VERSION)/
	find $(PACKAGE)-$(VERSION) -type d -name .svn|xargs rm -rf 
	tar cfj $(PACKAGE)-$(VERSION).tar.bz2 $(PACKAGE)-$(VERSION)
	rm -rf $(PACKAGE)-$(VERSION)

changelog:
	svn update
	svn2cl --authors=../../common/trunk/username.xml
