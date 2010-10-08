function [ y ] = linearConv( x1,x2 )
%linearConv Performs linear convolution using power-of-2 FFT's

N1 = length(x1);
N2 = length(x2);

% Zero pad to the longer signal
X1 = fft(x1,N1 + N2 - 1);
X2 = fft(x2,N1 + N2 - 1);

Y = X1 .* X2;

y = ifft(Y);

end

