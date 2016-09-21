(
Pdefn(\scale, [0,4,7]);
Pdefn(\mode, Scale.major);

//// accords
// s'occupent d'agencer les accords par rapport à une basse
// pour l'instant, c'est juste fait avec PCHORDS, et en gros,
// on reste entre si et la

// TODO ===> drop2 bidule
Pdef(\accords,
	{ arg basse=Pdefn(\basse),durH=Pdefn(\durHarmonique);
		Pbind(
			\type, \rest,
			\accord, basse.collect{arg x; if(x==6){4}{x}},
			\degree, Pchords(Pkey(\accord)),
			\do, Pfunc{arg in;
				Pdefn(\scale, in.degree);
				("chgt scale : "++Pdefn(\scale).source).postln;
				0},
			\stretch, durH
		)
}).quant_([16,0,0.5]);

// arpeggiation
// s'occupe d'arpéger les accords
Pdef(\arp,	
	Pbind(
		\type, \phrase,
		\degree, [0,1,2,1].pseq(inf),
		\mtranspose, [0, 0,[0,1],0].pseq(inf),
		\octave, 5+[-1,1,-1,1].iter.repeat,
		\scale, PdegreeToKey(
			Pdefn(\scale),
			Pdefn(\mode)
		),
		\dur, 8.reciprocal,
	)
).quant_(16);


)



