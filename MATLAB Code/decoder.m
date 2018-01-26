load('lpc4.mat')
load('lpc10.mat')
load('gain.mat')
load('voiced_detection.mat')
load('pitch_periods.mat')

% Generate the excitation and reconstruct the speech
index4=0;
index10=0;
indexp=0;
len=180;
x_recons=zeros(1,24000);
for i=1:numel(voiced)
    if voiced(i)==0
        index4=index4+1;
        excitation=randn(1,180);
        x_recons((i-1)*len+1:i*len)=filter(sqrt(p(i)),a4(index4,:),excitation);
    else
        index10=index10+1;
        indexp=indexp+1;
        excitation=train_generator(periods(indexp));
        x_recons((i-1)*len+1:i*len)=filter(sqrt(p(i)*periods(indexp)),a10(index10,:),excitation);
    end
end

% normalize and write the output
sentc=x_recons/(max(abs(x_recons)));
audiowrite('reconstruction.wav',sentc, 8000)