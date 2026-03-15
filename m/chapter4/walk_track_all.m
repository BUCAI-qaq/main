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

%% 绘图参数
lw = 1.0;

%% ================= 左腿 =================
figure(1); clf;
set(gcf,'Color','w','Position',[100 50 700 1000])

subplot(6,1,1)
plot(time,L_hr_real,'b','LineWidth',lw); hold on
plot(time,L_hr_ref,'r--','LineWidth',lw)
ylabel('Hip Roll Joint (rad)')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(6,1,2)
plot(time,L_hp_real,'b','LineWidth',lw); hold on
plot(time,L_hp_ref,'r--','LineWidth',lw)
ylabel('Hip Pitch Joint (rad)')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(6,1,3)
plot(time,L_hy_real,'b','LineWidth',lw); hold on
plot(time,L_hy_ref,'r--','LineWidth',lw)
ylabel('Hip Yaw Joint (rad)')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(6,1,4)
plot(time,L_kn_real,'b','LineWidth',lw); hold on
plot(time,L_kn_ref,'r--','LineWidth',lw)
ylabel('Knee Joint (rad)')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(6,1,5)
plot(time,L_ap_real,'b','LineWidth',lw); hold on
plot(time,L_ap_ref,'r--','LineWidth',lw)
ylabel('Ankle Pitch Joint (rad)')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(6,1,6)
plot(time,L_ar_real,'b','LineWidth',lw); hold on
plot(time,L_ar_ref,'r--','LineWidth',lw)
ylabel('Ankle Roll Joint (rad)')
xlabel('Time (s)')
legend('Real','Ref')
grid on; box on; xlim([23 33])


%% ================= 右腿 =================
figure(2); clf;
set(gcf,'Color','w','Position',[850 50 700 1000])

subplot(6,1,1)
plot(time,R_hr_real,'b','LineWidth',lw); hold on
plot(time,R_hr_ref,'r--','LineWidth',lw)
ylabel('Hip Roll Joint (rad)')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(6,1,2)
plot(time,R_hp_real,'b','LineWidth',lw); hold on
plot(time,R_hp_ref,'r--','LineWidth',lw)
ylabel('Hip Pitch Joint (rad)')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(6,1,3)
plot(time,R_hy_real,'b','LineWidth',lw); hold on
plot(time,R_hy_ref,'r--','LineWidth',lw)
ylabel('Hip Yaw Joint (rad)')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(6,1,4)
plot(time,R_kn_real,'b','LineWidth',lw); hold on
plot(time,R_kn_ref,'r--','LineWidth',lw)
ylabel('Knee Joint (rad)')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(6,1,5)
plot(time,R_ap_real,'b','LineWidth',lw); hold on
plot(time,R_ap_ref,'r--','LineWidth',lw)
ylabel('Ankle Pitch Joint (rad)')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(6,1,6)
plot(time,R_ar_real,'b','LineWidth',lw); hold on
plot(time,R_ar_ref,'r--','LineWidth',lw)
ylabel('Ankle Roll Joint (rad)')
xlabel('Time (s)')
legend('Real','Ref')
grid on; box on; xlim([23 33])


%% 统一字体
set(findall(0,'-property','FontName'),'FontName','Times New Roman')
set(findall(0,'-property','FontSize'),'FontSize',10)