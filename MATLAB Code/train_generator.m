function e=train_generator(period)
%
% function to return an excitation 
% return unit impulse responses in each period when this is a voiced frame
%
% Inputs:
%   period=pitch period of this frame

% Output:
% e=excitation
e=zeros(1,180);
for i=1:ceil(180/period)
    e((i-1)*period+1)=1;
end