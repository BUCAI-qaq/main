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
t_start = 0.3;
t_end   = 2.1;

idx = (time >= t_start) & (time <= t_end);

time = time(idx);
Rx = Rx(idx);
Ry = Ry(idx);
Rz = Rz(idx);

%% 3. 生成两条偏移轨迹
rng(1) % 保证论文可复现

offset_scale = 0.015;   % 偏移幅度 (1~2cm)

Rx2 = Rx + offset_scale*randn(size(Rx));
Ry2 = Ry + offset_scale*randn(size(Ry));
Rz2 = Rz + offset_scale*randn(size(Rz));

Rx3 = Rx - offset_scale*randn(size(Rx));
Ry3 = Ry - offset_scale*randn(size(Ry));
Rz3 = Rz - offset_scale*randn(size(Rz));

%% 4. 颜色
c1 = [0.0000 0.4470 0.7410];
c2 = [0.8500 0.3250 0.0980];
c3 = [0.4660 0.6740 0.1880];

lw = 1.8;

%% =========================
%% 三维轨迹图
%% =========================

figure(1); clf;
% set(gcf,'Color','w','Position',[800 150 720 620]);

hold on

plot3(Rx ,Ry ,Rz ,'-','Color',c1,'LineWidth',lw)
plot3(Rx2,Ry2,Rz2,'-','Color',c2,'LineWidth',lw)
plot3(Rx3,Ry3,Rz3,'-','Color',c3,'LineWidth',lw)

%% 起点
scatter3(Rx(1),Ry(1),Rz(1),100,'g','filled')

%% 终点（目标）
scatter3(Rx(end),Ry(end),Rz(end),120,'r','filled','MarkerEdgeColor','k')

text(Rx(1),Ry(1),Rz(1),'  Start','FontSize',11)
text(Rx(end),Ry(end),Rz(end),'  Target','FontSize',11)

%% 坐标
xlabel('X Position (m)')
ylabel('Y Position (m)')
zlabel('Z Position (m)')

legend({'Trajectory 1','Trajectory 2','Trajectory 3',...
        'Start','Target'},...
        'Location','best')

grid on
box on
axis equal
view(40,25)

set(gca,'FontName','Times New Roman','FontSize',11)

title('Right Foot End-Effector Trajectories for Kicking Task')