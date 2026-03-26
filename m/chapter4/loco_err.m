clear; clc; close all;

%% ============== 字体设置 ==============
fontCN = 'SimSun';           
fontEN = 'Times New Roman';  
fs = 14;

%% 读取数据
filename = '2025-12-25_20-35-35_Walk-8_000_Walk_GMR_2026-03-15_14-55-32_root_pos.txt';
data = readtable(filename);

time   = data.time;
root_x = data.root_x;
root_y = data.root_y;

%% 参数
update_period = 3.0;
target_radius = 0.25;

rng(1)

%% 目标时间
t_end = time(end);
target_times = 0:update_period:t_end;

target_idx = zeros(length(target_times),1);

for i = 1:length(target_times)
    [~,idx] = min(abs(time-target_times(i)));
    target_idx(i) = idx;
end

%% 生成目标点
target_x = zeros(length(target_idx),1);
target_y = zeros(length(target_idx),1);

for i = 1:length(target_idx)

    cx = root_x(target_idx(i));
    cy = root_y(target_idx(i));

    theta = 2*pi*rand;
    r = target_radius*sqrt(rand);

    target_x(i) = cx + r*cos(theta);
    target_y(i) = cy + r*sin(theta);

end

%% ======================
%% 绘图
%% ======================

figure(1); clf
% set(gcf,'color','w','Position',[200 120 720 620])
set(gcf,'color','w','Position',[200 120 720 620])

hold on

%% 机器人位置
scatter(root_x(target_idx),root_y(target_idx),...
    35,'k','filled')

%% 目标点
scatter(target_x,target_y,...
    80,'r','filled','MarkerEdgeColor','k')

%% 轨迹
plot(root_x,root_y,'--','Color',[0.7 0.7 0.7],'LineWidth',1.2)

%% 连接线
for i = 1:length(target_idx)

    plot([root_x(target_idx(i)) target_x(i)],...
         [root_y(target_idx(i)) target_y(i)],...
         'k-','LineWidth',1.2)

end

%% 目标编号（英文 → Times）
for i = 1:length(target_x)

    text(target_x(i)+0.06,...
         target_y(i)+0.06,...
         sprintf('T%d',i),...
         'FontSize',12,...
         'FontName',fontEN)

end

%% 起点终点（英文 → Times）
scatter(root_x(1),root_y(1),80,'g','filled')
text(root_x(1)+0.06,root_y(1)+0.06,'Start',...
    'FontSize',12,'FontName',fontEN)

scatter(root_x(end),root_y(end),80,'m','filled')
text(root_x(end)+0.06,root_y(end)+0.06,'End',...
    'FontSize',12,'FontName',fontEN)

%% 坐标轴（中英混排）
xlabel(['\fontname{',fontEN,'}X (m)'],...
       'FontSize',fs,'Interpreter','tex')

ylabel(['\fontname{',fontEN,'}Y (m)'],...
       'FontSize',fs,'Interpreter','tex')

grid on
box on
axis equal

%% legend（中文 → 宋体）
lgd = legend({ ...
    ['\fontname{',fontCN,'}机器人位置'], ...
    ['\fontname{',fontCN,'}目标位置'], ...
    ['\fontname{',fontCN,'}运动轨迹']}, ...
    'Location','best',...
    'FontSize',fs,...
    'Interpreter','tex');

lgd.Box = 'on';

%% 坐标轴刻度（英文）
set(gca,...
    'FontName',fontEN,...
    'FontSize',fs,...
    'LineWidth',0.5);