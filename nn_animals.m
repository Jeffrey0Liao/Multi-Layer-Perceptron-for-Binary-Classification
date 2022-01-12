function [] = nn_animals()
tic;
%NN_ANIMALS 

% Initialization
clear ; close all; clc
% Data loading
load data.mat

% create a neural network
net = patternnet([20 10]);

% divided into training, validation and testing simulate
net.divideParam.trainRatio = 0.65;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0.20;

rand_indices = randperm(size(X, 2));
net.trainParam.max_fail = 12;
net.trainparam.lr = 0.001;

trainData = X(:, rand_indices(1:1950));
trainLabels = y(:, rand_indices(1:1950));
valData = X(:, rand_indices(1951:2400));
valLabels = y(:, rand_indices(1951:2400));
testData = X(:, rand_indices(2401:end));
testLabels = y(:, rand_indices(2401:end));

% train a neural network
net = train(net, trainData, trainLabels);

% show the network
view(net);

preds = net(testData);
est = vec2ind(preds);
tar = vec2ind(testLabels);

% find percentage of correct classifications
accuracy = 100*length(find(est==tar))/length(tar);
fprintf('Accuracy rate is %.2f\n', accuracy);

% confusion matrix
plotconfusion(testLabels, preds)
save nn_animals.mat net;
toc;
end

