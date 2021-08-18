% otv=model(param);Y=otv(1,:);% так вызвав, на выходе получим только вектор Y
function otv=model(param,many)%помесячно
    global N year0 col0 n GDP FCE GCF Am A;
    rng 'default'
    r=randperm(N);%значения disp для разных построений не повторяются и заранее заданы (привязаны к N), т. е. для каждой страны одинак. N векторов disp(t)
global numsteps ;%disp open ;%  q    
q=param(1,1);
disp=param(1,4);%
open=param(1,3);%
% numsteps=param(1,3);
    Yrez=[];Krez=[];Crez=[];dt=1/(numsteps*n); % доля недели во всем периоде
	for j=1:N
        Y=GDP(1);C=FCE(1);K=GCF(1);
A=param(1,2);K=Y/A;Am='const';
        Atemp=A;
        rng(r(j));%при кажд след моделировании в мом t берется новое знач disp
        for i=1:n*numsteps-1
            u=disp*randn;
            Y=[Y, Y(i)+(Atemp-q)*K(i)*dt+Atemp*K(i)*sqrt(dt)*u];
            K=[K, K(i)+((Atemp-q)*K(i)-C(i))*dt+K(i)*sqrt(dt)*u];
            C=[C, open*C(i)+(Atemp*K(i)*dt-(1+q)*C(i)*dt+Atemp*K(i)*sqrt(dt)*u)];%
%Atemp=Y(i+1)/K(i+1);Am='A(t)';%
        end
        Yrez=[Yrez;Y];Krez=[Krez;K];Crez=[Crez;C];% матрицы  
    end
    if nargin>1
        t=year0+[0:1/numsteps:(n-1/(numsteps*n))];
        subplot(121);plot(t,Yrez,'--','Linewidth',0.1,'color',col0);hold on;
        subplot(222);plot(t,Crez,'--','Linewidth',0.1,'color',col0);hold on;
        subplot(224);plot(t,Krez,'--','Linewidth',0.1,'color',col0);hold on;
    end
    Y=mean(Yrez);K=mean(Krez);C=mean(Crez);
    otv(1,:)=Y;otv(2,:)=K;otv(3,:)=C;
    dY=std(Yrez);dK=std(Krez);dC=std(Crez);
    otv(4,:)=dY;otv(5,:)=dK;otv(6,:)=dC;
end