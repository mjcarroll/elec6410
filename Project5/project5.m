%% Homework Project #5

%% Exercise 1

%%% Find the poles and zeros 
num = [1, 0.2, -0.8]; den = [1, 0.7, 0.64];
h = tf(num,den);
[z,p,k] = tf2zp(num,den)

%%% Generate a pole-zero plot
figure(1); zplane(num,den);

%%% Display the frequency response with freqz
figure(2); freqz(num,den);

%% Exercise 2
HPnum = [1.0000,-1.9566,0.9571];
HPden = [1.0000,0.0000,0.2500];

highpass = tf(HPnum,HPden)

figure(3); zplane(num,den);
figure(4); freqz(HPnum,HPden);

%% Exercise 3

% $$ y[n] = -0.25y[n-1] + x[n] - 1.957x[n-1] + 0.9571x[n-2] $$

x = cos(0.25*pi*(0:0.1:100)) + cos(0.75*pi*(0:0.1:100));

figure(5); plot((0:0.1:100),x);
figure(6); plot((0:0.1:100),filter(HPnum,HPden,x));