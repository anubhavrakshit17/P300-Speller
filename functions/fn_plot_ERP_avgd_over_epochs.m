function [average_epoch, average_time] = fn_plot_ERP_avgd_over_epochs(epoch_data, pre_stimulus_samples, post_stimulus_samples)
% PLOT_AVERAGE_EPOCH Calculates the average epoch across trials and plots the result for each channel

% Calculate the number of channels and epoch length
[epoch_length, num_channels, num_epochs] = size(epoch_data);

% Average the epochs across trials for each channel
average_epoch = mean(epoch_data, 3);

% Create a time vector for the average epoch data
average_time = linspace(-pre_stimulus_samples/1000, post_stimulus_samples/1000, epoch_length);

% Plot the average epoch for each channel
figure;
for i = 1:num_channels
    subplot(num_channels, 1, i);
    plot(average_time, average_epoch(:, i));
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('ERP Channel %d', i));
end

end
