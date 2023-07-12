
rate = zeros(128,1); %intialize
for s =1:128 % loop aver each value of s
    c  = 0;
    for exp = 1:20 % run 20 experiments
        % generate random matrix A as stradard gaussian
        A = randn(256,512);

        % intialize x with zeros
        x = zeros(512,1);

        % update s locations in x with random numbers sampled from standard
        % gaussian
        inds = randsample(1:numel(x),s,false);
        for i = inds 
           x(i) = normrnd(0,1);
        end


        % calculate y (aka take random measurments)
        y = A*x;

        % calc iniial guess for x
        x0=A'*y;
        %Running the recovery Algorithm to calc x_hat
        x_hat=l1eq_pd(x0,A,[],y,1e-5);
           
        % if success increment by 1
        if norm(x_hat-x) <= ((1e-4)*norm(x))
            c=c+1;
        end
    end
    rate(s) = c/20;
end

plot(rate)
xlabel('s')
ylabel('success rate')
