clc; clear;

% 读取原始数据的CSV文件
angle_1_Data = csvread('../../angle&pc/robot1_data.csv', 1, 0); % 忽略标题行
angle_2_Data = csvread('../../angle&pc/robot2_data.csv', 1, 0); % 忽略标题行
pc_1_Data = csvread('../../angle&pc/robot1_datac.csv', 1, 0); % 忽略标题行
pc_2_Data = csvread('../../angle&pc/robot2_datac.csv', 1, 0); % 忽略标题行

% 分离时间和关节位置数据
startIndex1 = 3500;
endIndex1 = 6000;
time1 = angle_1_Data(startIndex1:endIndex1, 1) - angle_1_Data(startIndex1, 1);
angle1 = angle_1_Data(startIndex1:endIndex1,:);
pc1 = pc_1_Data(startIndex1:endIndex1,:);

startIndex2 = 3900;
endIndex2 = 6250;
time2 = angle_2_Data(startIndex2:endIndex2, 1) - angle_2_Data(startIndex2, 1);
angle2 = angle_2_Data(startIndex2:endIndex2,:);
pc2 = pc_2_Data(startIndex2:endIndex2, 1:10);

% 将角度从度转换为弧度
angle1 = angle1 * pi / 180;
angle2 = angle2 * pi / 180;
pc1 = pc1 * pi / 180;
pc2 = pc2 * pi / 180;

% 设置颜色和线条样式
c1 = [67, 111, 182] / 255; % 机器人1颜色
c2 = [255, 129, 0] / 255; % 机器人2颜色
lineStyleAngle = '-';   % 机器人1角度线条样式
lineStylePC = '-.';     % 机器人1机器人控制器数据线条样式（带圆圈）
lineStyleAngle2 = '-';  % 机器人2角度线条样式
markerAngle = 'o';
lineStylePC2 = ':';     % 机器人2控制器数据线条样式（带圆圈）

% 绘制Human1 和 Robot1关节图
figure;
% Human 1 LSP关节
plot(time2, angle2(:, 2), 'Color', c1, 'LineWidth', 2, 'LineStyle', lineStyleAngle); 
hold on;
% Robot 1 LSP关节
plot(time2, pc2(:, 2), 'Color', c2, 'LineWidth', 2, 'LineStyle', lineStylePC); 


xlabel('Time (s)', 'FontSize', 12);
ylabel('Angle (rad)', 'FontSize', 12);  
legend('Human', 'Robot', 'FontSize', 10, 'Location', 'best');
grid on; % 添加网格线

% 绘制Human1 和 Robot1关节图
figure;
% Human 1 LSP关节
plot(time2, angle2(:, 3), 'Color', c1, 'LineWidth', 2, 'LineStyle', lineStyleAngle); 
hold on;
% Robot 1 LSP关节
plot(time2, pc2(:, 3), 'Color', c2, 'LineWidth', 2, 'LineStyle', lineStylePC); 


xlabel('Time (s)', 'FontSize', 12);
ylabel('Angle (rad)', 'FontSize', 12);  
legend('Human', 'Robot', 'FontSize', 10, 'Location', 'best');
grid on; % 添加网格线



% 绘制Human2 和 Robot2关节图
figure;
% Human 2 LSP关节

plot(time1, angle1(:, 2), 'Color', c1, 'LineWidth', 2, 'LineStyle', lineStyleAngle);

hold on;
plot(time1, pc1(:, 2), 'Color', c2, 'LineWidth', 2, 'LineStyle', lineStylePC);

xlabel('Time (s)', 'FontSize', 12);
ylabel('Angle (rad)', 'FontSize', 12);  
legend('Human', 'Robot', 'FontSize', 10, 'Location', 'best');
grid on; % 添加网格线

% 绘制Human2 和 Robot2关节图
figure;
% Human 2 LSP关节

plot(time1, angle1(:, 3), 'Color', c1, 'LineWidth', 2, 'LineStyle', lineStyleAngle);

hold on;
plot(time1, pc1(:, 3), 'Color', c2, 'LineWidth', 2, 'LineStyle', lineStylePC);

xlabel('Time (s)', 'FontSize', 12);
ylabel('Angle (rad)', 'FontSize', 12);  
legend('Human', 'Robot', 'FontSize', 10, 'Location', 'best');
grid on; % 添加网格线
