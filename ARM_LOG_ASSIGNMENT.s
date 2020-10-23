     area     appcode, CODE, READONLY
     export __main
	 ENTRY 
__main  function		
              VLDR.f32 S0, = 1.0;  A fixed register to use value 1 anywhere
       VLDR.f32 S1, =1;
	   VLDR.f32 S11, =0;	     A fixed register to use value 0 anywhere
       VLDR.f32 S5,= 0 ; S5 ---> RESULT
       VLDR.f32 S12,= 0.3;  S12----> x 
       VLDR.f32 S2,= 0; S2---->A FLAG USED FOR SIGN
       VLDR.f32  S3,= 1 ;  S3--->COUNT
	   
T1 		VMOV.f32 S3,S1 ; adding value of S1(which is incremened in last step to S3.
		VMOV.f32 S4,S12 ; giving value of x(S12) to s4
T3		VCMP.f32 S3,S0 ;   //if value of count LE to 1, branch to division and sign block(T2)// 
		VMRS APSR_nzcv,FPSCR ; //for updating flags//
    
		BLE T2         ;   //Then part//
		VMULGT.F32 S4,S12,S4; multiplying x
		VSUBGT.F32 S3,S3,S0;
        BGT T3
T2		VDIVLE.F32 S4,S4,S1;     //else part//
		VCMPLE.F32 S2,#0.0 ; 
		VMRS APSR_nzcv,FPSCR
		VADDEQ.f32 S5,S4,S5;    //to get +ve sign(Addition of terms)//
		VMOVEQ.f32 S2,S0;         //Update flag//
		VSUBNE.F32 S5,S5,S4;    //to get -ve sign(Substraction of terms)//
		VMOVNE.f32 S2,S11;        //Update flag//
		VADD.F32 S1,S1,S0;        // increasing count value for furthur terms//
		B T1 ;
	endfunc
	end
;If u GIVE ln(1+0.3) and get correct result that is 0.262. 
