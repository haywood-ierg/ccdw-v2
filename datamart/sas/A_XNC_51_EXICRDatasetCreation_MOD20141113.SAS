*************************************************************************************
* CREATED BY:   Paul G. Earls                                                       *
* DATE CREATED: 02-09-2007                                                          *
* MODIFIED1:    Summer 2010                                                         *
* REQUESTOR:    Planning and Research                                               *
* PURPOSE:      Extension ICR Dataset Creation                                      *
*               For All Terms                                                       *
*************************************************************************************;
OPTIONS PS=5000 LS=256 NONUMBER NOCENTER;

LIBNAME pge5 'H:\Planning and Research FTP\CPCCSASDatasets\A_XNC_Datatel\Downloads\SASDatasets\01_Class';
LIBNAME pge6 'H:\Planning and Research FTP\CPCCSASDatasets\A_XNC_Datatel\Downloads\';
LIBNAME pge7 'H:\Planning and Research FTP\ICR\Datatel\';
LIBNAME pge8 'H:\Planning and Research FTP\CPCCSASDatasets\A_XNC_Datatel\Downloads\SASDatasets\20_ICR\';

%LET lb01=pge6;
%LET pt01=H:\Planning and Research FTP\CPCCSASDatasets\A_XNC_Datatel\Downloads\Archive\ICR\201702\;   /* UPDATE TERM */
%LET ds01=ICR_;
%LET rp01=EXT_;
%LET pr01=2;		* CHANGE VARIABLE;
%LET yr01=2017;		* CHANGE VARIABLE;
%LET yt01=201702;	* CHANGE VARIABLE;
%LET in01=_818;

/*
%LET lb02=pge6;
%LET ds02=E_;
%LET rp02=FTE;
%LET yt02=142;		* CHANGE VARIABLE;
*/

%LET lb02b=pge8;
%LET ds02b=E_;
%LET rp02b=FTE;
%LET yt02b=172;		* CHANGE VARIABLE;

%LET lb03=pge7;
%LET pt03=H:\Planning and Research FTP\ICR\Datatel\;
%LET ds03=E_;
%LET rp03=FTE_;
%LET yt03=SUM17;	* CHANGE VARIABLE;

%LET lb04=pge5;
%LET ds04=CL_;
%LET rp04=_ET;
%LET rp05=_pET;		* FOR LATEST TERM DATASET;
%LET yt04a=201602;		* CHANGE VARIABLE;
%LET yt04b=201603;		* CHANGE VARIABLE;
%LET yt04c=201701;		* CHANGE VARIABLE;
%LET yt04d=201702;		* CHANGE VARIABLE;

*%LET pf01=SSS;		*NOT APPLICABLE TO EXTENSION ICR;
%LET pf02=ZZZ;

DATA classrec (KEEP=
			ADCInst
			ADCRptPeriod
			ADCRptYear
			ADCCCCPrefix
			ADCSpFundCode
			ADCImmureCodes
			ADCCCCNumber
			ADCInstUseField
			ADCCCCSection
			ADCOn_Off
			ADCCounty
			ADCHourType
			ADCStuCt
			ADCBasSkl
			ADCLrnLab
			ADCOccExt
			ADCSSOE
			ADCFocIT
			ADCHRD
			ADCNewInd
			ADCSmBus
			ADCComSvc
			ADCSSNO
			ADCTotHrs
			ADCCampus
			ADCMethod
			ADCSchedHrs
			ADCClassID
			ADCContrctAgcy
			ADCRptTerm

)
	zzz__rec (KEEP=
			ADCInst
			ADCRptPeriod
			ADCRptYear
			ADCCCCPrefix
			ADCCCCNumber
			ADCCCCSection
			ADCBasSkl
			ADCLrnLab
			ADCOccExt
			ADCSSOE
			ADCFocIT
			ADCNewInd
			ADCSmBus
			ADCComSvc
			ADCSSNO
			ADCTotHrs
			ADCCampus
			ADCPrefix
			ADCNumber
);
FORMAT ADCRptTerm $6.
		ADCBasSkl_TEMP2 $6.
		ADCLrnLab_TEMP2 $6.
		ADCOccExt_TEMP2 $6.
		ADCSSOE_TEMP2 $6.
		ADCFocIT_TEMP2 $6.
		ADCNewInd_TEMP2 $6.
		ADCSmBus_TEMP2 $6.
		ADCComSvc_TEMP2 $6.
		ADCSSNO_TEMP2 $6.
		ADCTotHrs_TEMP2 $6.
		ADCBasSkl 8.
		ADCLrnLab 8.
		ADCOccExt 8.
		ADCSSOE 8.
		ADCFocIT 8.
		ADCHRD 8.
		ADCNewInd 8.
		ADCSmBus 8.
		ADCComSvc 8.
		ADCSSNO 8.
		ADCTotHrs 8.
		ADCPrefix $4.
		ADCNumber $10.
;
INFILE "&pt01&ds01&rp01&yt01&in01" TRUNCOVER;
INPUT @7 ADCRptPeriod $1. @8 ADCRptYear $4. @14 ADCCCCPrefix $3. @;
	SELECT;
	WHEN (ADCRptPeriod EQ "&pr01" AND ADCRptYear EQ "&yr01" 
			AND (ADCCCCPrefix NE "&pf02")) DO;
		INPUT 
			@1		ADCInst			$3.
			@7		ADCRptPeriod	$1.
			@8		ADCRptYear		$4.
			@14		ADCCCCPrefix	$3.
			@17		ADCSpFundCode	$1.
			@18		ADCImmureCodes	$1.
			@19		ADCCCCNumber	$4.
			@23		ADCInstUseField	$1.
			@24		ADCCCCSection	$3.
			@27		ADCOn_Off		$1.
			@28		ADCCounty		$3.
			@31		ADCHourType		$2.
			@35 	ADCStuCt		 3.
			@38		ADCBasSkl		 5.
			@43		ADCLrnLab		 5.
			@48		ADCOccExt		 5.
			@53		ADCSSOE			 5.
			@58		ADCFocIT		 5.
			@63		ADCHRD			 5.
			@68		ADCNewInd		 5.
			@73		ADCSmBus		 5.
			@83		ADCComSvc		 5.
			@88		ADCSSNO			 5.
			@93		ADCTotHrs		 5.
			@98		ADCCampus		$4.
			@102	ADCMethod		$2.
			@104	ADCSchedHrs		 5.1
			@109	ADCClassID		$7.
			@116	ADCContrctAgcy	$3.
