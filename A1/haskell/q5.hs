import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Builder as B
import Data.Foldable

data WavetableOscillator = WavetableOscillator
{
 phaseIndex :: Float,
 tableLength :: Int,
 waveTable :: a,
 nSamples :: Int,
 points :: [Float],
 freq :: Int,
 srate :: Int
}
