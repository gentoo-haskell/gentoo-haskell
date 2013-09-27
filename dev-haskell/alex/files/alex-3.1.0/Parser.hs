{-# OPTIONS_GHC -w #-}
{-# OPTIONS -fglasgow-exts -cpp #-}
-- -----------------------------------------------------------------------------
-- 
-- Parser.y, part of Alex
--
-- (c) Simon Marlow 2003
--
-- -----------------------------------------------------------------------------

{-# OPTIONS_GHC -w #-}

module Parser ( parse, P ) where
import AbsSyn
import Scan
import CharSet
import ParseMonad hiding ( StartCode )

import Data.Char
--import Debug.Trace
import qualified Data.Array as Happy_Data_Array
import qualified GHC.Exts as Happy_GHC_Exts

-- parser produced by Happy Version 1.19.0

newtype HappyAbsSyn  = HappyAbsSyn HappyAny
#if __GLASGOW_HASKELL__ >= 607
type HappyAny = Happy_GHC_Exts.Any
#else
type HappyAny = forall a . a
#endif
happyIn4 :: ((Maybe (AlexPosn,Code), [Directive], Scanner, Maybe (AlexPosn,Code))) -> (HappyAbsSyn )
happyIn4 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn4 #-}
happyOut4 :: (HappyAbsSyn ) -> ((Maybe (AlexPosn,Code), [Directive], Scanner, Maybe (AlexPosn,Code)))
happyOut4 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut4 #-}
happyIn5 :: (Maybe (AlexPosn,Code)) -> (HappyAbsSyn )
happyIn5 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn5 #-}
happyOut5 :: (HappyAbsSyn ) -> (Maybe (AlexPosn,Code))
happyOut5 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut5 #-}
happyIn6 :: ([Directive]) -> (HappyAbsSyn )
happyIn6 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn6 #-}
happyOut6 :: (HappyAbsSyn ) -> ([Directive])
happyOut6 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut6 #-}
happyIn7 :: (Directive) -> (HappyAbsSyn )
happyIn7 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn7 #-}
happyOut7 :: (HappyAbsSyn ) -> (Directive)
happyOut7 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut7 #-}
happyIn8 :: (()) -> (HappyAbsSyn )
happyIn8 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn8 #-}
happyOut8 :: (HappyAbsSyn ) -> (())
happyOut8 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut8 #-}
happyIn9 :: (()) -> (HappyAbsSyn )
happyIn9 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn ) -> (())
happyOut9 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut9 #-}
happyIn10 :: (Scanner) -> (HappyAbsSyn )
happyIn10 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn ) -> (Scanner)
happyOut10 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut10 #-}
happyIn11 :: ([RECtx]) -> (HappyAbsSyn )
happyIn11 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn ) -> ([RECtx])
happyOut11 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut11 #-}
happyIn12 :: ([RECtx]) -> (HappyAbsSyn )
happyIn12 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn ) -> ([RECtx])
happyOut12 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut12 #-}
happyIn13 :: (RECtx) -> (HappyAbsSyn )
happyIn13 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn13 #-}
happyOut13 :: (HappyAbsSyn ) -> (RECtx)
happyOut13 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut13 #-}
happyIn14 :: ([RECtx]) -> (HappyAbsSyn )
happyIn14 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn ) -> ([RECtx])
happyOut14 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut14 #-}
happyIn15 :: ([(String,StartCode)]) -> (HappyAbsSyn )
happyIn15 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn ) -> ([(String,StartCode)])
happyOut15 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: ([(String,StartCode)]) -> (HappyAbsSyn )
happyIn16 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn ) -> ([(String,StartCode)])
happyOut16 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: (String) -> (HappyAbsSyn )
happyIn17 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> (String)
happyOut17 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: (Maybe Code) -> (HappyAbsSyn )
happyIn18 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> (Maybe Code)
happyOut18 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: (Maybe CharSet, RExp, RightContext RExp) -> (HappyAbsSyn )
happyIn19 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> (Maybe CharSet, RExp, RightContext RExp)
happyOut19 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: (CharSet) -> (HappyAbsSyn )
happyIn20 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn ) -> (CharSet)
happyOut20 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut20 #-}
happyIn21 :: (RightContext RExp) -> (HappyAbsSyn )
happyIn21 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn ) -> (RightContext RExp)
happyOut21 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut21 #-}
happyIn22 :: (RExp) -> (HappyAbsSyn )
happyIn22 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn22 #-}
happyOut22 :: (HappyAbsSyn ) -> (RExp)
happyOut22 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut22 #-}
happyIn23 :: (RExp) -> (HappyAbsSyn )
happyIn23 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn23 #-}
happyOut23 :: (HappyAbsSyn ) -> (RExp)
happyOut23 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut23 #-}
happyIn24 :: (RExp) -> (HappyAbsSyn )
happyIn24 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn ) -> (RExp)
happyOut24 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut24 #-}
happyIn25 :: (RExp -> RExp) -> (HappyAbsSyn )
happyIn25 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn ) -> (RExp -> RExp)
happyOut25 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut25 #-}
happyIn26 :: (RExp) -> (HappyAbsSyn )
happyIn26 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> (RExp)
happyOut26 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut26 #-}
happyIn27 :: (CharSet) -> (HappyAbsSyn )
happyIn27 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn ) -> (CharSet)
happyOut27 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut27 #-}
happyIn28 :: (CharSet) -> (HappyAbsSyn )
happyIn28 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn ) -> (CharSet)
happyOut28 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut28 #-}
happyIn29 :: ([CharSet]) -> (HappyAbsSyn )
happyIn29 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> ([CharSet])
happyOut29 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut29 #-}
happyIn30 :: ((AlexPosn,String)) -> (HappyAbsSyn )
happyIn30 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> ((AlexPosn,String))
happyOut30 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut30 #-}
happyInTok :: (Token) -> (HappyAbsSyn )
happyInTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> (Token)
happyOutTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOutTok #-}


happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x72\x00\x72\x00\x66\x00\x00\x00\x52\x00\x51\x00\x60\x00\x67\x00\x00\x00\x00\x00\x63\x00\x51\x00\x7b\x00\x6d\x00\x00\x00\x5b\x00\x00\x00\x1a\x01\x6a\x00\x00\x00\x00\x00\x00\x00\x49\x00\x7b\x00\x80\x00\x00\x00\x64\x00\x00\x00\x00\x00\x62\x00\x00\x00\x4d\x00\x13\x00\x00\x00\x13\x00\x00\x00\x01\x00\xff\xff\x6d\x00\x02\x00\x10\x00\x1b\x00\x00\x00\x00\x00\x7b\x00\x48\x00\x73\x00\x59\x00\x7b\x00\x00\x00\x53\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x42\x00\x00\x00\x6d\x00\x00\x00\x15\x00\x00\x00\x47\x00\x00\x00\x00\x00\x00\x00\x00\x00\x54\x00\x50\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x37\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x25\x00\x00\x00\x25\x00\x3f\x00\x00\x00\x00\x00\x00\x00\x1b\x00\x00\x00\x00\x00\xf7\xff\x00\x00\x00\x00\x3c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x69\x00\x39\x00\x5c\x00\x00\x00\x00\x00\x4b\x00\x4a\x00\x00\x00\x00\x00\x00\x00\x30\x00\x3a\x00\x11\x00\xfe\x00\x00\x00\x03\x01\x00\x00\x31\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf5\x00\x2b\x00\x07\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\x00\xaa\x00\x00\x00\x96\x00\x00\x00\xda\x00\xf6\xff\xec\x00\x22\x00\x00\x00\x20\x00\x00\x00\x00\x00\x23\x00\x00\x00\xc2\x00\x00\x00\xb0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe3\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf3\xff\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\xce\x00\x00\x00\xbc\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xfc\xff\x00\x00\xfa\xff\xfd\xff\x00\x00\xf7\xff\xfa\xff\x00\x00\xf9\xff\xfb\xff\x00\x00\xf7\xff\x00\x00\x00\x00\xf5\xff\xdb\xff\xd9\xff\xd7\xff\xcd\xff\xca\xff\xc7\xff\xc1\xff\x00\x00\x00\x00\xc2\xff\xcf\xff\xc9\xff\xc0\xff\xce\xff\xf6\xff\xf8\xff\xfc\xff\xf2\xff\xf4\xff\xf2\xff\xef\xff\x00\x00\x00\x00\x00\x00\xdd\xff\xcd\xff\x00\x00\xe2\xff\xfe\xff\x00\x00\x00\x00\xc2\xff\x00\x00\xc2\xff\xc4\xff\x00\x00\xd0\xff\xd8\xff\xd6\xff\xd5\xff\xd4\xff\x00\x00\xda\xff\x00\x00\xdc\xff\x00\x00\xcc\xff\x00\x00\xc6\xff\xc3\xff\xc8\xff\xcb\xff\x00\x00\xe9\xff\xe8\xff\xe7\xff\xe1\xff\xe3\xff\xe0\xff\x00\x00\xdd\xff\xee\xff\xe5\xff\xe6\xff\xf1\xff\xec\xff\xf3\xff\xec\xff\x00\x00\xe4\xff\xdf\xff\xde\xff\x00\x00\xeb\xff\xc5\xff\x00\x00\xd3\xff\xd2\xff\x00\x00\xea\xff\xf0\xff\xed\xff\xd1\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x02\x00\x01\x00\x0c\x00\x0e\x00\x12\x00\x13\x00\x14\x00\x06\x00\x16\x00\x17\x00\x18\x00\x0b\x00\x1a\x00\x0d\x00\x0c\x00\x0d\x00\x10\x00\x1b\x00\x12\x00\x01\x00\x14\x00\x03\x00\x15\x00\x17\x00\x1a\x00\x05\x00\x11\x00\x1b\x00\x1c\x00\x1d\x00\x0f\x00\x0d\x00\x0c\x00\x01\x00\x10\x00\x14\x00\x12\x00\x01\x00\x14\x00\x17\x00\x18\x00\x17\x00\x1a\x00\x0c\x00\x0d\x00\x1b\x00\x1c\x00\x1d\x00\x16\x00\x0d\x00\x11\x00\x19\x00\x10\x00\x06\x00\x12\x00\x01\x00\x14\x00\x01\x00\x18\x00\x17\x00\x1a\x00\x04\x00\x05\x00\x1b\x00\x1c\x00\x1d\x00\x18\x00\x0d\x00\x1a\x00\x15\x00\x10\x00\x0c\x00\x12\x00\x01\x00\x0c\x00\x02\x00\x03\x00\x17\x00\x04\x00\x05\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x05\x00\x0d\x00\x0e\x00\x04\x00\x10\x00\x13\x00\x12\x00\x01\x00\x1b\x00\x02\x00\x03\x00\x17\x00\x0e\x00\x07\x00\x1b\x00\x1b\x00\x1c\x00\x1d\x00\x1a\x00\x0d\x00\x00\x00\x01\x00\x10\x00\x13\x00\x12\x00\x01\x00\x1e\x00\x1f\x00\x0f\x00\x17\x00\x21\x00\x01\x00\x11\x00\x1b\x00\x1c\x00\x1d\x00\x0f\x00\x0d\x00\x18\x00\x01\x00\x10\x00\x17\x00\x12\x00\x20\x00\x01\x00\x0f\x00\x10\x00\x17\x00\x12\x00\x20\x00\xff\xff\x1b\x00\x1c\x00\x1d\x00\x10\x00\x1a\x00\x12\x00\x1b\x00\x1c\x00\x10\x00\xff\xff\x12\x00\xff\xff\x14\x00\xff\xff\x1b\x00\x1c\x00\xff\xff\xff\xff\xff\xff\x1b\x00\x1c\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\xff\xff\xff\xff\x0f\x00\x10\x00\xff\xff\x12\x00\x13\x00\x14\x00\xff\xff\x16\x00\x17\x00\x18\x00\xff\xff\x1a\x00\x07\x00\x08\x00\x09\x00\xff\xff\x0b\x00\xff\xff\xff\xff\xff\xff\x0f\x00\x10\x00\xff\xff\x12\x00\x13\x00\x14\x00\xff\xff\x16\x00\x17\x00\x18\x00\xff\xff\x1a\x00\x09\x00\x0a\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x0f\x00\x10\x00\xff\xff\x12\x00\x13\x00\x14\x00\xff\xff\x16\x00\x17\x00\x18\x00\xff\xff\x1a\x00\x09\x00\x0a\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x0f\x00\x10\x00\xff\xff\x12\x00\x13\x00\x14\x00\x09\x00\x16\x00\x17\x00\x18\x00\xff\xff\x1a\x00\x0f\x00\x10\x00\xff\xff\x12\x00\x13\x00\x14\x00\xff\xff\x16\x00\x17\x00\x18\x00\xff\xff\x1a\x00\x12\x00\x13\x00\x14\x00\xff\xff\x16\x00\x17\x00\x18\x00\xff\xff\x1a\x00\x12\x00\x13\x00\x14\x00\xff\xff\x16\x00\x17\x00\x18\x00\xff\xff\x1a\x00\x12\x00\x13\x00\x14\x00\xff\xff\x16\x00\x17\x00\x18\x00\xff\xff\x1a\x00\x12\x00\x13\x00\x14\x00\xff\xff\x16\x00\x17\x00\x18\x00\x14\x00\x1a\x00\x16\x00\x17\x00\x18\x00\xff\xff\x1a\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x4e\x00\x16\x00\x5d\x00\x4c\x00\x55\x00\x0f\x00\x10\x00\x4a\x00\x11\x00\x12\x00\x13\x00\x51\x00\x14\x00\x17\x00\x5e\x00\x44\x00\x18\x00\x5e\x00\x19\x00\x16\x00\x2b\x00\x2a\x00\x4b\x00\x1a\x00\x4f\x00\x5b\x00\x54\x00\x1b\x00\x1c\x00\x1d\x00\x2d\x00\x17\x00\x5c\x00\x2b\x00\x18\x00\x48\x00\x19\x00\x16\x00\x2b\x00\x1d\x00\x13\x00\x1a\x00\x14\x00\x43\x00\x44\x00\x1b\x00\x1c\x00\x1d\x00\x46\x00\x17\x00\x48\x00\x47\x00\x18\x00\x1f\x00\x19\x00\x16\x00\x2b\x00\x02\x00\x42\x00\x1a\x00\x14\x00\x1e\x00\x0b\x00\x1b\x00\x1c\x00\x1d\x00\x31\x00\x17\x00\x14\x00\x34\x00\x18\x00\x62\x00\x19\x00\x16\x00\x60\x00\x09\x00\x06\x00\x1a\x00\x0a\x00\x0b\x00\x57\x00\x1b\x00\x1c\x00\x1d\x00\x58\x00\x17\x00\x34\x00\x59\x00\x18\x00\x5a\x00\x19\x00\x16\x00\x3d\x00\x05\x00\x06\x00\x1a\x00\x3e\x00\x3b\x00\x42\x00\x1b\x00\x1c\x00\x1d\x00\x04\x00\x17\x00\x04\x00\x02\x00\x18\x00\x40\x00\x19\x00\x16\x00\x0d\x00\x0e\x00\x2d\x00\x1a\x00\xff\xff\x16\x00\x2e\x00\x1b\x00\x1c\x00\x1d\x00\x2d\x00\x17\x00\x21\x00\x16\x00\x18\x00\x09\x00\x19\x00\x08\x00\x16\x00\x2d\x00\x18\x00\x1a\x00\x19\x00\x08\x00\x00\x00\x1b\x00\x1c\x00\x1d\x00\x18\x00\x04\x00\x19\x00\x1b\x00\x1c\x00\x18\x00\x00\x00\x19\x00\x00\x00\x31\x00\x00\x00\x1b\x00\x1c\x00\x00\x00\x00\x00\x00\x00\x1b\x00\x1c\x00\x51\x00\x22\x00\x23\x00\x00\x00\x24\x00\x00\x00\x00\x00\x00\x00\x25\x00\x26\x00\x00\x00\x27\x00\x0f\x00\x10\x00\x00\x00\x11\x00\x28\x00\x13\x00\x00\x00\x14\x00\x21\x00\x22\x00\x23\x00\x00\x00\x24\x00\x00\x00\x00\x00\x00\x00\x25\x00\x26\x00\x00\x00\x27\x00\x0f\x00\x10\x00\x00\x00\x11\x00\x28\x00\x13\x00\x00\x00\x14\x00\x52\x00\x60\x00\x2e\x00\x13\x00\x3e\x00\x14\x00\x25\x00\x26\x00\x00\x00\x27\x00\x0f\x00\x10\x00\x00\x00\x11\x00\x28\x00\x13\x00\x00\x00\x14\x00\x52\x00\x53\x00\x2e\x00\x13\x00\x40\x00\x14\x00\x25\x00\x26\x00\x00\x00\x27\x00\x0f\x00\x10\x00\x4f\x00\x11\x00\x28\x00\x13\x00\x00\x00\x14\x00\x25\x00\x26\x00\x00\x00\x27\x00\x0f\x00\x10\x00\x00\x00\x11\x00\x28\x00\x13\x00\x00\x00\x14\x00\x3b\x00\x0f\x00\x10\x00\x00\x00\x11\x00\x12\x00\x13\x00\x00\x00\x14\x00\x4b\x00\x0f\x00\x10\x00\x00\x00\x11\x00\x12\x00\x13\x00\x00\x00\x14\x00\x32\x00\x0f\x00\x10\x00\x00\x00\x11\x00\x12\x00\x13\x00\x00\x00\x14\x00\x0e\x00\x0f\x00\x10\x00\x00\x00\x11\x00\x12\x00\x13\x00\x39\x00\x14\x00\x11\x00\x12\x00\x13\x00\x00\x00\x14\x00\x2e\x00\x13\x00\x2f\x00\x14\x00\x36\x00\x37\x00\x38\x00\x39\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = Happy_Data_Array.array (1, 63) [
	(1 , happyReduce_1),
	(2 , happyReduce_2),
	(3 , happyReduce_3),
	(4 , happyReduce_4),
	(5 , happyReduce_5),
	(6 , happyReduce_6),
	(7 , happyReduce_7),
	(8 , happyReduce_8),
	(9 , happyReduce_9),
	(10 , happyReduce_10),
	(11 , happyReduce_11),
	(12 , happyReduce_12),
	(13 , happyReduce_13),
	(14 , happyReduce_14),
	(15 , happyReduce_15),
	(16 , happyReduce_16),
	(17 , happyReduce_17),
	(18 , happyReduce_18),
	(19 , happyReduce_19),
	(20 , happyReduce_20),
	(21 , happyReduce_21),
	(22 , happyReduce_22),
	(23 , happyReduce_23),
	(24 , happyReduce_24),
	(25 , happyReduce_25),
	(26 , happyReduce_26),
	(27 , happyReduce_27),
	(28 , happyReduce_28),
	(29 , happyReduce_29),
	(30 , happyReduce_30),
	(31 , happyReduce_31),
	(32 , happyReduce_32),
	(33 , happyReduce_33),
	(34 , happyReduce_34),
	(35 , happyReduce_35),
	(36 , happyReduce_36),
	(37 , happyReduce_37),
	(38 , happyReduce_38),
	(39 , happyReduce_39),
	(40 , happyReduce_40),
	(41 , happyReduce_41),
	(42 , happyReduce_42),
	(43 , happyReduce_43),
	(44 , happyReduce_44),
	(45 , happyReduce_45),
	(46 , happyReduce_46),
	(47 , happyReduce_47),
	(48 , happyReduce_48),
	(49 , happyReduce_49),
	(50 , happyReduce_50),
	(51 , happyReduce_51),
	(52 , happyReduce_52),
	(53 , happyReduce_53),
	(54 , happyReduce_54),
	(55 , happyReduce_55),
	(56 , happyReduce_56),
	(57 , happyReduce_57),
	(58 , happyReduce_58),
	(59 , happyReduce_59),
	(60 , happyReduce_60),
	(61 , happyReduce_61),
	(62 , happyReduce_62),
	(63 , happyReduce_63)
	]

