system gui_example

root CALC_GUI (our_cluster): "make"

default precompiled ("$EIFFEL3/precomp/spec/$PLATFORM/mvision")

cluster our_cluster:           ".";

external

  object: "$(EIFFEL3)/library/vision/spec/$(PLATFORM)/lib/motif_Clib.a";
          "$(EIFFEL3)/library/vision/spec/$(PLATFORM)/lib/Xt.a";
          "-lXm -lXt -lX11"

end