;
ADCRptTerm=ADCRptYear||'0'||ADCRptPeriod;

		OUTPUT classrec;
	END;
	WHEN (ADCRptPeriod EQ "&pr01" AND ADCRptYear EQ "&yr01" 
								AND (ADCCCCPrefix EQ 'ZZZ')) DO;
		INPUT 
			@1		ADCInst			$3.
			@7		ADCRptPeriod	$1.
			@8		ADCRptYear		$4.
			@14		ADCCCCPrefix	$3.
			@19		ADCCCCNumber	$4.
			@24		ADCCCCSection	$3.
			@38		ADCBasSkl_TEMP1	$5.
			@43		ADCLrnLab_TEMP1	$5.
			@48		ADCOccExt_TEMP1	$5.
			@53		ADCSSOE_TEMP1	$5.
			@58		ADCFocIT_TEMP1	$5.
			@68		ADCNewInd_TEMP1	$5.
			@73		ADCSmBus_TEMP1	$5.
			@83		ADCComSvc_TEMP1	$5.
			@88		ADCSSNO_TEMP1	$5.
			@93		ADCTotHrs_TEMP1	$5.
			@98		ADCCampus		$4.
			@107	ADCPrefix		$4.
			@110	ADCNumber		$10.
;
ADCRptTerm=ADCRptYear||'0'||ADCRptPeriod;
ADCPrefix=(UPCASE(ADCPrefix));
			IF (SUBSTR(ADCBasSkl_TEMP1,5,1)) EQ 'J'
				THEN ADCBasSkl_TEMP2='-'||(SUBSTR(ADCBasSkl_TEMP1,1,4))||'1';
			ELSE IF (SUBSTR(ADCBasSkl_TEMP1,5,1)) EQ 'K'
				THEN ADCBasSkl_TEMP2='-'||(SUBSTR(ADCBasSkl_TEMP1,1,4))||'2';
			ELSE IF (SUBSTR(ADCBasSkl_TEMP1,5,1)) EQ 'L'
				THEN ADCBasSkl_TEMP2='-'||(SUBSTR(ADCBasSkl_TEMP1,1,4))||'3';
			ELSE IF (SUBSTR(ADCBasSkl_TEMP1,5,1)) EQ 'M'
				THEN ADCBasSkl_TEMP2='-'||(SUBSTR(ADCBasSkl_TEMP1,1,4))||'4';
			ELSE IF (SUBSTR(ADCBasSkl_TEMP1,5,1)) EQ 'N'
				THEN ADCBasSkl_TEMP2='-'||(SUBSTR(ADCBasSkl_TEMP1,1,4))||'5';
			ELSE IF (SUBSTR(ADCBasSkl_TEMP1,5,1)) EQ 'O'
				THEN ADCBasSkl_TEMP2='-'||(SUBSTR(ADCBasSkl_TEMP1,1,4))||'6';
			ELSE IF (SUBSTR(ADCBasSkl_TEMP1,5,1)) EQ 'P'
				THEN ADCBasSkl_TEMP2='-'||(SUBSTR(ADCBasSkl_TEMP1,1,4))||'7';
			ELSE IF (SUBSTR(ADCBasSkl_TEMP1,5,1)) EQ 'Q'
				THEN ADCBasSkl_TEMP2='-'||(SUBSTR(ADCBasSkl_TEMP1,1,4))||'8';
			ELSE IF (SUBSTR(ADCBasSkl_TEMP1,5,1)) EQ 'R'
				THEN ADCBasSkl_TEMP2='-'||(SUBSTR(ADCBasSkl_TEMP1,1,4))||'9';
			ELSE IF (SUBSTR(ADCBasSkl_TEMP1,5,1)) EQ '}'
				THEN ADCBasSkl_TEMP2='-'||(SUBSTR(ADCBasSkl_TEMP1,1,4))||'0';
			ELSE ADCBasSkl_TEMP2='0'||(SUBSTR(ADCBasSkl_TEMP1,1,5));
			ADCBasSkl=INPUT(ADCBasSkl_TEMP2,6.);
			IF (SUBSTR(ADCLrnLab_TEMP1,5,1)) EQ 'J'
				THEN ADCLrnLab_TEMP2='-'||(SUBSTR(ADCLrnLab_TEMP1,1,4))||'1';
			ELSE IF (SUBSTR(ADCLrnLab_TEMP1,5,1)) EQ 'K'
				THEN ADCLrnLab_TEMP2='-'||(SUBSTR(ADCLrnLab_TEMP1,1,4))||'2';
			ELSE IF (SUBSTR(ADCLrnLab_TEMP1,5,1)) EQ 'L'
				THEN ADCLrnLab_TEMP2='-'||(SUBSTR(ADCLrnLab_TEMP1,1,4))||'3';
			ELSE IF (SUBSTR(ADCLrnLab_TEMP1,5,1)) EQ 'M'
				THEN ADCLrnLab_TEMP2='-'||(SUBSTR(ADCLrnLab_TEMP1,1,4))||'4';
			ELSE IF (SUBSTR(ADCLrnLab_TEMP1,5,1)) EQ 'N'
				THEN ADCLrnLab_TEMP2='-'||(SUBSTR(ADCLrnLab_TEMP1,1,4))||'5';
			ELSE IF (SUBSTR(ADCLrnLab_TEMP1,5,1)) EQ 'O'
				THEN ADCLrnLab_TEMP2='-'||(SUBSTR(ADCLrnLab_TEMP1,1,4))||'6';
			ELSE IF (SUBSTR(ADCLrnLab_TEMP1,5,1)) EQ 'P'
				THEN ADCLrnLab_TEMP2='-'||(SUBSTR(ADCLrnLab_TEMP1,1,4))||'7';
			ELSE IF (SUBSTR(ADCLrnLab_TEMP1,5,1)) EQ 'Q'
				THEN ADCLrnLab_TEMP2='-'||(SUBSTR(ADCLrnLab_TEMP1,1,4))||'8';
			ELSE IF (SUBSTR(ADCLrnLab_TEMP1,5,1)) EQ 'R'
				THEN ADCLrnLab_TEMP2='-'||(SUBSTR(ADCLrnLab_TEMP1,1,4))||'9';
			ELSE IF (SUBSTR(ADCLrnLab_TEMP1,5,1)) EQ '}'
				THEN ADCLrnLab_TEMP2='-'||(SUBSTR(ADCLrnLab_TEMP1,1,4))||'0';
			ELSE ADCLrnLab_TEMP2='0'||(SUBSTR(ADCLrnLab_TEMP1,1,5));
			ADCLrnLab=INPUT(ADCLrnLab_TEMP2,6.);
			IF (SUBSTR(ADCOccExt_TEMP1,5,1)) EQ 'J'
				THEN ADCOccExt_TEMP2='-'||(SUBSTR(ADCOccExt_TEMP1,1,4))||'1';
			ELSE IF (SUBSTR(ADCOccExt_TEMP1,5,1)) EQ 'K'
				THEN ADCOccExt_TEMP2='-'||(SUBSTR(ADCOccExt_TEMP1,1,4))||'2';
			ELSE IF (SUBSTR(ADCOccExt_TEMP1,5,1)) EQ 'L'
				THEN ADCOccExt_TEMP2='-'||(SUBSTR(ADCOccExt_TEMP1,1,4))||'3';
			ELSE IF (SUBSTR(ADCOccExt_TEMP1,5,1)) EQ 'M'
				THEN ADCOccExt_TEMP2='-'||(SUBSTR(ADCOccExt_TEMP1,1,4))||'4';
			ELSE IF (SUBSTR(ADCOccExt_TEMP1,5,1)) EQ 'N'
				THEN ADCOccExt_TEMP2='-'||(SUBSTR(ADCOccExt_TEMP1,1,4))||'5';
			ELSE IF (SUBSTR(ADCOccExt_TEMP1,5,1)) EQ 'O'
				THEN ADCOccExt_TEMP2='-'||(SUBSTR(ADCOccExt_TEMP1,1,4))||'6';
			ELSE IF (SUBSTR(ADCOccExt_TEMP1,5,1)) EQ 'P'
				THEN ADCOccExt_TEMP2='-'||(SUBSTR(ADCOccExt_TEMP1,1,4))||'7';
			ELSE IF (SUBSTR(ADCOccExt_TEMP1,5,1)) EQ 'Q'
				THEN ADCOccExt_TEMP2='-'||(SUBSTR(ADCOccExt_TEMP1,1,4))||'8';
			ELSE IF (SUBSTR(ADCOccExt_TEMP1,5,1)) EQ 'R'
				THEN ADCOccExt_TEMP2='-'||(SUBSTR(ADCOccExt_TEMP1,1,4))||'9';
			ELSE IF (SUBSTR(ADCOccExt_TEMP1,5,1)) EQ '}'
				THEN ADCOccExt_TEMP2='-'||(SUBSTR(ADCOccExt_TEMP1,1,4))||'0';
			ELSE ADCOccExt_TEMP2='0'||(SUBSTR(ADCOccExt_TEMP1,1,5));
			ADCOccExt=INPUT(ADCOccExt_TEMP2,6.);
			IF (SUBSTR(ADCSSOE_TEMP1,5,1)) EQ 'J'
				THEN ADCSSOE_TEMP2='-'||(SUBSTR(ADCSSOE_TEMP1,1,4))||'1';
			ELSE IF (SUBSTR(ADCSSOE_TEMP1,5,1)) EQ 'K'
				THEN ADCSSOE_TEMP2='-'||(SUBSTR(ADCSSOE_TEMP1,1,4))||'2';
			ELSE IF (SUBSTR(ADCSSOE_TEMP1,5,1)) EQ 'L'
				THEN ADCSSOE_TEMP2='-'||(SUBSTR(ADCSSOE_TEMP1,1,4))||'3';
			ELSE IF (SUBSTR(ADCSSOE_TEMP1,5,1)) EQ 'M'
				THEN ADCSSOE_TEMP2='-'||(SUBSTR(ADCSSOE_TEMP1,1,4))||'4';
			ELSE IF (SUBSTR(ADCSSOE_TEMP1,5,1)) EQ 'N'
				THEN ADCSSOE_TEMP2='-'||(SUBSTR(ADCSSOE_TEMP1,1,4))||'5';
			ELSE IF (SUBSTR(ADCSSOE_TEMP1,5,1)) EQ 'O'
				THEN ADCSSOE_TEMP2='-'||(SUBSTR(ADCSSOE_TEMP1,1,4))||'6';
			ELSE IF (SUBSTR(ADCSSOE_TEMP1,5,1)) EQ 'P'
				THEN ADCSSOE_TEMP2='-'||(SUBSTR(ADCSSOE_TEMP1,1,4))||'7';
			ELSE IF (SUBSTR(ADCSSOE_TEMP1,5,1)) EQ 'Q'
				THEN ADCSSOE_TEMP2='-'||(SUBSTR(ADCSSOE_TEMP1,1,4))||'8';
			ELSE IF (SUBSTR(ADCSSOE_TEMP1,5,1)) EQ 'R'
				THEN ADCSSOE_TEMP2='-'||(SUBSTR(ADCSSOE_TEMP1,1,4))||'9';
			ELSE IF (SUBSTR(ADCSSOE_TEMP1,5,1)) EQ '}'
				THEN ADCSSOE_TEMP2='-'||(SUBSTR(ADCSSOE_TEMP1,1,4))||'0';
			ELSE ADCSSOE_TEMP2='0'||(SUBSTR(ADCSSOE_TEMP1,1,5));
			ADCSSOE=INPUT(ADCSSOE_TEMP2,6.);
			IF (SUBSTR(ADCFocIT_TEMP1,5,1)) EQ 'J'
				THEN ADCFocIT_TEMP2='-'||(SUBSTR(ADCFocIT_TEMP1,1,4))||'1';
			ELSE IF (SUBSTR(ADCFocIT_TEMP1,5,1)) EQ 'K'
				THEN ADCFocIT_TEMP2='-'||(SUBSTR(ADCFocIT_TEMP1,1,4))||'2';
			ELSE IF (SUBSTR(ADCFocIT_TEMP1,5,1)) EQ 'L'
				THEN ADCFocIT_TEMP2='-'||(SUBSTR(ADCFocIT_TEMP1,1,4))||'3';
			ELSE IF (SUBSTR(ADCFocIT_TEMP1,5,1)) EQ 'M'
				THEN ADCFocIT_TEMP2='-'||(SUBSTR(ADCFocIT_TEMP1,1,4))||'4';
			ELSE IF (SUBSTR(ADCFocIT_TEMP1,5,1)) EQ 'N'
				THEN ADCFocIT_TEMP2='-'||(SUBSTR(ADCFocIT_TEMP1,1,4))||'5';
			ELSE IF (SUBSTR(ADCFocIT_TEMP1,5,1)) EQ 'O'
				THEN ADCFocIT_TEMP2='-'||(SUBSTR(ADCFocIT_TEMP1,1,4))||'6';
			ELSE IF (SUBSTR(ADCFocIT_TEMP1,5,1)) EQ 'P'
				THEN ADCFocIT_TEMP2='-'||(SUBSTR(ADCFocIT_TEMP1,1,4))||'7';
			ELSE IF (SUBSTR(ADCFocIT_TEMP1,5,1)) EQ 'Q'
				THEN ADCFocIT_TEMP2='-'||(SUBSTR(ADCFocIT_TEMP1,1,4))||'8';
			ELSE IF (SUBSTR(ADCFocIT_TEMP1,5,1)) EQ 'R'
				THEN ADCFocIT_TEMP2='-'||(SUBSTR(ADCFocIT_TEMP1,1,4))||'9';
			ELSE IF (SUBSTR(ADCFocIT_TEMP1,5,1)) EQ '}'
				THEN ADCFocIT_TEMP2='-'||(SUBSTR(ADCFocIT_TEMP1,1,4))||'0';
			ELSE ADCFocIT_TEMP2='0'||(SUBSTR(ADCFocIT_TEMP1,1,5));
			ADCFocIT=INPUT(ADCFocIT_TEMP2,6.);
			IF (SUBSTR(ADCNewInd_TEMP1,5,1)) EQ 'J'
				THEN ADCNewInd_TEMP2='-'||(SUBSTR(ADCNewInd_TEMP1,1,4))||'1';
			ELSE IF (SUBSTR(ADCNewInd_TEMP1,5,1)) EQ 'K'
				THEN ADCNewInd_TEMP2='-'||(SUBSTR(ADCNewInd_TEMP1,1,4))||'2';
			ELSE IF (SUBSTR(ADCNewInd_TEMP1,5,1)) EQ 'L'
				THEN ADCNewInd_TEMP2='-'||(SUBSTR(ADCNewInd_TEMP1,1,4))||'3';
			ELSE IF (SUBSTR(ADCNewInd_TEMP1,5,1)) EQ 'M'
				THEN ADCNewInd_TEMP2='-'||(SUBSTR(ADCNewInd_TEMP1,1,4))||'4';
			ELSE IF (SUBSTR(ADCNewInd_TEMP1,5,1)) EQ 'N'
				THEN ADCNewInd_TEMP2='-'||(SUBSTR(ADCNewInd_TEMP1,1,4))||'5';
			ELSE IF (SUBSTR(ADCNewInd_TEMP1,5,1)) EQ 'O'
				THEN ADCNewInd_TEMP2='-'||(SUBSTR(ADCNewInd_TEMP1,1,4))||'6';
			ELSE IF (SUBSTR(ADCNewInd_TEMP1,5,1)) EQ 'P'
				THEN ADCNewInd_TEMP2='-'||(SUBSTR(ADCNewInd_TEMP1,1,4))||'7';
			ELSE IF (SUBSTR(ADCNewInd_TEMP1,5,1)) EQ 'Q'
				THEN ADCNewInd_TEMP2='-'||(SUBSTR(ADCNewInd_TEMP1,1,4))||'8';
			ELSE IF (SUBSTR(ADCNewInd_TEMP1,5,1)) EQ 'R'
				THEN ADCNewInd_TEMP2='-'||(SUBSTR(ADCNewInd_TEMP1,1,4))||'9';
			ELSE IF (SUBSTR(ADCNewInd_TEMP1,5,1)) EQ '}'
				THEN ADCNewInd_TEMP2='-'||(SUBSTR(ADCNewInd_TEMP1,1,4))||'0';
			ELSE ADCNewInd_TEMP2='0'||(SUBSTR(ADCNewInd_TEMP1,1,5));
			ADCNewInd=INPUT(ADCNewInd_TEMP2,6.);
			IF (SUBSTR(ADCSmBus_TEMP1,5,1)) EQ 'J'
				THEN ADCSmBus_TEMP2='-'||(SUBSTR(ADCSmBus_TEMP1,1,4))||'1';
			ELSE IF (SUBSTR(ADCSmBus_TEMP1,5,1)) EQ 'K'
				THEN ADCSmBus_TEMP2='-'||(SUBSTR(ADCSmBus_TEMP1,1,4))||'2';
			ELSE IF (SUBSTR(ADCSmBus_TEMP1,5,1)) EQ 'L'
				THEN ADCSmBus_TEMP2='-'||(SUBSTR(ADCSmBus_TEMP1,1,4))||'3';
			ELSE IF (SUBSTR(ADCSmBus_TEMP1,5,1)) EQ 'M'
				THEN ADCSmBus_TEMP2='-'||(SUBSTR(ADCSmBus_TEMP1,1,4))||'4';
			ELSE IF (SUBSTR(ADCSmBus_TEMP1,5,1)) EQ 'N'
				THEN ADCSmBus_TEMP2='-'||(SUBSTR(ADCSmBus_TEMP1,1,4))||'5';
			ELSE IF (SUBSTR(ADCSmBus_TEMP1,5,1)) EQ 'O'
				THEN ADCSmBus_TEMP2='-'||(SUBSTR(ADCSmBus_TEMP1,1,4))||'6';
			ELSE IF (SUBSTR(ADCSmBus_TEMP1,5,1)) EQ 'P'
				THEN ADCSmBus_TEMP2='-'||(SUBSTR(ADCSmBus_TEMP1,1,4))||'7';
			ELSE IF (SUBSTR(ADCSmBus_TEMP1,5,1)) EQ 'Q'
				THEN ADCSmBus_TEMP2='-'||(SUBSTR(ADCSmBus_TEMP1,1,4))||'8';
			ELSE IF (SUBSTR(ADCSmBus_TEMP1,5,1)) EQ 'R'
				THEN ADCSmBus_TEMP2='-'||(SUBSTR(ADCSmBus_TEMP1,1,4))||'9';
			ELSE IF (SUBSTR(ADCSmBus_TEMP1,5,1)) EQ '}'
				THEN ADCSmBus_TEMP2='-'||(SUBSTR(ADCSmBus_TEMP1,1,4))||'0';
			ELSE ADCSmBus_TEMP2='0'||(SUBSTR(ADCSmBus_TEMP1,1,5));
			ADCSmBus=INPUT(ADCSmBus_TEMP2,6.);
			IF (SUBSTR(ADCComSvc_TEMP1,5,1)) EQ 'J'
				THEN ADCComSvc_TEMP2='-'||(SUBSTR(ADCComSvc_TEMP1,1,4))||'1';
			ELSE IF (SUBSTR(ADCComSvc_TEMP1,5,1)) EQ 'K'
				THEN ADCComSvc_TEMP2='-'||(SUBSTR(ADCComSvc_TEMP1,1,4))||'2';
			ELSE IF (SUBSTR(ADCComSvc_TEMP1,5,1)) EQ 'L'
				THEN ADCComSvc_TEMP2='-'||(SUBSTR(ADCComSvc_TEMP1,1,4))||'3';
			ELSE IF (SUBSTR(ADCComSvc_TEMP1,5,1)) EQ 'M'
				THEN ADCComSvc_TEMP2='-'||(SUBSTR(ADCComSvc_TEMP1,1,4))||'4';
			ELSE IF (SUBSTR(ADCComSvc_TEMP1,5,1)) EQ 'N'
				THEN ADCComSvc_TEMP2='-'||(SUBSTR(ADCComSvc_TEMP1,1,4))||'5';
			ELSE IF (SUBSTR(ADCComSvc_TEMP1,5,1)) EQ 'O'
				THEN ADCComSvc_TEMP2='-'||(SUBSTR(ADCComSvc_TEMP1,1,4))||'6';
			ELSE IF (SUBSTR(ADCComSvc_TEMP1,5,1)) EQ 'P'
				THEN ADCComSvc_TEMP2='-'||(SUBSTR(ADCComSvc_TEMP1,1,4))||'7';
			ELSE IF (SUBSTR(ADCComSvc_TEMP1,5,1)) EQ 'Q'
				THEN ADCComSvc_TEMP2='-'||(SUBSTR(ADCComSvc_TEMP1,1,4))||'8';
			ELSE IF (SUBSTR(ADCComSvc_TEMP1,5,1)) EQ 'R'
				THEN ADCComSvc_TEMP2='-'||(SUBSTR(ADCComSvc_TEMP1,1,4))||'9';
			ELSE IF (SUBSTR(ADCComSvc_TEMP1,5,1)) EQ '}'
				THEN ADCComSvc_TEMP2='-'||(SUBSTR(ADCComSvc_TEMP1,1,4))||'0';
			ELSE ADCComSvc_TEMP2='0'||(SUBSTR(ADCComSvc_TEMP1,1,5));
			ADCComSvc=INPUT(ADCComSvc_TEMP2,6.);
			IF (SUBSTR(ADCSSNO_TEMP1,5,1)) EQ 'J'
				THEN ADCSSNO_TEMP2='-'||(SUBSTR(ADCSSNO_TEMP1,1,4))||'1';
			ELSE IF (SUBSTR(ADCSSNO_TEMP1,5,1)) EQ 'K'
				THEN ADCSSNO_TEMP2='-'||(SUBSTR(ADCSSNO_TEMP1,1,4))||'2';
			ELSE IF (SUBSTR(ADCSSNO_TEMP1,5,1)) EQ 'L'
				THEN ADCSSNO_TEMP2='-'||(SUBSTR(ADCSSNO_TEMP1,1,4))||'3';
			ELSE IF (SUBSTR(ADCSSNO_TEMP1,5,1)) EQ 'M'
				THEN ADCSSNO_TEMP2='-'||(SUBSTR(ADCSSNO_TEMP1,1,4))||'4';
			ELSE IF (SUBSTR(ADCSSNO_TEMP1,5,1)) EQ 'N'
				THEN ADCSSNO_TEMP2='-'||(SUBSTR(ADCSSNO_TEMP1,1,4))||'5';
			ELSE IF (SUBSTR(ADCSSNO_TEMP1,5,1)) EQ 'O'
				THEN ADCSSNO_TEMP2='-'||(SUBSTR(ADCSSNO_TEMP1,1,4))||'6';
			ELSE IF (SUBSTR(ADCSSNO_TEMP1,5,1)) EQ 'P'
				THEN ADCSSNO_TEMP2='-'||(SUBSTR(ADCSSNO_TEMP1,1,4))||'7';
			ELSE IF (SUBSTR(ADCSSNO_TEMP1,5,1)) EQ 'Q'
				THEN ADCSSNO_TEMP2='-'||(SUBSTR(ADCSSNO_TEMP1,1,4))||'8';
			ELSE IF (SUBSTR(ADCSSNO_TEMP1,5,1)) EQ 'R'
				THEN ADCSSNO_TEMP2='-'||(SUBSTR(ADCSSNO_TEMP1,1,4))||'9';
			ELSE IF (SUBSTR(ADCSSNO_TEMP1,5,1)) EQ '}'
				THEN ADCSSNO_TEMP2='-'||(SUBSTR(ADCSSNO_TEMP1,1,4))||'0';
			ELSE ADCSSNO_TEMP2='0'||(SUBSTR(ADCSSNO_TEMP1,1,5));
			ADCSSNO=INPUT(ADCSSNO_TEMP2,6.);
			IF (SUBSTR(ADCTotHrs_TEMP1,5,1)) EQ 'J'
				THEN ADCTotHrs_TEMP2='-'||(SUBSTR(ADCTotHrs_TEMP1,1,4))||'1';
			ELSE IF (SUBSTR(ADCTotHrs_TEMP1,5,1)) EQ 'K'
				THEN ADCTotHrs_TEMP2='-'||(SUBSTR(ADCTotHrs_TEMP1,1,4))||'2';
			ELSE IF (SUBSTR(ADCTotHrs_TEMP1,5,1)) EQ 'L'
				THEN ADCTotHrs_TEMP2='-'||(SUBSTR(ADCTotHrs_TEMP1,1,4))||'3';
			ELSE IF (SUBSTR(ADCTotHrs_TEMP1,5,1)) EQ 'M'
				THEN ADCTotHrs_TEMP2='-'||(SUBSTR(ADCTotHrs_TEMP1,1,4))||'4';
			ELSE IF (SUBSTR(ADCTotHrs_TEMP1,5,1)) EQ 'N'
				THEN ADCTotHrs_TEMP2='-'||(SUBSTR(ADCTotHrs_TEMP1,1,4))||'5';
			ELSE IF (SUBSTR(ADCTotHrs_TEMP1,5,1)) EQ 'O'
				THEN ADCTotHrs_TEMP2='-'||(SUBSTR(ADCTotHrs_TEMP1,1,4))||'6';
			ELSE IF (SUBSTR(ADCTotHrs_TEMP1,5,1)) EQ 'P'
				THEN ADCTotHrs_TEMP2='-'||(SUBSTR(ADCTotHrs_TEMP1,1,4))||'7';
			ELSE IF (SUBSTR(ADCTotHrs_TEMP1,5,1)) EQ 'Q'
				THEN ADCTotHrs_TEMP2='-'||(SUBSTR(ADCTotHrs_TEMP1,1,4))||'8';
			ELSE IF (SUBSTR(ADCTotHrs_TEMP1,5,1)) EQ 'R'
				THEN ADCTotHrs_TEMP2='-'||(SUBSTR(ADCTotHrs_TEMP1,1,4))||'9';
			ELSE IF (SUBSTR(ADCTotHrs_TEMP1,5,1)) EQ '}'
				THEN ADCTotHrs_TEMP2='-'||(SUBSTR(ADCTotHrs_TEMP1,1,4))||'0';
			ELSE ADCTotHrs_TEMP2='0'||(SUBSTR(ADCTotHrs_TEMP1,1,5));
			ADCTotHrs=INPUT(ADCTotHrs_TEMP2,6.);
