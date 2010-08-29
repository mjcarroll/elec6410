function x = Exercise1( L, A, b, M )
%% Exercise1  
% Generate a periodic, truncated, decaying exponential function:
% L - Total number of samples in the waveform
% A - Beginning amplitude of the exponential function
% b - Decay rate of the exponential function
% M - Number of samples each period will last
% The function takes the form $A*\exp{-bn}$
% Test Paramters:
% L = 80
% A = 2
% b = 0.08
% M = 20

x = A*exp(-b * mod([0:L-1],M));

end
