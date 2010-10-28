function [ X ] = nonpowfft( x )
% References:
% http://www.engineeringproductivitytools.com/stuff/T0001/PT11.HTM#Head617
% http://www.katjaas.nl/chirpZ/chirpZ.html
% http://en.wikipedia.org/wiki/Bluestein%27s_FFT_algorithm
% http://healpix.jpl.nasa.gov/html/libfftpack/bluestein_8c-source.html
% I'm using the notation for Bluestein's algorithm from wikipedia.
validateattributes(x,{'numeric'},{'vector'});
N=length(x);

% We want the convolution index to be > 2N-1 (from reference 1).
Nf = 2^nextpow2(2*N-1);

% Coefficient a_{n} and b_{n} from Bluestein's algorithm.
n=1:N;
a(n)=x(n).*exp(-1i*pi*(n-1).^2/N);
b(n)=exp(1i*pi*(n-1).^2/N);
b(Nf-(n-2))=b(n);

% The loop generates a b_{n} 1 longer than it's supposed to.
% I started late, and I'm too tired to make this clever.
b=b(1:Nf);

% Convolve a_{n} and b_{n} together.
% Using Nf as an argument for the fft guarantees a power-of-2 input.
% We could just as easily zero-pad and convolve.
y = ifft(fft(a,Nf).*fft(b,Nf),Nf);

% Multiply by coefficient b_{k} from Bluestein's algorithm.
X(n) = y(n).*exp(-1i*pi*(n-1).^2/N);
end


