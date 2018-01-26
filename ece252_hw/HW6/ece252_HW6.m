load('washington.mat')
x=myRecording;

figure(1)
plot(x)
title('sentence speech')

len=180; 
n=fix(numel(x)/len);

% Zero Crossing Rate
for i=1:n
    s=x((i-1)*len+1:i*len);  
    zcr(i) = 0;  
    for j=2:len-1  
        zcr(i)=zcr(i)+abs(sign(s(j))-sign(s(j-1)))/2;  
    end  
end

figure(2)
plot(zcr);
title('Zero Crossing Rate') 

% Calculate the 4th or 10th order prediction and save PARCOR
a4=zeros(n,5);
a10=zeros(n,11);
k4=zeros(n,4);
k10=zeros(n,10);
for i=1:n
    s=x((i-1)*len+1:i*len);  
    if zcr(i)>120
        a4(i,:)=lpc(s,4);
        k4(i,:)=lpccoef_parcor(4,a4(i,:));
    else
        a10(i,:)=lpc(s,10);
        k10(i,:)=lpccoef_parcor(10,a10(i,:));
    end
end

% Calculate the error
error=zeros(1,numel(x));
for i=1:n
    s=x((i-1)*len+1:i*len);
    if zcr(i)>120
        error((i-1)*len+1:i*len)=filter(a4(i,:),1,s);  
    else
        error((i-1)*len+1:i*len)=filter(a10(i,:),1,s); 
    end
end

% Reconstruct the speech
x_recons=zeros(1,numel(x));
for i=1:n
    s=error((i-1)*len+1:i*len);
    if zcr(i)>120
        b=parcor_filt(4,k4(i,:));
        x_recons((i-1)*len+1:i*len)=filter(1,b,s);
    else
        b=parcor_filt(10,k10(i,:));
        x_recons((i-1)*len+1:i*len)=filter(1,b,s); 
    end
end

figure(3)
plot(x_recons)
title('reconstructed speech')

f=(-128:127)/256;
Fs=8000;

figure(4)
plot(f*Fs,mag2db(abs(fftshift(fft(x(32*len+1:33*len),256)))))
title('spectrum of a voiced speech frame')
xlabel('frequency Hz')
ylabel('Magnitude dB')

figure(5)
plot(f*Fs,mag2db(abs(fftshift(fft(x(39*len+1:40*len),256)))))
title('spectrum of an unvoiced speech frame')
xlabel('frequency Hz')
ylabel('Magnitude dB')

figure(6)
plot(error)
title('error')