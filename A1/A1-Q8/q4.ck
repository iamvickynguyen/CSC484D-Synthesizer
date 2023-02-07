PulseOsc p => dac;
440 => p.freq;
0.5 => p.width;
1::second=>now;


SawOsc s => dac;
440 => s.freq;
1::second=>now;


TriOsc t => dac;
440 => t.freq;
0.5 => t.width;
1::second=>now;

Noise n => dac;
1::second => now;
