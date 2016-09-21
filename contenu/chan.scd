Pdef(\chan,
	Pseq([
		Pbind(
			\chan, [0,1,2,3,4].pseq(inf),
			\do, Pfunc{ arg in;
				Pdefn(\chan, in.chan)
			},
			\dur,16
		),		
	]
	)
).quant_(16)

