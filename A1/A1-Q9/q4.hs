import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import System.Random
import Data.Foldable

sawtooth :: [Float] -> [Float]
sawtooth samples =
 map (\x -> (x - pi)/pi) samples

triangle :: [Float] -> [Float]
triangle samples =
 map (\x -> 1 - 2 * x) absSawtooth
 where
  stooth = sawtooth samples
  absSawtooth = map abs stooth

pulse :: [Float] -> [Float]
pulse samples =
 map (\x -> if (ceiling(x) `mod` 10) < 5 then 1.0 else 0.0) samples

noise :: [Float] -> [Float]
noise samples =
 take (length samples) randomRIO(0,1::Float) 

main :: IO()
main = do
 let srate = 44100
 let duration = 3
 let x = [0, 1.0/srate..(duration)]
 print (length x)
 let sawtoothWave = sawtooth x 
 B.writeFile "sawtooth.bin" $ B.toLazyByteString $ fold $ map B.floatLE sawtoothWave
 print (length x)
 let triangleWave = triangle x
 B.writeFile "triangle.bin" $ B.toLazyByteString $ fold $ map B.floatLE triangleWave
 print (length x)
 let pulseWave = pulse x
 B.writeFile "pulse.bin" $ B.toLazyByteString $ fold $ map B.floatLE pulseWave
 print (length x)
 let noiseSound = noise x
 B.writeFile "noise.bin" $ B.toLazyByteString $ fold $ map B.floatLE noiseSound
