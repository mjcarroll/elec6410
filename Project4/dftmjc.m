function [ X ] = dftmjc( x )
%dftmjc Computes the DFT summation of an input sequence.
%   Michael's (probably bad) implementation of the DFT.

% Verify that we are getting a proper 1-D integer sequence in.
validateattributes(x,{'numeric'},{'vector'});

% Preallocate the array for speed.
N = length(x);
X = zeros(N);

% Summation is O(n^2) (bad news)
for k=1:N,
   for n=1:N,
       X(k,n)=x(k)*exp(((-2*pi*1i)/N) * (k-1) * (n-1));
   end
end

% Let MATLAB do the actual sum, it probably vectorizes this.
X = sum(X);

end