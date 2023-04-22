function fn_plot_ERP_avgd_over_channel(epoch_data, pre_stimulus_samples, post_stimulus_samples)
    % Ask the user which epoch to display
    epoch_number = input(sprintf('Enter epoch number (1-%d): ', size(epoch_data, 3)));

    % Get the data for the selected epoch
    epoch_data_selected = squeeze(epoch_data(:, :, epoch_number));

    % Create a time vector for the epoch data
    epoch_length = size(epoch_data, 1);
    epoch_time = linspace(-pre_stimulus_samples/1000, post_stimulus_samples/1000, epoch_length);

    % Create a figure to display the epoch
    figure;
    plot(epoch_time, epoch_data_selected);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(sprintf('Epoch %d', epoch_number));
end
