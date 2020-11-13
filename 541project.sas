ods rtf file="541experiment.rtf"; /* MS-Word format */
	
DATA in; 
	DO day = 'MON', 'WED', 'FRI';
	DO time = 'AM  ', 'NOON', 'PM  ';
		INPUT open @@; OUTPUT;
	END; END;
	LINES;
    0.42 0.33 0.42
    0.50 0.33 0.58
    0.50 0.42 0.58
    ;

PROC GLM DATA=in PLOTS=(ALL);
    CLASS day time;
    MODEL open = day time / SS3;
    MEANS day time;
	LSMEANS day time / ADJUST=BON;

	*mu*;
	ESTIMATE 'mu' INTERCEPT 1;

	*day effect*;
	ESTIMATE 'day=MON' day 2 -1 -1 / divisor = 3;
	ESTIMATE 'day=WED' day -1 2 -1 / divisor = 3;
	ESTIMATE 'day=FRI' day -1 -1 2 / divisor = 3;

	*time effect*;
	ESTIMATE 'time=AM  ' time 2 -1 -1 / divisor = 3;
	ESTIMATE 'time=NOON' time -1 2 -1 / divisor = 3;
	ESTIMATE 'time=PM  ' time -1 -1 2 / divisor = 3;

TITLE 'TWO-FACTOR FACTORIAL DESIGN';

PROC GLMPOWER DATA=IN;
	CLASS day time;
	MODEL open = day time;
	POWER
		STDDEV = 0.042817
		ALPHA = 0.05
		NTOTAL = 9
		POWER = .
	;

TITLE 'POWER ANALYSIS';

RUN;

ods rtf close;
