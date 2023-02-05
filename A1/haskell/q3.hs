import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import Data.Foldable

data Note = Note { start :: Float, duration :: Float, midi :: Int }
data Signal = Signal { on :: Int, samples :: [Float] }


generateSound :: Note -> Signal 
generateSound note = Signal noteon points 
 where
  freq = 440
  srate = 44100
  f = (1.0 * freq/32) * (2 ** ((fromIntegral (midi note) - 9)/12))
  t = [0,1.0/srate..(duration note)]
  points = map (\x -> sin(2 * pi * f * x)) t
  noteon = ceiling (srate * (start note))

parseNote :: String -> Note
parseNote row = Note s d m
 where
  [a, b, c] = words row
  s = (read :: String -> Float) a
  d = (read :: String -> Float) b
  m = (read :: String -> Int) c

-- put Signal into correct position of the output list
combineSound :: [Float] -> Int -> [Signal] -> [Float]
combineSound xs i [] = xs
combineSound xs i ys 
 | startindex <= i = combineSound (xs ++ points) (i + (length points)) (tail ys)
 | otherwise = combineSound (xs ++ zeros) startindex ys
 where
  hd = head ys
  startindex = on hd
  points = samples hd
  offset = startindex - i
  zeros = take offset $ repeat 0


main :: IO()
main = do
 contents <- getContents
 let notes = filter (\note -> start note /= -1) $ map parseNote $ lines contents
 let sound = map generateSound notes
 let output = combineSound [] 0 sound
 B.writeFile "out.bin" $ B.toLazyByteString $ fold $ map B.floatLE output

