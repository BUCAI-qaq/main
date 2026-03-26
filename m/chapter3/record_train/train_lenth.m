clc;
clear;
close all;

%% =========================
% 1. 日志文件
%% =========================
log_file = 'output.log';

%% =========================
% 2. 读取日志
%% =========================
fid = fopen(log_file, 'r', 'n', 'UTF-8');
raw_text = fread(fid, '*char')';
fclose(fid);

%% =========================
% 3. 去除ANSI字符
%% =========================
raw_text = regexprep(raw_text, '\x1B\[[0-9;]*[A-Za-z]', '');

%% =========================
% 4. 提取 iteration
%% =========================
iter_tokens = regexp(raw_text, ...
    'Learning iteration\s+(\d+)\s*/\s*\d+', ...
    'tokens');

iterations = cellfun(@(x) str2double(x{1}), iter_tokens);

%% =========================
% 5. 提取 Mean episode length
%% =========================
len_tokens = regexp(raw_text, ...
    'Mean episode length:\s*([-+]?\d*\.?\d+)', ...
    'tokens');

mean_episode_length = cellfun(@(x) str2double(x{1}), len_tokens);

%% =========================
% 6. 提取 timesteps
%% =========================
step_tokens = regexp(raw_text, ...
    'Total timesteps:\s*(\d+)', ...
    'tokens');

total_timesteps = cellfun(@(x) str2double(x{1}), step_tokens);

%% =========================
% 7. 对齐
%% =========================
n = min([numel(iterations), numel(mean_episode_length), numel(total_timesteps)]);

iterations = iterations(1:n);
mean_episode_length = mean_episode_length(1:n);
total_timesteps = total_timesteps(1:n);

%% =========================
% 8. ⭐ 选择区间（推荐：iteration 0–2000）
%% =========================
idx = (iterations >= 0) & (iterations <= 3000);

x = iterations(idx);
y = mean_episode_length(idx);

%% =========================
% 9. 绘图（无平滑）
%% =========================
figure;
plot(x, y, ...
    'LineWidth', 2.0, ...
    'LineStyle', '-', ...
    'Color', [0 0.4470 0.7410]);

grid on;
box on;

xlabel('Iteration', 'FontName', 'Times New Roman', 'FontSize', 14);
ylabel('Mean Episode Length', 'FontName', 'Times New Roman', 'FontSize', 14);
title('Mean Episode Length vs Iteration', ...
    'FontName', 'Times New Roman', 'FontSize', 14);

set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);

%% =========================
% 10. 输出检查
%% =========================
fprintf('数据点数量: %d\n', length(x));
fprintf('Iteration范围: [%d, %d]\n', min(x), max(x));