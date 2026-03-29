clc; clear; close all;

%% =========================
% 1. 文件路径
%% =========================
file_path = 'data/retarget_motion_data_2026-03-27 16_42_49.csv';

%% =========================
% 2. 读取 CSV
%% =========================
tbl = readtable(file_path, ...
    'VariableNamingRule', 'preserve');

var_names = tbl.Properties.VariableNames;

%% =========================
% 3. 处理时间轴
%% =========================
if any(strcmp(var_names, 'time'))
    t = tbl.time;
else
    t = (0:height(tbl)-1)';   % 如果没有 time，用索引
end

% 从0开始（更规范）
t = t - t(1);

%% =========================
% 4. 提取关节数据列
%% =========================
data_cols = setdiff(var_names, {'time'});

n = length(data_cols);

%% =========================
% 5. 是否转换为角度（重要！）
%% =========================
use_degree = true;   % true: 转为角度 deg

%% =========================
% 6. 绘图（分子图）
%% =========================
figure('Color','w','Position',[100 100 1400 800]);

rows = ceil(n / 4);
cols = 4;

for i = 1:n
    subplot(rows, cols, i);

    y = tbl.(data_cols{i});

    % 转角度（如果是弧度）
    if use_degree
        if max(abs(y)) < 10   % 简单判断 rad
            y = rad2deg(y);
        end
    end

    plot(t, y, 'LineWidth', 1.2);
    grid on;

    % 子图标题（英文）
    title(data_cols{i}, ...
        'FontName','Times New Roman', ...
        'FontSize',12, ...
        'Interpreter','none');

    % 去掉中间子图的 x 标签（更论文风格）
    if i <= (rows-1)*cols
        set(gca, 'XTickLabel', []);
    end

    % 坐标轴字体
    set(gca, 'FontName','Times New Roman', 'FontSize',11);
end

%% =========================
% 7. 全局标签（论文用）
%% =========================
han = axes(gcf,'visible','off');
han.XLabel.Visible = 'on';
han.YLabel.Visible = 'on';

xlabel(han, '时间 (s)', ...
    'FontName','SimSun', ...
    'FontSize',16);

ylabel(han, '关节角度 (deg)', ...
    'FontName','SimSun', ...
    'FontSize',16);

sgtitle('关节角度变化曲线', ...
    'FontName','SimSun', ...
    'FontSize',16);