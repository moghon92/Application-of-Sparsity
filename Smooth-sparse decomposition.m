clc
clear all

load data.mat
M = double(imread('image32.jpeg'));
M = imresize(M,[100 10]);
figure;imagesc(M); colormap('jet')

Basis{1} = B; % convert to cell
Basisa{1} = Ba; % convert to cell


[yhat,a] = bsplineSmoothDecompauto(M,Basis,Basisa,[],[]); % run ssd

figure
colormap('jet')
subplot(1,3,1)
imagesc(yhat)
title('Mean')
set(gca,'FontSize',14)
subplot(1,3,2)
imagesc(a)
title('Anomalies')
set(gca,'FontSize',14)
subplot(1,3,3)
imagesc(Y-yhat-a)
title('noise')
set(gca,'FontSize',14)