DROP	ADCBasSkl_TEMP1
		ADCLrnLab_TEMP1
		ADCOccExt_TEMP1
		ADCSSOE_TEMP1
		ADCFocIT_TEMP1
		ADCNewInd_TEMP1
		ADCSmBus_TEMP1
		ADCComSvc_TEMP1
		ADCSSNO_TEMP1
		ADCTotHrs_TEMP1
		ADCBasSkl_TEMP2
		ADCLrnLab_TEMP2
		ADCOccExt_TEMP2
		ADCSSOE_TEMP2
		ADCFocIT_TEMP2
		ADCNewInd_TEMP2
		ADCSmBus_TEMP2
		ADCComSvc_TEMP2
		ADCSSNO_TEMP2
		ADCTotHrs_TEMP2;
		OUTPUT zzz__rec;
	END;
	OTHERWISE DO;
	PUT 'Error in record ' _n_ 'as follows:' _INFILE_;
		DELETE;
	END;
END;
RUN;

DATA Class01 (KEEP=
				ADCClassID
				ADCPrefix
				ADCNumber
				ADCSection
				ADCClsTerm
);
FORMAT
				ADCPrefix $4.
				ADCNumber $10.
				ADCSection $6.
				ADCClsTerm $8.
;
SET &lb04 .&ds04&yt04a&rp04
	&lb04 .&ds04&yt04b&rp04
	&lb04 .&ds04&yt04c&rp04
	&lb04 .&ds04&yt04d&rp05
