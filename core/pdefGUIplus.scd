
(
Window.closeAll;
Pdefn.removeAll;
Pdef.removeAll;

Pdef(\bob, Plazy{ arg in;
	Pbind(*in.asPairs)
})
.envir_((
	degree:0, octave:5, amp:1, 
));
e=Pdef(\bob).envir;
e.pairsDo{arg k,v; 
	Pdefn(("arp"++k).asSymbol, v)
}; k=e.keys;
z=(k.as(Array) +++( k.collect{arg w;("arp"++w).asSymbol.asRef}	))
.collect{arg x; [x[0], x[1].value]}
.flatten
;

Pdef(\bob).map(*z);

w=View(nil, 300@800).front; w.addFlowLayout;
PdefGui(Pdef(\bob),0,w);
a=PdefnAllGui(parent:w, bounds:300@300).filtering_(true).prefix_("arp");
a.filtBut.remove;a.filTextV.remove;


Pdef(\bob).trace.play;
)
