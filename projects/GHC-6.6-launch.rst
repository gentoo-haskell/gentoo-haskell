==============
GHC 6.6 Lanuch
==============

Due to the restructure of bundled libraries from GHC 6.4 -> 6.6 we've had to
rewrite ebuild dependincies between packages and libraries.

20:15 < dcoutts_> sure sure
20:15 < dcoutts_> so we should add dummy packages now
20:15 < dcoutts_> I think at the same time we should get ghc-6.6 into portage p.masked
20:16 < dcoutts_> so at least the arch teams will see our plan
20:16 < dcoutts_> and the necessity to mark the dummy things stable
20:16 < kolmodin> right
20:16 < dcoutts_> and it'll make it easier to test things in the context of portage rather than the overlay
20:16 < dcoutts_> we could also add new libs p.masked
20:16 < dcoutts_> whateer
20:17 < dcoutts_> actually if new libs work with 6.4 they can dep on the modular libs and things should work
20:17 < dcoutts_> since the dummys will be ~arch for a while
20:18 < dcoutts_> so they would not need to be p.masked, only things which require 6.6 would need to be p.masked
20:18 < dcoutts_> like the non-dummy versions of the modular libs
20:19 < dcoutts_> so lets clarify.. what can we do now without the arch team's involvement?
20:19 < dcoutts_> 1. we can add the dummy modular libs packages in ~arch
20:19 < dcoutts_> 2. we can add ghc-6.6 p.masked
20:19 < dcoutts_> 3. we can add the real modular libs packages in p.mask
20:20 -!- t4 [n=t44@ip24-250-253-203.ga.at.cox.net] has joined #gentoo-haskell
20:20 < dcoutts_> (note: so far now existing packages changed)
20:20 < dcoutts_> now/no
20:21 < dcoutts_> 4. new ~arch versions of libs/progs can dep on the dummy libs
20:21 < dcoutts_> 5. new p.maksed versions of libs/progs can dep on ghc-6.6 and real libs
20:21 < dcoutts_> then I think we have to wait
20:21 < dcoutts_> we have to get the dummy libs stable
20:21 < kolmodin> what tea did you make did you say? it's clear to me that I need some too
20:21 < dcoutts_> and modify existing packages to dep on them
20:21 < dcoutts_> kolmodin, heh, ordinary :-)
20:22 < kolmodin> without teine/caffine?
20:22 < dcoutts_> with!
20:22 < kolmodin> I'll try witohut
20:22 < kolmodin> ah.. I'm planning to go to sleep early this night
20:23 < dcoutts_> ok ok
20:23 < dcoutts_> so once the existing packages are depending on the modular libs, and are all patched up to work with ghc-6.6...
20:23 < kolmodin> as I,um.. , have to get serios at work
20:23 < dcoutts_> then we can unmask ghc-6.6 and the other libs depending on it
20:23 < dcoutts_> how about that?
20:23 < dcoutts_> so we never need to mark existing packages as <ghc-6.6
20:23 < dcoutts_> on the other hand it takes a bit longer to unmask 6.6
20:24 < dcoutts_> the other strategy is to unmask 6.6 earlier but modify existing packages to <ghc-6.6
20:24 < dcoutts_> that's not ideal since people upgrading will then not be able to update their existing packages
20:24 < dcoutts_> ie we'd break things
20:24  * kolmodin reads up, from the top
20:25 < dcoutts_> kolmodin, might want to copy it, edit it, and put it in portage as .txt/.html or something
20:25 < dcoutts_> and revise it as we refine/agree the plan
20:25 < kolmodin> aye, good idea
20:25 < dcoutts_> then we can get on with it without having to keep referring to each other about what the plan was :-)
20:26 < kolmodin> I'll try to grok it first
20:26 < dcoutts_> good idea :-)
20:26 < kolmodin> this'll be the master plan!
20:26 < dcoutts_> @yarr!
20:26 < lambdabot> What be a priate's favourite cheese?
20:26 < lambdabot> Yarrlsburg!
