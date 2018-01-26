[x,fs]=audioread('ppap.wav');
len=180;
n=fix(numel(x)/len);
zcr=zeros(1,n);
voiced=zeros(1,n);
periods=zeros(1,n);
energy=zeros(1,n);

% Normalize the speech
maximum=max(abs(x));
x=x/maximum;

% Determine whether the frame is voiced or not
h=firls(30,[0 .2 .3 .5]*2,[1 1 0 0]);
for i=1:n
    s=x((i-1)*len+1:i*len);
    % Determine based on low band energy
    s_low=filter(h,1,s);
    energy(i)=sum(abs(s_low).^2);
    if energy(i)>5
        voiced(i)=voiced(i)+1;
    end
    % Determine based on zero crossing rate
    for j=2:len-1  
        if s(j)*s(j-1)<0
            zcr(i)=zcr(i)+1;  
        end
    end
    if zcr(i)<45 && zcr(i)>0
        voiced(i)=voiced(i)+1;
    end
end

%clip
x_clip=zeros(1,numel(x));
for i=1:numel(x)
    if abs(x(i))>0.1
        x_clip(i)=x(i)-sign(x(i))*0.1;
    end
end

% Compute the periods
indexp=0;
for m=1:n
    if voiced(m)>0
        indexp=indexp+1;
        for k=1:n
            Rm(k)=0;
            for i=(k+1):len
                Rm(k)=Rm(k)+x_clip(i+(m-1)*len)*x_clip(i-k+(m-1)*len);
            end
        end
        temp=Rm(11:n);
        [Rmax,periods(indexp)]=max(temp);
    end
end
periods=periods+9;

% Compute the lpc coef and gain
p=zeros(1,n);
index4=0;
index10=0;

for i=1:n
    s=x((i-1)*len+1:i*len);  
    if voiced(i)==0
        index4=index4+1;
        [a4(index4,:),p(i)]=lpc(s,4);
    else
        index10=index10+1;
        [a10(index10,:),p(i)]=lpc(s,10);
    end
end

save lpc4 a4
save lpc10 a10
save gain p
save voiced_detection voiced
save pitch_periods periods