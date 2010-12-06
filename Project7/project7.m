%% Exercise 1

N = 20;
Wn = 0.25;

B = ones(5,21);

names = {'rectwin';'triang';'hann';'hamming';'blackman'};

B(1,:) = fir1(N,Wn,rectwin(N+1));
B(2,:) = fir1(N,Wn,triang(N+1));
hann_win = hann(N+3);
B(3,:) = fir1(N,Wn,hann_win(2:N+2));
B(4,:) = fir1(N,Wn,hamming(N+1));
blackman_win = blackman(N+3);
B(5,:) = fir1(N,Wn,blackman_win(2:N+2));

for i = 1:5,
    figure1 = figure('PaperSize',[11 8.5],'PaperOrientation','landscape');
    
    set(figure1,'Position',[1 1 1300 400]);
    set(figure1,'Name',names{i});
    axes1 = subplot(1,3,1);
    set(axes1,'Position',[0.045 0.098 0.276 0.85]);
    impz(B(i,:),1);
    
    axes2 = subplot(1,3,2);
    set(axes2,'Position',[0.368 0.098 0.276 0.85]);
    [h,w] = freqz(B(i,:),1);
    semilogy(w,abs(h));
    axis([0 pi 10^-5 10]);
    set(axes2,'XTick',linspace(0,pi,11));
    set(axes2,'XTickLabel',linspace(0,1,11));
    xlabel('Normalized Frequency')
    grid on;grid minor
    title('Magnitude Response')
    
    axes3 = subplot(1,3,3);
    set(axes3,'Position',[0.692 0.098 0.276 0.85]);
    zplane(B(i,:),1);
    xlim(axes3,[-4 4]);
    ylim(axes3,[-3.5 3.5]);
    title('Zero and Pole Locations');
end

%% Exercise 2

N = 20;
Wn = 0.25;
kaiser_B = ones(3,21);
names = {'Beta = 4';'Beta = 6';'Beta = 9'};

kaiser_B(1,:) = fir1(N,0.25,kaiser(N+1,4));
kaiser_B(2,:) = fir1(N,0.25,kaiser(N+1,6));
kaiser_B(3,:) = fir1(N,0.25,kaiser(N+1,9));

for i = 1:3,
    figure1 = figure('PaperSize',[11 8.5],'PaperOrientation','landscape');
    
    set(figure1,'Position',[1 1 1300 400]);
    set(figure1,'Name',names{i});
    axes1 = subplot(1,3,1);
    set(axes1,'Position',[0.045 0.098 0.276 0.85]);
    impz(kaiser_B(i,:),1);
    
    axes2 = subplot(1,3,2);
    set(axes2,'Position',[0.368 0.098 0.276 0.85]);
    [h,w] = freqz(kaiser_B(i,:),1);
    semilogy(w,abs(h));
    axis([0 pi 10^-5 10]);
    set(axes2,'XTick',linspace(0,pi,11));
    set(axes2,'XTickLabel',linspace(0,1,11));
    xlabel('Normalized Frequency')
    grid on;grid minor
    title('Magnitude Response')
    
    axes3 = subplot(1,3,3);
    set(axes3,'Position',[0.692 0.098 0.276 0.85]);
    zplane(kaiser_B(i,:),1);
    xlim(axes3,[-4 4]);
    ylim(axes3,[-3.5 3.5]);
    title('Zero and Pole Locations');
end

%% Exercise 3 - frequency sampling

N = 21;
Wn = 0.25*pi;
step = (2*pi)/N;
freq = -pi:2*pi/(N-1):pi;
signal = circshift(abs(freq) < Wn,[0 ceil(N/2)]);
samp_B = ifft(signal);
samp_B = circshift(samp_B,[0 ceil(N/2)]);

figure1 = figure('PaperSize',[11 8.5],'PaperOrientation','landscape');

set(figure1,'Position',[1 1 1300 400]);
set(figure1,'Name','Frequency Sampling');
axes1 = subplot(1,3,1);
set(axes1,'Position',[0.045 0.098 0.276 0.85]);
impz(samp_B,1);

