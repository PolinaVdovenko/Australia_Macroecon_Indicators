    clear;
    global n k N col0 year0 years years_all prices q open disp numsteps; %open q ;%%disp
year0=2002; % 2002:2006 %2008
k=5; % период, по кот калибруем %при k=6 почему-то не строит дов инт-л
n=9; % всего лет (из стат), >=k % 8
N=20;%кол-во прогнозов по 1 набору парам-мов, >=2!!!       %1000
prices='KD';  %KD - constant, CD - current
q=.18;%.9;%
numsteps=12*4; % длина моделируемого вектора (шаг по врем) за год
open=1.017;
disp=.15;
    col0='b';%[140 25 25]/255; % цвета :3
    %plot([1 2],[1 2],'color',col0,'Linewidth',10) % просмотр цвета
    years=year0+[0:k-1];%стаб период, по кот калибруем
    years_all=year0+[0:n-1];%весь период
