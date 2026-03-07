clc;
clear;
close all;

%% 读取数据
data = readtable('body_error.txt');

%% 选择 timestep 区间
idx = data.timestep >= 0 & data.timestep <= 300;

timestep = data.timestep(idx);

E_g_vel = data.E_g_vel(idx);
E_r_pos = data.E_r_pos(idx);
E_r_ori = data.E_r_ori(idx);
E_root_vel = data.E_root_vel(idx);
E_joint_pos_mean = data.E_joint_pos_mean(idx)-0.8;

%% 滑动窗口
window = 20;

%% 计算 mean 和 std
mean_g = movmean(E_g_vel, window);
std_g  = movstd(E_g_vel, window);

mean_p = movmean(E_r_pos, window);
std_p  = movstd(E_r_pos, window);

mean_o = movmean(E_r_ori, window);
std_o  = movstd(E_r_ori, window);

mean_r = movmean(E_root_vel, window);
std_r  = movstd(E_root_vel, window);

mean_j = movmean(E_joint_pos_mean, window);
std_j  = movstd(E_joint_pos_mean, window);

%% ===== 平均误差计算 =====
mean_E_g_vel      = mean(E_g_vel);
mean_E_r_pos      = mean(E_r_pos);
mean_E_r_ori      = mean(E_r_ori);
mean_E_root_vel   = mean(E_root_vel);
mean_E_joint_pos  = mean(E_joint_pos_mean);

fprintf('\n===== Mean Tracking Errors (timestep 0–300) =====\n');
fprintf('Mean E_g_vel         : %.4f\n', mean_E_g_vel);
fprintf('Mean E_r_pos         : %.4f\n', mean_E_r_pos);
fprintf('Mean E_r_ori         : %.4f\n', mean_E_r_ori);
fprintf('Mean E_root_vel      : %.4f\n', mean_E_root_vel);
fprintf('Mean E_joint_pos_mean: %.4f\n', mean_E_joint_pos);

%% 颜色
c1 = [0 0.4470 0.7410];
c2 = [0.8500 0.3250 0.0980];
c3 = [0.9290 0.6940 0.1250];
c4 = [0.4940 0.1840 0.5560];
c5 = [0.4660 0.6740 0.1880];

%% -------- Eg_vel --------
figure
hold on
grid on
plot_shaded(timestep, mean_g, std_g, c1)
xlabel('$\mathrm{Timestep}$','Interpreter','latex')
ylabel('$E_{\mathrm{MPKVE}}\;(\mathrm{m/frame})$','Interpreter','latex')
set(gca, 'FontSize', 12)
box on

%% -------- Er_pos --------
figure
hold on
grid on
plot_shaded(timestep, mean_p, std_p, c2)
xlabel('$\mathrm{Timestep}$','Interpreter','latex')
ylabel('$E_{\mathrm{MPKPE}}\;(\mathrm{m})$','Interpreter','latex')
set(gca, 'FontSize', 12)
box on

%% -------- Er_ori --------
figure
hold on
grid on
plot_shaded(timestep, mean_o, std_o, c3)
xlabel('$\mathrm{Timestep}$','Interpreter','latex')
ylabel('$E_{\mathrm{MPKOE}}\;(\mathrm{rad})$','Interpreter','latex')
set(gca, 'FontSize', 12)
box on

%% -------- Eroot_vel --------
figure
hold on
grid on
plot_shaded(timestep, mean_r, std_r, c4)
xlabel('$\mathrm{Timestep}$','Interpreter','latex')
ylabel('$E_{\mathrm{VEL}}\;(\mathrm{m/frame})$','Interpreter','latex')
set(gca, 'FontSize', 12)
box on

%% -------- E_joint_pos_mean --------
figure
hold on
grid on
plot_shaded(timestep, mean_j, std_j, c5)
xlabel('$\mathrm{Timestep}$','Interpreter','latex')
ylabel('$E_{\mathrm{MPJPE}}\;(\mathrm{rad})$','Interpreter','latex')
set(gca, 'FontSize', 12)
box on

%% ===== 函数必须在最后 =====
function plot_shaded(x, mean_val, std_val, color)

upper = mean_val + std_val;
lower = mean_val - std_val;

fill([x; flipud(x)], [upper; flipud(lower)], color, ...
    'FaceAlpha', 0.2, 'EdgeColor', 'none');
hold on;

plot(x, mean_val, 'Color', color, 'LineWidth', 1.5);

end