a=Pbind()<>

a=Pbind(*(a:Pseq([0])).asPairs)
a.trace.play

(
Window.closeAll;
Pdefn.removeAll;
Pdef.removeAll;

Pdef(\bob, Plazy{ arg in;
	Pbind(*in.asPairs)
})
.envir_((
	degree:3, chien:8
));
e=Pdef(\bob).envir;
e.pairsDo{arg k,v; 
	Pdefn(("arp"++k).asSymbol, v)
};
z=(e.keys.as(Array) +++
	(
		e.keys
		.collect{arg w;("arp"++w).asSymbol.asRef}
	))
.collect{arg x; [x[0], x[1].value]}
.flatten
;

Pdef(\bob).map(*z);

//w=FlowView();
a=
{arg p;
	var a=PdefnAllGui(parent:p).filtering_(true).prefix_("arp");
	a.filtBut.remove;a.filTextV.remove;a
};

b=PdefGui( Pdef(\bob), numItems:16, options:a);

Pdef(\bob).trace.play;
)
