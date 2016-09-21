(

~dispatch={arg name, chans, durs, template=\periode;
	var dictChan;
	var n=(name).asSymbol;
	var sortie=("_"++name++"sortie").asSymbol;
	template.switch(
		\periode,{Pdef(template).copy(n).set(\sortieFinale, sortie)},
		{Pdef(template).copy(n).set(\instrument, sortie)}
	);
	Pdefn(sortie, {arg in;
		Pstep(in.chans,	in.dur)
	}).map(
		\chans, (sortie++"chans").asSymbol,
		\dur, (sortie++"dur").asSymbol
	);
	(Pdefn(sortie).envir.values.asArray+++
		[chans,durs].collect{arg x; x.asArray.pseq(inf).asRef}
	)	
	.do{arg k;
		k[0].source_(k[1].value)
	};
	Pdef(sortie, Pbind(
		\type, \midi,\midiout, MIDIOut(0),
		\chan, Pdefn(sortie).asStream,
		//		\legato, Pdefn(sortie++"leg").asStream
	));
	~gui.(name)
};


~gui={ arg name;
	// la vue
	var w=FlowView();
	// les envirs
	var env=Pdef(name).envir;
	var envS=Pdefn(("_"++name++"sortie").asSymbol).envir;
	// les gui
	PdefGui(Pdef(name),env.size,parent:w);
	envS.pairsDo{arg k,v; PdefnGui(v, parent:w)};
	Pdefn(envS++"leg")!?{PdefnGui(Pdefn(envS++"leg"),parent:w)}
};

)