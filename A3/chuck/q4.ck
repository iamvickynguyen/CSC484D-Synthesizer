// https://www.math.drexel.edu/~dp399/musicmath/Intro_to_chuck.html

SndBuf mug1 => ADSR e1 => dac;
//SndBuf mug2 => ADSR e1 => dac;

e1.set(100::ms, 800::ms, 0,500::ms);

"../audio/mug1.wav" => mug1.read;
mug1.samples() => mug1.pos;

0 => mug1.pos;
e1.keyOn();
mug1.length() => now;
e1.keyOff();
