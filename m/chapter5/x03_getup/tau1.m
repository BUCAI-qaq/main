clc; clear; close all;

%% =========================
% 1. 文件路径
%% =========================
real_file = 'realdata_2025-12-16_19-30-27.txt';
sim_file  = 'simdata_2026-03-20_22-05-25.txt';

%% =========================
% 2. 读取数据
%% =========================
real_tbl = readtable(real_file, 'FileType', 'text', 'VariableNamingRule', 'preserve');
sim_tbl  = readtable(sim_file,  'FileType', 'text', 'VariableNamingRule', 'preserve');

t_real = real_tbl.time;
t_sim  = sim_tbl.time;

%% =========================
% 3. 时间区间裁剪
%% =========================
t_min = 0;
t_max = 6;

idx_real = (t_real >= t_min) & (t_real <= t_max);
idx_sim  = (t_sim  >= t_min) & (t_sim  <= t_max);

real_tbl = real_tbl(idx_real, :);
sim_tbl  = sim_tbl(idx_sim, :);

t_real = real_tbl.time;
t_sim  = sim_tbl.time;

%% =========================
% 4. 绘图参数
%% =========================
lw_line   = 2.0;
fs_axis   = 12;
fs_leg    = 11;
fs_title  = 13;

smooth_win = 25;   % 平滑窗口
band_scale = 1.0;  % 波带系数（±1σ）
band_alpha = 0.15; % 波带透明度

%% =========================
% 5. 关节分组（只保留最终4张图需要的关节）
%% =========================
right_leg_cols  = {'mpRc', 'mkRc', 'mapRc'};
right_leg_names = {'Hip pitch', 'Knee', 'Ankle pitch'};

right_arm_cols  = {'mspRt', 'meRt'};
right_arm_names = {'Shoulder pitch', 'Elbow'};

%% =========================
% 6. 检查列是否存在
%% =========================
check_cols = [right_leg_cols, right_arm_cols];
for k = 1:numel(check_cols)
    if ~ismember(check_cols{k}, real_tbl.Properties.VariableNames)
        error('realdata 中缺少力矩列: %s', check_cols{k});
    end
end

required_rpy = {'r', 'p', 'y'};
for k = 1:numel(required_rpy)
    if ~ismember(required_rpy{k}, sim_tbl.Properties.VariableNames)
        error('simdata 中缺少列: %s', required_rpy{k});
    end
end

%% =========================
% 7. 右腿关节扭矩：时序图（平滑线 + 波带）
%% =========================
figure('Color', 'w');
hold on;

h_lines_leg = gobjects(numel(right_leg_cols), 1);
ax = gca;
color_order = ax.ColorOrder;

for i = 1:numel(right_leg_cols)
    tau = real_tbl.(right_leg_cols{i});

    % 平滑与波带
    tau_mean  = movmean(tau, smooth_win);
    tau_std   = movstd(tau, smooth_win);
    tau_upper = tau_mean + band_scale * tau_std;
    tau_lower = tau_mean - band_scale * tau_std;

    % 固定颜色
    c = color_order(mod(i-1, size(color_order,1)) + 1, :);

    % 波带（不进入图例）
    h_fill = fill([t_real; flipud(t_real)], ...
                  [tau_upper; flipud(tau_lower)], ...
                  c, ...
                  'FaceAlpha', band_alpha, ...
                  'EdgeColor', 'none');
    h_fill.Annotation.LegendInformation.IconDisplayStyle = 'off';

    % 平滑中心线（进入图例）
    h_lines_leg(i) = plot(t_real, tau_mean, ...
                          'Color', c, ...
                          'LineWidth', lw_line);
end

grid on;
xlabel('时间 (s)', 'FontSize', fs_axis);
ylabel('关节力矩 (N·m)', 'FontSize', fs_axis);

lgd = legend(h_lines_leg, right_leg_names, 'FontSize', fs_leg);
set(lgd, 'Location', 'northeast');

%% =========================
% 8. 右手关节扭矩：时序图（平滑线 + 波带）
%% =========================
figure('Color', 'w');
hold on;

h_lines_arm = gobjects(numel(right_arm_cols), 1);
ax = gca;
color_order = ax.ColorOrder;