happy_n_terms = 34 :: Int
happy_n_nonterms = 27 :: Int

happyReduce_1 = happyReduce 5# 0# happyReduction_1
happyReduction_1 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_2 of { happy_var_2 -> 
	case happyOut10 happy_x_4 of { happy_var_4 -> 
	case happyOut5 happy_x_5 of { happy_var_5 -> 
	happyIn4
		 ((happy_var_1,happy_var_2,happy_var_4,happy_var_5)
	) `HappyStk` happyRest}}}}

happyReduce_2 = happySpecReduce_1  1# happyReduction_2
happyReduction_2 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn5
		 (case happy_var_1 of T pos (CodeT code) -> 
						Just (pos,code)
	)}

happyReduce_3 = happySpecReduce_0  1# happyReduction_3
happyReduction_3  =  happyIn5
		 (Nothing
	)

happyReduce_4 = happySpecReduce_2  2# happyReduction_4
happyReduction_4 happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_2 of { happy_var_2 -> 
	happyIn6
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_5 = happySpecReduce_0  2# happyReduction_5
happyReduction_5  =  happyIn6
		 ([]
	)

happyReduce_6 = happySpecReduce_2  3# happyReduction_6
happyReduction_6 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { (T _ (StringT happy_var_2)) -> 
	happyIn7
		 (WrapperDirective happy_var_2
	)}

happyReduce_7 = happySpecReduce_2  4# happyReduction_7
happyReduction_7 happy_x_2
	happy_x_1
	 =  happyIn8
		 (()
	)

happyReduce_8 = happySpecReduce_0  4# happyReduction_8
happyReduction_8  =  happyIn8
		 (()
	)

happyReduce_9 = happyMonadReduce 2# 5# happyReduction_9
happyReduction_9 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { (T _ (SMacDefT happy_var_1)) -> 
	case happyOut27 happy_x_2 of { happy_var_2 -> 
	( newSMac happy_var_1 happy_var_2)}}
	) (\r -> happyReturn (happyIn9 r))

