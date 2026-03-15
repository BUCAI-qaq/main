clear; clc; close all;

%% 1 读取数据
filename = '2025-12-25_20-35-35_Walk-8_000_Walk_GMR_2026-03-15_10-37-00_joint_log.txt';
data = readtable(filename);

%% 2 时间
time = data.time;

%% 3 选择时间区间
idx = (time >= 23) & (time <= 33);
time = time(idx);

%% 4 Hip Pitch
L_hip_real = data.left_hip_pitch_joint_actual(idx);
L_hip_ref  = data.left_hip_pitch_joint_ref(idx);
R_hip_real = data.right_hip_pitch_joint_actual(idx);
R_hip_ref  = data.right_hip_pitch_joint_ref(idx);

%% 5 Knee
L_knee_real = data.left_knee_joint_actual(idx);
L_knee_ref  = data.left_knee_joint_ref(idx);
R_knee_real = data.right_knee_joint_actual(idx);
R_knee_ref  = data.right_knee_joint_ref(idx);

%% 6 Ankle Pitch
L_ankle_real = data.left_ankle_pitch_joint_actual(idx);
L_ankle_ref  = data.left_ankle_pitch_joint_ref(idx);
R_ankle_real = data.right_ankle_pitch_joint_actual(idx);
R_ankle_ref  = data.right_ankle_pitch_joint_ref(idx);

%% 绘图参数
lw = 1.0;

%% ================= 左腿 =================
figure(1); clf;

subplot(3,1,1)
plot(time,L_hip_real,'b','LineWidth',lw); hold on
plot(time,L_hip_ref,'r--','LineWidth',lw)
ylabel('Angle (rad)')
title('Hip Pitch')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(3,1,2)
plot(time,L_knee_real,'b','LineWidth',lw); hold on
plot(time,L_knee_ref,'r--','LineWidth',lw)
ylabel('Angle (rad)')
title('Knee')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(3,1,3)
plot(time,L_ankle_real,'b','LineWidth',lw); hold on
plot(time,L_ankle_ref,'r--','LineWidth',lw)
xlabel('Time (s)')
ylabel('Angle (rad)')
title('Ankle Pitch')
legend('Real','Ref')
grid on; box on; xlim([23 33])

sgtitle('Left Leg Joint Tracking')

set(findall(gcf,'-property','FontName'),'FontName','Times New Roman')
set(findall(gcf,'-property','FontSize'),'FontSize',11)

%% ================= 右腿 =================
figure(2); clf;

subplot(3,1,1)
plot(time,R_hip_real,'b','LineWidth',lw); hold on
plot(time,R_hip_ref,'r--','LineWidth',lw)
ylabel('Angle (rad)')
title('Hip Pitch')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(3,1,2)
plot(time,R_knee_real,'b','LineWidth',lw); hold on
plot(time,R_knee_ref,'r--','LineWidth',lw)
ylabel('Angle (rad)')
title('Knee')
legend('Real','Ref')
grid on; box on; xlim([23 33])

subplot(3,1,3)
plot(time,R_ankle_real,'b','LineWidth',lw); hold on
plot(time,R_ankle_ref,'r--','LineWidth',lw)
xlabel('Time (s)')
ylabel('Angle (rad)')
title('Ankle Pitch')
legend('Real','Ref')
grid on; box on; xlim([23 33])

sgtitle('Right Leg Joint Tracking')

set(findall(gcf,'-property','FontName'),'FontName','Times New Roman')
set(findall(gcf,'-property','FontSize'),'FontSize',11)