function fn_results_plot()
    %addpath("hackathon\Results\")
    % Load the results from the CSV file
    results = csvread('results.csv'); 

    % Define the subject IDs and the number of subjects
    subject_ids = {'S1', 'S2', 'S3', 'S4','S5'};
    num_subjects = numel(subject_ids);

    % Extract the accuracy and AUC values for each subject
    accuracy_values = results(:,1);
    auc_values = results(:, 2);

        % Plot accuracy and AUC side by side
    % Plot the accuracy and AUC values side by side for each subject
figure;

% Create the first axes for AUC values
ax1 = subplot(1,2,1);
bar(ax1, auc_values);
xlabel(ax1, 'Subject ID');
ylabel(ax1, 'AUC');
set(ax1, 'XTick', 1:num_subjects, 'XTickLabels', subject_ids);

% Create the second axes for accuracy values
ax2 = subplot(1,2,2);
bar(ax2, accuracy_values,'red');
xlabel(ax2, 'Subject ID');
ylabel(ax2, 'Accuracy');
set(ax2, 'XTick', 1:num_subjects, 'XTickLabels', subject_ids);

% Set the same y-axis limits for both axes
ylim(ax1, [0, 1]);
ylim(ax2, [0, 1]);

% Add legend
legend(ax1, {'AUC'});
legend(ax2, {'Accuracy'});

% Set figure title
sgtitle('Accuracy and AUC for each subject');    
