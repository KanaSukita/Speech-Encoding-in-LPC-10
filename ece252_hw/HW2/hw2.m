n=64;  
f=[0.05 0.95];
m=[1 1]; 
b=firpm(n,f,m,'h');  
[H,w]=freqz(b,1,512);
figure(1)
plot(w,10*log10(abs(H)));
title('dB Magnitude of H(z)');
figure(2)
plot(w,angle(H));
[h,t]=impz(b,1,64);
title('Phase of H(z)');
figure(3)
plot(t-32,h);
title('impulse response h(n)');