;
ADCPrefix=ADCClsPrefix;
ADCNumber=ADCClsNumber;
ADCSection=ADCClsSection;
ADCClassID=ADCClsID;
*ADCClsTerm=ADCTerm;
PROC SORT NODUPKEY DATA=Class01; BY ADCClassID;
RUN;

DATA classrec2;
FORMAT
				ADCPrefix $4.
				ADCNumber $10.
				ADCSection $6.
				ADCClsTerm $8.
;
SET classrec;
* BEGIN - FOR MANUAL CORRECTIONS TO Match01b;
* BEGIN - SUMMER 2010;
/*
IF ADCClassID EQ '     ' 
	AND ADCCCCPrefix EQ 'EMS' 
	AND ADCCCCNumber EQ '3050'
	AND ADCCCCSection EQ '66'
	THEN ADCPrefix='EMT';
IF ADCClassID EQ '     ' 
	AND ADCCCCPrefix EQ 'EMS' 
	AND ADCCCCNumber EQ '3050'
	AND ADCCCCSection EQ '66'
	THEN ADCNumber='7370';
IF ADCClassID EQ '     ' 
	AND ADCCCCPrefix EQ 'EMS' 
	AND ADCCCCNumber EQ '3050'
	AND ADCCCCSection EQ '66'
	THEN ADCSection='66';
IF ADCClassID EQ '     ' 
	AND ADCCCCPrefix EQ 'EMS' 
	AND ADCCCCNumber EQ '3050'
	AND ADCCCCSection EQ '66'
	THEN ADCClsTerm='2010CE2';
IF ADCClassID EQ '     ' 
	AND ADCCCCPrefix EQ 'EMS' 
	AND ADCCCCNumber EQ '3050'
	AND ADCCCCSection EQ '66'
	THEN ADCStuCt='27';
*/
* END - SUMMER 2010;
* BEGIN - FALL 2010;
/*
IF ADCClassID EQ '61517' THEN ADCPrefix='EMT';
IF ADCClassID EQ '61517' THEN ADCNumber='7300';
IF ADCClassID EQ '61517' THEN ADCSection='07';
IF ADCClassID EQ '61517' THEN ADCClsTerm='2009CE3';
IF ADCClassID EQ '76207' THEN ADCPrefix='HSD';
IF ADCClassID EQ '76207' THEN ADCNumber='6005';
IF ADCClassID EQ '76207' THEN ADCSection='20';
IF ADCClassID EQ '76207' THEN ADCClsTerm='2010CE3';
*/
* END - FALL 2010;
* BEGIN - SPRING 2012;
/*
IF ADCClassID EQ '106379' THEN ADCPrefix='MTG';
IF ADCClassID EQ '106379' THEN ADCNumber='7222';
IF ADCClassID EQ '106379' THEN ADCSection='90';
IF ADCClassID EQ '106379' THEN ADCClsTerm='2012CE1';
IF ADCClassID EQ '106382' THEN ADCPrefix='CTP';
IF ADCClassID EQ '106382' THEN ADCNumber='7531';
IF ADCClassID EQ '106382' THEN ADCSection='01';
IF ADCClassID EQ '106382' THEN ADCClsTerm='2012CE1';
IF ADCClassID EQ '106383' THEN ADCPrefix='CTP';
IF ADCClassID EQ '106383' THEN ADCNumber='7611';
IF ADCClassID EQ '106383' THEN ADCSection='01';
IF ADCClassID EQ '106383' THEN ADCClsTerm='2012CE1';
IF ADCClassID EQ '106412' THEN ADCPrefix='CTP';
IF ADCClassID EQ '106412' THEN ADCNumber='7433';
IF ADCClassID EQ '106412' THEN ADCSection='40';
IF ADCClassID EQ '106412' THEN ADCClsTerm='2012CE1';
IF ADCClassID EQ '106476' THEN ADCPrefix='EMT';
IF ADCClassID EQ '106476' THEN ADCNumber='7368';
IF ADCClassID EQ '106476' THEN ADCSection='61';
IF ADCClassID EQ '106476' THEN ADCClsTerm='2012CE1';
*/
* END - SPRING 2012;
* BEGIN - SUMMER 2012;
/*
IF ADCClassID EQ '111109' THEN ADCPrefix='PSX';
IF ADCClassID EQ '111109' THEN ADCNumber='8020';
IF ADCClassID EQ '111109' THEN ADCSection='02';
IF ADCClassID EQ '111109' THEN ADCClsTerm='2012CE2';
IF ADCClassID EQ '111113' THEN ADCPrefix='PSX';
IF ADCClassID EQ '111113' THEN ADCNumber='8020';
IF ADCClassID EQ '111113' THEN ADCSection='03';
IF ADCClassID EQ '111113' THEN ADCClsTerm='2012CE2';
IF ADCClassID EQ '105535' THEN ADCPrefix='BUS';
IF ADCClassID EQ '105535' THEN ADCNumber='7116';
IF ADCClassID EQ '105535' THEN ADCSection='01';
IF ADCClassID EQ '105535' THEN ADCClsTerm='2012CE2';
IF ADCClassID EQ '105907' THEN ADCPrefix='MTG';
IF ADCClassID EQ '105907' THEN ADCNumber='7222';
IF ADCClassID EQ '105907' THEN ADCSection='01';
IF ADCClassID EQ '105907' THEN ADCClsTerm='2012CE2';
IF ADCClassID EQ '111205' THEN ADCPrefix='AUX';
IF ADCClassID EQ '111205' THEN ADCNumber='7254';
IF ADCClassID EQ '111205' THEN ADCSection='03';
IF ADCClassID EQ '111205' THEN ADCClsTerm='2012CE2';
*/
* END - SUMMER 2012;
* BEGIN - SPRING 2013;
/*
IF ADCClassID EQ '119963' THEN ADCPrefix='BUS';
IF ADCClassID EQ '119963' THEN ADCNumber='7116';
IF ADCClassID EQ '119963' THEN ADCSection='01';
IF ADCClassID EQ '119963' THEN ADCClsTerm='2013CE2';
IF ADCClassID EQ '124447' THEN ADCPrefix='WLX';
IF ADCClassID EQ '124447' THEN ADCNumber='7103';
IF ADCClassID EQ '124447' THEN ADCSection='50';
IF ADCClassID EQ '124447' THEN ADCClsTerm='2013CE1';
IF ADCClassID EQ '124449' THEN ADCPrefix='WLX';
IF ADCClassID EQ '124449' THEN ADCNumber='8106';
IF ADCClassID EQ '124449' THEN ADCSection='50';
IF ADCClassID EQ '124449' THEN ADCClsTerm='2013CE1';
IF ADCClassID EQ '124534' THEN ADCPrefix='CTP';
IF ADCClassID EQ '124534' THEN ADCNumber='7017';
IF ADCClassID EQ '124534' THEN ADCSection='04';
IF ADCClassID EQ '124534' THEN ADCClsTerm='2013CE1';
IF ADCClassID EQ '124572' THEN ADCPrefix='BUX';
IF ADCClassID EQ '124572' THEN ADCNumber='8031';
IF ADCClassID EQ '124572' THEN ADCSection='90';
IF ADCClassID EQ '124572' THEN ADCClsTerm='2013CE1';
IF ADCClassID EQ '124575' THEN ADCPrefix='ISM';
IF ADCClassID EQ '124575' THEN ADCNumber='7200';
IF ADCClassID EQ '124575' THEN ADCSection='90';
IF ADCClassID EQ '124575' THEN ADCClsTerm='2013CE1';
IF ADCClassID EQ '124577' THEN ADCPrefix='ISM';
IF ADCClassID EQ '124577' THEN ADCNumber='7124';
IF ADCClassID EQ '124577' THEN ADCSection='93';
IF ADCClassID EQ '124577' THEN ADCClsTerm='2013CE1';
IF ADCClassID EQ '124578' THEN ADCPrefix='ISM';
IF ADCClassID EQ '124578' THEN ADCNumber='7201';
IF ADCClassID EQ '124578' THEN ADCSection='91';
IF ADCClassID EQ '124578' THEN ADCClsTerm='2013CE1';
IF ADCClassID EQ '124579' THEN ADCPrefix='ISM';
IF ADCClassID EQ '124579' THEN ADCNumber='7202';
IF ADCClassID EQ '124579' THEN ADCSection='92';
IF ADCClassID EQ '124579' THEN ADCClsTerm='2013CE1';
*/
* END - SPRING 2013;
* BEGIN CORRECTIONS FOR SUMMER 2013;
/*IF ADCClassID EQ '122872' THEN DO;
	ADCPrefix='BUS';
	ADCNumber='7116';
	ADCSection='01';
	ADCClsTerm='2013CE2';
	END;
IF ADCClassID EQ '123064' THEN DO;
	ADCPrefix='BUS';
	ADCNumber='7116';
	ADCSection='02';
	ADCClsTerm='2013CE2';
	END;
*/
* END CORRECTIONS FOR SUMMER 2013;
* BEGIN CORRECTIONS FOR SUMMER 2014;
/*
IF ADCClassID EQ '144064' THEN DO;
	ADCPrefix='BUS';
	ADCNumber='7116';
	ADCSection='02';
	ADCClsTerm='2014CE3';
	END;
*/
* END CORRECTIONS FOR SUMMER 2014;
* BEGIN CORRECTIONS FOR FALL 2014;
/*IF ADCClassID EQ '124675' THEN DO;
	ADCPrefix='ETG';
	ADCNumber='8012';
	ADCSection='G02';
	ADCClsTerm='2014CE3';
	END;
*/
* END CORRECTIONS FOR FALL 2014;

