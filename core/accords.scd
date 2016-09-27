(

Pdefn(\basse, \tourn);
Pdefn(\scale, [0,2,4]);
Pdefn(\mode, \major);
Pdefn(\rythmeH, 1);

//// accords
// s'occupent d'agencer les accords par rapport à une basse
// pour l'instant, c'est juste fait avec PCHORDS, et en gros,
// on reste entre si et la

// TODO ===> drop2 bidule
Pdef(\_accords,
	{ arg basse=Pdefn(\basse),durH=Pdefn(\rythmeH);
		Pbind(
			\type, \rest,
			\basse, basse.collect{arg x; if(x==6){4}{x}},
			\accord, 
			p{ arg in;
				in.basse.postln.switch(
					\cad, [3,4,0,0],
					\demi,[0,3,4,4],
					\tourn,[0,0,3,4],
					in.basse.asArray
				).postln.iter.embedInStream(in)		
			}.repeat,
			\degree, Pchords(Pkey(\accord)).collect{arg x;Pdefn(\scale,x)},
			\stretch, durH
		)
	}
).quant_([16, 0, 0]);

// arpeggiation
// s'occupe d'arpéger les accords
Pdef(\_arp,	
	Pbind(
  		\type, \phrase,
		\degree, PdegreeToKey(		Pkey(\degree), Pdefn(\scale), 7),
		\scale, Pdefn(\mode).collect(Scale.at(_)),
	) <> ~master.repeat
).quant_(16)
.envir_(
	(
		degree: [0,1,2,1],
		mtranspose: [0],
		octave: [0]+5,
		dur: 0.5
	)
);


)