happyReduce_10 = happyMonadReduce 2# 5# happyReduction_10
happyReduction_10 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { (T _ (RMacDefT happy_var_1)) -> 
	case happyOut22 happy_x_2 of { happy_var_2 -> 
	( newRMac happy_var_1 happy_var_2)}}
	) (\r -> happyReturn (happyIn9 r))

happyReduce_11 = happySpecReduce_2  6# happyReduction_11
happyReduction_11 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { (T _ (BindT happy_var_1)) -> 
	case happyOut11 happy_x_2 of { happy_var_2 -> 
	happyIn10
		 (Scanner happy_var_1 happy_var_2
	)}}

happyReduce_12 = happySpecReduce_2  7# happyReduction_12
happyReduction_12 happy_x_2
	happy_x_1
	 =  case happyOut12 happy_x_1 of { happy_var_1 -> 
	case happyOut11 happy_x_2 of { happy_var_2 -> 
	happyIn11
		 (happy_var_1 ++ happy_var_2
	)}}

happyReduce_13 = happySpecReduce_0  7# happyReduction_13
happyReduction_13  =  happyIn11
		 ([]
	)

happyReduce_14 = happySpecReduce_2  8# happyReduction_14
happyReduction_14 happy_x_2
	happy_x_1
	 =  case happyOut15 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_2 of { happy_var_2 -> 
	happyIn12
		 ([ replaceCodes happy_var_1 happy_var_2 ]
	)}}

