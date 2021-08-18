% �������� �� ����� ������� �� 1 ����������
% ������ ������ ��������
% �������� ��������=(1-spread)*100%
function spread=spreadcalibr(param)%year - �� ���, � ����� ���� � ����� ������� (�� 1 �� k ��� �� k �� n)
global GDP FCE GCF k n;
otv=model(param);
MMY=otv(1,:);MMK=otv(2,:);MMC=otv(3,:); % ������-�������, ������� �� N, ����������, 384 ��������
SMY=otv(4,:);SMK=otv(5,:);SMC=otv(6,:); % std (���. �������),  EMS (expected mean square)

%%%ForecastY=MMY(numsteps*[1:k]);FactY=GDP(1:k);%��� ��������� �� ����� ����, ������� ����� ������� �� �������� � ��� ����
%�������������
ForecastY=[];FactY=[];
for i=1:k-1 % �� ������ ��������� (������) � ����
    ForecastY(i)=mean(MMY([1:length(MMY)/n]*i));
    FactY(i)=mean(GDP([0:1]+i));
end
ERY=ForecastY-FactY; %������, ����-������� [� ��� �� 2 ���� �����]
% spread=mean(ERY);
% spread=mean(ForecastY./FactY);% ��������� ����� � ��������
% spread=sum(MMY)/sum(FactY);
% spread=mean((ERY.^2)./(ForecastY.^2));%���/�������������������� ���������� ������ �� ��������
%? ����� ����. �������������
%MBE=max(ERY);
%MAPE_Y=mean(abs(ERY)./FactY)*100; %�����, ��_������/���� % Mean absolute percentage error
RMSE_Y=sqrt(mean(ERY.^2));
% MAE = mean(abs(ERY));
%spread=MAPE_Y;
%spread=RMSE_Y;%������ ��� ���

%��� �
% ForecastC=MMC(numsteps*[1:k]);%(((k0:k)-1)*12+1); % �� ������ � ����
% FactC=FCE(1:k);
ForecastC=[];FactC=[];
for i=1:k-1 % �� ������ ��������� (������) � ����
    ForecastC(i)=mean(MMC([1:length(MMC)/n]*i));
    FactC(i)=mean(FCE([0:1]+i));
end
ERC=ForecastC-FactC;
%MAPE_C=mean(abs(ERC)./FactC)*100; %�����, ��_������/���� % Mean absolute percentage error
RMSE_C=sqrt(mean(ERC.^2));

spread=RMSE_Y*RMSE_C;
%spread=RMSE_Y;


%[MAPE_Y RMSE_Y;MAPE_C RMSE_C] %������ � �� �, � �� � �� 2 ���� �� 5

end