function [y_ica, A, W] = fn_ica_components_plot(y_filtered)
    num_cols = size(y_filtered, 2); % Get the number of columns in y_filtered
    [y_ica, A, W] = fn_ica(y_filtered, num_cols); % Call the function with the number of columns

    num_components = size(y_ica, 2); % get the number of independent components

    % Create a figure with subplots for each component
    figure;
    for i = 1:num_components
        subplot(num_components, 1, i);
        plot(y_ica(:,i));
        title(['ICA Component ' num2str(i)]);
    end
end
