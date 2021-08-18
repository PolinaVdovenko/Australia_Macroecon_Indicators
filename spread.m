% ������ ������ ��������
% �������� ��������=(1-spread)*100%
function spread=spread(param, startyear, endyear)%year - �� ���, � ����� ���� � ����� ������� (�� 1 �� k ��� �� k �� n)
global GDP FCE GCF n spreadf;
otv=model(param);
MMY=otv(1,:);MMK=otv(2,:);MMC=otv(3,:); % ������-������� ������� �� N ���������� 384 ��������
SMY=otv(4,:);SMK=otv(5,:);SMC=otv(6,:); % std (���. �������),  EMS (expected mean square)

%Forecast=MMY(numsteps*[startyear:endyear]);%�� ������ � ����
%Fact=GDP(startyear:endyear);

%%%%%%%%%%%%%%ForecastY=MMY(numsteps*[1:k]);FactY=GDP(1:k);%��� ��������� �� ����� ����, ������� ����� ������� �� �������� � ��� ����
%�������������
ForecastY=[];FactY=[];
for i=startyear:endyear-1 % �� ������ ��������� (������) � ����
    ForecastY(i)=mean(MMY([1:length(MMY)/n]*i));
    FactY(i)=mean(GDP([0:1]+i));
end

ERY=ForecastY-FactY; %������, ����-������� [� ��� �� 2 ���� �����]
% spread=mean(ERY);
% spread=mean(Forecast./Fact);% ��������� ����� � ��������
% spread=sum(MMY)/sum(Fact);
% spread=mean((ERY.^2)./(Forecast.^2));%���/�������������������� ���������� ������ �� ��������
%? ����� ����. �������������
%MBE=max(ERY);
%MAPE_Y=mean(abs(ERY)./Fact)*100; %�����, ��_������/���� % Mean absolute percentage error
RMSE_Y=sqrt(mean(ERY.^2));
% MAE = mean(abs(ERY));
%spread=MAPE_Y;
%spread=RMSE_Y;

%��� �
% ForecastC=MMC(numsteps*[1:k]);
% FactC=FCE(1:k);
ForecastC=[];FactC=[];
for i=startyear:endyear-1 % �� ������ ��������� (������) � ����
    ForecastC(i)=mean(MMC([1:length(MMC)/n]*i));
    FactC(i)=mean(FCE([0:1]+i));
end
ERC=ForecastC-FactC;
%MAPE_C=mean(abs(ERC)./FactC)*100;
RMSE_C=sqrt(mean(ERC.^2));

spread=RMSE_Y*RMSE_C;spreadf='RMSE_Y*RMSE_C';
%spread=RMSE_Y;spreadf='RMSE_Y';
%[MAPE_Y RMSE_Y;MAPE_C RMSE_C] %������ � �� �, � �� � �� 2 ���� �� 5

end