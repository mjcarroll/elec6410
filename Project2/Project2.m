%% ELEC6410 Project 2
% Answers to Digital Signal Processing Project #2
%% Question 1
% Let $y[n] - 0.9y[n-1] + 0.7y[n-2] = x[n] + 0.5x[n-1] + 0.3x[n-2]$. This
% difference equation can be implemented using the filter command.  Find
% the vectors a and b that represent that difference equation above for the
% filter command.

%%% Solution
% Using the properties of the Fourier transform, the difference equation can be
% rearranged to the following:
%
% $$\frac{Y(e^{j\omega})}{X(e^{j\omega})} = 
% \frac{1 + 0.5e^{-j\omega} + 0.3e^{-2j\omega}}
% {1 - 0.9e^{-j\omega} + 0.7e^{-2j\omega}}$$
%
% Yielding the following two vectors, with vector "a" representing the y coefficients,
% and vector "b" representing the x coefficiencts:
a = [1 -0.9, 0.7];
b = [1, 0.5, 0.3];

%% Question 2
% Calculate $h[n]$ analytically for the difference equation above.  Your
% answer should be a functional expression.  Hint: You may find the
% residuez function useful.  Note that the initial expression may come out
% with complex components.  However, it is possible to simplify it into an
% expression that is real.

%%% Solution
% Using the derived equation in the Fourier domain from Question 1, the
% impulse response of h[n] may be calculated.
%
% $$H(e^{j\omega}) = \frac{Y(e^{j\omega})}{X(e^{j\omega})} = 
% \frac{1 + 0.5e^{-j\omega} + 0.3e^{-2j\omega}}
% {1 - 0.9e^{-j\omega} + 0.7e^{-2j\omega}}$$
%
% Using partial fraction expansion and the residuez command in MATLAB, this
% yields the equation:
%
% $$H(e^{j\omega}) = \frac{R(1)}{1-P(1)e^{-jw}} + \frac{R(2)}{1-P(2)e^{-j\omega}} +
% k$$
%
% Which equals:
%
% $$H(e^{j\omega}) = \frac{0.2857 - 0.8101j}{1- (0.45 + 0.7053j)e^{-j\omega}} +
% \frac{0.2857 + 0.8101j}{1 - (0.45 - 0.7053j)e^{-j\omega}} + 0.4286$$
%
% Using the Inverse DTFT yields:
%
% $$h[n] = 0.4286\delta[n] + (0.2857 - 0.8101j)(0.45 + 0.7053j)^{n}\mu[n] + 
% (0.2857 + 0.8101j)(0.45 - 0.7053j)^{n}\mu[n]$$
%
% Using the exponential representation of complex numbers:
%
% $$h[n] = 0.4286\delta[n] + (0.859e^{-1.2317j})(0.8366e^{j})^{n}\mu[n] +
% (0.859e^{1.2317j})(0.8366e^{-j})^{n}\mu[n]$$
%
% Combining some of the exponential terms:
%
% $$h[n] = 0.4286\delta[n] + 0.718e^{(-1.2317 + n)j} + 0.718e^{(1.2317 -
% n)j}\mu[n]$$
%
% Using Euler's Identity:
%
% $$h[n] = 0.4286\delta[n] + 1.436\cos{(n - 1.2317)}\mu[n]$$

[r,p,k] = residuez(b,a)

%% Question 3
% Create an impulse (not a pulse!) of length 100.  Recall that systems
% described by linear constant-coefficient difference equations are LSI
% systems (assuming initial rest conditions).  Characterize the LSI system
% above by finding the first 100 points of the impulse response using
% filter, and plot the result with stem.

%%% Solution
% The system was characterized using the filter function to generate an
% impulse response for the system.  The impulse response is plotted in
% Figure 1.
figure(1);
impulse = [1, zeros(1,99)];

impulseResponse = filter(b,a,impulse);

stem(impulseResponse);
title('Impulse Response of y[n]');
xlabel('Samples');ylabel('Amplitude');

