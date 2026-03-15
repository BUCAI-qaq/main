clear; clc; close all;

%% 1. 读取数据
filename = '2026-03-15_15-57-58_foot_end_pos.txt';
data = readtable(filename);

time = data.time;

% 右脚
Rx = data.right_foot_x;
Ry = data.right_foot_y;
Rz = data.right_foot_z;

%% 2. 选择时间区间
t_start = 0.3;   % 起始时间
t_end   = 2.1;   % 结束时间

idx = (time >= t_start) & (time <= t_end);

time = time(idx);
Rx = Rx(idx);
Ry = Ry(idx);
Rz = Rz(idx);

%% 3. 绘图参数
lw = 1.6;
cR = [0.8500 0.3250 0.0980];   % 右脚：红色

%% =========================
%% 三维轨迹图（右腿）
%% =========================

figure(1); clf;
set(gcf, 'Color', 'w', 'Position', [800 150 700 600]);

plot3(Rx, Ry, Rz, '-', 'Color', cR, 'LineWidth', lw); hold on

% 起点
scatter3(Rx(1), Ry(1), Rz(1), 80, 'g', 'filled')

% 终点
scatter3(Rx(end), Ry(end), Rz(end), 80, 'm', 'filled')

% 标注
text(Rx(1), Ry(1), Rz(1), '  Start', 'FontSize', 11)
text(Rx(end), Ry(end), Rz(end), '  End', 'FontSize', 11)

xlabel('X Position (m)')
ylabel('Y Position (m)')
zlabel('Z Position (m)')

legend('Right foot trajectory','Start','End','Location','best')

grid on
box on
axis tight
view(40,25)

set(gca, 'FontName', 'Times New Roman', 'FontSize', 11)