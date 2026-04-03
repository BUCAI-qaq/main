clc; clear; close all;

%% =========================
% 1. 数据文件夹
%% =========================
data_dir = 'real_retarget_data';

%% =========================
% 2. 文件分组（已去掉 ankle）
%% =========================
file_groups = {
    'left_hip_pitch',      'left_hip_pitch_pos.csv',      'left_hip_pitch_posT.csv';
    'left_knee',           'left_knee_pos.csv',           'left_knee_posT.csv';
    'left_shoulder_pitch', 'left_shoulder_pitch_pos.csv', 'left_shoulder_pitch_posT.csv';
    'left_elbow',          'left_elbow_pos.csv',          'left_elbow_posT.csv';
};

n_groups = size(file_groups, 1);


%% =========================
% 3. 循环绘图（每个关节一张图）
%% =========================
for i = 1:n_groups
    joint_name = file_groups{i, 1};

    % 路径
    pos_file  = fullfile(data_dir, file_groups{i, 2});
    posT_file = fullfile(data_dir, file_groups{i, 3});

    %% =========================
    % 4. 读取 CSV
    %% =========================
    pos_tbl  = readtable(pos_file,  'VariableNamingRule', 'preserve');
    posT_tbl = readtable(posT_file, 'VariableNamingRule', 'preserve');

    % 自动适配大小写（更稳）
    vars1 = pos_tbl.Properties.VariableNames;
    vars2 = posT_tbl.Properties.VariableNames;

    step_name1  = vars1{strcmpi(vars1, 'Step')};
    value_name1 = vars1{strcmpi(vars1, 'Value')};

    step_name2  = vars2{strcmpi(vars2, 'Step')};
    value_name2 = vars2{strcmpi(vars2, 'Value')};

    step_pos   = pos_tbl.(step_name1);
    value_pos  = pos_tbl.(value_name1);

    step_posT  = posT_tbl.(step_name2);
    value_posT = posT_tbl.(value_name2);

    %% =========================
    % 5. 对齐数据
    %% =========================
    min_len = min([length(step_pos), length(step_posT), ...
                   length(value_pos), length(value_posT)]);

    x = step_posT(1:min_len);
    pos_data  = value_pos(1:min_len);
    posT_data = value_posT(1:min_len);
    
    pos_data  = deg2rad(pos_data);
posT_data = deg2rad(posT_data);
    
    %% =========================
    % 5.1 选择步数范围（关键修改）
    %% =========================
%     step_start = 500;
%     step_end   = 2000;
% 
%     idx = (x >= step_start) & (x <= step_end);
% 
%     x = x(idx);
%     pos_data  = pos_data(idx);
%     posT_data = posT_data(idx);

    %% =========================
    % 6. 绘制单独图
    %% =========================
%     figure('Color', 'w', ...
%            'Name', joint_name, ...
%            'Position', [200 200 800 450]);
       
        figure('Color', 'w', ...
           'Name', joint_name)

    plot(x, posT_data, 'LineWidth', 1.8); hold on;
    plot(x, pos_data,  'LineWidth', 1.8);
    hold off;
    grid on;

%     title(joint_name, ...
%         'FontName', 'Times New Roman', ...
%         'FontSize', 16, ...
%         'Interpreter', 'none');

%     set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);

hx = xlabel('步数');
set(hx, 'FontName', 'SimSun', 'FontSize', 16);

hy = ylabel('\fontname{SimSun}关节角度 \fontname{Times New Roman}(rad)', ...
    'Interpreter', 'tex');
set(hy, 'FontSize', 16);

lgd = legend({'目标值', '实际值'}, 'Location', 'best');
set(lgd, 'FontName', 'SimSun', 'FontSize', 16);
end