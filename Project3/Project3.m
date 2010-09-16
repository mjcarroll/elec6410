%% ELEC6410 Project 3
% Answers to Digital Signal Processing Project #3
%% Question 1
% Examine a sampled waveform

%%% Part A
% Same the waveform $x(t) = 3\cos{3000\pit} + \cos(800\pit}$ at a sampling
% frequency of 16 kHz for one second:
%
% Since the signal is sampled at greater than the Nyquist rate, it may be
% treated as a continuous signal.
t = [0:1/16000:1];
xc = 3*cos(3000*pi*t) + cos(800*pi*t);

%%% Part B
% Plot the first 100 points of the signal with an appropriately labeled t
% axis.
%
% Plot is used for the case of a continuous signal in Figure ~\ref(fig:figure1)
figure(1);
plot(t(1:100),xc(1:100));
xlabel('Time in Seconds'); ylabel('Amplitude');
title('First 100 Points of Waveform xc');

%%% Part C
% Plot the Fourier-transform magnitude of x(t).
figure(2);
plot([-8000:7999],fftshift(abs(fft(xc(1:2*8000)))));
xlabel('Normalized Frequency (\time 2\pi to give rad/s)');
title('Fourier-transform magnitude of waveform xc');

%%% Part D
% Explain how this graph corresponds to the actual Fourier transform of
% x(t).
%
% The plot of the Fourier transform in Figure ~\ref(fig:figure2).  The
% important thing to note in the plot of the Fourier transform is that the
% amplitudes are a function of the number of samples as opposed to
% infinite Dirac Delta functions in the case of a true Fourier transform.