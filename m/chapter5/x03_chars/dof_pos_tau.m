clc; clear; close all;

%% =========================
% 1. 文件路径
%% =========================
real_file = 'realdata_2025-12-10_14-40-47.txt';
sim_file  = 'simdata_2026-03-20_15-04-37.txt';

%% =========================
% 2. 读取数据
%% =========================
real_tbl = readtable(real_file, 'FileType', 'text', 'VariableNamingRule', 'preserve');
sim_tbl  = readtable(sim_file,  'FileType', 'text', 'VariableNamingRule', 'preserve');

t_real = real_tbl.time;
t_sim  = sim_tbl.time;

%% =========================
% 3. 可选：时间区间裁剪
%% =========================
t_min = -inf;   % 例如 0
t_max = inf;    % 例如 10

idx_real = (t_real >= t_min) & (t_real <= t_max);
idx_sim  = (t_sim  >= t_min) & (t_sim  <= t_max);

real_tbl = real_tbl(idx_real, :);
sim_tbl  = sim_tbl(idx_sim, :);

t_real = real_tbl.time;
t_sim  = sim_tbl.time;

%% =========================
% 4. 线宽等参数
%% =========================
lw_angle  = 1.8;
lw_torque = 1.5;
fs_axis   = 12;
fs_title  = 13;
fs_leg    = 11;

%% =========================
% 5. 左腿关节：角度目标/当前 + 当前力矩
%    每个关节单独一张图
%% =========================
leg_joints = {
    'Left Hip Pitch',   'jpLt',  'jpLc',  'mpLc';
    'Left Knee',        'jkLt',  'jkLc',  'mkLc';
    'Left Ankle Pitch', 'japLt', 'japLc', 'mapLc';
};

for i = 1:size(leg_joints,1)
    joint_name = leg_joints{i,1};
    ang_t_col  = leg_joints{i,2};
    ang_c_col  = leg_joints{i,3};
    tau_c_col  = leg_joints{i,4};

    if ~ismember(ang_t_col, real_tbl.Properties.VariableNames)
        error('realdata 中缺少列: %s', ang_t_col);
    end
    if ~ismember(ang_c_col, real_tbl.Properties.VariableNames)
        error('realdata 中缺少列: %s', ang_c_col);
    end
    if ~ismember(tau_c_col, real_tbl.Properties.VariableNames)
        error('realdata 中缺少列: %s', tau_c_col);
    end

    ang_t = real_tbl.(ang_t_col);
    ang_c = real_tbl.(ang_c_col);
    tau_c = real_tbl.(tau_c_col);

    figure('Color', 'w', 'Position', [200 120 1000 500]);

    yyaxis left
    h1 = plot(t_real, ang_t, 'LineWidth', lw_angle); hold on;
    h2 = plot(t_real, ang_c, '--', 'LineWidth', lw_angle);
    ylabel('Joint Angle (rad)', 'FontSize', fs_axis);
    grid on

    yyaxis right
    h3 = plot(t_real, tau_c, 'LineWidth', lw_torque);
    ylabel('Current Torque (N·m)', 'FontSize', fs_axis);

    xlabel('Time (s)', 'FontSize', fs_axis);
    title(joint_name, 'FontSize', fs_title);

    legend([h1, h2, h3], ...
        {'Target Angle', 'Current Angle', 'Current Torque'}, ...
        'Location', 'best', 'FontSize', fs_leg);

    set(gca, 'FontSize', fs_axis, 'LineWidth', 1.0);
end

%% =========================
% 6. 左臂关节：只画角度目标/当前
%    每个关节单独一张图
%% =========================
arm_joints = {
    'Left Shoulder Pitch', 'jspLt', 'jspLc';
    'Left Elbow',          'jeLt',  'jeLc';
};

for i = 1:size(arm_joints,1)
    joint_name = arm_joints{i,1};
    ang_t_col  = arm_joints{i,2};
    ang_c_col  = arm_joints{i,3};

    if ~ismember(ang_t_col, real_tbl.Properties.VariableNames)
        error('realdata 中缺少列: %s', ang_t_col);
    end
    if ~ismember(ang_c_col, real_tbl.Properties.VariableNames)
        error('realdata 中缺少列: %s', ang_c_col);
    end

    ang_t = real_tbl.(ang_t_col);
    ang_c = real_tbl.(ang_c_col);

    figure('Color', 'w', 'Position', [220 140 1000 500]);

    plot(t_real, ang_t, 'LineWidth', lw_angle); hold on;
    plot(t_real, ang_c, '--', 'LineWidth', lw_angle);

    grid on;
    xlabel('Time (s)', 'FontSize', fs_axis);
    ylabel('Joint Angle (rad)', 'FontSize', fs_axis);
    title(joint_name, 'FontSize', fs_title);
    legend({'Target Angle', 'Current Angle'}, ...
        'Location', 'best', 'FontSize', fs_leg);

    set(gca, 'FontSize', fs_axis, 'LineWidth', 1.0);
end

%% =========================
% 7. RPY：同一张图中直接画三条曲线
%% =========================
required_rpy = {'r', 'p', 'y'};
for k = 1:numel(required_rpy)
    if ~ismember(required_rpy{k}, sim_tbl.Properties.VariableNames)
        error('simdata 中缺少列: %s', required_rpy{k});
    end
end

r = sim_tbl.r;
p = sim_tbl.p;
y = sim_tbl.y;

figure('Color', 'w', 'Position', [240 160 1000 500]);
plot(t_sim, r, 'LineWidth', 1.8); hold on;
plot(t_sim, p, '--', 'LineWidth', 1.8);
plot(t_sim, y, '-.', 'LineWidth', 1.8);

grid on;
xlabel('Time (s)', 'FontSize', fs_axis);
ylabel('Angle (rad)', 'FontSize', fs_axis);
title('RPY Curves', 'FontSize', fs_title);
legend({'Roll', 'Pitch', 'Yaw'}, 'Location', 'best', 'FontSize', fs_leg);

set(gca, 'FontSize', fs_axis, 'LineWidth', 1.0);

%% =========================
% 8. 可选：保存图片
%% =========================
% exportgraphics(gcf, 'rpy_curves.pdf', 'ContentType', 'vector');