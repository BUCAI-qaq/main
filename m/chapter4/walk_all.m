clear; clc; close all;

%% 1 读取数据
filename = '2025-12-25_20-35-35_Walk-8_000_Walk_GMR_2026-03-15_10-37-00_joint_log.txt';
data = readtable(filename);

%% 2 时间
time = data.time;

%% 3 选择时间区间
idx = (time >= 23) & (time <= 33);
time = time(idx);

%% 左腿
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

%% 右腿
R_hr_real = data.right_hip_roll_joint_actual(idx);
R_hr_ref  = data.right_hip_roll_joint_ref(idx);

R_hp_real = data.right_hip_pitch_joint_actual(idx);
R_hp_ref  = data.right_hip_pitch_joint_ref(idx);

R_hy_real = data.right_hip_yaw_joint_actual(idx);
R_hy_ref  = data.right_hip_yaw_joint_ref(idx);

R_kn_real = data.right_knee_joint_actual(idx);
R_kn_ref  = data.right_knee_joint_ref(idx);

R_ap_real = data.right_ankle_pitch_joint_actual(idx);
R_ap_ref  = data.right_ankle_pitch_joint_ref(idx);

R_ar_real = data.right_ankle_roll_joint_actual(idx);
R_ar_ref  = data.right_ankle_roll_joint_ref(idx);

%% 误差
L_hr_err = L_hr_ref - L_hr_real;
L_hp_err = L_hp_ref - L_hp_real;
L_hy_err = L_hy_ref - L_hy_real;
L_kn_err = L_kn_ref - L_kn_real;
L_ap_err = L_ap_ref - L_ap_real;
L_ar_err = L_ar_ref - L_ar_real;

R_hr_err = R_hr_ref - R_hr_real;
R_hp_err = R_hp_ref - R_hp_real;
R_hy_err = R_hy_ref - R_hy_real;
R_kn_err = R_kn_ref - R_kn_real;
R_ap_err = R_ap_ref - R_ap_real;
R_ar_err = R_ar_ref - R_ar_real;

%% 绘图参数
lw_main   = 1.2;    % Real / Ref 线宽
lw_err    = 1.0;    % Error 线宽
alpha_val = 0.15;   % 误差带透明度
win       = 25;     % movstd窗口
min_band  = 0.005;  % 最小带宽

% 配色
c_real = [0.0000 0.4470 0.7410];   % 蓝色 Real
c_ref  = [0.8500 0.3250 0.0980];   % 红色 Ref
c_err  = [0.4660 0.6740 0.1880];   % 绿色 Error
c_band = [0.4660 0.6740 0.1880];   % 误差带

%% 打包数据
L_real = {L_hr_real, L_hp_real, L_hy_real, L_kn_real, L_ap_real, L_ar_real};
L_ref  = {L_hr_ref,  L_hp_ref,  L_hy_ref,  L_kn_ref,  L_ap_ref,  L_ar_ref};
L_err  = {L_hr_err,  L_hp_err,  L_hy_err,  L_kn_err,  L_ap_err,  L_ar_err};

R_real = {R_hr_real, R_hp_real, R_hy_real, R_kn_real, R_ap_real, R_ar_real};
R_ref  = {R_hr_ref,  R_hp_ref,  R_hy_ref,  R_kn_ref,  R_ap_ref,  R_ar_ref};
R_err  = {R_hr_err,  R_hp_err,  R_hy_err,  R_kn_err,  R_ap_err,  R_ar_err};

joint_labels = { ...
    'Hip Roll Joint (rad)', ...
    'Hip Pitch Joint (rad)', ...
    'Hip Yaw Joint (rad)', ...
    'Knee Joint (rad)', ...
    'Ankle Pitch Joint (rad)', ...
    'Ankle Roll Joint (rad)'};

%% ================= 左腿 =================
figure(1); clf;
set(gcf,'Color','w','Position',[100 50 780 1050])

for i = 1:6
    real_i = L_real{i};
    ref_i  = L_ref{i};
    err_i  = L_err{i};

    band = movstd(err_i, win);
    band = max(band, min_band);

    upper = err_i + band;
    lower = err_i - band;

    subplot(6,1,i)

    %% 左轴：Real / Ref
    yyaxis left
    plot(time, real_i, 'Color', c_real, 'LineWidth', lw_main); hold on
    plot(time, ref_i, '--', 'Color', c_ref, 'LineWidth', lw_main)
    ylabel(joint_labels{i})
    xlim([23 33])
    grid on
    box on
    ax = gca;
    ax.YColor = 'k';
    ax.XColor = 'k';

    %% 右轴：Error + Error Band
    yyaxis right
    fill([time; flipud(time)], ...
         [upper; flipud(lower)], ...
         c_band, ...
         'FaceAlpha', alpha_val, ...
         'EdgeColor', 'none'); hold on
    plot(time, err_i, 'Color', c_err, 'LineWidth', lw_err)
    yline(0, 'k-', 'LineWidth', 0.6)
    ylabel('Error (rad)')
    ax = gca;
    ax.YColor = 'k';

    if i == 1
        legend('Real', 'Ref', 'Error band', 'Error', 'Location', 'northeast');
    end
    if i == 6
        xlabel('Time (s)')
    end

    set(gca, 'FontName', 'Times New Roman', 'FontSize', 10)
end

%% ================= 右腿 =================
figure(2); clf;
set(gcf,'Color','w','Position',[920 50 780 1050])

for i = 1:6
    real_i = R_real{i};
    ref_i  = R_ref{i};
    err_i  = R_err{i};

    band = movstd(err_i, win);
    band = max(band, min_band);

    upper = err_i + band;
    lower = err_i - band;

    subplot(6,1,i)

    %% 左轴：Real / Ref
    yyaxis left
    plot(time, real_i, 'Color', c_real, 'LineWidth', lw_main); hold on
    plot(time, ref_i, '--', 'Color', c_ref, 'LineWidth', lw_main)
    ylabel(joint_labels{i})
    xlim([23 33])
    grid on
    box on
    ax = gca;
    ax.YColor = 'k';
    ax.XColor = 'k';

    %% 右轴：Error + Error Band
    yyaxis right
    fill([time; flipud(time)], ...
         [upper; flipud(lower)], ...
         c_band, ...
         'FaceAlpha', alpha_val, ...
         'EdgeColor', 'none'); hold on
%     plot(time, err_i, 'Color', c_err, 'LineWidth', lw_err)
    
    yline(0, 'k-', 'LineWidth', 0.6)
    ylabel('Error (rad)')
    ax = gca;
    ax.YColor = 'k';

    if i == 1
        legend('Real', 'Ref', 'Error band', 'Error', 'Location', 'northeast');
    end
    if i == 6
        xlabel('Time (s)')
    end

    set(gca, 'FontName', 'Times New Roman', 'FontSize', 10)
end