*BEGIN CORRECTIONS FOR SUMMER 2014;
/*If ADCClassID EQ '165659' then do;*/
/*	ADCPrefix='BUS';*/
/*	ADCNumber='7116';*/
/*	ADCSection='01';*/
/*	ADCClsTerm='2015CE2';*/
/*	END;*/

* END CORRECTIONS FOR SUMMER 2014;

* BEGIN CORRECTIONS FOR SUMMER 2016;
/*IF ADCClassID EQ '186282' THEN DO;*/
/*	ADCPrefix='BUS';*/
/*	ADCNumber='7116';*/
/*	ADCSection='01';*/
/*	ADCClsTerm='2016CE2';*/
/*	END;*/
/*IF ADCClassID EQ '174079' THEN DO;*/
/*	ADCPrefix='ETG';*/
/*	ADCNumber='8102';*/
/*	ADCSection='G01';*/
/*	ADCClsTerm='2016CE2';*/
/*	END;*/
/*IF ADCClassID EQ '165514' THEN DO;*/
/*	ADCPrefix='GAT';*/
/*	ADCNumber='8039';*/
/*	ADCSection='G02';*/
/*	ADCClsTerm='2016CE2';*/
/*	END;*/
* END CORRECTIONS FOR SUMMER 2016;

* BEGIN CORRECTIONS FOR FALL 2016;

