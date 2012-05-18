{-# LANGUAGE CPP #-}
{-# LANGUAGE QuasiQuotes #-}

module Main where

import Test.HUnit

import Language.C.Quote.C
import System.Exit (exitFailure, exitSuccess)

#if !MIN_VERSION_template_haskell(2,7,0)
import qualified Data.Loc
import qualified Data.Symbol
import qualified Language.C.Syntax
#endif /* !MIN_VERSION_template_haskell(2,7,0) */

main = do
    count <- runTestTT tests
    case failures count of
      0 -> exitSuccess
      _ -> exitFailure

tests = TestList [exp_id, exp_int, exp_float, exp_char, exp_string,
                  exp_exp, exp_func, exp_args, exp_decl, exp_sdecl,
                  exp_enum, exp_edecl, exp_stm, exp_param, exp_ty,
                  pat_args, exp_hexp]


exp_id = "exp id" ~: [cexp|$id:ident|] ~?= [cexp|x|]
  where
    ident = "x"

exp_int =
    "exp int" ~:  [cexp|$int:one + $uint:one + $lint:one + $ulint:one|]
              ~?= [cexp|1 + 1U + 1L + 1UL|]
  where
    one = 1

exp_float =
    "exp float" ~:  [cexp|$float:one + $double:one + $ldouble:one|]
                ~?= [cexp|1.0F + 1.0 + 1.0L|]
  where
    one = 1

exp_char = "exp char" ~: [cexp|$char:a|] ~?=  [cexp|'a'|]
    where
      a = 'a'

exp_string =
    "exp string" ~: [cexp|$string:hello|] ~?=  [cexp|"Hello, world\n"|]
  where
    hello = "Hello, world\n"

exp_exp =
    "exp expression" ~: [cexp|$exp:e1 + $exp:e2|] ~?=  [cexp|1 + 2|]
  where
    e1 = [cexp|1|]
    e2 = [cexp|2|]

exp_func =
    "exp function" ~:  [cunit|$func:f|]
                   ~?= [cunit|int add(int x) { return x + 10; }|]
  where
    f = add 10
    add n = [cfun|int add(int x) { return x + $int:n; } |]

exp_args =
    "exp args" ~:  [cstm|f($exp:e1, $args:args, $exp:e2);|]
               ~?= [cstm|f(1, 1, 2, 2);|]
  where
    e1 = [cexp|1|]
    e2 = [cexp|2|]
    args = [e1, e2]

exp_decl =
    "exp decl" ~:  [cfun|int inc(int n) {
                             $decl:d1;
                             $decls:decls

                             return n + 1;
                          }|]
               ~?= [cfun|int inc(int n) {
                             int i;
                             int j;
                             char c = 'c';

                             return n + 1;
                          }|]
  where
    d1 = [cdecl|int i;|]
    d2 = [cdecl|int j;|]
    d3 = [cdecl|char c = 'c';|]
    decls = [d2, d3]

exp_sdecl =
    "exp sdecl" ~:  [cty|struct foo { $sdecl:d1 $sdecls:decls }|]
                ~?= [cty|struct foo { int i; int j; char c; }|]
  where
    d1 = [csdecl|int i;|]
    d2 = [csdecl|int j;|]
    d3 = [csdecl|char c;|]
    decls = [d2, d3]

exp_enum = "exp enum" ~:  [cty|enum foo { $enum:enum1, $enums:enums }|]
                      ~?= [cty|enum foo { A = 0, B, C = 2 }|]
  where
    enum1 = [cenum|A = 0|]
    enum2 = [cenum|B|]
    enum3 = [cenum|C = 2|]
    enums = [enum2, enum3]

exp_edecl =
    "exp edecl" ~:  [cunit|$edecl:d1 $edecls:decls|]
                ~?= [cunit|int i; int j; char c = 'c';|]
  where
    d1 = [cedecl|int i;|]
    d2 = [cedecl|int j;|]
    d3 = [cedecl|char c = 'c';|]
    decls = [d2, d3]

exp_stm =
    "exp stm" ~:  [cfun|int add(int x) { $stms:stms return x + 1; }|]
              ~?= [cfun|int add(int x) { a = 1; b = 2; return x + 1; }|]
  where
    one = 1
    stm1 = [cstm|a = $int:one;|]
    stm2 = [cstm|b = 2;|]
    stms = [stm1, stm2]

exp_param =
    "exp param" ~:  [cdecl|int f($param:ty1, $params:tys);|]
                ~?= [cdecl|int f(char, int, float);|]
  where
    ty1 = [cparam|char|]
    ty2 = [cparam|int|]
    ty3 = [cparam|float|]
    tys = [ty2, ty3]

exp_ty =
    "exp ty" ~:  [cdecl|$ty:ty1 f(const $ty:ty2);|]
             ~?= [cdecl|int f(const float);|]
  where
    ty1 = [cty|int|]
    ty2 = [cty|float|]

pat_args =
    "pat args" ~:   stms
               ~?=  [[cexp|2|], [cexp|3|]]
  where
    stms = case [cstm|f(1, 2, 3);|] of
             [cstm|f(1, $args:es);|] -> es
             _ -> []

exp_hexp =
    "exp hexp" ~:  [cexp|$ulint:(13 - 2*5)|]
               ~?= [cexp|3UL|]
