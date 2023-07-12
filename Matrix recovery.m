%% a)

%Generating M0 matrix
n1 = 50; n2 = 50;
A = randi([-20,20],n1,n2);
r = 2; %rank
[U, S, V] = svd(A); %SVD decomp

% truncate the sigma matrix
s = diag(S); s(r+1:end)=0; S=[diag(s); zeros(n1-n2,n2)];

M = U* S* V';
rank_M = rank(M);
M0 = M;

%Removing 50% of the observations
A = [rand(n1,n2)>=0.50];
M(A) = 0;
m = sum(sum(A==0));

%% b)
%Initialization
Y=zeros(n1,n2);
delta = n1*n2/m;
tau = 250;
%Iterations
vec = zeros(500,1);
err = zeros(500,1);

for i = 1:500
[U, S, V] = svd(Y);
S_t = (S-tau);
S_t(S_t<0) = 0;
Z = U*S_t*V';
P = M-Z;
P(A) = 0;
Y0 = Y;
Y = Y0 + delta*P;
vec(i) = sum(sum((Y-Y0).^2));
%err(i) = sum(sum((M0-Z).^2))/sum(sum((M0).^2));
err(i) = norm(Z-M0,'fro')/norm(M0,'fro');
end
% plot the results
figure;plot(vec);
figure;plot((err));
figure;
Ar=reshape(A, n1*n2,1);
Xr=reshape(M0, n1*n2,1);Xr=Xr(Ar);
Zr=reshape(Z, n1*n2,1);Zr=Zr(Ar);
subplot(2,1,1);plot(Xr);hold on;plot(Zr,'r');
subplot(2,1,2);plot(Xr-Zr);

%% c

error_final = norm(Z-M0,'fro')/norm(M0,'fro');