/*IF ADCClassID EQ '184069' THEN DO;*/
/*	ADCPrefix='AUX';*/
/*	ADCNumber='7404';*/
/*	ADCSection='03';*/
/*	ADCClsTerm='2016CE3';*/
/*	END;*/


/* END CORRECTIONS FOR FALL 2016;*/

IF ADCClassID EQ '203299' THEN DO;
	ADCClsTerm='2017CE1';
	ADCPrefix='BUS';
	ADCNumber='7116';
	ADCSection='01';
END;

* END - FOR MANUAL CORRECTIONS TO Match01b;
PROC SORT DATA=classrec2; BY ADCClassID;
RUN;

DATA Match01a;
	MERGE classrec2(IN=a) Class01(IN=b); BY ADCClassID;
	IF a*b=1;
PROC SORT DATA=Match01a; BY ADCCCCPrefix;
RUN;

DATA Match01b;
	MERGE classrec2(IN=a) Class01(IN=b); BY ADCClassID;
	IF a AND NOT b;
TITLE1 "ERROR REPORT - Classes in Extension ICR NOT MATCHED To Class File";
PROC SORT DATA=Match01b; BY ADCCCCPrefix;
PROC PRINT DATA=Match01b;
RUN;

DATA finalexticr;
RETAIN
			ADCRptTerm
			ADCClsTerm
			ADCPrefix
			ADCNumber
			ADCSection
			ADCMethod
			ADCCampus
			ADCStuCt
			ADCTotHrs
			ADCHourType
			ADCBasSkl
			ADCLrnLab
			ADCOccExt
			ADCSSOE
			ADCFocIT
			ADCHRD
			ADCNewInd
			ADCSmBus
			ADCComSvc
			ADCSSNO
			ADCInst
			ADCRptPeriod
			ADCRptYear
			ADCCCCPrefix
			ADCCCCNumber
			ADCCCCSection
			ADCSpFundCode
			ADCImmureCodes
			ADCInstUseField
			ADCOn_Off
			ADCCounty
			ADCSchedHrs
			ADCClassID
			ADCContrctAgcy
