function samples = read_data()

data = importdata("parkinson.data");

number_of_patients = 42;

samples = cell(1, number_of_patients);

for i = 1:size(data,1)
    patient_id = data(i,1);
    samples{patient_id} = [samples{patient_id}; data(i,2:end)];
end