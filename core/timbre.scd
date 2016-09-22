(

~gui={ arg name, parent;
	// la vue
	var w=FlowView(parent, 280@300);
	// les envirs
	var env=Pdef(name).envir;
	var envS=Pdefn(("_"++name++"sortie").asSymbol).envir;
	// les gui
	PdefGui(Pdef(name),env.size,parent:w);
	envS.pairsDo{arg k,v; PdefnGuiPlus(v, parent:w)};
	//Pdefn(envS++"leg")!?{PdefnGuiPlus(Pdefn(envS++"leg"),parent:w)};
	w
};

~dispatch={arg name, parent, chans, durs, template=\periode;
	var dictChan;
	var n=(name).asSymbol;
	var sortie=("_"++name++"sortie").asSymbol;
	template.switch(
		\periode,{Pdef(template).copy(n).set(\sortieFinale, sortie)},
		{Pdef(template).copy(n).set(\instrument, sortie)}
	).quant_(16);
	Pdefn(sortie, {arg in;
		Pstep(in.chans,	in.dur)
	}).map(
		\chans, (sortie++"chans").asSymbol,
		\dur, (sortie++"dur").asSymbol
	);
	(Pdefn(sortie).envir.values.asArray+++
		[chans,durs].collect{arg x; x.asArray.pseq(inf).asRef}
	).do{arg k;
		k[0].source_(k[1].value)
	};
	Pdef(sortie,
			//			MIDIOut(0).allNotesOff(chan);
			Pbind(
				\type, \midi,\midiout, MIDIOut(0),
				\chan, Pdefn(sortie).asStream,
				//		\legato, Pdefn(sortie++"leg").asStream,
				\do, Pfunc{arg in;
					in.midiout.allNotesOff(in.chan)
				}
			)
	);
	~gui.(name,parent)
};


~new={arg ... args;
	~dispatch.(*args)
};


)