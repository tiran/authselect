if HAVE_MANPAGES
BUILT_SOURCES = \
    build_manpages \
    $(NULL)

man_MANS = \
    authselect.8 \
    authselect-profiles.5 \
    authselect-migration.7 \
    $(NULL)

build_manpages:
	./build.sh $(prefix) $(exec_prefix)

.PHONY: expand_files

clean-local:
	for FILE in $(man_MANS) ; do \
		$(RM) $$FILE $$FILE.txt ; \
	done
endif