clc; clear; close all;

%% ============== 字体设置 ==============
fontCN = 'SimSun';           
fontEN = 'Times New Roman';  
fs = 14;

%% =========================
% 1. 文件路径
%% =========================
file_path = 'sim2real_data_2024-01-26_21-49-44.txt';

%% =========================
% 2. 读取数据
%% =========================
tbl = readtable(file_path, 'FileType', 'text', 'VariableNamingRule', 'preserve');
var_names = tbl.Properties.VariableNames;

%% =========================
% 3. 数据
%% =========================
t = tbl.time;

cmd_vx  = tbl.cmd_vx;
cmd_vy  = tbl.cmd_vy;
cmd_yaw = tbl.cmd_yaw;

roll  = tbl.roll;
pitch = tbl.pitch;
yaw   = tbl.yaw;

%% =========================
% 4. joint
%% =========================
joint_pos_cols = var_names(startsWith(var_names, 'joint_pos_'));
n_joint_pos = numel(joint_pos_cols);

joint_pos = zeros(height(tbl), n_joint_pos);
for i = 1:n_joint_pos
    joint_pos(:, i) = tbl.(joint_pos_cols{i});
end

%% =========================
% 5. 时间筛选
%% =========================
t_min = 80;
t_max = 84;

idx = (t >= t_min) & (t <= t_max);

t = t(idx);

cmd_vx  = cmd_vx(idx);
cmd_vy  = cmd_vy(idx);
cmd_yaw = cmd_yaw(idx);

joint_pos = joint_pos(idx, :);

%% =========================
% 6. 左右腿
%% =========================
left_leg_idx  = 1:5;
right_leg_idx = 6:10;

left_leg_cur  = joint_pos(:, left_leg_idx);
right_leg_cur = joint_pos(:, right_leg_idx);

%% =========================
% 7. 参数
%% =========================
lw_cmd   = 1.2;
lw_joint = 1.0;

left_color  = [0 0.4470 0.7410];
right_color = [0.8500 0.3250 0.0980];

%% =========================
% 8. CMD
%% =========================
figure('Color','w','Position',[200 100 900 220]);
plot(t, cmd_vx,  'LineWidth', lw_cmd); hold on;
plot(t, cmd_vy,  '--', 'LineWidth', lw_cmd);
plot(t, cmd_yaw, '-.', 'LineWidth', lw_cmd);

grid on;

% xlabel(['\fontname{',fontCN,'}时间 ' ...
%         '\fontname{',fontEN,'}(s)'], ...
%         'FontSize',fs,'Interpreter','tex');

ylabel(['\fontname{',fontCN,'}目标速度'], ...
        'FontSize',fs,'Interpreter','tex');

legend({'$v_x$', '$v_y$', '$\omega_z$'}, ...
       'Interpreter','latex', ...
       'Location','northeast', ...
       'FontSize',fs);

set(gca,'FontName',fontEN,'FontSize',fs);

%% =========================
% 9~13 关节图统一写法
%% =========================
joint_names = {'RHY','LHY'; 'RHR','LHR'; 'RHP','LHP'; 'RKP','LKP'; 'RAP','LAP'};

for k = 1:5

    figure('Color','w','Position',[200+20*k 100+20*k 900 220]);

    plot(t, right_leg_cur(:,k), '--', 'Color', right_color, 'LineWidth', lw_joint); hold on;
    plot(t, left_leg_cur(:,k),  '-',  'Color', left_color,  'LineWidth', lw_joint);

    grid on;

if k == 5   % ⭐ 只有最后一张图显示
    xlabel(['\fontname{',fontCN,'}时间 ' ...
            '\fontname{',fontEN,'}(s)'], ...
            'FontSize',fs,'Interpreter','tex');
else
    xlabel('');   % 前面不显示
end

    ylabel(['\fontname{',fontCN,'}关节角度 ' ...
            '\fontname{',fontEN,'}(rad)'], ...
            'FontSize',fs,'Interpreter','tex');

    legend(joint_names(k,:), ...
        'Location','northeast', ...
        'FontSize',fs);

    set(gca,'FontName',fontEN,'FontSize',fs);
end