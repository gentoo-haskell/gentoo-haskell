CATEGORIES:=$(wildcard *-*)
EBUILDS:=$(wildcard *-*/*)
MANIFESTS:=$(addsuffix /Manifest, $(EBUILDS))
FILESDIR:=$(addsuffix /files, $(EBUILDS))

all: ${FILESDIR} ${MANIFESTS} profiles/categories

%/files:
	mkdir -p $@

%/Manifest: %/*.ebuild
	$(foreach file,$?,ebuild $(file) digest;)

profiles/categories: ${CATEGORIES}
	echo -e $(addprefix '\n', ${CATEGORIES}) > $@
