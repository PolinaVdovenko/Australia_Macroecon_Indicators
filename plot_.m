%строим 3 графика
function plot_(param, country)%,col)
global GDP FCE GCF years_all k col0 years n year0;
future_years=year0+[k:n-1];
%зафиксить ось Y?
otv=model(param);
Y=otv(1,:);K=otv(2,:);C=otv(3,:);
SMY=otv(4,:);SMK=otv(5,:);SMC=otv(6,:);
t=year0+[0:n/length(Y):(n-1/length(Y))];
    
figure
subplot(121);
plot(years,GDP(1:k),'o','MarkerSize', 5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k');hold on;
plot(future_years,GDP(k+1:n),'o','MarkerSize', 5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'w');hold on;
plot(t,[Y-.6745*SMY; Y+.6745*SMY],'--','Color','k');
XTick = years_all;xlabel('год');ylabel('млрд $');xlim([year0 years_all(end)]);
ylim([min(GDP)*.8 max(GDP)*1.2]);
plot(t,Y,'-','color',col0,'Linewidth', 2);
title(sprintf('Страна: %s\nПараметры:\n%s\nВВП',country, num2str(param)));
%sprintf('%g',round(mean(TO_total)*1e2)/1e2))
%hold off;

subplot(222);%K
plot(years,GCF(1:k),'o','MarkerSize', 5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k');hold on;
plot(future_years,GCF(k+1:n),'o','MarkerSize', 5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'w');hold on;
plot(t,[K-.6745*SMK; K+.6745*SMK],'--','Color','k');
XTick = years_all;xlim([year0 years_all(end)]);
%ylim([min(GCF)*.5 max(GCF)*1.5]);
title('Запас капитала');
plot(t,K,'-','color',col0);
% hold off;

subplot(224);%subplot(122);%C
plot(years,FCE(1:k),'o','MarkerSize', 5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k');hold on;
plot(future_years,FCE(k+1:n),'o','MarkerSize', 5, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'w');hold on;
plot(t,[C-.6745*SMC; C+.6745*SMC],'--','Color','k');
XTick = years_all;xlim([year0 years_all(end)])
ylim([min(FCE)*.8 max(FCE)*1.2]);
title('Потребление');
plot(t,C,'-','color',col0);
% hold off;
end