happyReduce_15 = happyReduce 4# 8# happyReduction_15
happyReduction_15 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut15 happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_3 of { happy_var_3 -> 
	happyIn12
		 (map (replaceCodes happy_var_1) happy_var_3
	) `HappyStk` happyRest}}

happyReduce_16 = happySpecReduce_1  8# happyReduction_16
happyReduction_16 happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	happyIn12
		 ([ happy_var_1 ]
	)}

happyReduce_17 = happySpecReduce_2  9# happyReduction_17
happyReduction_17 happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOut18 happy_x_2 of { happy_var_2 -> 
	happyIn13
		 (let (l,e,r) = happy_var_1 in 
					  RECtx [] l e r happy_var_2
	)}}

happyReduce_18 = happySpecReduce_2  10# happyReduction_18
happyReduction_18 happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_2 of { happy_var_2 -> 
	happyIn14
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_19 = happySpecReduce_0  10# happyReduction_19
happyReduction_19  =  happyIn14
		 ([]
	)

happyReduce_20 = happySpecReduce_3  11# happyReduction_20
happyReduction_20 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut16 happy_x_2 of { happy_var_2 -> 
	happyIn15
		 (happy_var_2
	)}

happyReduce_21 = happySpecReduce_3  12# happyReduction_21
happyReduction_21 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	case happyOut16 happy_x_3 of { happy_var_3 -> 
	happyIn16
		 ((happy_var_1,0) : happy_var_3
	)}}

happyReduce_22 = happySpecReduce_1  12# happyReduction_22
happyReduction_22 happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 ([(happy_var_1,0)]
	)}

happyReduce_23 = happySpecReduce_1  13# happyReduction_23
happyReduction_23 happy_x_1
	 =  happyIn17
		 ("0"
	)

happyReduce_24 = happySpecReduce_1  13# happyReduction_24
happyReduction_24 happy_x_1
	 =  case happyOutTok happy_x_1 of { (T _ (IdT happy_var_1)) -> 
	happyIn17
		 (happy_var_1
	)}

happyReduce_25 = happySpecReduce_1  14# happyReduction_25
happyReduction_25 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn18
		 (case happy_var_1 of T _ (CodeT code) -> Just code
	)}

happyReduce_26 = happySpecReduce_1  14# happyReduction_26
happyReduction_26 happy_x_1
	 =  happyIn18
		 (Nothing
	)

happyReduce_27 = happySpecReduce_3  15# happyReduction_27
happyReduction_27 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut20 happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_2 of { happy_var_2 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	happyIn19
		 ((Just happy_var_1,happy_var_2,happy_var_3)
	)}}}

happyReduce_28 = happySpecReduce_2  15# happyReduction_28
happyReduction_28 happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_2 of { happy_var_2 -> 
	happyIn19
		 ((Nothing,happy_var_1,happy_var_2)
	)}}

