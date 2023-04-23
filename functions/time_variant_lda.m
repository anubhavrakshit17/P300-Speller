function [classification, lda_weights] = time_variant_lda(target_epoch_data, nontarget_epoch_data, new_trial)
% Apply time variant LDA to distinguish between target and nontarget data
%
% Inputs:
% - target_epoch_data: a 3D array of target data, with dimensions trials x channels x time points
% - nontarget_epoch_data: a 3D array of nontarget data, with dimensions trials x channels x time points
% - new_trial: a 2D array of new data to be classified, with dimensions channels x time points
%
% Outputs:
% - classification: a string indicating the classification of the new trial, either 'target' or 'nontarget'
% - lda_weights: a 1D array of time-varying LDA weights, with one weight per time point

%i have nontarget_epoch_data 1001x8x1050 double and target_epoch_data 1001x8x150 double, how can I apply time variant LDA to distinguish between target and nontarget


    % Concatenate target and nontarget data
    data = cat(3, target_epoch_data, nontarget_epoch_data);

    % Reshape data
    data = reshape(data, size(data, 1), []);

    

    % Compute time-varying LDA weights
    lda_weights = zeros(size(data, 2), 1);
    for i = 1:size(data, 2)
        time_slice = data(:,i);
        target_score = log(mvnpdf(time_slice', target_mean', target_cov));
        nontarget_score = log(mvnpdf(time_slice', nontarget_mean', nontarget_cov));
        lda_weights(i) = target_score - nontarget_score;
    end

    % Classify new trial
    lda_scores = zeros(size(new_trial, 2), 1);
    for i = 1:size(new_trial, 2)
        time_slice = new_trial(:,i);
        target_score = log(mvnpdf(time_slice', target_mean', target_cov));
        nontarget_score = log(mvnpdf(time_slice', nontarget_mean', nontarget_cov));
        lda_scores(i) = target_score - nontarget_score;
    end
    if sum(lda_scores > 0) > sum(lda_scores < 0)
        classification = 'target';
    else
        classification = 'nontarget';
    end
end
