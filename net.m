[samples_traning, samples_test] = read_data();

motor_UPDRS_index = 1;
total_UPDRS_index = 2;
test_time_index = 3;

number_of_patients = 42;
traning_set_size = size(samples_traning, 2);
test_set_size = size(samples_test, 2);

input = [];
target = [];
for i = 1:traning_set_size
    input = [input [samples_traning{i}(:, 4:5)'; samples_traning{i}(:, 6)'; samples_traning{i}(:, 12)'] ]; 
    target = [target samples_traning{i}(:, motor_UPDRS_index)'];
end

eg = 8.0; % sum-squared error goal 
sc = 0.1; % spread constant
RBF_net = newrb(input,target,eg,sc);

%validation with traning set
figure(1)
for j = 1:traning_set_size
    time = samples_traning{j}(:, test_time_index)';
    input1 = [samples_traning{j}(:, 4:5)'; samples_traning{j}(:, 6)'; samples_traning{j}(:, 12)'];
    UPDRS1 = samples_traning{j}(:, motor_UPDRS_index)';

    subplot(6,7,j);
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
    input2 = [samples_test{k}(:, 4:5)'; samples_test{k}(:, 6)'; samples_test{k}(:, 12)'];
    UPDRS2 = samples_test{k}(:, motor_UPDRS_index)';

    subplot(6,7,k);
    output2 = RBF_net(input2);
    hold on;
    plot(time, UPDRS2, 'bo');
    plot(time, output2,'r-');
    %legend({'Target','Output'})
end