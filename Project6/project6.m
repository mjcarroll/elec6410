clc
clear all

%% Exercise 1
%
% I used the MATLAB butter command to design the 5th order Butterworth
% filter.

Wn = 0.15;
N = 5;

for i = 1:4,
    if i == 1,
        [B,A] = butter(N,Wn,'low');
        type = 'butter';
    elseif i == 2,
        [B,A] = cheby1(N,0.5,Wn,'low');
        type = 'cheby1';
    elseif i == 3,
        [B,A] = cheby2(N,30,Wn,'low');
        type = 'cheby2';
    elseif i == 4,
        [B,A] = ellip(N,0.5,30,Wn,'low');
        type = 'elliptical';
    end
    figure();
    freqz(B,A);
    title(['Magnitude and Phase Response of the ',type,' LPF']);

    figure();
    zplane(B,A);
    title(['Pole and Zero Locations in the Z-domain of the ',type,' LPF']);

    figure();
    x = [1, zeros(1,24)];
    y = filter(B,A,x);
    stem(y)
    title(['Impulse Response of the ',type,' Filter']);
    ylabel('Amplitude'); xlabel('Samples');
end

%% Exercise 2

Wp = 0.15; Ws = 0.6;
Rp = 0.5; Rs = 30;

fprintf('Butterworth %f Order\n',buttord(Wp,Ws,Rp,Rs));
fprintf('Chebyshev I %f Order\n',cheb1ord(Wp,Ws,Rp,Rs));
fprintf('Chebyshev II %f Order\n',cheb2ord(Wp,Ws,Rp,Rs));
fprintf('Elliptical %f Order\n',ellipord(Wp,Ws,Rp,Rs));

%% Exercise 3

audio = auread('doorbell');

N = length(audio);
if mod(N,2)==0
    k = -N/2:N/2-1;
else
    k = -(N-1)/2:(N-1)/2;
end
T = N/8000;
freq = k/T;

spectrum = fft(audio)/N;
spectrum = fftshift(spectrum);

stem(freq,abs(spectrum))

Wp = .2; Ws = .8;
Rp = 3;  Rs = 15;

[Nb,Wnb] = buttord(Wp, Ws, Rp, Rs);
[Bb,Ab] = butter(Nb,Wnb,'low');
yb = filter(Bb,Ab,audio);

[Nc1,Wnc1] = cheb1ord(Wp, Ws, Rp, Rs);
[Bc1,Ac1] = cheby1(Nc1,Rp,Wnc1,'low');
yc1 = filter(Bc1,Ac1,audio);

[Nc2,Wnc2] = cheb2ord(Wp, Ws, Rp, Rs);
[Bc2,Ac2] = cheby2(Nc2,Rp, Wnc2,'low');
yc2 = filter(Bc2,Ac2,audio);

[Ne,Wne] = ellipord(Wp, Ws, Rp, Rs);
[Be,Ae] = ellip(Ne,Rp,Rs,Wne,'low');
ye = filter(Be,Ae,audio);