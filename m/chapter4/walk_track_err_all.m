clear; clc; close all;

%% 1. 读取数据
filename = '2025-12-25_20-35-35_Walk-8_000_Walk_GMR_2026-03-15_10-37-00_joint_log.txt';
data = readtable(filename);

%% 2. 时间
time = data.time;

%% 3. 选择时间区间
idx = (time >= 23) & (time <= 33);
time = time(idx);

%% 4. 左腿误差 (ref - real)
L_hr_err = data.left_hip_roll_joint_ref(idx)    - data.left_hip_roll_joint_actual(idx);
L_hp_err = data.left_hip_pitch_joint_ref(idx)   - data.left_hip_pitch_joint_actual(idx);
L_hy_err = data.left_hip_yaw_joint_ref(idx)     - data.left_hip_yaw_joint_actual(idx);
L_kn_err = data.left_knee_joint_ref(idx)        - data.left_knee_joint_actual(idx);
L_ap_err = data.left_ankle_pitch_joint_ref(idx) - data.left_ankle_pitch_joint_actual(idx);
L_ar_err = data.left_ankle_roll_joint_ref(idx)  - data.left_ankle_roll_joint_actual(idx);

%% 5. 右腿误差 (ref - real)
R_hr_err = data.right_hip_roll_joint_ref(idx)    - data.right_hip_roll_joint_actual(idx);
R_hp_err = data.right_hip_pitch_joint_ref(idx)   - data.right_hip_pitch_joint_actual(idx);
R_hy_err = data.right_hip_yaw_joint_ref(idx)     - data.right_hip_yaw_joint_actual(idx);
R_kn_err = data.right_knee_joint_ref(idx)        - data.right_knee_joint_actual(idx);
R_ap_err = data.right_ankle_pitch_joint_ref(idx) - data.right_ankle_pitch_joint_actual(idx);
R_ar_err = data.right_ankle_roll_joint_ref(idx)  - data.right_ankle_roll_joint_actual(idx);

%% 6. 参数设置
lw = 1.2;
alpha_val = 0.18;
win = 25;
min_band = 0.005;

colors = [
    0.0000 0.4470 0.7410   % Hip Roll
    0.8500 0.3250 0.0980   % Hip Pitch
    0.9290 0.6940 0.1250   % Hip Yaw
    0.4940 0.1840 0.5560   % Knee
    0.4660 0.6740 0.1880   % Ankle Pitch
    0.3010 0.7450 0.9330   % Ankle Roll
];

joint_names = {'Hip Roll','Hip Pitch','Hip Yaw','Knee','Ankle Pitch','Ankle Roll'};

errs_left  = {L_hr_err, L_hp_err, L_hy_err, L_kn_err, L_ap_err, L_ar_err};
errs_right = {R_hr_err, R_hp_err, R_hy_err, R_kn_err, R_ap_err, R_ar_err};

%% ================= Figure 1: 左腿 6x1 =================
figure(1); clf;
set(gcf, 'Color', 'w', 'Position', [100, 40, 800, 1100]);

for i = 1:6
    err = errs_left{i};
    c = colors(i,:);

    band = movstd(err, win);
    band = max(band, min_band);

    upper = err + band;
    lower = err - band;

    subplot(6,1,i); hold on;

    fill([time; flipud(time)], ...
         [upper; flipud(lower)], ...
         c, ...
         'FaceAlpha', alpha_val, ...
         'EdgeColor', 'none');

    plot(time, err, 'Color', c, 'LineWidth', lw);
    yline(0, 'k-', 'LineWidth', 0.8);

    ylabel([joint_names{i}, ' (rad)']);
    xlim([23 33]);
    grid on;
    box on;

    if i == 1
        title('Left Leg Joint Tracking Error');
    end
    if i == 6
        xlabel('Time (s)');
    end

    set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);
end

%% ================= Figure 2: 右腿 6x1 =================
figure(2); clf;
set(gcf, 'Color', 'w', 'Position', [950, 40, 800, 1100]);

for i = 1:6
    err = errs_right{i};
    c = colors(i,:);

    band = movstd(err, win);
    band = max(band, min_band);

    upper = err + band;
    lower = err - band;

    subplot(6,1,i); hold on;

    fill([time; flipud(time)], ...
         [upper; flipud(lower)], ...
         c, ...
         'FaceAlpha', alpha_val, ...
         'EdgeColor', 'none');

    plot(time, err, 'Color', c, 'LineWidth', lw);
    yline(0, 'k-', 'LineWidth', 0.8);

    ylabel([joint_names{i}, ' (rad)']);
    xlim([23 33]);
    grid on;
    box on;

    if i == 1
        title('Right Leg Joint Tracking Error');
    end
    if i == 6
        xlabel('Time (s)');
    end

    set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);
end