%% Question 4
% Examine two ways of implementing an LSI system:
% 
% # Create a pulse of width 10 and zeropadded to a total length of 100.
% # Find the response of the system to this input pulse using conv by
% convolving with the impulse response.
% # Find the response of the system to this input pulse using filter by
% filtering with the difference equation.
% # Explain any differences you observe between these two results.

%%% Solution
% The system's response to a pulse of width 10 was generated using the 
% impulse reponse of the system, characterized in the previous question.
% 
% The filter command was then used to generate a similar response to the
% pulse of width 10.
%
% Both responses are included in Figure 2.  The convolution response ends
% up containing a higher number of samples due to the nature of the
% operating.  Convolving the two samples together, each of length 100, will
% yield a sample with length 199.  The 100 points that the filter response
% generated are identical to the first 100 points of the convolution
% function, just truncated at the 101st sample.
pulse = [ones(1,10),zeros(1,90)];
convolutionResults = conv(pulse,impulseResponse);
filterResults = filter(b,a,pulse);

figure(2);
subplot(2,1,1);
stem(convolutionResults);
title('LSI System Response using MATLAB conv() function');
xlabel('Samples');ylabel('Amplitude');
subplot(2,1,2);
stem(filterResults);
title('LSI System Response using MATLAB filter() function');
xlabel('Samples');ylabel('Amplitude');

%% Question 5
% Examine the frequency response:
%
% # Find an expression for the frequency response of the system described
% by the difference equation given.
% # Use the command freqz to plot the magnitude and phase response of the
% system.
% # Is this system more of a highpass, a lowpass, or a bandpass filter?
% Explain your answer.

%%% Solution
%
% The frequency response of the system was found as part of the derivation
% of h[n].
%
% $$H(e^{j\omega}) = \frac{Y(e^{j\omega})}{X(e^{j\omega})} = 
% \frac{1 + 0.5e^{-j\omega} + 0.3e^{-2j\omega}}
% {1 - 0.9e^{-j\omega} + 0.7e^{-2j\omega}}$$
%
% From looking at the graph of the magnitude and phase Response in figure
% 3, then system appears to be a low-pass filter, but it is important to
% remember that the frequency response is periodic in $\omega$ with a
% period of $2\pi$.  This makes the filter a bandpass filter.

figure(3);
freqz(b,a);
title('Magnitude and Phase Response');

%% Question 6
% Examine the reponse to two sine waves:
%
% # Create two signals $x_{1}[n] = \cos(0.32\pi n)$ and $x_{2}[n] =
% \cos(0.8 \pi n)$, both of length 100.
% # Filter each signal separately with the filter defined in Step 1, and
% plot them.
% # Explain the outputs you observe in terms of the frequency magnitude
% response of the system.
% # Now add the two signals together and filter the sum of the two.
% Explain the output in light of your previous observations.

%%% Solution
%
% To determine the effect of the filter on the two signals, it is important
% to note where in the magnitude response that the two signals fall.  The
% first signal, x1, falls at $0.32\pi$ radians, which is in the middle of
% the pass band of the filter (about 15dB gain).  The second signal, x2,
% falls at $0.8\pi$ radians, which is in the middle of the stop band of the
% filter (about -10dB attenuation).
%
% Using this knowledge, the output of the filter for the two different
% input signals can be seen in figure 4.  As expected, the first signal,
% x1, has a significant gain in amplitude, reaching a value of almost 5.
% The second signal, x2, has a decrease in amplitude, barely reaching 0.5.
%
% The combination of the two signals yields the same results, with the
% major peaks in the signal coming mainly from the contributions of signal
% x1.

x1 = cos(0.32*pi*(0:1:100));
x2 = cos(0.80*pi*(0:1:100));

figure(4);
subplot(2,1,1);
stem(filter(b,a,x1));
title('Filter Response to x1');xlabel('Samples');ylabel('Amplitude');
subplot(2,1,2);
stem(filter(b,a,x2));
title('Filter Response to x2');xlabel('Samples');ylabel('Amplitude');

figure(5);
stem(filter(b,a,x1+x2));
title('Filter Reponse to Combined x1 and x2');
xlabel('Samples');ylabel('Amplitude');