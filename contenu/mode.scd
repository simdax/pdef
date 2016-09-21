(Pdef( \mode,
	Pbind(
		\mode, [0,1].pseq(inf)
		.collect{arg x;
			Scale.major.degrees
			.differentiate.drop(1).rotate(x)
			.integrate.addFirst(0)
		},
		\do, Pfunc{arg in; Pdefn(\mode, in.mode)},
		\dur, 16
	)
).quant_([16, 0, 0.5])
)

