/* Question: Logic Puzzle enjoyment against Correctness & time to completion */

FILENAME REFFILE '/home/u64156068/ST662/3SudokuCombined (5).csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT= Sudoku;
	GETNAMES=YES;
RUN;

/* standardise, remove "NA" and leave empty */
data sudoku_clean;
set sudoku;
Logic = propcase(strip(Logic));
if Logic in ('NA', '') then Logic = ''; 
run;

/* freq table for cleaned Logic*/
proc freq data=sudoku_clean;
tables Logic / missing;
run;

/* logic enjoyment and puzzle correctness */
proc freq data=sudoku_clean;
tables Logic*Correct / nocol nopercent chisq;
run;

/* Bar chart for puzzle correctness and logic */
proc sgplot data=sudoku_clean;
vbar Logic / group=Correct groupdisplay=cluster;
title 'Sudoku Correctness by Logic Enjoyment';
run;

/* How many missing values from Time2 */
proc sql;
select count(*) as NA_Count
from sudoku
where upcase(strip(Time2)) = 'NA';
quit;

/* Clean Time2 and plot against Logic */
data logic_vs_time;
set sudoku_clean;

/* Remove rows where Time2 is 'NA' */
if upcase(strip(Time2)) = 'NA' then delete;

/* Convert Time2 to numeric */
Time2_num = input(Time2, best.);
run;

/* Scatterplot of Time2 by Logic */
proc sgplot data=logic_vs_time;
scatter x=Logic y=Time2_num / jitter;
title 'Scatter Plot of Completion Time by Logic Preference';
run;

/* Boxplot of Time2 by Logic */
proc sgplot data=logic_vs_time;
vbox Time2_num / category=Logic;
title 'Time to Complete Sudoku by Logic Enjoyment';
run;

/* Bar Chart Mean Time2 by Logic */
proc means data=logic_vs_time noprint;
class Logic;
var Time2_num;
output out=mean_times mean=mean_time;
run;
proc sgplot data=mean_times;
vbar Logic / response=mean_time datalabel;
yaxis label='Average Time (Seconds)';
title 'Average Sudoku Completion Time vs Logic Enjoyment';
run;
