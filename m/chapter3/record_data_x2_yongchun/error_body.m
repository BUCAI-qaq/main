clc;
clear;
close all;

%% =========================
% 1. 读取两个数据文件
%% =========================
data_x2 = readtable('body_error_x2.txt');   % X02
data_x3 = readtable('body_error_x3.txt');   % X03

%% =========================
% 2. 选择 timestep 区间
%% =========================
idx_x2 = data_x2.timestep >= 0 & data_x2.timestep <= 300;
idx_x3 = data_x3.timestep >= 0 & data_x3.timestep <= 300;

timestep_x2 = data_x2.timestep(idx_x2);
timestep_x3 = data_x3.timestep(idx_x3);

%% =========================
% 3. 提取五个误差指标
%% =========================
% ---- X02 ----
E_g_vel_x2          = data_x2.E_g_vel(idx_x2);
E_r_pos_x2          = data_x2.E_r_pos(idx_x2);
E_r_ori_x2          = data_x2.E_r_ori(idx_x2);
E_root_vel_x2       = data_x2.E_root_vel(idx_x2);
E_joint_pos_mean_x2 = data_x2.E_joint_pos_mean(idx_x2) - 0.8;

% ---- X03 ----
E_g_vel_x3          = data_x3.E_g_vel(idx_x3);
E_r_pos_x3          = data_x3.E_r_pos(idx_x3);
E_r_ori_x3          = data_x3.E_r_ori(idx_x3);
E_root_vel_x3       = data_x3.E_root_vel(idx_x3);
E_joint_pos_mean_x3 = data_x3.E_joint_pos_mean(idx_x3) - 0.8;

%% =========================
% 4. 滑动窗口参数
%% =========================
window = 20;

%% =========================
% 5. 计算 mean 和 std
%% =========================
% -------- MPKVE --------
mean_g_x2 = movmean(E_g_vel_x2, window);
std_g_x2  = movstd(E_g_vel_x2, window);

mean_g_x3 = movmean(E_g_vel_x3, window);
std_g_x3  = movstd(E_g_vel_x3, window);

% -------- MPKPE --------
mean_p_x2 = movmean(E_r_pos_x2, window);
std_p_x2  = movstd(E_r_pos_x2, window);

mean_p_x3 = movmean(E_r_pos_x3, window);
std_p_x3  = movstd(E_r_pos_x3, window);

% -------- MPKOE --------
mean_o_x2 = movmean(E_r_ori_x2, window);
std_o_x2  = movstd(E_r_ori_x2, window);

mean_o_x3 = movmean(E_r_ori_x3, window);
std_o_x3  = movstd(E_r_ori_x3, window);

% -------- VEL --------
mean_r_x2 = movmean(E_root_vel_x2, window);
std_r_x2  = movstd(E_root_vel_x2, window);

mean_r_x3 = movmean(E_root_vel_x3, window);
std_r_x3  = movstd(E_root_vel_x3, window);

% -------- MPJPE --------
mean_j_x2 = movmean(E_joint_pos_mean_x2, window);
std_j_x2  = movstd(E_joint_pos_mean_x2, window);

mean_j_x3 = movmean(E_joint_pos_mean_x3, window);
std_j_x3  = movstd(E_joint_pos_mean_x3, window);

%% =========================
% 6. 平均误差计算
%% =========================
fprintf('\n===== Mean Tracking Errors (timestep 0–300) =====\n');

fprintf('\n----- X02 -----\n');
fprintf('Mean E_g_vel         : %.4f\n', mean(E_g_vel_x2));
fprintf('Mean E_r_pos         : %.4f\n', mean(E_r_pos_x2));
fprintf('Mean E_r_ori         : %.4f\n', mean(E_r_ori_x2));
fprintf('Mean E_root_vel      : %.4f\n', mean(E_root_vel_x2));
fprintf('Mean E_joint_pos_mean: %.4f\n', mean(E_joint_pos_mean_x2));

fprintf('\n----- X03 -----\n');
fprintf('Mean E_g_vel         : %.4f\n', mean(E_g_vel_x3));
fprintf('Mean E_r_pos         : %.4f\n', mean(E_r_pos_x3));
fprintf('Mean E_r_ori         : %.4f\n', mean(E_r_ori_x3));
fprintf('Mean E_root_vel      : %.4f\n', mean(E_root_vel_x3));
fprintf('Mean E_joint_pos_mean: %.4f\n', mean(E_joint_pos_mean_x3));

%% =========================
% 7. 颜色设置
%% =========================
c_x2 = [0 0.4470 0.7410];          % 蓝色：X02
c_x3 = [0.8500 0.3250 0.0980];     % 橙色：X03

%% =========================
% 8. 绘图：E_g_vel
%% =========================
figure;
hold on;
grid on;

h1 = plot_shaded(timestep_x2, mean_g_x2, std_g_x2, c_x2, '-');    % X02 实线
h2 = plot_shaded(timestep_x3, mean_g_x3, std_g_x3, c_x3, '--');   % X03 虚线

xlabel('$\mathrm{Timestep}$','Interpreter','latex');
ylabel('$E_{\mathrm{MPKVE}}\;(\mathrm{m/frame})$','Interpreter','latex');
legend([h1, h2], {'X02', 'X03'}, 'Location', 'best');
set(gca, 'FontSize', 12);
box on;

%% =========================
% 9. 绘图：E_r_pos
%% =========================
figure;
hold on;
grid on;

h1 = plot_shaded(timestep_x2, mean_p_x2, std_p_x2, c_x2, '-');
h2 = plot_shaded(timestep_x3, mean_p_x3, std_p_x3, c_x3, '--');

xlabel('$\mathrm{Timestep}$','Interpreter','latex');
ylabel('$E_{\mathrm{MPKPE}}\;(\mathrm{m})$','Interpreter','latex');
legend([h1, h2], {'X02', 'X03'}, 'Location', 'best');
set(gca, 'FontSize', 12);
box on;

%% =========================
% 10. 绘图：E_r_ori
%% =========================
figure;
hold on;
grid on;

h1 = plot_shaded(timestep_x2, mean_o_x2, std_o_x2, c_x2, '-');
h2 = plot_shaded(timestep_x3, mean_o_x3, std_o_x3, c_x3, '--');

xlabel('$\mathrm{Timestep}$','Interpreter','latex');
ylabel('$E_{\mathrm{MPKOE}}\;(\mathrm{rad})$','Interpreter','latex');
legend([h1, h2], {'X02', 'X03'}, 'Location', 'best');
set(gca, 'FontSize', 12);
box on;

%% =========================
% 11. 绘图：E_root_vel
%% =========================
figure;
hold on;
grid on;

h1 = plot_shaded(timestep_x2, mean_r_x2, std_r_x2, c_x2, '-');
h2 = plot_shaded(timestep_x3, mean_r_x3, std_r_x3, c_x3, '--');

xlabel('$\mathrm{Timestep}$','Interpreter','latex');
ylabel('$E_{\mathrm{VEL}}\;(\mathrm{m/frame})$','Interpreter','latex');
legend([h1, h2], {'X02', 'X03'}, 'Location', 'best');
set(gca, 'FontSize', 12);
box on;

%% =========================
% 12. 绘图：E_joint_pos_mean
%% =========================
figure;
hold on;
grid on;

h1 = plot_shaded(timestep_x2, mean_j_x2, std_j_x2, c_x2, '-');
h2 = plot_shaded(timestep_x3, mean_j_x3, std_j_x3, c_x3, '--');

xlabel('$\mathrm{Timestep}$','Interpreter','latex');
ylabel('$E_{\mathrm{MPJPE}}\;(\mathrm{rad})$','Interpreter','latex');
lgd = legend([h1, h2], {'X02', 'X03'}, 'Location', 'best');

lgd.FontName = 'Times New Roman';
lgd.FontSize = 12;
set(gca, 'FontSize', 12);
box on;

%% =========================
% 13. 局部函数
%% =========================
function h = plot_shaded(x, mean_val, std_val, color, linestyle)

    upper = mean_val + std_val;
    lower = mean_val - std_val;

    fill([x; flipud(x)], [upper; flipud(lower)], color, ...
        'FaceAlpha', 0.15, 'EdgeColor', 'none');
    hold on;

    h = plot(x, mean_val, ...
        'Color', color, ...
        'LineWidth', 1.2, ...
        'LineStyle', linestyle);

end