happyReduce_29 = happySpecReduce_1  16# happyReduction_29
happyReduction_29 happy_x_1
	 =  happyIn20
		 (charSetSingleton '\n'
	)

happyReduce_30 = happySpecReduce_2  16# happyReduction_30
happyReduction_30 happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	happyIn20
		 (happy_var_1
	)}

happyReduce_31 = happySpecReduce_1  17# happyReduction_31
happyReduction_31 happy_x_1
	 =  happyIn21
		 (RightContextRExp (Ch (charSetSingleton '\n'))
	)

happyReduce_32 = happySpecReduce_2  17# happyReduction_32
happyReduction_32 happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_2 of { happy_var_2 -> 
	happyIn21
		 (RightContextRExp happy_var_2
	)}

happyReduce_33 = happySpecReduce_2  17# happyReduction_33
happyReduction_33 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { happy_var_2 -> 
	happyIn21
		 (RightContextCode (case happy_var_2 of 
						T _ (CodeT code) -> code)
	)}

happyReduce_34 = happySpecReduce_0  17# happyReduction_34
happyReduction_34  =  happyIn21
		 (NoRightContext
	)

happyReduce_35 = happySpecReduce_3  18# happyReduction_35
happyReduction_35 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_3 of { happy_var_3 -> 
	happyIn22
		 (happy_var_1 :| happy_var_3
	)}}

happyReduce_36 = happySpecReduce_1  18# happyReduction_36
happyReduction_36 happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	happyIn22
		 (happy_var_1
	)}

happyReduce_37 = happySpecReduce_2  19# happyReduction_37
happyReduction_37 happy_x_2
	happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	case happyOut24 happy_x_2 of { happy_var_2 -> 
	happyIn23
		 (happy_var_1 :%% happy_var_2
	)}}

happyReduce_38 = happySpecReduce_1  19# happyReduction_38
happyReduction_38 happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	happyIn23
		 (happy_var_1
	)}

happyReduce_39 = happySpecReduce_2  20# happyReduction_39
happyReduction_39 happy_x_2
	happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	case happyOut25 happy_x_2 of { happy_var_2 -> 
	happyIn24
		 (happy_var_2 happy_var_1
	)}}

happyReduce_40 = happySpecReduce_1  20# happyReduction_40
happyReduction_40 happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	happyIn24
		 (happy_var_1
	)}

happyReduce_41 = happySpecReduce_1  21# happyReduction_41
happyReduction_41 happy_x_1
	 =  happyIn25
		 (Star
	)

happyReduce_42 = happySpecReduce_1  21# happyReduction_42
happyReduction_42 happy_x_1
	 =  happyIn25
		 (Plus
	)

happyReduce_43 = happySpecReduce_1  21# happyReduction_43
happyReduction_43 happy_x_1
	 =  happyIn25
		 (Ques
	)

happyReduce_44 = happySpecReduce_3  21# happyReduction_44
happyReduction_44 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { (T _ (CharT happy_var_2)) -> 
	happyIn25
		 (repeat_rng (digit happy_var_2) Nothing
	)}

happyReduce_45 = happyReduce 4# 21# happyReduction_45
happyReduction_45 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_2 of { (T _ (CharT happy_var_2)) -> 
	happyIn25
		 (repeat_rng (digit happy_var_2) (Just Nothing)
	) `HappyStk` happyRest}

happyReduce_46 = happyReduce 5# 21# happyReduction_46
happyReduction_46 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_2 of { (T _ (CharT happy_var_2)) -> 
	case happyOutTok happy_x_4 of { (T _ (CharT happy_var_4)) -> 
	happyIn25
		 (repeat_rng (digit happy_var_2) (Just (Just (digit happy_var_4)))
	) `HappyStk` happyRest}}

happyReduce_47 = happySpecReduce_2  22# happyReduction_47
happyReduction_47 happy_x_2
	happy_x_1
	 =  happyIn26
		 (Eps
	)

happyReduce_48 = happySpecReduce_1  22# happyReduction_48
happyReduction_48 happy_x_1
	 =  case happyOutTok happy_x_1 of { (T _ (StringT happy_var_1)) -> 
	happyIn26
		 (foldr (:%%) Eps 
					    (map (Ch . charSetSingleton) happy_var_1)
	)}

happyReduce_49 = happyMonadReduce 1# 22# happyReduction_49
happyReduction_49 (happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { (T _ (RMacT happy_var_1)) -> 
	( lookupRMac happy_var_1)}
	) (\r -> happyReturn (happyIn26 r))

happyReduce_50 = happySpecReduce_1  22# happyReduction_50
happyReduction_50 happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	happyIn26
		 (Ch happy_var_1
	)}

happyReduce_51 = happySpecReduce_3  22# happyReduction_51
happyReduction_51 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_2 of { happy_var_2 -> 
	happyIn26
		 (happy_var_2
	)}

happyReduce_52 = happySpecReduce_3  23# happyReduction_52
happyReduction_52 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut28 happy_x_3 of { happy_var_3 -> 
	happyIn27
		 (happy_var_1 `charSetMinus` happy_var_3
	)}}

happyReduce_53 = happySpecReduce_1  23# happyReduction_53
happyReduction_53 happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	happyIn27
		 (happy_var_1
	)}

