     area     appcode, CODE, READONLY
     export __main
	 ENTRY 
__main  function		 
              VLDR.f32 S3, = 1.0;  A fixed register to use value 1 anywhere
       VLDR.f32 S5, =1;
	   VLDR.f32 S11, =0;	     A fixed register to use value 0 anywhere
       VLDR.f32 S10,= 0 ; S10 ---> RESULT
       VLDR.f32 S12,= 1;  S12----> x 
       VLDR.f32 S2,= 0; S2----> SIGN
       VLDR.f32  S9,= 1 ;  S9--->COUNT
	   
T1 		VMOV.f32 S9,S5 ; adding value of S5(which is incremened in last step to S9.
		VMOV.f32 S8,S12 ; giving value of x(S12) to s8  
		VCMP.f32 S9,S3 ;
		VMRS APSR_nzcv,FPSCR
    ITTE GT
		
		VMULGT.F32 S8,S12,S8; multiplying x. //then part//
		VMOVGT.F32 S9,S3;
        
		VDIVLE.F32 S8,S8,S5;     //else part//
		VCMPLE.F32 S2,#0.0 ; 
		VMRS APSR_nzcv,FPSCR
		ITTE EQ;
		VADDEQ.f32 S10,S8,S10;    //to get +ve sign(Addition of terms)//
		VMOVEQ.f32 S2,S3;         
		VSUBNE.F32 S10,S8,S10;    //to get -ve sign(Substraction of terms)//
		VMOVNE.f32 S2,S10;        
		VADD.F32 S5,S5,S3;
		B T1 ;
	endfunc
	end
