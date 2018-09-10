BUG proc report does not show group variable across pages in rtf and pdf

BUG
The ODS output dataset does not honor the page break indicator.
Page break variable is present but is wrong, except for first page.
We could easily fix the missing group header by running report twice
if SAS honored ODS. Also, unike 'proc corresp' 'proc report' does
not honor column names in ods output.

Ods rtf and pdf ignore the pagesize setting altogether, in addition
the ods output datasets only provides the new page indicator
for the first page.

If proc report honored ODS output, we would have a very
powerfull sort, transpose, summarize and layout capability.
The ODS output is more important than the static report.

I do realize this is hard becaus eof all the various height
and font settings. But let us use the 'printer' setting
to get the various break indicators.


THIS WORKS, but only for the output window or printer destination.
AND THE ODS OUTPUT DATASET DOES NOT SET THE PAGE BREAK INDICATOR.

PAGE 1

MATH        STUDENT
Algebra           1  ==> Algebra
                  2
                  3
                  4
                  5
                  6
                  7
                  8
                  9
                 10
                 11
                 12
                 13
                 14

PAG 2

MATH        STUDENT
Algebra          15  ==> Algebra (missing in rtf and pdf)
                 16
                 17
                 18
                 19
                 20
                 21
                 22
                 23
                 24
                 25
                 26
                 27
                 28

PROBLEM (here is the problematic ODS output dataset)
-----------------------------------------------------

Up to 40 obs from HAVPGE total obs=91

   MATH       STUDENT    _BREAK_

   Algebra        1      _PAGE_
   Algebra        1
   Algebra        2
   Algebra        3
   Algebra        4
   Algebra        5
   Algebra        6
   Algebra        7
   Algebra        8
   Algebra        9
   Algebra       10
   Algebra       11
   Algebra       12
   Algebra       13
   Algebra       14
   Algebra       15   ** should have _PAGE_ undicator
   Algebra       15
   Algebra       16
   Algebra       17
   Algebra       18
   Algebra       19

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

data have;
 do math='Algebra ','Trig','Calculus';
   do student=1 to 30;
      output;
   end;
 end;
run;quit;

*____  ____   ___   ____ _____ ____ ____
|  _ \|  _ \ / _ \ / ___| ____/ ___/ ___|
| |_) | |_) | | | | |   |  _| \___ \___ \
|  __/|  _ <| |_| | |___| |___ ___) |__) |
|_|   |_| \_\\___/ \____|_____|____/____/

;

* ods output is wrong;

ods output report=havPge;
proc report data=have nowd missing ps=15;
cols math student;
define math / group;
define student / display;
compute before _page_ / left;
 lyn="";
 line lyn $1.;
endcomp;
run;quit;
