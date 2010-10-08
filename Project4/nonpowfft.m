x = [1 1 1 1 1];

% Preallocate the array for speed.
N = length(x);
X = zeros([1,N]);

Nf = 2^nextpow2(2*N-1);

y = zeros([1,Nf-1]);

for n=1:N
    y(n) = exp(1i*pi*(n-1)^2/N);
    y(Nf-(n)) = y(n);
end

Y = fft(y,Nf);

f = zeros([1,Nf-1]);
for n=1:N,
    f(n) = x(n)*exp(-1i*pi*(n-1)^2/N);
end

F = fft(f,Nf);

C = ifft(Y.*F);

for n = 1:N,
    X(n) = exp(-1i*pi*n^2/N)/Nf * C(n);
end

X