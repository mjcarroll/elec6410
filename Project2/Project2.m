%% ELEC6410 Project 2
% Answers to Digital Signal Processing Project #2
%% Question 1
% Let $y[n] - 0.9y[n-1] + 0.7y[n-2] = x[n] + 0.5x[n-1] + 0.3x[n-2]$. This
% difference equation can be implemented using the filter command.  Find
% the vectors a and b that represent that difference equation above for the
% filter command.

%%% Solution
% Using the properties of the Z-transform, the difference equation can be
% rearranged to the following:
%
% $$\frac{Y(z)}{X(z)} = \frac{1 + 0.5z^{-1} + 0.3z^{-2}}{1 - 0.9z^{-1} +
% 0.7z^{-2}}$$
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

x1 = cos(0.32*pi*(0:1:100));
x2 = cos(0.80*pi*(0:1:100));

figure(4);
subplot(2,1,1);
stem(x1);
title('x1');
subplot(2,1,2);
title('x2');

figure(5);
subplot(2,1,1);
stem(filter(b,a,x1));
title('Filter Response to x1');
xlabel('Samples');ylabel('Amplitude');
subplot(2,1,2);
stem(filter(b,a,x2));
title('Filter Response to x2');
xlabel('Samples');ylabel('Amplitude');

figure(6);
stem(filter(b,a,x1+x2));
title('Filter Reponse to Combined x1 and x2');
xlabel('Samples');ylabel('Amplitude');