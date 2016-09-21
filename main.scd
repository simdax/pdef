(
var a="core/accords,core/mel,hydro".split($,);

Pdef.removeAll;
Window.closeAll;

a.collect(_++".scd").do(_.loadRelative);
w=FlowView().front;

a=PdefAllGui(parent:w, numItems:10).filtering_(true);
defer{w.parent.alwaysOnTop_(true)};
{
	var orig= Window.screenBounds.extent * (3/4), size=280@300;
	w.parent.bounds_(size.asRect.origin_(orig))
}.value;
w.decorator.nextLine;
EZSlider(w,250@20,"tempo",[0.1,9,\exp,0.1,1])
.value_(TempoClock.tempo)
.action_{arg self; TempoClock.tempo=self.value};

MIDICTL()



)




