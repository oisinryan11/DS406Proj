proc import datafile="/home/u64162398/ST662/3SudokuCombined.csv"
    out=SudokuRaw
    dbms=csv
    replace;
    guessingrows=max;
run;

/* Step 1: Clean and Convert Data */
data Sudoku_Cleaned;
    set SudokuRaw;

    /* Standardize Before2 values */
    if Before2 in ( "Within_3", "Inside") then Before2 = "within";
    else if Before2 in ("Out_3", "Outside") then Before2 = "outside";
    else if Before2 = "No" then Before2 = "no";
    else delete; /* Remove any unexpected values */

    /* Ensure Time2 is numeric */
    Time2_Num = input(Time2, best.);

    /* Remove rows where Time2 is missing after conversion */
    if not missing(Time2_Num);

    /* Keep only necessary variables */
    keep Before2 Time2_Num correct;
run;

/* Step 2: Calculate Mean Time2 for Each Category */
proc means data=Sudoku_Cleaned mean noprint;
    class Before2;
    var Time2_Num;
    output out=Mean_Time2 mean=Mean_Time;
run;

/* Step 3: Print Results */
proc print data=Mean_Time2 noobs;
    var Before2 Mean_Time;
    title "Mean Time2 for Each Before2 Category";
run;

/* Step 4: Box Plot*/
proc sgplot data=Sudoku_Cleaned;
    vbox Time2_Num / category=Before2;
    title "Box Plot of Time2 by Before2 Category";
    xaxis label="Before2 Category";
    yaxis label="Time2 (Numeric)";
run;

/* Step 5: Bar Plot of Correct*/
proc freq data=Sudoku_Cleaned noprint;
	tables Before2*correct / out=FreqData;
run;
proc sgplot data=FreqData;
	vbar Before2 / response=Count group=correct groupdisplay=cluster 
		barwidth=0.4
		datalabel 
		datalabelattrs=(weight=bold)
		grouporder=data;
	styleattrs datacolors=(red green);
	xaxis discreteorder=data display=(nolabel);
	yaxis label="Count";
	title "Correct Responses by Before2 Category";
run;


