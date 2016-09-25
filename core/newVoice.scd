(
~nV={arg parent;
	FlowView(parent:parent,bounds:Rect(100,100,280,320))
	.alwaysOnTop_(true)
	.flow{arg p;
		Button(p,250@30)
		.string_("add").action_{ arg self;
			fork{
				var tmpVue, cboxes, tField;
				var vue, template;
				var nom=FlowVar();
				var i, value;
				var stopF={arg s, c, m, u;
					if(u==13){
						nom.value=tField.value;
						tmpVue.remove;
					}
				};
				defer{
					tmpVue=View(nil,self.absoluteBounds).front
					.layout_(
						VLayout(
							tField=TextField(),//.addAction({false},\keyDownAction),
							*cboxes=[\arp,\periode].collect{ arg x,i;
								CheckBox().string_(x).action_{ arg self;
									template=x;
									cboxes.removing(cboxes[i]).do{arg x;
										x.value=self.value.not}
								}.value_(i.asBoolean.not)
							}
						)
					);
					template=\arp;
					tmpVue.children.do{arg x; x.keyDownAction=(stopF)};
				};
				nom.value;
				defer{
					i=t.add(nom.value);
					vue=FlowView(i).flow{ arg view;
						Button(view,120@15).string_("remove")
						.action_{
							Pdef.at(nom.value.asSymbol).remove;
							t.removeAt(*(t.views.selectIndices(_==i)))
						};
						~new.(nom.value.asSymbol, view,
							("_"++template).asSymbol
						);
					}
				}
			}
		};
		t=TabbedView2(p,300@300);
	}
};

)