function y = Exercise7b(x, yInit)
%% Exercise7b 
% Compute an iterative square root from a given input
% 
% $$ x[n] = \alpha*\mu[n] $$
% 
% Using the formula:
% 
% $$ y[n] = x[n] - y^{2}[n-1] + y[n-1]$$

% Rather than accepting "iterations" as an input, let's just calculated it
% from the size of x. (Second dimension is columns)
iterations = size(x,2);

% Pre-allocate, because it seems to make MATLAB happy.
% I'm assuming this is because MATLAB then uses FORTRAN style arrays vs
% C-type arrays under the hood.
y = [zeros(1,iterations)];

% Handle the first case here
% Minor cosmetic performance reasons, if put inside the loop, I would be
% executing the comparison for MATLAB's "if" statement "iterations" times.
y(1) = x(1) - yInit^2 + yInit;

% Take care of the rest of our iterations
for iter = 2:iterations
    y(iter) = x(iter) - y(iter-1)^2 + y(iter-1);
end

end

