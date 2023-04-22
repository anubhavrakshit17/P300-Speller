function fn_plot_ERP(epoch_data, pre_stimulus_samples, post_stimulus_samples, user_choice)
% Plot the averaged ERP based on user choice
% If user_choice = 1, average epochs channel-wise and plot all channels
% If user_choice = 2, average epochs and plot the average data for all channels

% Get the averaged epoch data based on user choice
if user_choice == 1
   fn_plot_ERP_avgd_over_channel(epoch_data, pre_stimulus_samples, post_stimulus_samples);
elseif user_choice == 2
    epoch_data_avg = fn_plot_ERP_avgd_over_epochs(epoch_data, pre_stimulus_samples, post_stimulus_samples);
else
    error('Invalid user choice');
end

