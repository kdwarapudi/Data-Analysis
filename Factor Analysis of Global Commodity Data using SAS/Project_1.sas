libname mydata '/folders/myfolders/';

data mydata.marketdata;
	infile '/folders/myfolders/data15.csv' dlm=',' firstobs=9;
	input PBEVE_Index	PCOCO_USD	PCOFFOTM_USD	PROIL_USD	PCOPP_USD	PCOTTIND_USD	PFISH_USD	PHIDE_USD	
	PIORECR_USD	 PLAMB_USD	PLEAD_USD	PNICK_USD	POILAPSP_USD	POILDUB_USD	POLVOIL_USD	PORANG_USD	PPORK_USD
	PPOULT_USD	PSALM_USD	PSAWMAL_USD	PSAWORE_USD	PSHRI_USD	PSMEA_USD	PURAN_USD	PWHEAMT_USD	PZINC_USD;
run;
	      
	 
proc contents data=mydata.marketdata;
run;	 
/* Handling Missing Values*/
proc means data=mydata.marketdata NMISS N; run;

/* Checking the file using the Proc freq, None of my columns have any missing values and all my columns are numeric  */

*Correlation to find if factor analysis is necessary;
proc corr data=mydata.marketdata rank;
run;
 
/* Looking at the correlation distribution, we see that some of the variables are highly correlated */

proc standard data=mydata.marketdata mean=0 std=1 out=mydata.marketplace_std;
run;


/*no rotations */
PROC FACTOR DATA=mydata.marketplace_std 
            SCREE;
        
   TITLE "Factor Analysis of Principal dataset";
 
RUN;


/*varimax*/
PROC FACTOR DATA=mydata.marketplace_std 
			rotate=varimax
			nfactors=4
            SCREE;
        
   TITLE "Factor Analysis of Principal dataset VARIMAX";
 
RUN;

/*promax*/
ods trace on/listing;
PROC FACTOR DATA=mydata.marketplace_std 
			rotate=promax
			nfactors=4
            SCREE;
ods output OrthRotFactPat=Rotated;        
   TITLE "Factor Analysis of Principal dataset PROMAX";
RUN;
ods trace off;