axes2 = subplot(1,3,2);
set(axes2,'Position',[0.368 0.098 0.276 0.85]);
[h,w] = freqz(samp_B,1);
semilogy(w,abs(h));
axis([0 pi 10^-4 10]);
set(axes2,'XTick',linspace(0,pi,11));
set(axes2,'XTickLabel',linspace(0,1,11));
xlabel('Normalized Frequency')
grid on;grid minor
title('Magnitude Response')

axes3 = subplot(1,3,3);
set(axes3,'Position',[0.692 0.098 0.276 0.85]);
zplane(samp_B,1);
xlim(axes3,[-4 4]);
ylim(axes3,[-3.5 3.5]);
title('Zero and Pole Locations');

%% Exercise 4 - Parks McClellan
f = [0 0.23 0.27 1];
a = [1 1 0 0];

parks_B = firpm(20,f,a);

figure1 = figure('PaperSize',[11 8.5],'PaperOrientation','landscape');

set(figure1,'Position',[1 1 1300 400]);
set(figure1,'Name','Parks McClellan FIR Design');
axes1 = subplot(1,3,1);
set(axes1,'Position',[0.045 0.098 0.276 0.85]);

impz(parks_B,1);

axes2 = subplot(1,3,2);
set(axes2,'Position',[0.368 0.098 0.276 0.85]);
[h,w] = freqz(parks_B,1);
semilogy(w,abs(h));
axis([0 pi 10^-4 10]);
set(axes2,'XTick',linspace(0,pi,11));
set(axes2,'XTickLabel',linspace(0,1,11));
xlabel('Normalized Frequency')
grid on;grid minor
title('Magnitude Response')

axes3 = subplot(1,3,3);
set(axes3,'Position',[0.692 0.098 0.276 0.85]);
zplane(parks_B,1);
xlim(axes3,[-4 4]);
ylim(axes3,[-3.5 3.5]);
title('Zero and Pole Locations');

%% Exercise 5 - Elliptic Lowpass filter

Rs = 0;
a = 0;
while a < 12,
    Rs = Rs+1;
    a = ellipord(0.24,0.26,1,Rs);
end

Rs = Rs - 1

[b,a] = ellip(11,1,Rs,0.24);

figure1 = figure('PaperSize',[11 8.5],'PaperOrientation','landscape');

set(figure1,'Position',[1 1 1300 400]);
set(figure1,'Name','Elliptical IIR Filter Design');
axes1 = subplot(1,3,1);
set(axes1,'Position',[0.045 0.098 0.276 0.85]);
impz(b,a);

axes2 = subplot(1,3,2);
set(axes2,'Position',[0.368 0.098 0.276 0.85]);
[h,w] = freqz(b,a);
semilogy(w,abs(h));
axis([0 pi 10^-6 10]);
set(axes2,'XTick',linspace(0,pi,11));
set(axes2,'XTickLabel',linspace(0,1,11));
xlabel('Normalized Frequency')
grid on;grid minor
title('Magnitude Response')

axes3 = subplot(1,3,3);
set(axes3,'Position',[0.692 0.098 0.276 0.85]);
zplane(b,a);
xlim(axes3,[-4 4]);
ylim(axes3,[-3.5 3.5]);
title('Zero and Pole Locations');

%% Exercise 6
f = [0 567* 2/8000 712 * 2/8000 1];
a = [1 1 0 0];

parks_B = firpm(20,f,a);

figure1 = figure('PaperSize',[11 8.5],'PaperOrientation','landscape');

set(figure1,'Position',[1 1 1300 400]);
set(figure1,'Name','Parks McClellan FIR Design');
axes1 = subplot(1,3,1);
set(axes1,'Position',[0.045 0.098 0.276 0.85]);

impz(parks_B,1);

axes2 = subplot(1,3,2);
set(axes2,'Position',[0.368 0.098 0.276 0.85]);
[h,w] = freqz(parks_B,1);
semilogy(w,abs(h));
axis([0 pi 10^-4 10]);
set(axes2,'XTick',linspace(0,pi,11));
set(axes2,'XTickLabel',linspace(0,1,11));
xlabel('Normalized Frequency')
grid on;grid minor
title('Magnitude Response')

axes3 = subplot(1,3,3);
set(axes3,'Position',[0.692 0.098 0.276 0.85]);
zplane(parks_B,1);
xlim(axes3,[-4 4]);
ylim(axes3,[-3.5 3.5]);
title('Zero and Pole Locations');