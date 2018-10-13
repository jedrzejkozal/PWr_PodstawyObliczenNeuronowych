samples = read_data();

motor_UPDRS_index = 1;
total_UPDRS_index = 2;
test_time_index = 3;

number_of_patients = 42;
traning_set_size = 30;
test_set_size = 12;

input = [];
target = [];
for i = 1:traning_set_size
    input = [input [samples{i}(:, 3:5)'; samples{i}(:, 6)'; samples{i}(:, 12)'] ]; 
    target = [target samples{i}(:, motor_UPDRS_index)'];
end

eg = 0.05; % sum-squared error goal
sc = 1;   % spread constant
RBF_net = newrb(input,target,eg,sc);

%validation with traning set
figure(1)
for j = 1:traning_set_size
    time = samples{j}(:, test_time_index)';
    input1 = [samples{j}(:, 3:5)'; samples{j}(:, 6)'; samples{j}(:, 12)'];
    UPDRS1 = samples{j}(:, motor_UPDRS_index)';

    subplot(5,6,j);
    output = RBF_net(input1);
    hold on;
    plot(time, UPDRS1, 'bo');
    plot(time, output,'r-');
    %legend({'Target','Output'})
end

%validation with test set
figure(2)
for k = 1:test_set_size
    vector_from_test_set_index = traning_set_size+k;
    
    time = samples{vector_from_test_set_index}(:, test_time_index);
    input2 = [samples{vector_from_test_set_index}(:, 3:5)'; samples{vector_from_test_set_index}(:, 6)'; samples{vector_from_test_set_index}(:, 12)';];
    UPDRS2 = samples{vector_from_test_set_index}(:, motor_UPDRS_index)';

    subplot(3,4,k);
    output2 = RBF_net(input2);
    hold on;
    plot(time, UPDRS2, 'bo');
    plot(time, output2,'r-');
    %legend({'Target','Output'})
end