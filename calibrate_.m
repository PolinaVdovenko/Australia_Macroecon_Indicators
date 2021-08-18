    clear all;init;
    global param k GDP FCE GCF n N year0 prices paramf Am spreadf q A open disp numsteps;
countries=['LS';'LR';'MR';'MG';'MW';'ML';'MZ'];% 'DJ';'ZM';'YE';'KI';; нет в 2010-2018
%   % отстающие
%  'KH';'KM';'LA' % отстающие
% 'AU';'ES';'FR';'DE';'CG'
% 'ZA';'GB';'GR';'CN';'RU';'CH';'IT'
%%наименее развитые
%'US';'JP';%развитые
%
A = 0.51;rA = A;%4.9684;%    
rq = q;rdisp = disp;ropen = open;rnumsteps = numsteps;Kstat='не учитываем';
    rRMSE0=[0];rRMSE=[0];rcountries=['P0';countries];
    for j=1:length(countries)
        country=countries(j,:);
        GDP=webreader('GDP',country);
        FCE=webreader('FCE',country);
        GCF=webreader('GCF',country);
A=GDP(1)/GCF(1);Kstat='есть';
        %q A open disp numsteps
%param=[q A];paramf='q A';
%param=[q disp open];paramf='q disp open';
%param=[q disp open];paramf='q disp open';
%param=[q A numsteps];paramf='q A numsteps';
%param=[q A open];paramf='q A open';
param=[q A open disp];paramf='q  A open disp';
    
Ann=[];b=[]; Aeq=[];beq=[]; % A*x <= b % Aeq*x = beq 
lb=[0 0 0 0]; ub=[1 10 2 100];%[q A open disp] %lb <= x <= ub
%
%
options = optimset('Display','iter',...%'TolX',1.e-2,...%
'TolCon',200,...%%'PlotFcns','on',...	Конечное допустимое отклонение по нарушению условий ограничения
'PlotFcns','on',...
'LargeScale','on',...
'Diagnostics','on');%'Algorithm','active-set',
param
%[popt,fval,exitflag,output] = fminsearch(@spreadcalibr,param);%,options
%[popt,fval,exitflag,output] = fminunc(@spreadcalibr,param,options);%
[popt,fval,exitflag,output] = fmincon(@spreadcalibr,param,Ann,b,Aeq,beq,lb,ub);%    ,[],options
    
        fprintf('%s\t%s\t%f\n',country,num2str(popt),spread(popt,k+1,n))
        rRMSE0 = [rRMSE0;spread(param,k+1,n)];
        rRMSE = [rRMSE;spread(popt,k+1,n)];
        plot_(param,country);
        plot_(popt,country);
        %model(popt,1);%много графиков % строит то выше, то ниже
rq = [rq;popt(1)];
rA = [rA;popt(2)];
rdisp = [rdisp;popt(4)];%
ropen = [ropen;popt(3)];%
%rnumsteps = [rnumsteps;popt(3)];
    end
    exlist=datestr(now(),'HH-MM-SS');
    Cond={'paramf';'Kstat';'Am';'numsteps';'year0';'k';'n';'prices';'N';'spreadf'};
    Realize={paramf;Kstat;Am;numsteps;year0;k;n;prices;N;spreadf};
    Tcond = table(Cond,Realize);
% Tres=table(rcountries,rq,rA,rRMSE0,rRMSE,...
% 'VariableNames',{'country' 'q' 'A' 'RMSE0' 'RMSE'});
% Tres=table(rcountries,rq,rdisp,ropen,rRMSE0,rRMSE,...
% 'VariableNames',{'country' 'q' 'disp' 'open' 'RMSE0' 'RMSE'});
% Tres=table(rcountries,rq,rA,rnumsteps,rRMSE0,rRMSE,...
% 'VariableNames',{'country' 'q' 'A' 'numsteps' 'RMSE0' 'RMSE'});
% Tres=table(rcountries,rq,rA,ropen,rRMSE0,rRMSE,...
% 'VariableNames',{'country' 'q' 'A' 'open' 'RMSE0' 'RMSE'});
Tres=table(rcountries,rq,rdisp,ropen,rA,rRMSE0,rRMSE,...
'VariableNames',{'country' 'q' 'disp' 'open' 'A' 'RMSE0' 'RMSE'});
    writetable(Tcond,'res.xlsx','Sheet',exlist);writetable(Tres,'res.xlsx','Sheet',exlist,'Range','D1')
    