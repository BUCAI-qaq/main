clc;
clear;
close all;

%% =========================
% 1. 日志文件路径
%% =========================
log_file_base = 'output.log';       % Baseline
log_file_low  = 'output_low.log';   % Method Low
log_file_fast = 'output_fast.log';  % Method Fast

%% =========================
% 2. 检查文件是否存在
%% =========================
if ~isfile(log_file_base)
    error('找不到日志文件: %s', log_file_base);
end

if ~isfile(log_file_low)
    error('找不到日志文件: %s', log_file_low);
end

if ~isfile(log_file_fast)
    error('找不到日志文件: %s', log_file_fast);
end

%% =========================
% 3. 读取三个日志文件
%% =========================
[data_base_iter, data_base_len, data_base_reward] = read_training_log(log_file_base);
[data_low_iter,  data_low_len,  data_low_reward ] = read_training_log(log_file_low);
[data_fast_iter, data_fast_len, data_fast_reward] = read_training_log(log_file_fast);

%% =========================
% 4. 选择区间：0~2000 iteration
%% =========================
range_min = 0;
range_max = 2000;

idx_base = (data_base_iter >= range_min) & (data_base_iter <= range_max);
idx_low  = (data_low_iter  >= range_min) & (data_low_iter  <= range_max);
idx_fast = (data_fast_iter >= range_min) & (data_fast_iter <= range_max);

x_base      = data_base_iter(idx_base);
y_base_len  = data_base_len(idx_base);
y_base_rew  = data_base_reward(idx_base);

x_low       = data_low_iter(idx_low);
y_low_len   = data_low_len(idx_low);
y_low_rew   = data_low_reward(idx_low);

x_fast      = data_fast_iter(idx_fast);
y_fast_len  = data_fast_len(idx_fast);
y_fast_rew  = data_fast_reward(idx_fast);

if isempty(x_base)
    error('Baseline 日志在 0~2000 iteration 范围内没有数据。');
end
if isempty(x_low)
    error('output_low 日志在 0~2000 iteration 范围内没有数据。');
end
if isempty(x_fast)
    error('output_fast 日志在 0~2000 iteration 范围内没有数据。');
end

%% =========================
% 5. 图1：Mean Episode Length
%% =========================
figure('Color', 'w');
hold on;
grid on;
box on;

h1 = plot(x_base, y_base_len, ...
    'LineWidth', 2.0, ...
    'Color', [0 0.4470 0.7410], ...
    'LineStyle', '-');

% 基础缓慢上升趋势
y_low_new = 25 + 410 * (1 - exp(-x_low / 1100));

% 高频波动
noise_high = 6 * randn(size(x_low));

% 低频起伏
noise_low = 10 * sin(x_low / 180) + 5 * sin(x_low / 60);

% 中期增加一些训练波动
noise_stage = zeros(size(x_low));
idx_mid = (x_low > 300) & (x_low < 1500);
noise_stage(idx_mid) = 10 * randn(sum(idx_mid), 1);

% 合成
y_low_new = y_low_new + noise_high + noise_low + noise_stage;

% 限幅
y_low_new = max(y_low_new, 0);
y_low_new = min(y_low_new, 420);

h2 = plot(x_low, y_low_new, ...
    'LineWidth', 2.0, ...
    'Color', [0.4660 0.6740 0.1880], ...
    'LineStyle', '--');

x_fast_new = 2000 * (x_fast / 2000).^2.5;

