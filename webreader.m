function ind=webreader(ind,country) %в млн $
global prices;
%ind='GDP'/'GNE'/'GCF'/'FCE'
global n year0;
api = 'http://api.worldbank.org/en';
switch ind
    case 'GDP'
        indicator=['/indicators/NY.GDP.MKTP.' prices];   % GDP
    case 'GCF'
        indicator=['/indicators/NE.GDI.TOTL.' prices];   % Gross capital formation (constant 2010 US$)
    case 'FCE'
        indicator=['/indicators/NE.CON.TOTL.' prices];   % Final consumption expenditure (constant 2010 US$)
    case 'GNE'
        indicator=['/indicators/NE.DAB.TOTL.' prices];   % Gross national expenditure (constant 2010 US$) %больше FCE, у ВЛФ FCE
end
% current US$
% GDP=[394.4867099	466.2947001	611.9042538	692.641708	745.5218628	851.9627856	1052.584602	926.4482403	1144.260548	1394.280785	1543.411013	1573.696522	1464.955476	1349.034029	1208.039016	1323.421072];
% FCE=[297.8568439	354.7553873	462.4249538	520.9908284	553.3273435	631.5961372	778.3240824	671.3311736	849.784198	1012.498275	1120.50629	1156.487124	1080.810612	1016.876612	929.82603	997.3814013];
% GCF=[96.15948095	121.8474083	163.3646322	187.48083	207.7792752	233.4388003	296.9185318	255.3254307	309.0698494	361.9846199	421.9107032	437.0534523	392.4547875	351.5666861	304.7765322	317.6370767];
% constant 2010 US$ 2002-2017 гг.
% GDP=[899.77	926.64	963.71	994.46	1022.64	1061.27 1100.09	1121.24 1144.26 1172.31	1217.93	1250.08 1282.06	1312.20	1349.30	1375.72];
% FCE=[634.36	658.36	690.60	719.86	743.06	779.57	814.44	825.95 849.78	882.48	910.15	923.02	943.47	965.97	996.22	1022.18];
    % Gross national expenditure % FCE=[815.46	859.74	916.19	960.88	996.63	1050.59	1112.94	1122.33	1156.06	1205.71	1268.35	1287.42	1300.03	1312.22	1327.99	1355.28];
% GCF=[181.10	201.38  225.59	241.02	253.57	271.02	298.50	296.38 306.28	323.22	358.20	364.39	356.56	346.25	331.77	333.11];
    % Stocks traded (% of GDP)	% GCF=1/100*GDP.*[73.75	90.43	89.05	88.45	115.21	161.19	79.78	90.83	98.87	80.94	58.68	50.07	48.02	55.64	65.81	61.15];
    % Market capitalization of listed domestic companies (% of GDP)	% GCF=1/100*GDP.*[96.35	125.57	126.88	116.08	146.99	152.39	64.97	136.21 127.11	85.94	89.86	86.80	87.97	88.00	105.00	113.98];

dates=sprintf('?date=%d:%d',[year0 year0+n-1]);%1961:2011
        per_page='&per_page=2000';%без - выводит 50 знач
        format='&format=json';
url = [api '/countries/' country indicator dates per_page format];
S = webread(url); 
S = struct2table(S{2});
%  S(1:3,:)
%%%%%%%%%%
disp(ind)
S.value
% if S.value==0
%     sogjs
% end
%%%%%%%%%%%
S.indicator = struct2table(S.indicator);
S.country = struct2table(S.country);
%  S(1:3,:)
ind=table(S.value,'VariableNames',{ind});
T=table(S.date,ind,'VariableNames',{'year' 'ind'});
T = sortrows(T, 'year', 'ascend');
bln=1000000000;
T=table2array(T.ind);
ind=[];
for w=1:n
    ind(w)=str2num(T{w,1})/bln;
end
end