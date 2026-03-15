clear; clc; close all;

%% 1. 读取数据
filename = '2025-12-25_20-35-35_Walk-8_000_Walk_GMR_2026-03-15_10-37-00_joint_log.txt';   % 改成你的txt文件名
data = readtable(filename);

%% 2. 读取时间
time = data.time;

%% 3. 提取实际关节角
L_hip_pitch  = data.left_hip_pitch_joint_actual;
L_knee       = data.left_knee_joint_actual;
L_ankle_pitch= data.left_ankle_pitch_joint_actual;

R_hip_pitch  = data.right_hip_pitch_joint_actual;
R_knee       = data.right_knee_joint_actual;
R_ankle_pitch= data.right_ankle_pitch_joint_actual;

%% 4. 绘图
figure('Color','w','Position',[100 100 900 700]);

subplot(3,1,1)
plot(time, L_hip_pitch, 'b','LineWidth',1.5); hold on
plot(time, R_hip_pitch, 'r','LineWidth',1.5)
ylabel('Hip Pitch (rad)')
legend('Left','Right')
grid on

subplot(3,1,2)
plot(time, L_knee, 'b','LineWidth',1.5); hold on
plot(time, R_knee, 'r','LineWidth',1.5)
ylabel('Knee (rad)')
legend('Left','Right')
grid on

subplot(3,1,3)
plot(time, L_ankle_pitch, 'b','LineWidth',1.5); hold on
plot(time, R_ankle_pitch, 'r','LineWidth',1.5)
ylabel('Ankle Pitch (rad)')
xlabel('Time (s)')
legend('Left','Right')
grid on

sgtitle('Actual Joint Angles')