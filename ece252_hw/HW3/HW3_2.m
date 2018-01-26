%% Problem 3 

% load ('washington.mat') or load('o.mat')
n1=numel(myRecording);
beginindex=20000;
endindex=20600;
vowel=myRecording(beginindex:endindex);
n2=numel(vowel);
r_all=xcorr(vowel,'coeff');
r=r_all(n2+1:n2+10);

R=zeros(10,10);
for i=1:10
    for j=1:10
        R(i,j)=r_all(n2+abs(i-j));
    end
end
Rinv=inv(R);
pred_a=Rinv*r
stem(pred_a)
title('Predictor aL')
xlabel('index L')
ylabel('aL')