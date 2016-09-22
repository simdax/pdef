(
var a="core/timbre,core/accords,core/mel,hydro".split($,);
var orig, size;

if(MIDIClient.initialized.not){MIDIClient.init};

Pdef.removeAll;
Pdefn.removeAll;
Window.closeAll;

orig = Window.screenBounds.extent * (3/4); size=280@700;

a.collect(_++".scd").do(_.loadRelative);
w=FlowView(nil,size.asRect.postln.origin_(orig)).front;

a=PdefAllGui(parent:w, bounds:Rect(0,0,260,150), numItems:8).filtering_(true);

EZSlider(w,250@20,"tempo",[0.1,9,\exp,0.1,1])
.value_(TempoClock.tempo)
.action_{arg self; TempoClock.tempo=self.value};

PdefnAllGui(8,parent:w,bounds:260@200).filtering_(true);
PdefGui(Pdef(\_accords),0,w);

MIDICTL();
defer{w.parent.alwaysOnTop_(true)};
MIDICTL.window.alwaysOnTop_(true);
CmdPeriod.add({Zyn.panic});


// GROSSSSSE GUI
"core/newVoice.scd".loadRelative
)
