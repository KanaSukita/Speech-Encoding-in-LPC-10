function k=lpccoef_parcor(p,a_all)
%
% function to convert from lpc polynomial coefficients to parcor
% coefficients
%
% Inputs:
%   p=lpc order
%   a_all=set of lpc coefficients for p-th order solution, A(z)=1-sum(i=1 to p)

% Output:
%   k=set of parcor coefficients

% initialize alpha array
alpha=-a_all(2:p+1);
a=zeros(p,p);
for j=1:p
     a(p,j)=alpha(j);
end    
 
% run the recursion backwards (from p-th order solution to first order
% solution; end result is the set of k's
k(p)=a(p,p);
 for i=p:-1:2
     for j=1:i-1;
        a(i-1,j)=(a(i,j)+a(i,i)*a(i,i-j))/(1-k(i)^2);
     end
     k(i-1)=a(i-1,i-1);
 end

