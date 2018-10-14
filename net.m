[samples_training, samples_test] = read_data();

motor_UPDRS_index = 1;
total_UPDRS_index = 2;
test_time_index = 3;

number_of_patients = 42;
training_set_size = 1;%size(samples_training, 2);
test_set_size = 1;%size(samples_test, 2);

input = [];
target = [];
for i = 1:training_set_size
    input = [input samples_training{i}(:, 3:21)']; 
    target = [target samples_training{i}(:, motor_UPDRS_index)'];
end

eg = 0.01e-09; % sum-squared error goal 
sc = 10; % spread constant
RBF_net = newrb(input,target,eg,sc);

%validation with traning set
figure(1)
for j = 1:training_set_size
    time = samples_training{j}(:, test_time_index)';
    input1 = samples_training{j}(:, 3:21)';
    UPDRS1 = samples_training{j}(:, motor_UPDRS_index)';

    %subplot(6,7,j);
    output = RBF_net(input1);
    hold on;
    plot(time, UPDRS1, 'bo');
    plot(time, output,'r-');
    %legend({'Target','Output'})
end

%validation with test set
figure(2)
for k = 1:test_set_size
    time = samples_test{k}(:, test_time_index);
    input2 = samples_test{k}(:, 3:21)';
    UPDRS2 = samples_test{k}(:, motor_UPDRS_index)';

    %subplot(6,7,k);
    output2 = RBF_net(input2);
    hold on;
    plot(time, UPDRS2, 'bo');
    plot(time, output2,'r-');
    %legend({'Target','Output'})
end