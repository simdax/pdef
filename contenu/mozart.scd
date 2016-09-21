(
a=[
	(1->    [0,0,4,0,3,0,4,0]),
	(0.5->  [3,0,4,0,1,1]),
	(2->    [4,0,4,0,4,4,4,4])
]// ==
// 0,0,4,4,0,0,4,4,
// 0,3,6,2,5,1,4,0,
// 1,1,1,1,0,0,4,4
)
(
var q=16;

v=a.collect(_.value);
k=a.collect{arg x,i; [x.key,v[i].size]};
Pdefn(\basse, v.collect(_.pseq).pseq(inf)).quant_(q);
Pdefn(\durHarmonique, k.collect{arg x; Pn(x[0],x[1])}.pseq(inf).reciprocal).quant_(q);
)



