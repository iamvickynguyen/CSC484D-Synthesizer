// Instead of getting MIDI inputs with an infinite loop reading inputs
// I test with arrays

[783.99, 659.26, 523.25, 392.00] @=> float freqs[];
[1000, 1100, 1000, 1000] @=> int durations[];
[0.0, 1000.0, 3100.0, 4100.0] @=> float start[];

SinOsc s => dac;

// Keep track of current time
0 @=> int curtime;

0.0 => s.freq;
start[0]::ms => now;

freqs[0] => s.freq;
durations[0]::ms => now;

for (1 => int i; i < 4; i++) {
	if (start[i - 1] + durations[i - 1] >= start[i]) {
		freqs[i] => s.freq;
  	durations[i]::ms => now;
	} else {
		0.0 => s.freq;
		(start[i] - (start[i - 1] + durations[i - 1]))::ms => now;
		
		freqs[i] => s.freq;
  	durations[i]::ms => now;
	}
}
