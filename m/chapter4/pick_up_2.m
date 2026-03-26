clear; clc; close all;

%% ============== 字体设置 ==============
fontCN = 'SimSun';           
fontEN = 'Times New Roman';  
fs = 14;

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

%% 2 时间区间
t_start = 0.7;
t_end   = time(end) - 0.5;

idx = (time >= t_start) & (time <= t_end);

time = time(idx);

Lx = Lx(idx); Ly = Ly(idx); Lz = Lz(idx);
Rx = Rx(idx); Ry = Ry(idx); Rz = Rz(idx);

%% 3 接触段
N = length(time);
contact_start_idx = floor(2*N/3);

%% 4 绘图参数
lw_main = 1.6;
lw_contact = 2.4;

cL = [0.0000 0.4470 0.7410];
cR = [0.8500 0.3250 0.0980];
cC = [0.9290 0.6940 0.1250];

%% 5 绘图
figure;
set(gcf,'Color','w','Position',[300 200 760 620])
hold on

% 左手
plot3(Lx(1:contact_start_idx),Ly(1:contact_start_idx),Lz(1:contact_start_idx),...
    '-', 'Color', cL, 'LineWidth', lw_main);

plot3(Lx(contact_start_idx:end),Ly(contact_start_idx:end),Lz(contact_start_idx:end),...
    '-', 'Color', cC, 'LineWidth', lw_contact);

% 右手
plot3(Rx(1:contact_start_idx),Ry(1:contact_start_idx),Rz(1:contact_start_idx),...
    '-', 'Color', cR, 'LineWidth', lw_main);

plot3(Rx(contact_start_idx:end),Ry(contact_start_idx:end),Rz(contact_start_idx:end),...
    '-', 'Color', cC, 'LineWidth', lw_contact);

% 起点终点
scatter3(Lx(1),Ly(1),Lz(1),70,cL,'filled')
scatter3(Rx(1),Ry(1),Rz(1),70,cR,'filled')

scatter3(Lx(end),Ly(end),Lz(end),70,cL,'d','filled')
scatter3(Rx(end),Ry(end),Rz(end),70,cR,'d','filled')

% 接触起点
scatter3(Lx(contact_start_idx),Ly(contact_start_idx),Lz(contact_start_idx),...
    80,cC,'o','filled','MarkerEdgeColor','k')
scatter3(Rx(contact_start_idx),Ry(contact_start_idx),Rz(contact_start_idx),...
    80,cC,'o','filled','MarkerEdgeColor','k')

%% ======================
%% 中文标注（全部改为宋体）
%% ======================

midL = floor(contact_start_idx/2);
midR = floor(contact_start_idx/2);

% 左手轨迹
text(Lx(midL)-0.2, Ly(midL), Lz(midL), ...
    '左手轨迹', ...
    'Color', cL, ...
    'FontName', fontCN, ...
    'FontSize', fs);

% 右手轨迹
text(Rx(midR)-0.2, Ry(midR), Rz(midR), ...
    '右手轨迹', ...
    'Color', cR, ...
    'FontName', fontCN, ...
    'FontSize', fs);

% 接触阶段
text(Lx(contact_start_idx)+0.005, Ly(contact_start_idx)-0.2, Lz(contact_start_idx)+0.05, ...
    '接触阶段', ...
    'Color', [0.2 0.2 0.2], ...
    'FontName', fontCN, ...
    'FontSize', fs);

text(Rx(contact_start_idx)+0.005, Ry(contact_start_idx)-0.2, Rz(contact_start_idx)+0.08, ...
    '接触阶段', ...
    'Color', [0.2 0.2 0.2], ...
    'FontName', fontCN, ...
    'FontSize', fs);

% 起点终点
text(Lx(1)+0.005, Ly(1)-0.05, Lz(1)-0.005, ...
    '开始', ...
    'Color', cL, ...
    'FontName', fontCN, ...
    'FontSize', fs);

text(Rx(1)+0.005, Ry(1)-0.03, Rz(1)-0.008, ...
    '开始', ...
    'Color', cR, ...
    'FontName', fontCN, ...
    'FontSize', fs);

text(Lx(end)+0.005, Ly(end)+0.01, Lz(end), ...
    '结束', ...
    'Color', cL, ...
    'FontName', fontCN, ...
    'FontSize', fs);

text(Rx(end)+0.005, Ry(end)+0.008, Rz(end), ...
    '结束', ...
    'Color', cR, ...
    'FontName', fontCN, ...
    'FontSize', fs);

%% ======================
%% 坐标轴（中英混排）
%% ======================

xlabel(['\fontname{',fontEN,'}X (m)'],...
       'FontSize',fs,'Interpreter','tex')

ylabel(['\fontname{',fontEN,'}Y (m)'],...
       'FontSize',fs,'Interpreter','tex')

zlabel(['\fontname{',fontEN,'}Z (m)'],...
       'FontSize',fs,'Interpreter','tex')

grid on
box on
axis tight
view(40,25)

set(gca,'FontName',fontEN,'FontSize',fs)