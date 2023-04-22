function fn_plot_time_domain(y, trig, fs, display_option, show_triggers)
%PLOT_TIME_DOMAIN Plot signals in the time domain with triggers
%   y - signal matrix, with each column representing a channel
%   trig - trigger vector, with 1 representing target and -1 representing
%          non-target
%   fs - sampling frequency
%   display_option - 1 to display all channels in one figure, 2 to display
%                    each channel in a separate subplot, 3 to display each
%                    channel in a separate figure
%   show_triggers - 1 to show the triggers, 0 to hide them

    num_channels = size(y, 2);
    
    if display_option == 1
        figure;
        hold on;
        for i = 1:num_channels
            plot((0:size(y, 1)-1) / fs, y(:, i));
            if show_triggers
                targetIdx = find(trig == 1);
                nonTargetIdx = find(trig == -1);
                plot(targetIdx/fs, y(targetIdx, i), 'r.');
                plot(nonTargetIdx/fs, y(nonTargetIdx, i), 'b.');
            end
        end
        hold off;
        xlabel('Time (s)');
        ylabel('Signal');
        title('Signals in Time Domain');
        if show_triggers
            legend({'Signal', 'Target', 'Non-Target'}, 'Location', 'best');
        else
            legend({'Signal'}, 'Location', 'best');
        end
        
    elseif display_option == 2
        for i = 1:num_channels
            subplot(num_channels, 1, i);
            plot((0:size(y, 1)-1) / fs, y(:, i));
            hold on;
            if show_triggers
                targetIdx = find(trig == 1);
                nonTargetIdx = find(trig == -1);
                plot(targetIdx/fs, y(targetIdx, i), 'r.');
                plot(nonTargetIdx/fs, y(nonTargetIdx, i), 'b.');
            end
            hold off;
            xlabel('Time (s)');
            ylabel(sprintf('Channel %d', i));
            title(sprintf('Signal in Channel %d', i));
            if show_triggers
                legend({'Signal', 'Target', 'Non-Target'}, 'Location', 'best');
            else
                legend({'Signal'}, 'Location', 'best');
            end
        end
        
    elseif display_option == 3
        for i = 1:num_channels
            figure;
            plot((0:size(y, 1)-1) / fs, y(:, i));
            hold on;
            if show_triggers
                targetIdx = find(trig == 1);
                nonTargetIdx = find(trig == -1);
                plot(targetIdx/fs, y(targetIdx, i), 'r.');
                plot(nonTargetIdx/fs, y(nonTargetIdx, i), 'b.');
            end
            hold off;
            xlabel('Time (s)');
            ylabel(sprintf('Channel %d', i));
            title(sprintf('Signal in Channel %d', i));
            if show_triggers
                legend({'Signal', 'Target', 'Non-Target'}, 'Location', 'best');
            else
                legend({'Signal'}, 'Location', 'best');
            end
        end
    end
end
