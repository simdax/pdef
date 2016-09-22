(

FlowView(bounds:Rect(100,100,280,320)).flow{arg p;
	Button(p,250@30)
	.string_("add").action_{ arg self;
		fork{
			var vue;
			var nom=FlowVar();
			var i, value;
			defer{TextField(nil,self.absoluteBounds).front
				.keyDownAction_{arg s, c, m, u;
					if(u==13){
						nom.value=s.value;
						s.remove;
					}
				}
			};
			nom.value;
			defer{
				i=t.add(nom.value.postln);
				vue=FlowView(i).flow{ arg view;
					Button(view,120@15).string_("remove")
					.action_{
						Pdef.at(nom.value.asSymbol).remove;
						t.removeAt(*(t.views.selectIndices(_==i)))
					};
					~new.(nom.value.asSymbol, view);
				}
			}
		}
	};
	t=TabbedView2(p,300@300);
}
)

