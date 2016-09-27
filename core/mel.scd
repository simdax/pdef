// =====================================================================
// SuperCollider Workspace
// =====================================================================

(

//MIDIOut(0).latency=0;
// def val

"utils.scd".loadRelative;

Pdefn(\base, 0);
// pdefs list
// remove and redef for clean
"sortie,_appo,_triade,_p,periode".split($,)
.do{arg x; Pdef(x.asSymbol).remove};


Pdef(\_sortie, Pbind(\type, \midi, \midiout, MIDIOut(0)));

Pdef(\_appo, { arg sortieFinale=\_sortie,
	degree, note, dur,decoupe,
	seedH,seedR,
	reso=8, chan
	//	chan=Pdefn(\chan);
	;
	Pbind(
		\type, \phrase, \instrument, sortieFinale,
		\degree, note.value,
		//		\chan, 
		\mtranspose, Pseed(seedH, Pseq([Prand((-2..2), decoupe), 0])),
		\scale, Pdefn(\mode).collect(Scale.at(_)),
		\stepsPerOctave, 12,
		\dur, dur * (Pseed(seedR, Plazy{reso.partition((decoupe+1)).iter})/reso)
	)
});
	
Pdef(\_triade, { arg dur, chan=0, base=0,
	sortieFinale=\sortie,
	seedR, seedH,
	finale,
	degree, note, lag;
	Pseq([
		Rest(dur*lag),
		Pbind(
			\type, \phrase,	\instrument, \_appo, \legato, 1,
			\degree, degree,
			\decoupe,  Pseed(seedH, Pseq([0, Prand([0,1,2],inf)])),
			\mtranspose, Pseed(seedH, Pseq([0, Pwhite(-2, 2)])),
			\dur, Pconst( dur*finale,
				Pseed(seedR,// 1,
					Pseq([Prand([2, [1,1].pseq]), 1,1], inf)
				)
			),
			\scale, Pdefn(\scale),
			\stepsPerOctave, 7
		)//([\scale, \degree, \mtranspose, \note])
		, Rest(0.005), // important ?
		Pbind(
			\type, \phrase, \instrument, sortieFinale,
			\hasGate, false,
			\degree, PdegreeToKey(
				degree,
				Pdefn(\scale),
			),
			\legato, 0.5,
			\scale, Pdefn(\mode).collect(Scale.at(_)),
			\stepsPerOctave, 12, 
		) 
	]) 
});

Pdef(\_p,
	{ arg seedR="aaba", seedH="cdef",
		squelette="1020",
		dur=8, degree=0, base=Pdefn(\base), reso="4682";
		var nb=max(seedR.size, seedH.size);
		Pbind(
			\type, \phrase, \instrument, \_triade,
			\legato, 1,
			\dur, [4].pseq(inf), 
			\reso, reso.collectAs(_.digit, Array).pseq(inf),
			\degree, squelette.collectAs(_.digit, Array).pseq(inf),
			\finale, [0.75, 0.75, 0.75, 0.5].pseq(inf),//[1,0.5,0.5].pseq(inf),
			\seedR, seedR.collectAs(_.digit, Array).pseq(inf)+base,
			\seedH, seedH.collectAs(_.digit, Array).pseq(inf)+base,
		)
	}
).quant_(8);

Pdef(\_periode,
	Pbind(
		\type, \phrase, \instrument, \_p, \legato, 1,
	) <> ~master.repeat
)
.envir_((
	squelette:Array.rand(4,0,2).collect(_.asString),
	reso:["1241"],
	dur: [16],
	seedH:["aaba"],
	seedR:["abac"],
	sortieFinale:\_sortie,
))
.quant_(16);


)