happyReduce_54 = happySpecReduce_1  24# happyReduction_54
happyReduction_54 happy_x_1
	 =  case happyOutTok happy_x_1 of { (T _ (CharT happy_var_1)) -> 
	happyIn28
		 (charSetSingleton happy_var_1
	)}

happyReduce_55 = happySpecReduce_3  24# happyReduction_55
happyReduction_55 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { (T _ (CharT happy_var_1)) -> 
	case happyOutTok happy_x_3 of { (T _ (CharT happy_var_3)) -> 
	happyIn28
		 (charSetRange happy_var_1 happy_var_3
	)}}

happyReduce_56 = happyMonadReduce 1# 24# happyReduction_56
happyReduction_56 (happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut30 happy_x_1 of { happy_var_1 -> 
	( lookupSMac happy_var_1)}
	) (\r -> happyReturn (happyIn28 r))

happyReduce_57 = happySpecReduce_3  24# happyReduction_57
happyReduction_57 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut29 happy_x_2 of { happy_var_2 -> 
	happyIn28
		 (foldr charSetUnion emptyCharSet happy_var_2
	)}

happyReduce_58 = happyMonadReduce 4# 24# happyReduction_58
happyReduction_58 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut29 happy_x_3 of { happy_var_3 -> 
	( do { dot <- lookupSMac (tokPosn happy_var_1, ".");
		      	        return (dot `charSetMinus`
			      		  foldr charSetUnion emptyCharSet happy_var_3) })}}
	) (\r -> happyReturn (happyIn28 r))

happyReduce_59 = happyMonadReduce 2# 24# happyReduction_59
happyReduction_59 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOutTok happy_x_1 of { happy_var_1 -> 
	case happyOut28 happy_x_2 of { happy_var_2 -> 
	( do { dot <- lookupSMac (tokPosn happy_var_1, ".");
		      	        return (dot `charSetMinus` happy_var_2) })}}
	) (\r -> happyReturn (happyIn28 r))

happyReduce_60 = happySpecReduce_2  25# happyReduction_60
happyReduction_60 happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut29 happy_x_2 of { happy_var_2 -> 
	happyIn29
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_61 = happySpecReduce_0  25# happyReduction_61
happyReduction_61  =  happyIn29
		 ([]
	)

happyReduce_62 = happySpecReduce_1  26# happyReduction_62
happyReduction_62 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn30
		 ((tokPosn happy_var_1, ".")
	)}

happyReduce_63 = happySpecReduce_1  26# happyReduction_63
happyReduction_63 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn30
		 (case happy_var_1 of T p (SMacT s) -> (p, s)
	)}

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = happyDoAction i tk action sts stk in
	case tk of {
	T _ EOFT -> happyDoAction 33# tk action sts stk;
	T _ (SpecialT '.') -> cont 1#;
	T _ (SpecialT ';') -> cont 2#;
	T _ (SpecialT '<') -> cont 3#;
	T _ (SpecialT '>') -> cont 4#;
	T _ (SpecialT ',') -> cont 5#;
	T _ (SpecialT '$') -> cont 6#;
	T _ (SpecialT '|') -> cont 7#;
	T _ (SpecialT '*') -> cont 8#;
	T _ (SpecialT '+') -> cont 9#;
	T _ (SpecialT '?') -> cont 10#;
	T _ (SpecialT '{') -> cont 11#;
	T _ (SpecialT '}') -> cont 12#;
	T _ (SpecialT '(') -> cont 13#;
	T _ (SpecialT ')') -> cont 14#;
	T _ (SpecialT '#') -> cont 15#;
	T _ (SpecialT '~') -> cont 16#;
	T _ (SpecialT '-') -> cont 17#;
	T _ (SpecialT '[') -> cont 18#;
	T _ (SpecialT ']') -> cont 19#;
	T _ (SpecialT '^') -> cont 20#;
	T _ (SpecialT '/') -> cont 21#;
	T _ ZeroT -> cont 22#;
	T _ (StringT happy_dollar_dollar) -> cont 23#;
	T _ (BindT happy_dollar_dollar) -> cont 24#;
	T _ (IdT happy_dollar_dollar) -> cont 25#;
	T _ (CodeT _) -> cont 26#;
	T _ (CharT happy_dollar_dollar) -> cont 27#;
	T _ (SMacT _) -> cont 28#;
	T _ (RMacT happy_dollar_dollar) -> cont 29#;
	T _ (SMacDefT happy_dollar_dollar) -> cont 30#;
	T _ (RMacDefT happy_dollar_dollar) -> cont 31#;
	T _ WrapperT -> cont 32#;
	_ -> happyError' tk
	})

happyError_ 33# tk = happyError' tk
happyError_ _ tk = happyError' tk

happyThen :: () => P a -> (a -> P b) -> P b
happyThen = ((>>=))
happyReturn :: () => a -> P a
happyReturn = (return)
happyThen1 = happyThen
happyReturn1 :: () => a -> P a
happyReturn1 = happyReturn
happyError' :: () => (Token) -> P a
happyError' tk = (\token -> happyError) tk