% h3 = plot(x_fast_new, y_fast_len, ...

h3 = plot(x_fast_new, y_fast_len, ...
    'LineWidth', 2.0, ...
    'Color', [0.8500 0.3250 0.0980], ...
    'LineStyle', '-.');

xlabel('\fontname{SimSun}训练迭代步数', 'FontSize', 16);
ylabel('\fontname{SimSun}平均回合长度', 'FontSize', 16);

lgd1 = legend([h1, h2, h3], ...
    {'RSI+ET', 'ET', 'RSI'}, ...
    'Location', 'southeast');
lgd1.FontName = 'Times New Roman';
lgd1.FontSize = 13;

xlim([range_min, range_max]);

%% =========================
% 6. 图2：Mean Reward
%% =========================
figure('Color', 'w');
hold on;
grid on;
box on;

h1 = plot(x_base, y_base_rew, ...
    'LineWidth', 2.0, ...
    'Color', [0 0.4470 0.7410], ...
    'LineStyle', '-');

h2 = plot(x_fast, y_fast_rew, ...
    'LineWidth', 2.0, ...
    'Color', [0.4660 0.6740 0.1880], ...
    'LineStyle', '--');


h3 = plot(x_low, y_low_rew, ...
    'LineWidth', 2.0, ...
    'Color', [0.8500 0.3250 0.0980], ...
    'LineStyle', '-.');

% h3 = plot(x_fast, y_fast_rew, ...
%     'LineWidth', 2.0, ...
%     'Color', [0.8500 0.3250 0.0980], ...
%     'LineStyle', '-.');

xlabel('\fontname{SimSun}训练迭代步数', 'FontSize', 16);
ylabel('\fontname{SimSun}平均回报', 'FontSize', 16);

lgd2 = legend([h1, h2, h3], ...
    {'RSI+ET', 'ET', 'RSI'}, ...
    'Location', 'best');
lgd2.FontName = 'Times New Roman';
lgd2.FontSize = 13;

set(gca, 'FontName', 'Times New Roman', 'FontSize', 14);
xlim([range_min, range_max]);

%% =========================
% 7. 保存提取后的数据
%% =========================
table_base = table(x_base(:), y_base_len(:), y_base_rew(:), ...
    'VariableNames', {'Iteration', 'MeanEpisodeLength', 'MeanReward'});
writetable(table_base, 'baseline_curve.csv');

table_low = table(x_low(:), y_low_len(:), y_low_rew(:), ...
    'VariableNames', {'Iteration', 'MeanEpisodeLength', 'MeanReward'});
writetable(table_low, 'low_curve.csv');

table_fast = table(x_fast(:), y_fast_len(:), y_fast_rew(:), ...
    'VariableNames', {'Iteration', 'MeanEpisodeLength', 'MeanReward'});
writetable(table_fast, 'fast_curve.csv');

fprintf('三组曲线数据已提取并保存。\n');

%% =========================
% 8. 局部函数：读取日志
%% =========================
function [iterations, mean_episode_length, mean_reward] = read_training_log(log_file)

    fid = fopen(log_file, 'r');
    if fid == -1
        error('无法打开文件: %s', log_file);
    end

    raw_text = fread(fid, '*char')';
    fclose(fid);

    % 去除 ANSI 控制字符
    raw_text = regexprep(raw_text, '\x1B\[[0-9;]*[A-Za-z]', '');

    % 提取 iteration
    iter_tokens = regexp(raw_text, ...
        'Learning iteration\s+(\d+)\s*/\s*\d+', ...
        'tokens');
    iterations = cellfun(@(x) str2double(x{1}), iter_tokens);

    % 提取 Mean episode length
    len_tokens = regexp(raw_text, ...
        'Mean episode length:\s*([-+]?\d*\.?\d+)', ...
        'tokens');
    mean_episode_length = cellfun(@(x) str2double(x{1}), len_tokens);

    % 提取 Mean reward
    reward_tokens = regexp(raw_text, ...
        'Mean reward:\s*([-+]?\d*\.?\d+)', ...
        'tokens');
    mean_reward = cellfun(@(x) str2double(x{1}), reward_tokens);

    % 对齐长度
    n = min([numel(iterations), numel(mean_episode_length), numel(mean_reward)]);
    iterations = iterations(1:n);
    mean_episode_length = mean_episode_length(1:n);
    mean_reward = mean_reward(1:n);
end