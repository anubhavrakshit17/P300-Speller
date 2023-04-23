function y_reconstructed = fn_ica_reconstruct(y_ica, A, W, components_to_reject)
    % Set the specified ICA components to zero
    y_ica_rejected = y_ica;
    y_ica_rejected(:, components_to_reject) = 0;

    % Reconstruct the signal by multiplying the rejected ICA components by their mixing matrix
    y_reconstructed = y_ica_rejected * A * pinv(W);
end
