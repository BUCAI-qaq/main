clc;
clear;
close all;

%% 读取数据
real_data = readtable('real_state.txt');
ref_data  = readtable('ref_state.txt');

%% 可选：选择时间范围
% 如果想只画一部分，比如 10~400
use_range = true;
t_min = 0;
t_max = 300;

if use_range
    idx_real = real_data.timestep >= t_min & real_data.timestep <= t_max;
    idx_ref  = ref_data.timestep  >= t_min & ref_data.timestep  <= t_max;
else
    idx_real = true(height(real_data),1);
    idx_ref  = true(height(ref_data),1);
end

real_data = real_data(idx_real,:);
ref_data  = ref_data(idx_ref,:);

% 默认两者 timestep 对齐
t = real_data.timestep;

%% 颜色设置
c_real = [0 0.4470 0.7410];
c_ref  = [0.8500 0.3250 0.0980];

lw_real = 1.2;
lw_ref  = 1.2;

%% =========================
%% 1. 根部速度跟踪（3个子图）
%% =========================
% figure('Name','Root Velocity Tracking','Position',[200 100 900 700]);

subplot(3,1,1);
plot(t, ref_data.ref_root_vel_x, '--', 'Color', c_ref, 'LineWidth', lw_ref); hold on;
plot(t, real_data.root_vel_x, '-',  'Color', c_real,'LineWidth', lw_real);
grid on; box on;
ylabel('$v_x\;(\mathrm{m/frame})$','Interpreter','latex');
legend('Reference','Real','Location','best');

subplot(3,1,2);
plot(t, ref_data.ref_root_vel_y, '--', 'Color', c_ref, 'LineWidth', lw_ref); hold on;
plot(t, real_data.root_vel_y, '-',  'Color', c_real,'LineWidth', lw_real);
grid on; box on;
ylabel('$v_y\;(\mathrm{m/frame})$','Interpreter','latex');
legend('Reference','Real','Location','best');

subplot(3,1,3);
plot(t, ref_data.ref_root_vel_z, '--', 'Color', c_ref, 'LineWidth', lw_ref); hold on;
plot(t, real_data.root_vel_z, '-',  'Color', c_real,'LineWidth', lw_real);
grid on; box on;
ylabel('$v_z\;(\mathrm{m/frame})$','Interpreter','latex');
xlabel('$\mathrm{Timestep}$','Interpreter','latex');
legend('Reference','Real','Location','best');
