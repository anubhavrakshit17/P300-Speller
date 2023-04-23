clear all
close all

% Add functions folder to the matlab path using 'set path'
addpath("hackathon\")
addpath("hackathon\dataset\")
addpath("hackathon\functions\")
%%
filename = "S5.mat"; % replace with the actual filename
load(filename);

% Extract the subject ID from the filename
[~, name, ext] = fileparts(filename);
subject_id = extractBetween(name, 1, 2); % assuming subject ID is 2 characters
%%
%%
% Filter signal using bandpass filter
%fn_plot_time_domain(y, trig, fs, 2, 0);

%%
% Apply bandpass filter to the signal
y_filtered = fn_filtering(y, fs, 'bandpass', 8, 30, 4);

%%
% Plot the filtered signal
%fn_plot_time_domain(y_filtered, trig, fs, 2, 0);

%%
% Plot the spectrograms
%fn_plot_spectrograms(y, y_filtered, fs);

%%
% Perform ICA on the filtered signal and plot the components
[y_ica, A, W] = fn_ica_components_plot(y_filtered);

% Prompt user to enter components to reject for each subject
prompt = 'Enter components to reject for this subject (as array of integers): ';
components_to_reject = input(prompt);

% Reconstruct the signal after rejecting the selected components
y_reconstructed = fn_ica_reconstruct(y_ica, A, W, components_to_reject);

%%
% Define the pre-stimulus and post-stimulus periods in samples
pre_stimulus_samples = 300;
post_stimulus_samples = 700;

% Call the function to extract and display epochs
target_epoch_data = fn_create_epochs(y_reconstructed, trig, pre_stimulus_samples, post_stimulus_samples, 1);
nontarget_epoch_data = fn_create_epochs(y_reconstructed, trig, pre_stimulus_samples, post_stimulus_samples, -1);

%%
% Plot the ERPs
%fn_plot_ERP(target_epoch_data, pre_stimulus_samples, post_stimulus_samples, 2);
%fn_plot_ERP(nontarget_epoch_data, pre_stimulus_samples, post_stimulus_samples, 2);

%%
% Classify the epochs and calculate accuracy and AUC
[accuracy, AUC] = fn_classify(nontarget_epoch_data, target_epoch_data);
% Ask the user if they want to append the data to the results.csv file
%%
fn_results_save_csv(accuracy, AUC)
%%
fn_results_plot()
