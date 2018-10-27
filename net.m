clear all;

[samples_training_with_duplicates, samples_test_with_duplicates] = read_data();
[samples_training, samples_test] = remove_duplicates(samples_training_with_duplicates, samples_test_with_duplicates);
%samples_training = samples_training_with_duplicates;
%samples_test = samples_test_with_duplicates;

motor_UPDRS_index = 1;
total_UPDRS_index = 2;
test_time_index = 3;

number_of_patients = 42;
classes = 42;
training_set_size = classes;%size(samples_training, 2)
test_set_size = classes;%size(samples_test, 2)

% for i = 1:number_of_patients
%    samples_training{i}(:,[3 18]) = normalize(samples_training{i}(:, [3 18]), 'range');
%    samples_test{i}(:,[3 18]) = normalize(samples_test{i}(:,[3 18]), 'range');
% end

input = [];
target = [];
for i = 1:training_set_size
    input = [input samples_training{i}(:, 3:21)']; % [samples_training{i}(:, 4:5)'; samples_training{i}(:, 6)'; samples_training{i}(:, 12)'];
    target = [target samples_training{i}(:, motor_UPDRS_index)'];
end

eg = 1e-10; % sum-squared error goal 
sc = 50; % spread constant
RBF_net = newrb(input,target,eg,sc);

subplot_x = 6;
subplot_y = 7;

%validation with traning set
figure(1)
for j = 1:training_set_size
    time1 = samples_training{j}(:, test_time_index);
    input1 = samples_training{j}(:, 3:21)'; %[samples_training{j}(:, 4:5)'; samples_training{j}(:, 6)'; samples_training{j}(:, 12)']; 
    UPDRS1 = samples_training{j}(:, motor_UPDRS_index)';

    subplot(subplot_x,subplot_y,j);
    output1 = RBF_net(input1);
    hold on;
    plot(time1, UPDRS1, 'bo');
    plot(time1, output1,'r-');
    title(['Training data, number of patients: ', num2str(classes)]);
    xlabel('Time');
    ylabel('Motor UPDRS index');
    %legend({'Data','Net output'},'Location','northwest')
end

%validation with test set
figure(2)
for k = 1:test_set_size
    time2 = samples_test{k}(:, test_time_index);
    input2 = samples_test{k}(:, 3:21)'; % [samples_test{k}(:, 4:5)'; samples_test{k}(:, 6)'; samples_test{k}(:, 12)'];
    UPDRS2 = samples_test{k}(:, motor_UPDRS_index)';

    subplot(subplot_x,subplot_y,k);
    output2 = RBF_net(input2);
    hold on;
    plot(time2, UPDRS2, 'bo');
    plot(time2, output2,'r-');
    title(['Test data, number of patients: ', num2str(classes)]);
    xlabel('Time');
    ylabel('Motor UPDRS index');
    %legend({'Data','Net output'},'Location','northwest')
end