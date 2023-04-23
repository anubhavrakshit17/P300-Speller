function [y_ica, A, W] = fn_ica(y, num_components)
% MY_ICA performs independent component analysis on a multi-channel signal
%
%   [y_ica, A, W] = MY_ICA(y, num_components) performs independent component
%   analysis (ICA) on the multi-channel signal y, and returns the
%   demixed signals in y_ica, and the mixing and demixing matrices in A and
%   W, respectively. The number of independent components to extract is
%   specified by num_components.
%
%   Inputs:
%       - y: input signal (NxM matrix, where N is the number of samples and
%            M is the number of channels)
%       - num_components: number of independent components to extract
%
%   Outputs:
%       - y_ica: demixed signal (NxM matrix, same size as y)
%       - A: mixing matrix (MxM matrix)
%       - W: demixing matrix (MxM matrix)

% Center the data
y_centered = y - mean(y, 1);

% Whiten the data
C = cov(y_centered);
[V, D] = eig(C);
P = V * diag(sqrt(1 ./ diag(D))) * V';
y_whitened = y_centered * P;

% Run the FastICA algorithm
[y_ica, W, A] = fastica(y_whitened', 'numOfIC', num_components);

% Rescale the demixed signals
y_ica = bsxfun(@plus, y_ica', mean(y, 1));

end