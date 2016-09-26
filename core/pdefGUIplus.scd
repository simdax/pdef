
a=Pbind()<>

a=Pbind(*(a:Pseq([0])).asPairs)
a.trace.play

(
Pdefn.removeAll;
Pdef.removeAll;

Pdef(\bob, Plazy{ arg in;
	in.postln;
	Pbind(*in.asPairs)
})
.envir_((
	degree:3, chien:8
));
e=Pdef(\bob).envir;
e.pairsDo{arg k,v; 
	Pdefn(("arp"++k).asSymbol, v.postln).postln
};
z=(e.keys.as(Array) +++ (e.keys.collectAs({arg w;("arp"++w).asSymbol}, Array).collect(_.asRef)))
.collect{arg x; [x[0], x[1].value]}
.flatten
;
z.postln;
Pdef(\bob).map(*z); 
PdefnAllGui().filtering_(true).prefix_("arp");
Pdef(\bob).trace.play;
)

Pdefn("arpchien").source
Pdefn(\prout).source

Set[3]+++Set[9,3]

Pdef.removeAll
Pdefn(\degree).iter.next

Pdef(\bob).envir