function fn_plot_spectrograms(y, y_filtered, fs)
% PLOT_SPECTROGRAMS plots the spectrograms of the unfiltered and filtered signals
%
%   plot_spectrograms(y, y_filtered, fs) plots the spectrograms of the
%   unfiltered signal y and the filtered signal y_filtered, both sampled
%   at sampling frequency fs.
%
%   Inputs:
%       - y: unfiltered signal (NxM matrix, where N is the number of samples and
%            M is the number of channels)
%       - y_filtered: filtered signal (NxM matrix, same size as y)
%       - fs: sampling frequency (in Hz)

% Compute spectrograms
win = round(0.1*fs); % window size in samples
noverlap = round(0.05*fs); % overlap size in samples
nfft = 2*win; % FFT size
[S, F, T] = spectrogram(y(:,1), win, noverlap, nfft, fs);
[S_filtered, ~, ~] = spectrogram(y_filtered(:,1), win, noverlap, nfft, fs);

% Plot spectrograms
figure;
subplot(211);
imagesc(T, F, 20*log10(abs(S)));
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Unfiltered signal spectrogram');
colorbar;

subplot(212);
imagesc(T, F, 20*log10(abs(S_filtered)));
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Filtered signal spectrogram');
colorbar;

end
