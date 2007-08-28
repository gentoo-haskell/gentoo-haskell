CATEGORIES:=$(wildcard *-*)
EBUILDS:=$(wildcard *-*/*)
MANIFESTS:=$(addsuffix /Manifest, $(EBUILDS))

all: ${MANIFESTS} profiles/categories

%/Manifest: %/*.ebuild
	$(foreach file,$?,ebuild $(file) digest;)

profiles/categories: ${CATEGORIES}
	echo -e $(addprefix '\n', ${CATEGORIES}) > $@
