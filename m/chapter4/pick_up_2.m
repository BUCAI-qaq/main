clear; clc; close all;

%% 1 读取数据
filename = '2026-03-15_16-12-56_hand_end_pos_hand.txt';
data = readtable(filename);

time = data.time;

Lx = data.left_hand_x;
Ly = data.left_hand_y;
Lz = data.left_hand_z;

Rx = data.right_hand_x;
Ry = data.right_hand_y;
Rz = data.right_hand_z;

%% 2 设置时间区间
t_start = 0.7;
t_end   = time(end) - 0.5;

idx = (time >= t_start) & (time <= t_end);

%% 3 过滤数据
time = time(idx);

Lx = Lx(idx);
Ly = Ly(idx);
Lz = Lz(idx);

Rx = Rx(idx);
Ry = Ry(idx);
Rz = Rz(idx);

%% 4 接触段：后 1/3
N = length(time);
contact_start_idx = floor(2*N/3);

%% 5 绘图参数
lw_main = 1.6;
lw_contact = 2.4;

cL = [0.0000 0.4470 0.7410];   % 左手蓝
cR = [0.8500 0.3250 0.0980];   % 右手红
cC = [0.9290 0.6940 0.1250];   % 接触段橙黄色

%% 6 三维轨迹图
figure;
set(gcf,'Color','w','Position',[300 200 760 620])
hold on

% 左手普通轨迹
plot3(Lx(1:contact_start_idx), ...
      Ly(1:contact_start_idx), ...
      Lz(1:contact_start_idx), ...
      '-', 'Color', cL, 'LineWidth', lw_main);

% 左手接触段
plot3(Lx(contact_start_idx:end), ...
      Ly(contact_start_idx:end), ...
      Lz(contact_start_idx:end), ...
      '-', 'Color', cC, 'LineWidth', lw_contact);

% 右手普通轨迹
plot3(Rx(1:contact_start_idx), ...
      Ry(1:contact_start_idx), ...
      Rz(1:contact_start_idx), ...
      '-', 'Color', cR, 'LineWidth', lw_main);

% 右手接触段
plot3(Rx(contact_start_idx:end), ...
      Ry(contact_start_idx:end), ...
      Rz(contact_start_idx:end), ...
      '-', 'Color', cC, 'LineWidth', lw_contact);

% 起点
scatter3(Lx(1),Ly(1),Lz(1),70,cL,'filled')
scatter3(Rx(1),Ry(1),Rz(1),70,cR,'filled')

% 终点
scatter3(Lx(end),Ly(end),Lz(end),70,cL,'d','filled')
scatter3(Rx(end),Ry(end),Rz(end),70,cR,'d','filled')

% 接触段起点
scatter3(Lx(contact_start_idx),Ly(contact_start_idx),Lz(contact_start_idx), ...
    80,cC,'o','filled','MarkerEdgeColor','k')
scatter3(Rx(contact_start_idx),Ry(contact_start_idx),Rz(contact_start_idx), ...
    80,cC,'o','filled','MarkerEdgeColor','k')

%% 7 图中直接标注（替代 legend）

% 轨迹中间位置
midL = floor(contact_start_idx/2);
midR = floor(contact_start_idx/2);

% 左手轨迹标注
text(Lx(midL)-0.2, Ly(midL), Lz(midL), ...
    'Left hand trajectory', ...
    'Color', cL, ...
    'FontName', 'Times New Roman', ...
    'FontSize', 11);

% 右手轨迹标注
text(Rx(midR)-0.2, Ry(midR)-0., Rz(midR), ...
    'Right hand trajectory', ...
    'Color', cR, ...
    'FontName', 'Times New Roman', ...
    'FontSize', 11);

% 接触阶段标注
text(Lx(contact_start_idx)+0.005, Ly(contact_start_idx)-0.2, Lz(contact_start_idx)+0.05, ...
    'Contact phase', ...
    'Color', [0.2 0.2 0.2], ...
    'FontName', 'Times New Roman', ...
    'FontSize', 11);

text(Rx(contact_start_idx)+0.005, Ry(contact_start_idx)-0.2, Rz(contact_start_idx)+0.08, ...
    'Contact phase', ...
    'Color', [0.2 0.2 0.2], ...
    'FontName', 'Times New Roman', ...
    'FontSize', 11);

% 起点终点标注
text(Lx(1)+0.005, Ly(1)-0.05, Lz(1)-0.005, ...
    'start', ...
    'Color', cL, ...
    'FontName', 'Times New Roman', ...
    'FontSize', 11);

text(Rx(1)+0.005, Ry(1)-0.03, Rz(1)-0.008, ...
    'start', ...
    'Color', cR, ...
    'FontName', 'Times New Roman', ...
    'FontSize', 11);

text(Lx(end)+0.005, Ly(end)+0.01, Lz(end), ...
    'end', ...
    'Color', cL, ...
    'FontName', 'Times New Roman', ...
    'FontSize', 11);

text(Rx(end)+0.005, Ry(end)+0.008, Rz(end), ...
    'end', ...
    'Color', cR, ...
    'FontName', 'Times New Roman', ...
    'FontSize', 11);

%% 8 坐标轴
xlabel('X Position (m)')
ylabel('Y Position (m)')
zlabel('Z Position (m)')

grid on
box on
axis tight
view(40,25)

set(gca,'FontName','Times New Roman','FontSize',11)