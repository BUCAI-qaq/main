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
t_min = 1;   % 例如 0
t_max = 11;    % 例如 10

idx_real = (t_real >= t_min) & (t_real <= t_max);
idx_sim  = (t_sim  >= t_min) & (t_sim  <= t_max);

real_tbl = real_tbl(idx_real, :);
sim_tbl  = sim_tbl(idx_sim, :);

t_real = real_tbl.time;
t_sim  = sim_tbl.time;

%% =========================
% 4. 绘图参数
%% =========================
lw_angle = 1.8;
fs_axis  = 12;
fs_title = 13;
fs_leg   = 11;

%% =========================
% 5. 关键关节：每个关节单独一张图
%% =========================
joint_info = {
    'Left Hip Pitch',      'jpLt',  'jpLc';
    'Left Knee',           'jkLt',  'jkLc';
    'Left Ankle Pitch',    'japLt', 'japLc';
    'Left Shoulder Pitch', 'jspLt', 'jspLc';
    'Left Elbow',          'jeLt',  'jeLc';
};

for i = 1:size(joint_info,1)
    joint_name = joint_info{i,1};
    ang_t_col  = joint_info{i,2};
    ang_c_col  = joint_info{i,3};

    if ~ismember(ang_t_col, real_tbl.Properties.VariableNames)
        error('realdata 中缺少列: %s', ang_t_col);
    end
    if ~ismember(ang_c_col, real_tbl.Properties.VariableNames)
        error('realdata 中缺少列: %s', ang_c_col);
    end

    ang_t = real_tbl.(ang_t_col);
    ang_c = real_tbl.(ang_c_col);

    figure('Color', 'w');
    
    plot(t_real, ang_t, '--', 'Color', [0 0.4470 0.7410], 'LineWidth', lw_angle); hold on;
    plot(t_real, ang_c, '-',  'Color', [0.8500 0.3250 0.0980], 'LineWidth', lw_angle);

%  [0.8500 0.3250 0.0980] [0 0.4470 0.7410]
% plot(t_real, ang_t, '--', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', lw_angle); hold on;
% plot(t_real, ang_c, '-',  'Color',[0 0.4470 0.7410], 'LineWidth', lw_angle);

    grid on;
    xlabel('时间 (s)', 'FontSize', fs_axis);
    ylabel('关节角度 (rad)', 'FontSize', fs_axis);
%     legend({'期望角度', '实际角度'}, ...
%         'Location','northeast', 'FontSize', fs_leg);
    lgd = legend({'期望角度', '实际角度'}, 'FontSize', fs_leg);
set(lgd, 'Units', 'normalized', 'Position', [0.705, 0.825, 0.2, 0.1]);

%     set(gca, 'FontSize', fs_axis, 'LineWidth', 1.0);
end

%% =========================
% 6. RPY：同一张图中画三条曲线
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

figure('Color', 'w');
plot(t_sim, r, 'LineWidth', 1.8); hold on;
plot(t_sim, p, '--', 'LineWidth', 1.8);
plot(t_sim, y, '-.', 'LineWidth', 1.8);

grid on;
xlabel('时间 (s)', 'FontSize', fs_axis);
ylabel('角度 (rad)', 'FontSize', fs_axis);
lgd = legend({'横滚角', '俯仰角', '航向角'}, 'FontSize', fs_leg);
set(lgd, 'Units', 'normalized', 'Position', [0.705, 0.825, 0.2, 0.1]);


% set(gca, 'FontSize', fs_axis, 'LineWidth', 1.0);

%% =========================
% 7. 可选：保存图片
%% =========================
% exportgraphics(gcf, 'rpy_curves.pdf', 'ContentType', 'vector');