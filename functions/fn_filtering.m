function [y_filtered] = fn_filtering(y, fs, filter_type, f_low, f_high, filter_order)
% MY_FILTER applies a bandpass or highpass filter to a signal
%
%   [y_filtered] = MY_FILTER(y, fs, filter_type, f_low, f_high, filter_order) applies a
%   bandpass or highpass filter to signal y with sampling frequency fs. The
%   type of filter to apply is determined by the string filter_type, which
%   must be either 'bandpass' or 'highpass'. If filter_type is 'bandpass',
%   the filter will pass frequencies between f_low and f_high. If
%   filter_type is 'highpass', the filter will pass frequencies above
%   f_low. The filter order can also be specified (default is 3rd order).
%
%   Example usage:
%       y_filtered = my_filter(y, fs, 'bandpass', 5, 15, 4);
%       y_filtered = my_filter(y, fs, 'highpass', 3, [], 5);
%
%   Inputs:
%       - y: input signal (NxM matrix, where N is the number of samples and
%            M is the number of channels)
%       - fs: sampling frequency (in Hz)
%       - filter_type: string, must be 'bandpass' or 'highpass'
%       - f_low: lower cutoff frequency (in Hz)
%       - f_high: upper cutoff frequency (in Hz), use [] for highpass
%       - filter_order: filter order (default is 3)
%
%   Outputs:
%       - y_filtered: filtered signal (NxM matrix, same size as y)

% Check input arguments
if ~strcmp(filter_type, 'bandpass') && ~strcmp(filter_type, 'highpass')
    error('Invalid filter type, must be ''bandpass'' or ''highpass''');
end

% Set default filter order
if nargin < 6
    filter_order = 3;
end

% Compute filter coefficients
if strcmp(filter_type, 'bandpass')
    [b, a] = butter(filter_order, [f_low f_high] / (fs/2), 'bandpass');
else
    [b, a] = butter(filter_order, f_low / (fs/2), 'highpass');
end

% Apply filter to each channel of the signal
y_filtered = zeros(size(y));
for i = 1:size(y, 2)
    % Apply pre-processing (optional)
    % y(:,i) = preprocess_signal(y(:,i));
    
    % Apply filter
    y_filtered(:,i) = filtfilt(b, a, y(:,i));
end
