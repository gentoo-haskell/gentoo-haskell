:PostID: 113
:Title: unsafePerformIO and missing NOINLINE
:Keywords: gentoo, ghc, darcs
:Categories: news

Two months ago Ivan asked me if we had working **darcs-2.8** for **ghc-7.8** in **gentoo**.
We had a workaround to compile **darcs** to that day, but **darcs**
did not work reliably. Sometimes it needed 2-3 attempts to pull
a repository.

A bit later I've decided to actually look at `failure case (Issued on darcs bugtracker) <http://bugs.darcs.net/issue2364>`_
and do something about it. My idea to debug the mystery was simple: to reproduce the difference on the same source
for **ghc-7.6/7.8** and start plugging debug info unless difference I can understand will pop up.

Darcs has great **debug-verbose** option for most of commands. I used
**debugMessage** function to litter code with more debugging statements unless
complete horrible image would emerge.

As you can see in bugtracker issue I posted there various intermediate points
of what I thought went wrong (don't expect those comments to have much sense).

The immediate consequence of a breakage was file overwrite of partially downloaded file.
The event timeline looked simple:

- darcs scheduled for download the same file twice (two jobs in download queue)
- first download job did finish
- notified waiter started processing of that downloaded temp file
- second download started  truncating previous complete download
- notified waiter continued processing partially downloadeed file
  and detected breakage

Thus first I've decided `to fix the consequence <http://hub.darcs.net/darcs/darcs-screened/patch/20140429134020-6895e>`_.
It did not fix problems completely, sometimes **darcs pull** complained
about remote repositories still being broken (missing files), but it
made errors saner (only remote side was allegedly at fault).

Ideally, that file overwrite should not happen in the first place.
Partially, it was `temp file predictability <https://ghc.haskell.org/trac/ghc/ticket/9058>`_.

But, OK. Then i've started digging why **7.6**/**7.8** request download
patterns were so severely different. At first I thought of `new IO manager <http://haskell.cs.yale.edu/wp-content/uploads/2013/08/hask035-voellmy.pdf>`_
being a cause of difference. The paper says it fixed haskell thread scheduling issue (paper is nice even for leisure reading!):

.. code-block:: bash

     GHC’s RTS had a bug in which yield
     placed the thread back on the front of the run queue. This bug
     was uncovered by our use of yield
     which requires that the thread
     be placed at the end of the run queue

Thus I was expecting the bug from this side.

Then being determined to dig A Lot in **darcs** source code I've
decided to disable optimizations (**-O0**) to speedup rebuilds.
And, the bug has vanished.

That made the click: **unsafePerformIO** might be the real problem.
I've grepped for all **unsafePerformIO** instances and examined all definition sites.

Two were especially interesting:

.. code-block:: haskell

    -- src/Darcs/Util/Global.hs
    -- ...
    _crcWarningList :: IORef CRCWarningList
    _crcWarningList = unsafePerformIO $ newIORef []
    {-# NOINLINE _crcWarningList #-}
    -- ...
    _badSourcesList :: IORef [String]
    _badSourcesList = unsafePerformIO $ newIORef []
    {- NOINLINE _badSourcesList -}
    -- ...

Did you spot the bug?

Thus The Proper Fix was pushed upstream `a month ago <https://github.com/gentoo-haskell/gentoo-haskell/blob/master/dev-vcs/darcs/files/darcs-2.8.4-issue2364-part-2.patch>`_.
Which means **ghc** is now able to inline things more aggressively
(and **_badSourcesList** were inlined in all user sites, throwing out all update sites).

I don't know if those **newIORef []** can be **de-CSE**d if types would have
the same representation. Ideally the module also needs **-fno-cse**, or get rid of **unsafePerformIO** completely :].

(Side thought: top-level global variables in **C** style are surprisingly non-trivial in "pure" haskell.
They are easy to use via **peek** / **poke** (in a racy way), but are hard to declare / initialize.)

I had a question wondered how many haskell packages manage to misspell ghc pragma decparations
in a way **darcs** did it.
And there still _is_ a few of such offenders:

.. code-block:: bash

    $ fgrep -R NOINLINE . | grep -v '{-# NOINLINE' | grep '{-'
    --
    ajhc-0.8.0.10/lib/jhc/Jhc/List.hs:{- NOINLINE filterFB #-}
    ajhc-0.8.0.10/lib/jhc/Jhc/List.hs:{- NOINLINE iterateFB #-}
    ajhc-0.8.0.10/lib/jhc/Jhc/List.hs:{- NOINLINE mapFB #-}
    --
    darcs-2.8.4/src/Darcs/Global.hs:{- NOINLINE _badSourcesList -}
    darcs-2.8.4/src/Darcs/Global.hs:{- NOINLINE _reachableSourcesList -}
    --
    dph-lifted-copy-0.7.0.1/Data/Array/Parallel.hs:{- NOINLINE emptyP #-}
    --
    dph-par-0.5.1.1/Data/Array/Parallel.hs:{- NOINLINE emptyP #-}
    --
    dph-seq-0.5.1.1/Data/Array/Parallel.hs:{- NOINLINE emptyP #-}
    --
    freesect-0.8/FreeSectAnnotated.hs:{- # NOINLINE showSSI #-}
    freesect-0.8/FreeSectAnnotated.hs:{- # NOINLINE FreeSectAnnotated.showSSI #-}
    freesect-0.8/FreeSect.hs:{- # NOINLINE fs_warn_flaw #-}
    --
    http-proxy-0.0.8/Network/HTTP/Proxy/ReadInt.hs:{- NOINLINE readInt64MH #-}
    http-proxy-0.0.8/Network/HTTP/Proxy/ReadInt.hs:{- NOINLINE mhDigitToInt #-}
    --
    lhc-0.10/lib/base/src/GHC/PArr.hs:{- NOINLINE emptyP #-}
    --
    property-list-0.1.0.2/src/Data/PropertyList/Binary/Float.hs:{- NOINLINE doubleToWord64 -}
    property-list-0.1.0.2/src/Data/PropertyList/Binary/Float.hs:{- NOINLINE word64ToDouble -}
    property-list-0.1.0.2/src/Data/PropertyList/Binary/Float.hs:{- NOINLINE floatToWord32 -}
    property-list-0.1.0.2/src/Data/PropertyList/Binary/Float.hs:{- NOINLINE word32ToFloat -}
    --
    warp-2.0.3.3/Network/Wai/Handler/Warp/ReadInt.hs:{- NOINLINE readInt64MH #-}
    warp-2.0.3.3/Network/Wai/Handler/Warp/ReadInt.hs:{- NOINLINE mhDigitToInt #-}

Looks like there is yet something to fix :]

Would be great if **hlint** would be able to detect pragma-like comments
and warn when comment contents is a valid pragma, but comment brackets
don't allow it to fire.

.. code-block:: haskell

    {- NOINLINE foo -} -- bad
    {- NOINLINE foo #-} -- bad
    {-# NOINLINE foo -} -- bad
    {-# NOINLINE foo #-} -- ok

Thanks for reading!
