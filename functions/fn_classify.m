function [accuracy, AUC] = fn_classify(nontarget_epoch_data, target_epoch_data)
% Combine the data into a single matrix and create labels
data = cat(3, nontarget_epoch_data, target_epoch_data); % 1001x8x1200
numTarget = size(target_epoch_data, 3);
numNonTarget = size(nontarget_epoch_data, 3);
labels = [zeros(numNonTarget,1); ones(numTarget,1)];

% Define the number of folds for cross-validation
numFolds = 5;

% Create a partitioning object for cross-validation
partition = cvpartition(labels,'KFold',numFolds);

% Get the indices for the training and test sets
trainingIdx = training(partition, 1);
testIdx = test(partition, 1);

% Create the training and test data sets
trainData = data(:, :, trainingIdx);
testData = data(:, :, testIdx);

% Create the training and test label sets
trainLabels = labels(trainingIdx);
testLabels = labels(testIdx);

% Reshape the data
trainDataReshaped = reshape(trainData, [], size(trainData, 1)*size(trainData, 2));
testDataReshaped = reshape(testData, [], size(testData, 1)*size(testData, 2));

% Train LDA classifier
ldaClassifier = fitcdiscr(trainDataReshaped, trainLabels);

% Make predictions on test data
predictions = predict(ldaClassifier, testDataReshaped);

% Evaluate classification accuracy
accuracy = mean(predictions == testLabels);

% Compute the ROC curve and AUC
scores = ldaClassifier.predict(testDataReshaped);
[X,Y,~,AUC] = perfcurve(testLabels, scores, 1);

% Plot the ROC curve
plot(X,Y);
xlabel('False positive rate');
ylabel('True positive rate');
title(sprintf('ROC Curve (AUC = %0.2f)', AUC));
end
