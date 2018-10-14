function [samples_training_without_duplicates, samples_test_without_duplicates] = remove_duplicates(samples_training, samples_test)

training_set_size = size(samples_training, 2);
test_set_size = size(samples_test, 2);

samples_training_without_duplicates = cell(1, training_set_size);
samples_test_without_duplicates = cell(1, test_set_size);

for i = 1:training_set_size
    samples_training_without_duplicates{i} = samples_training{i}(1:5:size(samples_training{i},1), :); 
end

samples_test_without_duplicates = samples_test;
%for i = 1:test_set_size
%    samples_test_without_duplicates{i} = samples_test{i}(1:5:size(samples_test{i},1), :); 
%end