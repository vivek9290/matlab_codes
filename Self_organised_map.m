close all, clear all, clc, format compact
% number of samples of each cluster
K = 200;
% offset of classes
q = 1.1;
% define 4 clusters of input data
P = [rand(1,K)-q rand(1,K)+q rand(1,K)+q rand(1,K)-q;
 rand(1,K)+q rand(1,K)+q rand(1,K)-q rand(1,K)-q];
% plot clusters
plot(P(1,:),P(2,:),'g.')
hold on
grid on
% SOM parameters
dimensions = [100];
coverSteps = 100;
initNeighbor = 10;
topologyFcn = 'gridtop';
distanceFcn = 'linkdist';
% define net
net1 = selforgmap(dimensions,coverSteps,initNeighbor,topologyFcn,distanceFcn);
% train
[net1,Y] = train(net1,P);
% plot input data and SOM weight positions
plotsompos(net1,P);
grid on
% SOM parameters
dimensions = [10 10];
coverSteps = 100;
initNeighbor = 4;
topologyFcn = 'hextop';
distanceFcn = 'linkdist';
% define net
net2 = selforgmap(dimensions,coverSteps,initNeighbor,topologyFcn,distanceFcn);
% train
[net2,Y] = train(net2,P);
% plot input data and SOM weight positions
plotsompos(net2,P);
grid on
% plot SOM neighbor distances
plotsomnd(net2)
% plot for each SOM neuron the number of input vectors that it classifies
figure
plotsomhits(net2,P)