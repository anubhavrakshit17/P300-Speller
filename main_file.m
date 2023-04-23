clc
clear all
close all
% Add functions folder to the matlab path using 'set path'
addpath("hackathon\dataset\")
addpath("hackathon\functions\")
load ("S1.mat");
%%
% Filter signal using bandpass filter
%fn_plot_time_domain(y, trig, fs,2,0);
%%
y_filtered = fn_filtering(y, fs, 'bandpass', 8, 60,4);
%%
%fn_plot_time_domain(y_filtered, trig, fs,2,0);
%%
fn_plot_spectrograms(y,y_filtered,fs)

%%
[y_ica, A, W] = fn_ica(y_filtered, 8);
% Assume y_ica is the demixed signal obtained from ICA
num_components = size(y_ica, 2); % get the number of independent components

% Create a figure with subplots for each component
figure;
for i = 1:num_components
    subplot(num_components, 1, i);
    plot(y_ica(:,i));
    title(['ICA Component ' num2str(i)]);
end
%%
% Assume y_ica is the demixed signal obtained from ICA
% and components 5, 6, 7, and 8 are to be rejected.

% Set the columns corresponding to the rejected components to zero
components_to_reject = [5, 6, 7, 8];
y_ica_rejected = y_ica;
y_ica_rejected(:,components_to_reject) = 0;

% Reconstruct the signal by multiplying the rejected ICA components by their mixing matrix
y_reconstructed = y_ica_rejected * W';
%%
%fn_plot_time_domain(y_reconstructed, trig, fs,1,0);
%%
%figure
%fn_plot_time_domain(y, trig, fs,2,0);
%%
% Define the pre-stimulus and post-stimulus periods in samples
pre_stimulus_samples = 300;
post_stimulus_samples = 700;

% Call the function to extract and display epochs
target_epoch_data = fn_create_epochs(y_reconstructed, trig, pre_stimulus_samples, post_stimulus_samples,1);
nontarget_epoch_data = fn_create_epochs(y_reconstructed, trig, pre_stimulus_samples, post_stimulus_samples,-1);

%%
fn_plot_ERP(target_epoch_data,pre_stimulus_samples,post_stimulus_samples,2);
fn_plot_ERP(nontarget_epoch_data,pre_stimulus_samples,post_stimulus_samples,2);

%%
clc
clear all
close all
addpath("hackathon\customized_dataset\");
addpath("hackathon\functions\");
% Load target and nontarget data
load('target_epoch_data.mat');
load('nontarget_epoch_data.mat');
fn_classify(nontarget_epoch_data,target_epoch_data);
%%