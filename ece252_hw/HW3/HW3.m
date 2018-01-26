%% Problem 1 & 2 

% load ('washington.mat') or load('o.mat')
n1=numel(myRecording);
beginindex=16400;
endindex=17000;
vowel=myRecording(beginindex:endindex);
n2=numel(vowel);
r_all_coeff=xcorr(vowel,'coeff');
r=r_all_coeff(n2:n2+10)
stem(0:10,r);
title('auto-correlation(coefficient)')
xlabel('index k')
ylabel('r(k)')


