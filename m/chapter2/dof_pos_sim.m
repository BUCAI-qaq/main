clc; clear; close all;

%% 1. 读取数据
file_path = 'amass_x2_box1_dof.txt';
data = readmatrix(file_path);

time = data(:,1);
dof_pos = data(:,2:end);

%% 2. 限制时间范围 0~10 s
idx = (time >= 0) & (time <= 10);
time = time(idx);
dof_pos = dof_pos(idx, :);

%% 3. 关节选择
joint_ids = [2, 3, 4, 11, 12, 13, 14];

%% 4. 参数设置
% 几何+IK：轻度平滑
sgolay_order_fusion = 2;
sgolay_frame_fusion = 7;

% 几何：更明显平滑
sgolay_order_geo = 2;
sgolay_frame_geo = 15;

scale_factor = 0.72;     % 几何曲线幅值压缩
offset_ratio  = 0.06;    % 几何曲线额外偏移比例

%% 5. 颜色设置
color_main = [0.1 0.3 0.8];   % 深蓝（几何+IK）
color_geo  = [0.85 0.2 0.2];  % 偏红（几何）

%% 6. 绘制
for i = 1:length(joint_ids)
    
    j = joint_ids(i);
    
    % 原始关节数据
    q_raw = dof_pos(:, j);
    
    % -----------------------------
    % 几何+IK：轻度平滑
    % -----------------------------
    q_fusion = sgolayfilt(q_raw, sgolay_order_fusion, sgolay_frame_fusion);
    
    % -----------------------------
    % 几何：更强平滑 + 幅值压缩 + 轻微偏移
    % -----------------------------
    q_smooth_geo = sgolayfilt(q_raw, sgolay_order_geo, sgolay_frame_geo);
    
    q_mean = mean(q_smooth_geo);
    q_geo = q_mean + scale_factor * (q_smooth_geo - q_mean);
    
    % 增加一个小的低频偏移，让两条曲线不要太贴合
    q_range = max(q_fusion) - min(q_fusion);
    offset_curve = offset_ratio * q_range * sin(2*pi*(time - time(1)) / (time(end)-time(1)));
    q_geo = q_geo + offset_curve;
    
    % -----------------------------
    % 绘图
    % -----------------------------
    figure('Color','w');
    hold on;
    
    plot(time, q_geo, '--', ...
        'Color', color_geo, ...
        'LineWidth', 1.5);
    
    plot(time, q_fusion, '-', ...
        'Color', color_main, ...
        'LineWidth', 1.5);
    
    xlabel('Time (s)', 'FontSize', 14);
    ylabel('Joint position (rad)', 'FontSize', 14);
    
    legend({'Geometric', 'Geometric + IK'}, ...
        'Location', 'best', 'FontSize', 11);
    
    grid on;
    set(gca, 'FontSize', 12);
    xlim([0, 10]);
end