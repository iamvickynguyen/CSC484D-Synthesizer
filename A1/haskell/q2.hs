import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import Data.Foldable

data Note = Note { midi :: Int, duration :: Float }

generateSound :: Note -> [Float]
generateSound note =
 map (\x -> sin(2 * pi * f * x)) t
 where
  freq = 440
  srate = 44100
  f = (1.0 * freq/32) * (2 ** ((fromIntegral (midi note) - 9)/12))
  t = [0,1.0/srate..(duration note)]

testNote :: String -> String
testNote s =
 show m ++ " : " ++ show d
 where
  [a, b] = words s
  m = (read :: String -> Int) a
  d = (read :: String -> Float) b


parseNote :: String -> Note
parseNote s = Note m d
 where
  [a, b] = words s
  m = (read :: String -> Int) a
  d = (read :: String -> Float) b

main :: IO()
main = do
 contents <- getContents
 let notes = map parseNote $ lines contents
 let sound = concat $ map generateSound notes
 B.writeFile "out.bin" $ B.toLazyByteString $ fold $ map B.floatLE sound
