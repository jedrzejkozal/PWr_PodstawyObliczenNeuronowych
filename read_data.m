function samples = read_data()

data = importdata("parkinson.data");

number_of_patients = 42;

samples = cell(1, number_of_patients);

for i = 1:size(data,1)
    patient_id = data(i,1);
    samples{patient_id} = [samples{patient_id}; data(i,2:end)];
end

for i = 1:size(samples, 2)
   samples{i}(:,[1 4]) = samples{i}(:,[4 1]);
   samples{i}(:,[2 5]) = samples{i}(:,[5 2]);
   
   samples{i} = sortrows(samples{i}, 3);
end