;
SET Match01a
	zzz__rec
	Match01b;
IF ADCCCCPrefix EQ 'ZZZ'
	THEN Prefix=ADCCCCPrefix;
	ELSE Prefix=ADCPrefix;
IF ADCCCCNumber EQ '9999'
	THEN Number=ADCCCCNumber;
	ELSE Number=ADCNumber;
TITLE1 "Extension ICR Dataset";
TITLE2 "For &yt01";
PROC SORT DATA=finalexticr; BY Prefix Number ADCSection ADCCCCSection;
PROC PRINT DATA=finalexticr;
RUN;

/*
DATA &lb02 .&ds02&rp02&yt02;
SET finalexticr;
RUN;
*/

DATA &lb02b .&ds02b&rp02b&yt02b;
SET finalexticr;
RUN;


PROC EXPORT DATA= WORK.FINALEXTICR 
            OUTFILE= "&pt03&ds03&rp03&yt03 .csv" 
            DBMS=CSV REPLACE;
*			DELIMITER='","';
RUN;

/*
PROC EXPORT DATA= WORK.FINALEXTICR 
            OUTFILE= "&pt03&ds03&rp03&yt03 .csv" REPLACE; DELIMITER='","';
RUN;
*/


/*

PROC CONTENTS DATA=zzz__rec;
RUN;

*/
