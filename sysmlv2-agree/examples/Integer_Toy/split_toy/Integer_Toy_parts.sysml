package Integer_Toy {
	import AADL::*;
	import AADL_Project::*;
	import AgreeLibrary::*;

	language "agree" /*
		fun timesOne(i : int) : int = i * 1;
	*/

	part def A :> System {
		in port Input : DataPort { in :> type : ScalarValues::Integer; }
		out port Output : DataPort { out :> type : ScalarValues::Integer; }
		language "agree" /*
			assume "A input range" : Input < 20;
			guarantee "A output range" : Output < 2*Input;
		*/
	}

	part def B :> System {
		in port Input : DataPort { in :> type : ScalarValues::Integer; }
		out port Output : DataPort { out :> type : ScalarValues::Integer; }
		language "agree" /* 
			assume "B input range" : Input < 20;
			guarantee "B output range" : Output < Input + 15;
		*/
	}

	part def C :> System {
		in port Input1 : DataPort { in :> type : ScalarValues::Integer; }
		in port Input2 : DataPort { in :> type : ScalarValues::Integer; }
		out port Output : DataPort { out :> type : ScalarValues::Integer; }

		language "agree" /* 
	  		eq mode : int;
	  
	  		guarantee "mode always is increasing" : mode >= 0 -> mode > pre(mode);
			guarantee "C output range" : Output = if mode = 3 then (Input1 + Input2) else 0;
		*/
	}
}