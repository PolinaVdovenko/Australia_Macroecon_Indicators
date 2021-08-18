% отдельно тк нужна функци€ от 1 переменной
% оценка ошибки прогноза
% точность прогноза=(1-spread)*100%
function spread=spreadcalibr(param)%year - не год, а номер года в нашем периоде (от 1 до k или от k до n)
global GDP FCE GCF k n;
otv=model(param);
MMY=otv(1,:);MMK=otv(2,:);MMC=otv(3,:); % строка-прогноз, среднее из N, понедельно, 384 значени€
SMY=otv(4,:);SMK=otv(5,:);SMC=otv(6,:); % std (дов. коридор),  EMS (expected mean square)

%%%ForecastY=MMY(numsteps*[1:k]);FactY=GDP(1:k);%¬¬ѕ считаетс€ на конец года, поэтому берем среднее на середину и ввп тоже
%пересчитываем
ForecastY=[];FactY=[];
for i=1:k-1 % из недель ќ –”√Ћя≈ћ (срзнач) в годы
    ForecastY(i)=mean(MMY([1:length(MMY)/n]*i));
    FactY(i)=mean(GDP([0:1]+i));
end
ERY=ForecastY-FactY; %вектор, факт-прогноз [у ¬Ћ‘ по 2 посл годам]
% spread=mean(ERY);
% spread=mean(ForecastY./FactY);% отношение факта к прогнозу
% spread=sum(MMY)/sum(FactY);
% spread=mean((ERY.^2)./(ForecastY.^2));%ћЌ /среднеквадратическое отклонение ошибки от прогноза
%? метод макс. правдоподоби€
%MBE=max(ERY);
%MAPE_Y=mean(abs(ERY)./FactY)*100; %число, ср_отклон/факт % Mean absolute percentage error
RMSE_Y=sqrt(mean(ERY.^2));
% MAE = mean(abs(ERY));
%spread=MAPE_Y;
%spread=RMSE_Y;%раньше исп это

%дл€ —
% ForecastC=MMC(numsteps*[1:k]);%(((k0:k)-1)*12+1); % из недель в годы
% FactC=FCE(1:k);
ForecastC=[];FactC=[];
for i=1:k-1 % из недель ќ –”√Ћя≈ћ (срзнач) в годы
    ForecastC(i)=mean(MMC([1:length(MMC)/n]*i));
    FactC(i)=mean(FCE([0:1]+i));
end
ERC=ForecastC-FactC;
%MAPE_C=mean(abs(ERC)./FactC)*100; %число, ср_отклон/факт % Mean absolute percentage error
RMSE_C=sqrt(mean(ERC.^2));

spread=RMSE_Y*RMSE_C;
%spread=RMSE_Y;


%[MAPE_Y RMSE_Y;MAPE_C RMSE_C] %отклон и по у, и по с за 2 года из 5

end