samples = read_data();

age_index = 1;
sex_index = 2;
test_time_index = 3;
motor_UPDRS_index = 4;
total_UPDRS_index = 5;

number_of_patients = 42;
traning_set_size = 30;
test_set_size = 12;

input = [];
target = [];
for i = 1:traning_set_size
    age = samples{i}(:, age_index);
    sex = samples{i}(:, sex_index);
    time = samples{i}(:, test_time_index);
    UPDRS = samples{i}(:, motor_UPDRS_index);

    merged = [time'; UPDRS'];
    sorted = sortrows(merged', 1)';
    time = sorted(1, :);
    UPDRS = sorted(2, :);
    input = [input [age'; sex'; time]];
    target = [target UPDRS];
end

eg = 0.05; % sum-squared error goal
sc = 1;    % spread constant
%RBF_net = newrb(input,target,eg,sc);

%validation with traning set
figure(1)
for j = 1:traning_set_size
    vector_from_test_set_index = j;
    age = samples{vector_from_test_set_index}(:, age_index);
    sex = samples{vector_from_test_set_index}(:, sex_index);
    time = samples{vector_from_test_set_index}(:, test_time_index);
    UPDRS = samples{vector_from_test_set_index}(:, motor_UPDRS_index);

    merged = [time'; UPDRS'];
    sorted = sortrows(merged', 1)';
    time = sorted(1, :);
    UPDRS = sorted(2, :);

    subplot(5,6,j);
    output = RBF_net([age'; sex'; time]);
    hold on;
    plot(time, UPDRS, 'bo');
    plot(time, output,'r-');
    %legend({'Target','Output'})
end

%validation with test set
figure(2)
for k = 1:test_set_size
    vector_from_test_set_index = traning_set_size+k;
    age = samples{vector_from_test_set_index}(:, age_index);
    sex = samples{vector_from_test_set_index}(:, sex_index);
    time = samples{vector_from_test_set_index}(:, test_time_index);
    UPDRS = samples{vector_from_test_set_index}(:, motor_UPDRS_index);

    merged = [time'; UPDRS'];
    sorted = sortrows(merged', 1)';
    time = sorted(1, :);
    UPDRS = sorted(2, :);

    subplot(3,4,k);
    output = RBF_net([age'; sex'; time]);
    hold on;
    plot(time, UPDRS, 'bo');
    plot(time, output,'r-');
    legend({'Target','Output'})
end