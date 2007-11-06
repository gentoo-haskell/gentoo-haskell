CATEGORIES:=$(wildcard *-*)
EBUILDS:=$(wildcard *-*/*)
MANIFESTS:=$(addsuffix /Manifest, $(EBUILDS))

all: ${MANIFESTS} profiles/categories

%/Manifest: %/*.ebuild %/files/*
	ebuild $(firstword $(wildcard $(dir $@)*.ebuild)) digest

profiles/categories: ${CATEGORIES}
	echo -e $(addprefix '\n', ${CATEGORIES}) > $@
