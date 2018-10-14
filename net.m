[samples_training_with_duplicates, samples_test_with_duplicates] = read_data();
[samples_training, samples_test] = remove_duplicates(samples_training_with_duplicates, samples_test_with_duplicates);
%samples_training = samples_training_with_duplicates;
%samples_test = samples_test_with_duplicates;

motor_UPDRS_index = 1;
total_UPDRS_index = 2;
test_time_index = 3;

number_of_patients = 42;
training_set_size =  1;%size(samples_training, 2)
test_set_size =  1;%size(samples_test, 2)

input = [];
target = [];
for i = 1:training_set_size
    input = [input [samples_training{i}(:, 4:5)'; samples_training{i}(:, 6)'; samples_training{i}(:, 12)'] ]; % [input samples_training{i}(:, 3:21)'];
    target = [target samples_training{i}(:, motor_UPDRS_index)'];
end

eg = 0.01e-09; % sum-squared error goal 
sc = 10; % spread constant
RBF_net = newrb(input,target,eg,sc);

%validation with traning set
figure(1)
for j = 1:training_set_size
    time1 = samples_training{j}(:, test_time_index)';
    input1 = [samples_training{j}(:, 4:5)'; samples_training{j}(:, 6)'; samples_training{j}(:, 12)']; %samples_training{j}(:, 3:21)';
    UPDRS1 = samples_training{j}(:, motor_UPDRS_index)';

    %subplot(6,7,j);
    output1 = RBF_net(input1);
    hold on;
    plot(time1, UPDRS1, 'bo');
    plot(time1, output1,'r-');
    %legend({'Target','Output'})
end

%validation with test set
MSE = 0;
figure(2)
for k = 1:test_set_size
    time2 = samples_test{k}(:, test_time_index);
    input2 = [samples_test{k}(:, 4:5)'; samples_test{k}(:, 6)'; samples_test{k}(:, 12)']; %samples_test{k}(:, 3:21)';
    UPDRS2 = samples_test{k}(:, motor_UPDRS_index)';

    %subplot(6,7,k);
    output2 = RBF_net(input2);
    hold on;
    plot(time2, UPDRS2, 'bo');
    plot(time2, output2,'r-');
    
    MSE = MSE + immse(UPDRS2,output2);
    %legend({'Target','Output'})
end
MSE