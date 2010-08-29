x = [1 1 1 1 1 0 0 0 0 0 0];
h = [1 0 0 2 0 0 0 0 0 0 0];
out = conv(x,h)
stem(out)