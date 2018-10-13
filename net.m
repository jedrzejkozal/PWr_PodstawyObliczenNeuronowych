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
    %plot(time, UPDRS,'bo');

    merged = [time'; UPDRS'];
    sorted = sortrows(merged', 1)';
    time = sorted(1, :);
    UPDRS = sorted(2, :);
    input = [input [age'; sex'; time]];
    target = [target UPDRS];
end

eg = 0.02; % sum-squared error goal
sc = 1;    % spread constant
RBF_net = newrb(input,target,eg,sc);

output = RBF_net([age'; sex'; time]);
hold on;
plot(time, output,'r-');
legend({'Target','Output'})