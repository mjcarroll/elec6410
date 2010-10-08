x=[1 1 1 1 1];

% References:
% http://www.engineeringproductivitytools.com/stuff/T0001/PT11.HTM#Head617
% http://www.katjaas.nl/chirpZ/chirpZ.html
% http://en.wikipedia.org/wiki/Bluestein%27s_FFT_algorithm
% http://healpix.jpl.nasa.gov/html/libfftpack/bluestein_8c-source.html
% I'm using the notation for Bluestein's algorithm from wikipedia.

N=length(x);
% We want the convolution index to be > 2N-1
Nf = 2^nextpow2(2*N-1);

% Coefficient a_{n} from Bluestein's algorithm.
a = zeros([1,Nf]);
for n=1:N,
    a(n)=x(n).*exp(-1i*pi*(n-1)^2/N);
end

% Coefficient b_{n} from Bluestein's algorithm.
b = zeros([1,Nf]);
b(1)=1;
for n=2:N,
    b(n)=exp(1i*pi*(n-1)^2/N);
    b(Nf-(n-2))=b(n);
end

% Convolve a_{n} and b_{n} together.
% Using Nf as an argument for the fft guarantees a power-of-2 input.
% We could just as easily zero-pad and convolve.
A = fft(a,Nf);
B = fft(b,Nf);
y = ifft(A.*B,Nf);

% Coefficient b_{k} from Bluestein's algorithm.
Y = zeros([1,N]);
for n=1:N
    Y(n) = y(n).*exp(-1i*pi*(n-1)^2/M);
end

