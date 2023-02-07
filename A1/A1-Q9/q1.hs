import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import Data.Foldable

sinewave :: [Float]
sinewave =
 map (\x -> sin(2 * pi * freq * x)) t
 where
  srate = 44100
  duration = 2
  freq = 440
  t = [0,1/srate..duration]
   
main :: IO()
main = do
 B.writeFile "out.bin" $ B.toLazyByteString $ fold $ map B.floatLE sinewave
