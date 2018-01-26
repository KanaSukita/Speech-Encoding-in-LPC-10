beginindex=5601;
endindex=6200;
a=myRecording(beginindex:endindex);
l=numel(a);
a_clip=zeros(1,600);
for i=1:l
    if a(i)>0.13
        a_clip(i)=1;
    else if a(i)<-0.13
            a_clip(i)=-1;
        else a_clip(i)=0;
        end
    end
end

%% Problem 1(a)
n=120;
for m=4:9
    for k=1:n
        Rm(k)=0;
        for i=1:n
            Rm(k)=Rm(k)+a_clip(i+(m-1)*60)*a_clip(i-k+1+(m-1)*60);
        end
    end
    if m==4
        Rmplot=Rm;
    end
    p=Rm(11:n);
    [Rmax,N(m-3)]=max(p);
end
N1=N+10;
T1=N1/8;

%% Problem 1(b)
for m=4:9
    for k=1:n
        A(k)=0;
        for i=0:n-1
        A(k)=A(k)+abs(a_clip(i+(m-1)*60)-a_clip(i-k+1+(m-1)*60));
        end
        A(k)=A(k)/n;
    end
    if m==4
        Aplot=A;
    end
    p=A(11:n);
    [Amin,N(m-3)]=min(p);
end
N2=N+10;
T2=N2/8;

%% Problem 1(c)
figure(1)
plot(a(181:4*44+180))
title('4 periods of "a" using autocorrelation method')
xlabel('time series')
ylabel('speech samples')

figure(2)
plot(a(181:4*44+180))
title('4 periods of "a" using AMDF method')
xlabel('time series')
ylabel('speech samples')

%% Problem 1(d)
figure(3)
plot(0:119,Rmplot)
title('auto-correlation method')
xlabel('index k')
ylabel('auto-correlation')

figure(4)
plot(0:119,Aplot)
title('AMDF method')
xlabel('index k')
ylabel('AMDF')