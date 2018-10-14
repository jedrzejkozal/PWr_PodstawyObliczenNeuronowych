function [samples_training, samples_test] = read_data()

data = importdata("parkinson.data");

number_of_patients = 42;

samples = cell(1, number_of_patients);

% crop out the patient_id
for i = 1:size(data,1)
    patient_id = data(i,1);
    samples{patient_id} = [samples{patient_id}; data(i,2:end)];
end

% swap age and sex with motor_UPDRS,total_UPDRS cloumns
for i = 1:size(samples, 2)
   samples{i}(:,[1 4]) = samples{i}(:,[4 1]);
   samples{i}(:,[2 5]) = samples{i}(:,[5 2]);
end

samples_test = cell(1, number_of_patients);
samples_training = cell(1, number_of_patients);
for i = 1:size(samples,2)
    samples_test{i} = samples{i}(1:24, :);
    samples_training{i} = samples{i}(24:end, :);
end

%sort through time
for i = 1:size(samples_test, 2)
   samples_test{i} = sortrows(samples_test{i}, 3);
end

for i = 1:size(samples_training, 2)
    samples_training{i} = sortrows(samples_training{i}, 3);
end
