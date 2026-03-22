clear; clc; close all;

%% 读取数据
tau_data         = readmatrix('time_tau_2026-03-18_16-10-53.txt');
m_tauc_data      = readmatrix('time_m_tauc_2026-03-18_16-10-53.txt');
tau_applied_data = readmatrix('time_tau_applied_2026-03-18_16-10-53.txt');

time = tau_data(:,1);

tau         = tau_data(:,2:end);
m_tauc      = m_tauc_data(:,2:end);
tau_applied = tau_applied_data(:,2:end);

%% ===== 时间筛选 =====
idx = (time >= 0) & (time <= 5);

time = time(idx);
tau = tau(idx,:);
m_tauc = m_tauc(idx,:);
tau_applied = tau_applied(idx,:);

[num_steps, num_joints] = size(tau);

%% 电机扭矩限制
m_tau_limit = [
    37.5, 20, 20, 24, 24, 10,...
    37.5, 20, 20, 24, 24, 10,...
    20, 20,...
    25, 10, 10, 10, 10,...
    25, 10, 10, 10, 10
];

c = 2.0;
limit = m_tau_limit * c;
limit_mat = repmat(limit, num_steps, 1);

%% 计算 m_clip
m_clip = min(max(m_tauc, -limit_mat), limit_mat);

%% 耦合电机对
motor_pairs = [
    4,5;
    10,11
];

%% ===== 单独绘图（关键修改）=====
for k = 1:size(motor_pairs, 1)
    pair = motor_pairs(k, :);

    for s = 1:2
        j = pair(s);

        figure('Name', sprintf('Motor %d', j));
        hold on;

        h1 = plot(time, tau(:,j), 'LineWidth', 1.8);
        h2 = plot(time, m_tauc(:,j), '--', 'LineWidth', 1.8);
        h3 = plot(time, m_clip(:,j), ':', 'LineWidth', 2.2);
        h4 = plot(time, tau_applied(:,j), '-.', 'LineWidth', 1.8);

    h5 = yline(limit(j), ':', 'LineWidth', 2);
    h6 = yline(-limit(j), ':', 'LineWidth', 2);

        grid on;
        xlabel('Time (s)');
        if ismember(j, [4,10])
            ylabel('Knee torque (N·m)');
        elseif ismember(j, [5,11])
            ylabel('Ankle torque (N·m)');
        else
            ylabel('Torque (N·m)');
        end
        

lgd = legend([h1 h2 h3 h4 h5], ...
    {'$\tau_j$', '$\tau_m$', '$\tau_m^{clip}$', '$\tau_j^{applied}$', '$\tau_m^{limit}$'}, ...
    'Interpreter','latex', ...
    'Location','best');

lgd.FontSize = 12;        % 默认10，可以稍微大一点
lgd.Box = 'on';           % 加框更清晰

    end
end