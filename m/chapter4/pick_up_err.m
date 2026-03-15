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
contact_start_idx = floor(2*N/3);   % 后1/3起点

%% 5 绘图参数
lw_main = 1.6;
lw_contact = 2.4;

cL = [0.0000 0.4470 0.7410];   % 左手蓝
cR = [0.8500 0.3250 0.0980];   % 右手红
cC = [0.9290 0.6940 0.1250];   % 接触段橙黄色

%% 6 三维轨迹
figure;
set(gcf,'Color','w','Position',[300 200 760 620])
hold on

% 左手普通轨迹
h1 = plot3(Lx(1:contact_start_idx), ...
           Ly(1:contact_start_idx), ...
           Lz(1:contact_start_idx), ...
           '-', 'Color', cL, 'LineWidth', lw_main);

% 左手接触段
h2 = plot3(Lx(contact_start_idx:end), ...
           Ly(contact_start_idx:end), ...
           Lz(contact_start_idx:end), ...
           '-', 'Color', cC, 'LineWidth', lw_contact);

% 右手普通轨迹
h3 = plot3(Rx(1:contact_start_idx), ...
           Ry(1:contact_start_idx), ...
           Rz(1:contact_start_idx), ...
           '-', 'Color', cR, 'LineWidth', lw_main);

% 右手接触段（不加入 legend）
plot3(Rx(contact_start_idx:end), ...
      Ry(contact_start_idx:end), ...
      Rz(contact_start_idx:end), ...
      '-', 'Color', cC, 'LineWidth', lw_contact);
  
 h4 = scatter3(Lx(1),Ly(1),Lz(1),70,cL,'filled');
h5 = scatter3(Rx(1),Ry(1),Rz(1),70,cR,'filled');

h6 = scatter3(Lx(end),Ly(end),Lz(end),70,cL,'d','filled');
h7 = scatter3(Rx(end),Ry(end),Rz(end),70,cR,'d','filled');

h8 = scatter3(Lx(contact_start_idx),Ly(contact_start_idx), ...
              Lz(contact_start_idx),80,cC,'o','filled','MarkerEdgeColor','k');

% 起点
scatter3(Lx(1),Ly(1),Lz(1),70,cL,'filled')
scatter3(Rx(1),Ry(1),Rz(1),70,cR,'filled')

% 终点
scatter3(Lx(end),Ly(end),Lz(end),70,cL,'d','filled')
scatter3(Rx(end),Ry(end),Rz(end),70,cR,'d','filled')

% 接触段起点标记（可选）
scatter3(Lx(contact_start_idx),Ly(contact_start_idx),Lz(contact_start_idx), ...
    80,cC,'o','filled','MarkerEdgeColor','k')
scatter3(Rx(contact_start_idx),Ry(contact_start_idx),Rz(contact_start_idx), ...
    80,cC,'o','filled','MarkerEdgeColor','k')

xlabel('X Position (m)')
ylabel('Y Position (m)')
zlabel('Z Position (m)')

legend([h1 h3 h2 h4 h5 h6 h7 h8], ...
       {'Left hand trajectory', ...
        'Right hand trajectory', ...
        'Hand contact phase', ...
        'Left hand start', ...
        'Right hand start', ...
        'Left hand end', ...
        'Right hand end', ...
        'Contact start'}, ...
       'Location','best');

grid on
box on
axis tight
view(40,25)

set(gca,'FontName','Times New Roman','FontSize',11)