package Integer_Toy_Impl {
    import AADL::*;
	import AADL_Project::*;
	import Integer_Toy::*;

	part def top_level :> System {

		in port Input : DataPort { in :> type : ScalarValues::Integer; }
		out port Output : DataPort { out :> type : ScalarValues::Integer; }
		
		language "agree" /* 
	  		eq mode : int;
			assume "System input range " : Input < 10;
			guarantee "mode is always positive" : mode >= 0;
			guarantee "System output range" : Output < 50;
		*/
	}

	part def 'top_level.Impl' :> top_level {
		part a : Integer_Toy::A;
		part b : Integer_Toy::B;
		part c : Integer_Toy::C;

		connection IN_TO_A : PortConnection connect Input to a.Input;
		connection A_TO_B : PortConnection connect a.Output to b.Input;
		connection A_TO_C : PortConnection connect a.Output to c.Input1;
		connection B_TO_C : PortConnection connect b.Output to c.Input2;
		connection C_TO_OUTPIT : PortConnection connect c.Output to Output;
		language "agree" /*
		assign mode = Integer_Toy::timesOne(c.mode);
		*/
	}
}