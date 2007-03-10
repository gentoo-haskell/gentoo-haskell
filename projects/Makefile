
all : GHC-6.5-failures.html GHC-6.6-failures.html GHC-6.6-launch.html

%.html : %.rst
	rst2html.py $< $@