for i = 1:numel(right_arm_cols)
    tau = real_tbl.(right_arm_cols{i});

    % 平滑与波带
    tau_mean  = movmean(tau, smooth_win);
    tau_std   = movstd(tau, smooth_win);
    tau_upper = tau_mean + band_scale * tau_std;
    tau_lower = tau_mean - band_scale * tau_std;

    % 固定颜色
    c = color_order(mod(i-1, size(color_order,1)) + 1, :);

    % 波带（不进入图例）
    h_fill = fill([t_real; flipud(t_real)], ...
                  [tau_upper; flipud(tau_lower)], ...
                  c, ...
                  'FaceAlpha', band_alpha, ...
                  'EdgeColor', 'none');
    h_fill.Annotation.LegendInformation.IconDisplayStyle = 'off';

    % 平滑中心线（进入图例）
    h_lines_arm(i) = plot(t_real, tau_mean, ...
                          'Color', c, ...
                          'LineWidth', lw_line);
end

grid on;
xlabel('时间 (s)', 'FontSize', fs_axis);
ylabel('关节力矩 (N·m)', 'FontSize', fs_axis);

lgd = legend(h_lines_arm, right_arm_names, 'FontSize', fs_leg);
set(lgd, 'Location', 'northeast');

%% =========================
% 9. 姿态：用四元数代替欧拉角绘图
% 假设 sim_tbl 中 r/p/y 分别为 roll / pitch / yaw，单位 rad
% 按 yaw-pitch-roll (ZYX) 组合成四元数
%% =========================
r = sim_tbl.r;   % roll
p = sim_tbl.p;   % pitch
y = sim_tbl.y;   % yaw

N = numel(r);
q = zeros(N, 4);   % [w x y z]

for i = 1:N
    cr = cos(r(i)/2); sr = sin(r(i)/2);
    cp = cos(p(i)/2); sp = sin(p(i)/2);
    cy = cos(y(i)/2); sy = sin(y(i)/2);

    % ZYX: yaw-pitch-roll
    qw = cr*cp*cy + sr*sp*sy;
    qx = sr*cp*cy - cr*sp*sy;
    qy = cr*sp*cy + sr*cp*sy;
    qz = cr*cp*sy - sr*sp*cy;

    q(i,:) = [qw, qx, qy, qz];
end

% 四元数连续化，避免 q 和 -q 的符号跳变
for i = 2:N
    if dot(q(i,:), q(i-1,:)) < 0
        q(i,:) = -q(i,:);
    end
end

figure('Color', 'w');
plot(t_sim, q(:,1), 'LineWidth', 1.8); hold on;
plot(t_sim, q(:,2), '--', 'LineWidth', 1.8);
plot(t_sim, q(:,3), '-.', 'LineWidth', 1.8);
plot(t_sim, q(:,4), ':', 'LineWidth', 2.0);

grid on;
xlabel('时间 (s)', 'FontSize', fs_axis);
ylabel('四元数分量', 'FontSize', fs_axis);
legend({'q_w', 'q_x', 'q_y', 'q_z'}, ...
       'Location', 'northeast', ...
       'FontSize', fs_leg);

%% =========================
% 10. 统计对比图（均值 + 最大绝对值）
%% =========================
all_cols  = [right_leg_cols, right_arm_cols];
all_names = [right_leg_names, right_arm_names];

n_joint = numel(all_cols);
tau_mean_all = zeros(1, n_joint);
tau_max_all  = zeros(1, n_joint);

for i = 1:n_joint
    tau = real_tbl.(all_cols{i});
    tau_mean_all(i) = mean(abs(tau));   % 平均绝对力矩
    tau_max_all(i)  = max(abs(tau));    % 最大绝对力矩
end

stats_mat = [tau_mean_all(:), tau_max_all(:)];

figure('Color', 'w');
bar(stats_mat, 'grouped');
grid on;

% xlabel('关节', 'FontSize', fs_axis);
ylabel('关节力矩 (N·m)', 'FontSize', fs_axis);

set(gca, 'XTick', 1:n_joint, 'XTickLabel', all_names, 'FontSize', fs_axis);
xtickangle(25);

legend({'Mean', 'Max'}, ...
       'Location', 'northeast', ...
       'FontSize', fs_leg);

%% =========================
% 11. 可选：保存图片
%% =========================
% exportgraphics(gcf, 'torque_statistics.pdf', 'ContentType', 'vector');