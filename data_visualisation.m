[samples_training_with_duplicates, samples_test_with_duplicates] = read_data();
%[samples_training, samples_test] = remove_duplicates(samples_training_with_duplicates, samples_test_with_duplicates);
samples_training = samples_training_with_duplicates;
samples_test = samples_test_with_duplicates;

test_time_index = 3;
colors = ['r-', 'b-', 'g-', 'o-'];

figure(1)
for j = 1:21
    legend_str = cell(1, 5);
    for i = 1:5
        index = i*10 -9;
        time = samples_training{index}(:, test_time_index)';
        data = samples_training{index}(:, j)';
    
        subplot(3,7,j)
        hold on;
        legend('-DynamicLegend');
        plot(time, data);
        legend_str{i} = num2str(index);
    end
    legend(legend_str)
end