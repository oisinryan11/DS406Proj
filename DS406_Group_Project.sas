FILENAME REFFILE '/home/u64155860/ds406/Datasets/3SudokuCombined.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


data data_oisin;
    set WORK.IMPORT;

    Before1 = propcase(strip(Before1));
    Correct = propcase(strip(Correct));

    if Before1 not in ('Yes', 'No') then Before1 = '';
    if Correct not in ('Yes', 'No') then Correct = '';

    mins_num = input(Mins, ?? best.);
    secs_num = input(Seconds, ?? best.);
    time2_num = input(Time2, ?? best.);

    if missing(time2_num) and not missing(mins_num) and not missing(secs_num) then 
        time2_num = mins_num * 60 + secs_num;
run;

data data_oisin;
    set data_oisin;
    if Before1 ne '' and Correct ne '' and not missing(time2_num);
run;

proc contents data=data_oisin; run;

proc print data=data_oisin (obs=10);
    var Before1 Correct time2_num;
    title "Preview of Cleaned Dataset for Question 1 (data_oisin)";
run;

data data_megan;
    set WORK.IMPORT;

    Type = propcase(strip(Type));
    Correct = propcase(strip(Correct));

    if Type not in ('Numbers', 'Greek', 'Letters', 'Symbol') then Type = '';
    if Correct not in ('Yes', 'No') then Correct = '';

    mins_num = input(Mins, ?? best.);
    secs_num = input(Seconds, ?? best.);
    time2_num = input(Time2, ?? best.);

    if missing(time2_num) and not missing(mins_num) and not missing(secs_num) then 
        time2_num = mins_num * 60 + secs_num;
run;

data data_megan;
    set data_megan;
    if Type ne '' and Correct ne '' and not missing(time2_num);
run;

proc contents data=data_megan; run;

proc print data=data_megan (obs=10);
    var Type Correct time2_num;
    title "Preview of Cleaned Dataset for Question 2 (data_megan)";
run;

data data_daniel;
    set WORK.IMPORT;

    Logic = propcase(strip(Logic));
    Correct = propcase(strip(Correct));

    if Logic not in ('Yes', 'No', 'Indifferent') then Logic = '';
    if Correct not in ('Yes', 'No') then Correct = '';

    mins_num = input(Mins, ?? best.);
    secs_num = input(Seconds, ?? best.);
    time2_num = input(Time2, ?? best.);

    if missing(time2_num) and not missing(mins_num) and not missing(secs_num) then 
        time2_num = mins_num * 60 + secs_num;
run;

data data_daniel;
    set data_daniel;
    if Logic ne '' and Correct ne '' and not missing(time2_num);
run;

proc contents data=data_daniel; run;

proc print data=data_daniel (obs=10);
    var Logic Correct time2_num;
    title "Preview of Cleaned Dataset for Question 3 (data_daniel)";
run;
