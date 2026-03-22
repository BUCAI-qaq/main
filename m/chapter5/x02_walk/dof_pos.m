clc; clear; close all;

%% =========================
% 1. 文件路径
%% =========================
file_path = 'sim2real_data_2024-01-26_21-49-44.txt';

%% =========================
% 2. 读取数据
%% =========================
tbl = readtable(file_path, 'FileType', 'text', 'VariableNamingRule', 'preserve');
var_names = tbl.Properties.VariableNames;

%% =========================
% 3. 提取基础数据
%% =========================
t = tbl.time;

cmd_vx  = tbl.cmd_vx;
cmd_vy  = tbl.cmd_vy;
cmd_yaw = tbl.cmd_yaw;

roll  = tbl.roll;
pitch = tbl.pitch;
yaw   = tbl.yaw;

%% =========================
% 4. 提取腿部当前关节角
%% =========================
joint_pos_cols = var_names(startsWith(var_names, 'joint_pos_'));
n_joint_pos = numel(joint_pos_cols);

joint_pos = zeros(height(tbl), n_joint_pos);
for i = 1:n_joint_pos
    joint_pos(:, i) = tbl.(joint_pos_cols{i});
end

%% =========================
% 5. 时间区间选择
%% =========================
t_min = 80;
t_max = 84;

idx = (t >= t_min) & (t <= t_max);

if ~any(idx)
    error('选取的时间区间内没有数据，请检查 t_min 和 t_max。');
end

t = t(idx);

cmd_vx  = cmd_vx(idx);
cmd_vy  = cmd_vy(idx);
cmd_yaw = cmd_yaw(idx);

roll  = roll(idx);
pitch = pitch(idx);
yaw   = yaw(idx);

joint_pos = joint_pos(idx, :);

%% =========================
% 6. 左右腿分组
% 0~4 左腿，5~9 右腿
%% =========================
left_leg_idx  = 1:5;    % joint_pos_0 ~ joint_pos_4
right_leg_idx = 6:10;   % joint_pos_5 ~ joint_pos_9

left_leg_cur  = joint_pos(:, left_leg_idx);
right_leg_cur = joint_pos(:, right_leg_idx);

%% =========================
% 7. 绘图参数
%% =========================
lw_cmd   = 1.2;
lw_joint = 1.0;
fs_axis  = 12;
fs_leg   = 11;

left_color  = [0 0.4470 0.7410];
right_color = [0.8500 0.3250 0.0980];

%% =========================
% 8. CMD 图
%% =========================
figure('Color', 'w', 'Position', [200 100 900 220]);
plot(t, cmd_vx,  'LineWidth', lw_cmd); hold on;
plot(t, cmd_vy,  '--', 'LineWidth', lw_cmd);
plot(t, cmd_yaw, '-.', 'LineWidth', lw_cmd);

grid on;
xlabel('时间 (s)', 'FontSize', fs_axis);
ylabel('目标速度', 'FontSize', fs_axis);
legend({'$v_x$', '$v_y$', '$\omega_z$'}, ...
       'Interpreter', 'latex', ...
       'Location', 'northeast', ...
       'FontSize', fs_leg);

%% =========================
% 9. Hip yaw
%% =========================
figure('Color', 'w', 'Position', [220 120 900 220]);
plot(t, right_leg_cur(:,1), '--', 'Color', right_color, 'LineWidth', lw_joint); hold on;
plot(t, left_leg_cur(:,1),  '-', 'Color', left_color,  'LineWidth', lw_joint);

grid on;
xlabel('时间 (s)', 'FontSize', fs_axis);
ylabel('关节角度(rad)', 'FontSize', fs_axis);
legend({'RHY', 'LHY'}, 'Location', 'northeast', 'FontSize', fs_leg);

%% =========================
% 10. Hip roll
%% =========================
figure('Color', 'w', 'Position', [240 140 900 220]);
plot(t, right_leg_cur(:,2), '--', 'Color', right_color, 'LineWidth', lw_joint); hold on;
plot(t, left_leg_cur(:,2),  '-', 'Color', left_color,  'LineWidth', lw_joint);

grid on;
xlabel('时间 (s)', 'FontSize', fs_axis);
ylabel('关节角度(rad)', 'FontSize', fs_axis);
legend({'RHR', 'LHR'}, 'Location', 'northeast', 'FontSize', fs_leg);

%% =========================
% 11. Hip pitch
%% =========================
figure('Color', 'w', 'Position', [260 160 900 220]);
plot(t, right_leg_cur(:,3), '--', 'Color', right_color, 'LineWidth', lw_joint); hold on;
plot(t, left_leg_cur(:,3),  '-', 'Color', left_color,  'LineWidth', lw_joint);

grid on;
xlabel('时间 (s)', 'FontSize', fs_axis);
ylabel('关节角度(rad)', 'FontSize', fs_axis);
legend({'RHP', 'LHP'}, 'Location', 'northeast', 'FontSize', fs_leg);

%% =========================
% 12. Knee
%% =========================
figure('Color', 'w', 'Position', [280 180 900 220]);
plot(t, right_leg_cur(:,4), '--', 'Color', right_color, 'LineWidth', lw_joint); hold on;
plot(t, left_leg_cur(:,4),  '-', 'Color', left_color,  'LineWidth', lw_joint);

grid on;
xlabel('时间 (s)', 'FontSize', fs_axis);
ylabel('关节角度(rad)', 'FontSize', fs_axis);
legend({'RKP', 'LKP'}, 'Location', 'northeast', 'FontSize', fs_leg);

%% =========================
% 13. Ankle pitch
%% =========================
figure('Color', 'w', 'Position', [300 200 900 220]);
plot(t, right_leg_cur(:,5), '--', 'Color', right_color, 'LineWidth', lw_joint); hold on;
plot(t, left_leg_cur(:,5),  '-', 'Color', left_color,  'LineWidth', lw_joint);

grid on;
xlabel('时间 (s)', 'FontSize', fs_axis);
ylabel('关节角度(rad)', 'FontSize', fs_axis);
legend({'RAP', 'LAP'}, 'Location', 'northeast', 'FontSize', fs_leg);