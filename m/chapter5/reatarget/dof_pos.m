clc; clear; close all;

%% =========================
% 1. 数据文件夹
%% =========================
data_dir = 'data';

%% =========================
% 2. 文件分组（已去掉 ankle）
%% =========================
file_groups = {
    'l_hip_pitch',    'l_hip_pitch_pos.csv',    'l_hip_pitch_posT.csv';
    'R_knee',         'R_knee_pos.csv',         'R_knee_posT.csv';
    'shoulder_pitch', 'shoulder_pitch_pos.csv', 'shoulder_pitch_posT.csv';
    'elbow',          'elbow_pos.csv',          'elbow_posT.csv';
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

    %% =========================
    % 6. 绘制单独图
    %% =========================
    figure('Color', 'w', ...
           'Name', joint_name, ...
           'Position', [200 200 800 450]);

    plot(x, posT_data, 'LineWidth', 2); hold on;
    plot(x, pos_data,  'LineWidth', 2);
    hold off;
    grid on;

    title(joint_name, ...
        'FontName', 'Times New Roman', ...
        'FontSize', 16, ...
        'Interpreter', 'none');

    xlabel('步数 (Step)', ...
        'FontName', 'SimSun', ...
        'FontSize', 14);

    ylabel('关节角度', ...
        'FontName', 'SimSun', ...
        'FontSize', 14);

    legend({'posT（参考）', 'pos（实际）'}, ...
        'FontName', 'SimSun', ...
        'FontSize', 12, ...
        'Location', 'best');

    set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);
end