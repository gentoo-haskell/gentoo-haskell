-- We need 'FlexibleInstances to instance 'ArgVal' for 'Maybe Exp' and
-- '( String, Exp )'.
{-# LANGUAGE FlexibleInstances #-}
module Arith where

import Prelude hiding ( exp )
import System.Console.CmdTheLine hiding ( eval )
import Control.Applicative       hiding ( (<|>) )

import Control.Monad ( guard )
import Data.Char     ( isAlpha )
import Data.Function ( on )

import Text.Parsec
import qualified Text.PrettyPrint as PP

import qualified Data.Map as M

import System.IO

type Parser a = Parsec String () a

data Bin = Pow | Mul | Div | Add | Sub

prec :: Bin -> Int
prec b = case b of
  { Pow -> 3 ; Mul -> 2 ; Div -> 2 ; Add -> 1 ; Sub -> 1 }

assoc :: Bin -> Assoc
assoc b = case b of
  Pow -> R
  _   -> L

toFunc :: Bin -> (Int -> Int -> Int)
toFunc b = case b of
  { Pow -> (^) ; Mul -> (*) ; Div -> div ; Add -> (+) ; Sub -> (-) }

data Exp = IntExp Int
         | VarExp String
         | BinExp Bin Exp Exp

instance ArgVal Exp where
  converter = ( parser, pretty 0 )
    where
    parser = fromParsec onErr exp
    onErr str =  PP.text "invalid expression" PP.<+> PP.quotes (PP.text str)

instance ArgVal (Maybe Exp) where
  converter = just

instance ArgVal ( String, Exp ) where
  converter = pair '='

data Assoc = L | R

type Env = M.Map String Exp

catParsers :: [Parser String] -> Parser String
catParsers = foldl (liftA2 (++)) (return "")

integer :: Parser Int
integer = read <$> catParsers [ option "" $ string "-", many1 digit ]

tok :: Parser a -> Parser a
tok p = p <* spaces

parens :: Parser a -> Parser a
parens = between op cp
  where
  op = tok $ char '('
  cp = tok $ char ')'

-- Parse a terminal expression.
term :: Parser Exp
term = parens exp <|> int <|> var
  where
  int = tok $ IntExp <$> try integer -- Try so '-<not-digits>' won't fail.
  var = tok $ VarExp <$> many1 (satisfy isAlpha)

-- Parse a binary operator.
bin :: Parser Bin
bin = choice [ pow, mul, div, add, sub ]
  where
  pow = tok $ Pow <$ char '^'
  mul = tok $ Mul <$ char '*'
  div = tok $ Div <$ char '/'
  add = tok $ Add <$ char '+'
  sub = tok $ Sub <$ char '-'

exp :: Parser Exp
exp = e 0

-- Precedence climbing expressions.  See
-- <www.engr.mun.ca/~theo/Misc/exp_parsing.htm> for further information.
e :: Int -> Parser Exp
e p = do
  t <- term
  try (go t) <|> return t
  where
  go e1 = do
    b <- bin
    guard $ prec b >= p

    let q = case assoc b of
          R -> prec b
          L -> prec b + 1
    e2 <- e q

    let expr = BinExp b e1 e2
    try (go expr) <|> return expr

-- Beta reduce by replacing variables in 'e' with values in 'env'.
beta :: Env -> Exp -> Maybe Exp
beta env e = case e of
  VarExp str     -> M.lookup str env
  int@(IntExp _) -> return int
  BinExp b e1 e2 -> (liftA2 (BinExp b) `on` beta env) e1 e2

eval :: Exp -> Int
eval e = case e of
  VarExp str     -> error $ "saw VarExp " ++ str ++ " while evaluating"
  IntExp i       -> i
  BinExp b e1 e2 -> (toFunc b `on` eval) e1 e2

pretty :: Int -> Exp -> PP.Doc
pretty p e = case e of
  VarExp str     -> PP.text str
  IntExp i       -> PP.int i
  BinExp b e1 e2 -> let q = prec b
                    in  parensOrNot q $ PP.cat [ pretty q e1, ppBin b, pretty q e2 ]
  where
  parensOrNot q = if q < p then PP.parens else id

ppBin :: Bin -> PP.Doc
ppBin b = case b of
  Pow -> PP.char '^'
  Mul -> PP.char '*'
  Div -> PP.char '/'
  Add -> PP.char '+'
  Sub -> PP.char '-'

arith :: Bool -> [( String, Exp )] -> Exp -> IO ()
arith pp assoc = maybe badEnv method . beta (M.fromList assoc)
  where
  method = if pp then print . pretty 0 else print . eval
  badEnv = hPutStrLn stderr "arith: bad environment"

arithTerm :: Term (IO ())
arithTerm = arith <$> pp <*> env <*> e
  where
  pp = value $ flag (optInfo [ "pretty", "p" ])
     { optName = "PP"
     , optDoc  = "If present, pretty print instead of evaluating EXP."
     }

  env = nonEmpty $ posRight 0 [] posInfo
      { posName = "ENV"
      , posDoc  = "One or more assignments of the form '<name>=<exp>' to be "
               ++ "substituted in the input expression."
      }

  e = required $ pos 0 Nothing posInfo
    { posName = "EXP"
    , posDoc  = "An arithmetic expression to be evaluated."
    }

termInfo :: TermInfo
termInfo = defTI
  { termName = "arith"
  , version  = "0.3"
  , termDoc  = "Evaluate mathematical functions demonstrating precedence "
           ++ "climbing and instantiating 'ArgVal' for tuples and Parsec "
           ++ "parsers."
  , man      = [ S "BUGS"
              , P "Email bug reports to <fitsCarolDo@example.com>"
              ]
  }
