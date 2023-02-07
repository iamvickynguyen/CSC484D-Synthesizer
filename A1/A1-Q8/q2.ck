// Instead of getting MIDI inputs with an infinite loop reading inputs
// I test with arrays

[783.99, 659.26, 523.25, 392.00] @=> float freqs[];
[1000, 1100, 1000, 1000] @=> int durations[];

SinOsc s => dac;

for (0 => int i; i < 4; i++) {
	freqs[i] => s.freq;
  durations[i]::ms => now;
}
