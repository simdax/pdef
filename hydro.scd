// =====================================================================
// SuperCollider Workspace
// =====================================================================

// (

// "hydrogen".unixCmd;
// )
// MIDIClient.init;
// (
// var port=MIDIOut.findPort("Hydrogen", "Hydrogen Midi-In");
// MIDIOut(1).connect(port);
// )

// // test for notes
// (
// MIDIOut(1).noteOn(0, 42) // hh
// MIDIOut(1).noteOn(0, 49) // hh
// )

(
var q=4;
Pdef(\hh, Pbind(\midinote, 42, \amp, 0.1, \dur, 4.reciprocal).midi(1)).quant_(q);
Pdef(\splash, Pbind(\midinote, 49, \amp, 1, \dur, 8).midi(1)).quant_(q);
 Pdef(\met, Pbind(
	\chan, 1,
	\mtranspose, -13,
	\amp, [1, 0.25, 0.75, 0.25].iter.repeat,
	\degree,[1,2,1,2].flat.pseq(inf)
	//[1,2!((~q?4)-1)].flat.pseq(inf)
).midi(1)
).quant_(q);
)

