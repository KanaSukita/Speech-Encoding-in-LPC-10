% obatin the data sample
load('washington.mat')
x=myRecording;

% define the filter parameters
h0=0.125*[-1,2,6,2,-1];
f0=0.5*[1,2,1];
h1=0.5*[1,-2,1];
f1=0.125*[1,2,-6,2,1];

% plot the frequency response of H0(z) and H1(z)
subplot(2,1,1)
plot((-128:127)/256,abs(fftshift(fft(h0,256))))
title('frequency response of H0(z) (linear magnitude)')
xlabel('frequency cycles/sampe')
ylabel('linear magnitude')

subplot(2,1,2)
plot((-128:127)/256,abs(fftshift(fft(h1,256))))
title('frequency response of H1(z) (linear magnitude)')
xlabel('frequency cycles/sampe')
ylabel('linear magnitude')

% passing data sample through the LPF and HPF
y0=filter(h0,1,x);
y1=filter(h1,1,x);

% downsample
v0=downsample(y0,2);
v1=downsample(y1,2);

% upsample
u0=upsample(v0,2);
u1=upsample(v1,2);

% passing the data through the synthesis
x_recover=filter(f0,1,u0)+filter(f1,1,u1);

playObj=audioplayer(x_recover,8000)
play(playObj)