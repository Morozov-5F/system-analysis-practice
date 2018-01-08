clear all;
% Number of factors and their range
nf = 2;
minf = [0.3 0.25]; % Should be 0.3 0.25
maxf = [0.7 0.6];   % Should be 0.7 0.6
% Form a two-level fractional factorial design
N = 2^nf;
fracplan = fracfact('a b ab' )
% Create a transposed design matrix with addition of fictional factorial
fictfact = ones(N, 1);
X = [fictfact fracplan]'
% Form a source data for an experiment
fracexp = zeros(N, nf);
for i = 1:nf,
    for j = 1:N,
        fracexp(j,i) = minf(i) + (fracplan(j,i) + 1) * (maxf(i) - minf(i))/2;
    end;
end;
fracexp

% Tactical design
d_m   = 0.2;   % Should be 0.2
alpha = 0.04;  % Should be 0.04
% Find a critical value for a t-distributed value
t_cr_alpha = norminv(1 - alpha / 2);
% Number of required experiments
NE = 10000

% Enumerate through all of the experiments of the strategical design
Y = zeros(1, N);
for j = 1:N,
    v = fracexp(j, 1);
    w = fracexp(j, 2);
    % First, we need to determine number of experiments to run 
    NE = 1;
    k = 0;
    while NE < 500
        u(NE) = betarnd(v, w);
        if (NE > 30),
            D = std(u) ^ 2;
            n = round((t_cr_alpha ^ 2) * D / (d_m ^ 2));
            if (n == NE),
                NE
                break
            end
        end
        NE = NE + 1;
    end
    % Enumerate through all of the statistical experiments
%     u = zeros(1, NE);
%     for k = 1:NE,
%         % Imitate a system (Beta-distrbuted value)
%         u(k) = betarnd(v, w); % Should be betadistr(v, w)
%     end;
    % Mean for each experiment
    mx = mean(u);
    Y(j) = mx;
    % Plot a diagramm with 12 intervals on it
%     figure;
%     hist(u, 12);
end;

% Calculate regression coefficients for eperiment results
C = X * X';
b_ = inv(C) * X * Y'

A = minf(1):0.1:maxf(1); 
B = minf(2):0.1:maxf(2); 
[~, N1] = size(A); 
[~, N2] = size(B);
for i = 1:N1, 
    for j = 1:N2, 
        an(i) = 2 * (A(i) - minf(1)) / (maxf(1) - minf(1)) - 1; 
        bn(j) = 2 * (B(j) - minf(2)) / (maxf(2) - minf(2)) - 1; 
        
        Yc(j, i) = b_(1) + an(i) * b_(2) + bn(j) * b_(3) + an(i) * bn(j) * b_(4);
        Yo(j, i) = A(i) / (A(i) + B(j));
    end;
end;

[x, y] = meshgrid(A, B); 
figure; 
subplot(1,2,1), plot3(x,y,Yc), 
xlabel('fact a'), 
ylabel('fact b'),
zlabel('Yc'), 
title('System output (simulated)'), 
grid on, 
subplot(1,2,2), plot3(x,y,Yo),
xlabel('fact a'), 
ylabel('fact b'), 
zlabel('Yo'), 
title('System output (actual)'), 
grid on;
% Plot both ouputs on the same plot
figure;
plot3(x,y,Yc), hold on, plot3(x,y,Yo),
xlabel('fact a'), ylabel('fact b')
zlabel('Yo, Yc'),
title('Compared system output'),
grid on;
