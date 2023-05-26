:PostID: 149
:Title: How to deal with portage blockers
:Keywords: gentoo, haskell, portage, blocker
:Categories: notes

TL;DR:
======

- use ``--autounmask=n``
- use ``--backtrack=1000`` (or more)
- ``package.mask`` all outdated packages that cause conflicts (usually requires more iterations)
- run world update

The problem
===========

Occasionally (more frequently on haskel packages) ``portage``
starts taking long time to only tell you it was not able to
figure out the upgrade path.

Some people suggest "wipe-blockers-and-reinstall" solution.
This post will try to explain how to actually upgrade (or
find out why it's not possible) without actually destroying
your system.

Real-world example
==================

I'll take a real-world example in Gentoo's bugzilla: `bug 579520 <https://bugs.gentoo.org/579520>`_
where original upgrade error looked like that:

::

    !!! Multiple package instances within a single package slot have been pulled
    !!! into the dependency graph, resulting in a slot conflict:
    
    x11-libs/gtk+:3
    
      (x11-libs/gtk+-3.18.7:3/3::gentoo, ebuild scheduled for merge) pulled in by
        (no parents that aren't satisfied by other packages in this slot)
    
      (x11-libs/gtk+-3.20.0:3/3::gnome, installed) pulled in by
        >=x11-libs/gtk+-3.19.12:3[introspection?] required by (gnome-base/nautilus-3.20.0:0/0::gnome, installed)
        ^^              ^^^^^^^^^
        >=x11-libs/gtk+-3.20.0:3[cups?] required by (gnome-base/gnome-core-libs-3.20.0:3.0/3.0::gnome, installed)
        ^^              ^^^^^^^^
        >=x11-libs/gtk+-3.19.4:3[introspection?] required by (media-video/totem-3.20.0:0/0::gnome, ebuild scheduled for merge)
        ^^              ^^^^^^^^
        >=x11-libs/gtk+-3.19.0:3[introspection?] required by (app-editors/gedit-3.20.0:0/0::gnome, ebuild scheduled for merge)
        ^^              ^^^^^^^^
        >=x11-libs/gtk+-3.19.5:3 required by (gnome-base/dconf-editor-3.20.0:0/0::gnome, ebuild scheduled for merge)
        ^^              ^^^^^^^^
        >=x11-libs/gtk+-3.19.6:3[introspection?] required by (x11-libs/gtksourceview-3.20.0:3.0/3::gnome, ebuild scheduled for merge)
        ^^              ^^^^^^^^
        >=x11-libs/gtk+-3.19.3:3[introspection,X] required by (media-gfx/eog-3.20.0:1/1::gnome, ebuild scheduled for merge)
        ^^              ^^^^^^^^
        >=x11-libs/gtk+-3.19.8:3[X,introspection?] required by (x11-wm/mutter-3.20.0:0/0::gnome, installed)
        ^^              ^^^^^^^^
        >=x11-libs/gtk+-3.19.12:3[X,wayland?] required by (gnome-base/gnome-control-center-3.20.0:2/2::gnome, installed)
        ^^              ^^^^^^^^^
        >=x11-libs/gtk+-3.19.11:3[introspection?] required by (app-text/gspell-1.0.0:0/0::gnome, ebuild scheduled for merge)
        ^^              ^^^^^^^^^
    
    x11-base/xorg-server:0
    
      (x11-base/xorg-server-1.18.3:0/1.18.3::gentoo, installed) pulled in by
        x11-base/xorg-server:0/1.18.3= required by (x11-drivers/xf86-video-nouveau-1.0.12:0/0::gentoo, installed)
                            ^^^^^^^^^^
        x11-base/xorg-server:0/1.18.3= required by (x11-drivers/xf86-video-fbdev-0.4.4:0/0::gentoo, installed)
                            ^^^^^^^^^^
        x11-base/xorg-server:0/1.18.3= required by (x11-drivers/xf86-input-evdev-2.10.1:0/0::gentoo, installed)
                            ^^^^^^^^^^
    
      (x11-base/xorg-server-1.18.2:0/1.18.2::gentoo, ebuild scheduled for merge) pulled in by
        x11-base/xorg-server:0/1.18.2= required by (x11-drivers/xf86-video-vesa-2.3.4:0/0::gentoo, installed)
                            ^^^^^^^^^^
        x11-base/xorg-server:0/1.18.2= required by (x11-drivers/xf86-input-synaptics-1.8.2:0/0::gentoo, installed)
                            ^^^^^^^^^^
        x11-base/xorg-server:0/1.18.2= required by (x11-drivers/xf86-input-mouse-1.9.1:0/0::gentoo, installed)
                            ^^^^^^^^^^
    
    app-text/poppler:0
    
      (app-text/poppler-0.32.0:0/51::gentoo, ebuild scheduled for merge) pulled in by
        >=app-text/poppler-0.32:0/51=[cxx,jpeg,lcms,tiff,xpdf-headers(+)] required by (net-print/cups-filters-1.5.0:0/0::gentoo, installed)
                               ^^^^^^
        >=app-text/poppler-0.16:0/51=[cxx] required by (app-office/libreoffice-5.0.5.2:0/0::gentoo, installed)
                               ^^^^^^
        >=app-text/poppler-0.12.3-r3:0/51= required by (app-text/texlive-core-2014-r4:0/0::gentoo, installed)
                                    ^^^^^^
    
      (app-text/poppler-0.42.0:0/59::gentoo, ebuild scheduled for merge) pulled in by
        >=app-text/poppler-0.33[cairo] required by (app-text/evince-3.20.0:0/evd3.4-evv3.3::gnome, ebuild scheduled for merge)
        ^^                 ^^^^
    
    net-fs/samba:0
    
      (net-fs/samba-4.2.9:0/0::gentoo, installed) pulled in by
        (no parents that aren't satisfied by other packages in this slot)
    
      (net-fs/samba-3.6.25:0/0::gentoo, ebuild scheduled for merge) pulled in by
        net-fs/samba[smbclient] required by (media-sound/xmms2-0.8-r2:0/0::gentoo, ebuild scheduled for merge)
                     ^^^^^^^^^
    
    
    It may be possible to solve this problem by using package.mask to
    prevent one of those packages from being selected. However, it is also
    possible that conflicting dependencies exist such that they are
    impossible to satisfy simultaneously.  If such a conflict exists in
    the dependencies of two different packages, then those packages can
    not be installed simultaneously.
    
    For more information, see MASKED PACKAGES section in the emerge man
    page or refer to the Gentoo Handbook.
    
    
    emerge: there are no ebuilds to satisfy ">=dev-libs/boost-1.55:0/1.57.0=".
    (dependency required by "app-office/libreoffice-5.0.5.2::gentoo" [installed])
    (dependency required by "@selected" [set])
    (dependency required by "@world" [argument])

A lot of text! Let's trim it down to essential detail first (AKA
how to actually read it). I've dropped the "cause" of conflcts
from previous listing and left only problematic packages:

::

    !!! Multiple package instances within a single package slot have been pulled
    !!! into the dependency graph, resulting in a slot conflict:
    
    x11-libs/gtk+:3
      (x11-libs/gtk+-3.18.7:3/3::gentoo, ebuild scheduled for merge) pulled in by
      (x11-libs/gtk+-3.20.0:3/3::gnome, installed) pulled in by
    
    x11-base/xorg-server:0
      (x11-base/xorg-server-1.18.3:0/1.18.3::gentoo, installed) pulled in by
      (x11-base/xorg-server-1.18.2:0/1.18.2::gentoo, ebuild scheduled for merge) pulled in by
    
    app-text/poppler:0
      (app-text/poppler-0.32.0:0/51::gentoo, ebuild scheduled for merge) pulled in by
      (app-text/poppler-0.42.0:0/59::gentoo, ebuild scheduled for merge) pulled in by
    
    net-fs/samba:0
      (net-fs/samba-4.2.9:0/0::gentoo, installed) pulled in by
      (net-fs/samba-3.6.25:0/0::gentoo, ebuild scheduled for merge) pulled in by

    emerge: there are no ebuilds to satisfy ">=dev-libs/boost-1.55:0/1.57.0=".

That is more manageable. We have 4 "conflicts" here and one "missing" package.

Note: all the listed requirements under "conflicts" (the previous listing)
suggest these are ``>=`` depends. Thus the dependencies themselves can't block
upgrade path and error message is misleading.

For us it means that portage leaves old versions of ``gtk+`` (and others) for
some unknown reason.

To get an idea on how to explore that situation we need to somehow hide
outdated packages from portage and retry an update. It will be the same
as uninstalling and reinstalling a package but not actually doing it :)

``package.mask`` does exactly that. To make package hidden for real we
will also need to disable autounmask: ``--autounmask=n`` (default is `y`).

Let's hide outdated ``x11-libs/gtk+-3.18.7`` package from portage:

::

    # /etc/portage/package.mask
    <x11-libs/gtk+-3.20.0:3

Blocker list became shorter but still does not make sense:

::

    x11-base/xorg-server:0
      (x11-base/xorg-server-1.18.2:0/1.18.2::gentoo, ebuild scheduled for merge) pulled in by
      (x11-base/xorg-server-1.18.3:0/1.18.3::gentoo, installed) pulled in by
                            ^^^^^^^^^^
    
    app-text/poppler:0
      (app-text/poppler-0.32.0:0/51::gentoo, ebuild scheduled for merge) pulled in by
      (app-text/poppler-0.42.0:0/59::gentoo, ebuild scheduled for merge) pulled in by

Blocking more old stuff:

::

    # /etc/portage/package.mask
    <x11-libs/gtk+-3.20.0:3
    <x11-base/xorg-server-1.18.3
    <app-text/poppler-0.42.0

The output is:

::

     [blocks B      ] <dev-util/gdbus-codegen-2.48.0 ("<dev-util/gdbus-codegen-2.48.0" is blocking dev-libs/glib-2.48.0)

     * Error: The above package list contains packages which cannot be
     * installed at the same time on the same system.
    
      (dev-libs/glib-2.48.0:2/2::gentoo, ebuild scheduled for merge) pulled in by
    
      (dev-util/gdbus-codegen-2.46.2:0/0::gentoo, ebuild scheduled for merge) pulled in by

That's our blocker! Stable ``<dev-util/gdbus-codegen-2.48.0`` blocks unstable ``blocking dev-libs/glib-2.48.0``.

The solution is to ~arch keyword ``dev-util/gdbus-codegen-2.48.0``:

::

    # /etc/portage/package.accept_keywords
    dev-util/gdbus-codegen

And run world update.

Simple!
