function fn_results_save_csv(accuracy, AUC)
    % Prompt the user to append the data to the CSV file
    choice = input('Do you want to append the data to the results.csv file? (y/n): ', 's');
   
    if lower(choice) == 'y'
        % Append the data to the results.csv file
        result_csv_filename = 'hackathon\Results\results.csv';
        if exist(result_csv_filename, 'file')
            results = csvread(result_csv_filename);
        else
            results = [];
            % Add column headings if file does not exist
            columnHeadings = ["Accuracy", "AUC"];
            writematrix(columnHeadings, result_csv_filename);
        end

        % Add the accuracy and AUC for the current subject to the results matrix
        results(end+1,:) = [accuracy, AUC];

        % Save the results matrix to the CSV file
        writematrix(results, result_csv_filename, 'WriteMode', 'overwrite');
    end
end
