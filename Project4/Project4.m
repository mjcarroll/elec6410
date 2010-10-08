%% ELEC6410 Project 4
% Answers to Digital Signal Processing Project #4

%% Question 1


%% Question 2
% The real key here is whether tic/toc or cputime should be used.  I think
% that, in reality, if we wanted something really accurate, we would use
% the MATLAB profiler.  But since cputime and tic/toc are the given
% options, it would make sense to choose the best between the two for the
% assignment.
%
% The thing that really interests me about this is that MATLAB
% documentation seems to prefer tic/toc (wall time), when CPU time seems to
% be a better measure of performance.  Why would wall time be a benchmark?
F = dftmtx(2^11);

mjctimes = zeros([1,10]);
mattimes = zeros([1,10]);

x = rand([1,2^11]);
for n = 1:10,
    Xf = zeros([1,2^11]);
    tic;
    Xf = dftmjc(x);
    mjctimes(n) = toc;
end
disp('Michaels Function: ');
mean(mjctimes)

for n = 1:10,
    Xf = zeros([1,2^11]);
    tic;
    Xf = F * x';
    mattimes(n) = toc;
end
disp('Matrix Multiply: ');
mean(mattimes)

%% Question 3
% Testing the internal MATLAB FFT function against my function and the
% matrix multiplication yields a much faster result (about 500 times faster).
% This is obvious, as the matrix multiplication will be O(n^2), and the FFT
% will be O(n log(n)).  For the case of 2^11, this is a speedup of about
% 200.  On top of the algorithm being faster, the MATLAB function is
% probably using FFTW under the hood.  FFTW also takes advantage of
% extended instruction sets in the Intel processor and is highly
% parallelized.
x = rand([1,2^11]);
ffttimes = zeros([1,10000]);
for n=1:10000,
    tic;
    Xf = fft(x);
    ffttimes(n) = toc;
end

disp('FFT: ');
mean(ffttimes)

%% Question 4
% Computing the speed of a non-power-of-2 FFT.  This turns out to be
% considerably slower (order of magnitude).  The reason for this is that
% MATLAB has to use one of the alternate algorithms that we talked about in
% class.
%
% The length of the sequence we are to use (2^11-9) is a large prime
% number, so it seems that MATLAB will use the Rader algorithm.  Using
% this algorithm will move the complexity bound from O(N log(N)) to
% something slightly worse.
x = rand([1,2^11-9]);
fftnon2times = zeros([1,10000]);
for n=1:10000,
    tic;
    Xf = fft(x);
    fftnon2times(n) = toc;
end

disp('FFT (2^11-9):');
mean (fftnon2times)

%% Question 5

x1 = rand([1,2^12]);
x2 = rand([1,2^12]);

convtimes = zeros([1,1000]);
fftconvtimes = zeros([1,1000]);

for n=1:1000,
    tic;
    linearConv(x1,x2);
    fftconvtimes(n) = toc;
    tic;
    conv(x1,x2);
    convtimes(n) = toc;
end

disp('FFT Convolution Time')
mean(fftconvtimes)
disp('MATLAB Convolution Time')
mean(convtimes)

%% Question 6

% Make the sequence a BIG prime length.
x = rand([1,999983]);

tic;
nonpowfft(x);
toc

tic;
fft(x);
toc
    
