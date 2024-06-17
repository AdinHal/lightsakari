%*
- LINUX call scheme:

  clingo --outf=1 lights.lp instanceXY.lp | grep -v "^ANSWER" | clingo - check.lp solutionXY.lp

- LINUX example call:

  clingo --outf=1 lights.lp instance01.lp | grep -v "^ANSWER" | clingo - check.lp solution01.lp
*%

%*
- WINDOWS call scheme:

  clingo --outf=1 lights.lp instanceXY.lp | findstr /v "^ANSWER" | clingo - check.lp solutionXY.lp

- WINDOWS example call:

  clingo --outf=1 lights.lp instance01.lp | findstr /v "^ANSWER" | clingo - check.lp solution01.lp
*%

:- light(X,Y), not solution(X,Y).
:- solution(X,Y), not light(X,Y).

#show light/2.
