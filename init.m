    clear;
    global n k N col0 year0 years years_all prices q open disp numsteps; %open q ;%%disp
year0=2002; % 2002:2006 %2008
k=5; % ������, �� ��� ��������� %��� k=6 ������-�� �� ������ ��� ���-�
n=9; % ����� ��� (�� ����), >=k % 8
N=20;%���-�� ��������� �� 1 ������ �����-���, >=2!!!       %1000
prices='KD';  %KD - constant, CD - current
q=.18;%.9;%
numsteps=12*4; % ����� ������������� ������� (��� �� ����) �� ���
open=1.017;
disp=.15;
    col0='b';%[140 25 25]/255; % ����� :3
    %plot([1 2],[1 2],'color',col0,'Linewidth',10) % �������� �����
    years=year0+[0:k-1];%���� ������, �� ��� ���������
    years_all=year0+[0:n-1];%���� ������
