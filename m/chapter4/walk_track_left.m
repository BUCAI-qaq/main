clear; clc; close all;

%% ============== 字体设置 ==============
fontCN = 'SimSun';           
fontEN = 'Times New Roman';  
fs = 14;

%% 1 读取数据
filename = '2025-12-25_20-35-35_Walk-8_000_Walk_GMR_2026-03-15_10-37-00_joint_log.txt';
data = readtable(filename);

%% 2 时间
time = data.time;

%% 3 时间区间
idx = (time >= 23) & (time <= 33);
time = time(idx);

%% 左腿数据
L_hr_real = data.left_hip_roll_joint_actual(idx);
L_hr_ref  = data.left_hip_roll_joint_ref(idx);

L_hp_real = data.left_hip_pitch_joint_actual(idx);
L_hp_ref  = data.left_hip_pitch_joint_ref(idx);

L_hy_real = data.left_hip_yaw_joint_actual(idx);
L_hy_ref  = data.left_hip_yaw_joint_ref(idx);

L_kn_real = data.left_knee_joint_actual(idx);
L_kn_ref  = data.left_knee_joint_ref(idx);

L_ap_real = data.left_ankle_pitch_joint_actual(idx);
L_ap_ref  = data.left_ankle_pitch_joint_ref(idx);

L_ar_real = data.left_ankle_roll_joint_actual(idx);
L_ar_ref  = data.left_ankle_roll_joint_ref(idx);

%% 绘图参数
lw = 1.2;

%% ================= 左腿6张图 =================

% plot_joint(time, L_hr_real, L_hr_ref, '髋关节滚转', fontCN, fontEN, fs, lw, [100 100 800 250]);
% plot_joint(time, L_hp_real, L_hp_ref, '髋关节俯仰', fontCN, fontEN, fs, lw, [120 120 800 250]);
% plot_joint(time, L_hy_real, L_hy_ref, '髋关节偏航', fontCN, fontEN, fs, lw, [140 140 800 250]);
% plot_joint(time, L_kn_real, L_kn_ref, '膝关节',     fontCN, fontEN, fs, lw, [160 160 800 250]);
% plot_joint(time, L_ap_real, L_ap_ref, '踝关节俯仰', fontCN, fontEN, fs, lw, [180 180 800 250]);
% plot_joint(time, L_ar_real, L_ar_ref, '踝关节滚转', fontCN, fontEN, fs, lw, [200 200 800 250]);

%% ================= 左腿6张图 =================
plot_joint(time, L_hp_real, L_hp_ref, '关节角度', fontCN, fontEN, fs, lw, [120 120 800 250], false);
plot_joint(time, L_hr_real, L_hr_ref, '关节角度', fontCN, fontEN, fs, lw, [100 100 800 250], false);
plot_joint(time, L_hy_real, L_hy_ref, '关节角度', fontCN, fontEN, fs, lw, [140 140 800 250], false);
plot_joint(time, L_kn_real, L_kn_ref, '关节角度', fontCN, fontEN, fs, lw, [160 160 800 250], false);
plot_joint(time, L_ap_real, L_ap_ref, '关节角度', fontCN, fontEN, fs, lw, [180 180 800 250], false);

% 只有最后一个显示时间轴
plot_joint(time, L_ar_real, L_ar_ref, '关节角度', fontCN, fontEN, fs, lw, [200 200 800 250], true);

%% ================= 函数定义 =================
function plot_joint(time, real, ref, ylab, fontCN, fontEN, fs, lw, pos, show_xlabel)

    figure('Color','w','Position',pos);

    plot(time, real, 'b', 'LineWidth', lw); hold on;
    plot(time, ref,  'r--', 'LineWidth', lw);

    % ===== Y轴 =====
    ylabel(['\fontname{',fontCN,'}',ylab,' ', ...
            '\fontname{',fontEN,'}(rad)'], ...
            'FontSize', fs, 'Interpreter','tex');

    % ===== X轴（是否显示）=====
    if show_xlabel
        xlabel(['\fontname{',fontCN,'}时间 ', ...
                '\fontname{',fontEN,'}(s)'], ...
                'FontSize', fs, 'Interpreter','tex');
    else
        % 不显示标签（但保留刻度）
        xlabel('');
    end

    % ===== legend =====
    legend({ ...
        ['\fontname{',fontCN,'}实际值'], ...
        ['\fontname{',fontCN,'}参考值']}, ...
        'FontSize', fs, 'Interpreter','tex');

    grid on; box on;
    xlim([23 33]);

    set(gca, ...
        'FontName', fontEN, ...
        'FontSize', fs, ...
        'LineWidth', 0.5);
end