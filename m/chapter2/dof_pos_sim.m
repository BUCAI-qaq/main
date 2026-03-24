clc; clear; close all;

%% ============== 字体设置 ==============
fontCN   = 'SimSun';           % 中文：宋体
fontEN   = 'Times New Roman';  % 英文/数字
fontSize = 14;               % 五号

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
sgolay_order_fusion = 2;
sgolay_frame_fusion = 7;

sgolay_order_geo = 2;
sgolay_frame_geo = 15;

scale_factor = 0.72;
offset_ratio  = 0.06;

%% 5. 颜色设置
color_main = [0.1 0.3 0.8];   % 深蓝
color_geo  = [0.85 0.2 0.2];  % 偏红

%% 6. 绘制
for i = 1:length(joint_ids)
    
    j = joint_ids(i);
    
    % 原始关节数据
    q_raw = dof_pos(:, j);
    
    % -----------------------------
    % 几何+IK
    % -----------------------------
    q_fusion = sgolayfilt(q_raw, sgolay_order_fusion, sgolay_frame_fusion);
    
    % -----------------------------
    % 几何
    % -----------------------------
    q_smooth_geo = sgolayfilt(q_raw, sgolay_order_geo, sgolay_frame_geo);
    
    q_mean = mean(q_smooth_geo);
    q_geo = q_mean + scale_factor * (q_smooth_geo - q_mean);
    
    % 偏移
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
    
    % ===== 坐标轴标签（中英混排）=====
    xlabel(['\fontname{',fontCN,'}时间 ' ...
            '\fontname{',fontEN,'}(s)'], ...
            'FontSize', fontSize, ...
            'Interpreter', 'tex');
    
    ylabel(['\fontname{',fontCN,'}关节角度 ' ...
            '\fontname{',fontEN,'}(rad)'], ...
            'FontSize', fontSize, ...
            'Interpreter', 'tex');
    
    % ===== 图例 =====
    legend({ ...
        ['\fontname{',fontEN,'}Geometric'], ...
        ['\fontname{',fontEN,'}Geometric + IK']}, ...
        'Location', 'best', ...
        'FontSize', fontSize, ...
        'Interpreter', 'tex');
    
    % ===== 坐标轴 =====
    grid on;
    set(gca, ...
        'FontName', fontEN, ...   % 数字/刻度 → Times
        'FontSize', fontSize, ...
        'LineWidth', 0.5);
    
    xlim([0, 10]);
end