parse = happySomeParser where
  happySomeParser = happyThen (happyParse 0#) (\x -> happyReturn (happyOut4 x))

happySeq = happyDontSeq


happyError :: P a
happyError = failP "parse error"

-- -----------------------------------------------------------------------------
-- Utils

digit c = ord c - ord '0'

repeat_rng :: Int -> Maybe (Maybe Int) -> (RExp->RExp)
repeat_rng n (Nothing) re = foldr (:%%) Eps (replicate n re)
repeat_rng n (Just Nothing) re = foldr (:%%) (Star re) (replicate n re)
repeat_rng n (Just (Just m)) re = intl :%% rst
	where
	intl = repeat_rng n Nothing re
	rst = foldr (\re re'->Ques(re :%% re')) Eps (replicate (m-n) re)

replaceCodes codes rectx = rectx{ reCtxStartCodes = codes }
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}





#if __GLASGOW_HASKELL__ > 706
#define LT(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.<# m)) :: Bool)
#define GTE(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.>=# m)) :: Bool)
#define EQ(n,m) ((Happy_GHC_Exts.tagToEnum# (n Happy_GHC_Exts.==# m)) :: Bool)
#else
#define LT(n,m) (n Happy_GHC_Exts.<# m)
#define GTE(n,m) (n Happy_GHC_Exts.>=# m)
#define EQ(n,m) (n Happy_GHC_Exts.==# m)
#endif
{-# LINE 45 "templates/GenericTemplate.hs" #-}


data Happy_IntList = HappyCons Happy_GHC_Exts.Int# Happy_IntList





{-# LINE 66 "templates/GenericTemplate.hs" #-}

{-# LINE 76 "templates/GenericTemplate.hs" #-}

{-# LINE 85 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is 0#, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept 0# tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	(happyTcHack j (happyTcHack st)) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action



happyDoAction i tk st
	= {- nothing -}


	  case action of
		0#		  -> {- nothing -}
				     happyFail i tk st
		-1# 	  -> {- nothing -}
				     happyAccept i tk st
		n | LT(n,(0# :: Happy_GHC_Exts.Int#)) -> {- nothing -}

				     (happyReduceArr Happy_Data_Array.! rule) i tk st
				     where rule = (Happy_GHC_Exts.I# ((Happy_GHC_Exts.negateInt# ((n Happy_GHC_Exts.+# (1# :: Happy_GHC_Exts.Int#))))))
		n		  -> {- nothing -}


				     happyShift new_state i tk st
                                     where new_state = (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#))
   where off    = indexShortOffAddr happyActOffsets st
         off_i  = (off Happy_GHC_Exts.+# i)
	 check  = if GTE(off_i,(0# :: Happy_GHC_Exts.Int#))
                  then EQ(indexShortOffAddr happyCheck off_i, i)
		  else False
         action
          | check     = indexShortOffAddr happyTable off_i
          | otherwise = indexShortOffAddr happyDefActions st


indexShortOffAddr (HappyA# arr) off =
	Happy_GHC_Exts.narrow16Int# i
  where
        i = Happy_GHC_Exts.word2Int# (Happy_GHC_Exts.or# (Happy_GHC_Exts.uncheckedShiftL# high 8#) low)
        high = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr (off' Happy_GHC_Exts.+# 1#)))
        low  = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr off'))
        off' = off Happy_GHC_Exts.*# 2#





data HappyAddr = HappyA# Happy_GHC_Exts.Addr#




-----------------------------------------------------------------------------
-- HappyState data type (not arrays)

{-# LINE 169 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state 0# tk st sts stk@(x `HappyStk` _) =
     let i = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--     trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons (st) (sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons (st) (sts)) ((happyInTok (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_0 nt fn j tk st@((action)) sts stk
     = happyGoto nt j tk st (HappyCons (st) (sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@((HappyCons (st@(action)) (_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_2 nt fn j tk _ (HappyCons (_) (sts@((HappyCons (st@(action)) (_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_3 nt fn j tk _ (HappyCons (_) ((HappyCons (_) (sts@((HappyCons (st@(action)) (_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) sts of
	 sts1@((HappyCons (st1@(action)) (_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k (HappyCons (st) (sts)) of
        sts1@((HappyCons (st1@(action)) (_))) ->
         let drop_stk = happyDropStk k stk

             off = indexShortOffAddr happyGotoOffsets st1
             off_i = (off Happy_GHC_Exts.+# nt)
             new_state = indexShortOffAddr happyTable off_i



          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop 0# l = l
happyDrop n (HappyCons (_) (t)) = happyDrop (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) t

happyDropStk 0# l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Happy_GHC_Exts.-# (1#::Happy_GHC_Exts.Int#)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction


happyGoto nt j tk st = 
   {- nothing -}
   happyDoAction j tk new_state
   where off = indexShortOffAddr happyGotoOffsets st
         off_i = (off Happy_GHC_Exts.+# nt)
         new_state = indexShortOffAddr happyTable off_i




-----------------------------------------------------------------------------
-- Error recovery (0# is the error token)

-- parse error if we are in recovery and we fail again
happyFail 0# tk old_st _ stk@(x `HappyStk` _) =
     let i = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--	trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  0# tk old_st (HappyCons ((action)) (sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	happyDoAction 0# tk action sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (action) sts stk =
--      trace "entering error recovery" $
	happyDoAction 0# tk action sts ( (Happy_GHC_Exts.unsafeCoerce# (Happy_GHC_Exts.I# (i))) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions


happyTcHack :: Happy_GHC_Exts.Int# -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}


-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.


{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
