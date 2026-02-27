clc; clear; close all;

%% ============== 基本参数 ==============
T  = 1000;             % 时间步数，对应 10 s（dt=0.01）
dt = 0.01;             % 采样时间
t  = (0:T-1)*dt;       % 时间轴 0~10 s
numEE = 4;             % 4 个末端：1-LH, 2-RH, 3-LF, 4-RF

P_human = zeros(T, numEE, 3);
P_robot = zeros(T, numEE, 3);

%% ============== 生成人体末端轨迹 ==============
for i = 1:numEE
    freq1 = 0.5 + 0.1*i;
    freq2 = 0.2 + 0.05*i;
    amp   = 0.25 + 0.05*i;

    P_human(:,i,1) = amp*sin(2*pi*freq1*t) + 0.03*sin(2*pi*freq2*t);
    P_human(:,i,2) = amp*cos(2*pi*freq1*t);
    P_human(:,i,3) = 0.8 + 0.08*sin(2*pi*0.3*t);
end

%% ============== 误差上升因子：从 0 抖动式长大 ==============
Tramp       = 2.5;                      % 误差上升时间（秒），可根据需要调
s           = min(t/Tramp, 1);          % 0 -> 1
amp_growth  = s'.^0.8;                  % 稍微前快后慢的上升（抖动更自然）

%% ============== 生成机器人末端轨迹（控制左右手误差大小） ==============
for i = 1:numEE
    
    % 小比例误差
    scale = 1 + 0.005*randn;
    
    % 低频漂移
    drift = 0.005*sin(2*pi*0.15*t)'.*randn(1,3);  % T x 3
    
    % 动作相关误差：右手略大，左手略小，脚更小
    mag = sqrt(sum(squeeze(P_human(:,i,:)).^2,2));
    mag = mag / max(mag);               % 0~1
    mag = mag(:);                       % T x 1
    
    if i == 1          % LH
        action_noise = 0.010*(mag .* randn(T,1)) * ones(1,3);
    elseif i == 2      % RH
        action_noise = 0.012*(mag .* randn(T,1)) * ones(1,3);
    else               % 脚（更小一点）
        action_noise = 0.008*(mag .* randn(T,1)) * ones(1,3);
    end
    
    % 随机小扰动
    noise = 0.003*randn(T,3);
    
    % —— 关键：误差幅值随时间“抖动上升” ——
    P_robot(:,i,:) = scale*squeeze(P_human(:,i,:)) ...
                     + amp_growth .* drift ...
                     + amp_growth .* action_noise ...
                     + amp_growth .* noise;
end

% 保证初始时刻完全对齐：t=0 时误差为 0
P_robot(1,:,:) = P_human(1,:,:);

%% ============== 计算末端欧氏误差（单位：m） ==============
err = zeros(T, numEE);
for i = 1:numEE
    diff = squeeze(P_robot(:, i, :) - P_human(:, i, :));
    err(:, i) = sqrt(sum(diff.^2, 2));
end

%% ============== 平滑并转为 cm ==============
win = 15;
err_smooth      = movmean(err, win, 1);
err_smooth(1,:) = 0;                % 确保 t=0 误差为 0
err_cm          = err_smooth * 100; % m -> cm

%% ============== 图1：误差时间曲线 ==============
figure('Color','w'); 
hold on;

cmap = lines(4);

plot(t, err_cm(:,1), '-',  'LineWidth',2.0, 'Color',cmap(1,:)); % LH
plot(t, err_cm(:,2), '--', 'LineWidth',2.0, 'Color',cmap(2,:)); % RH
plot(t, err_cm(:,3), '-.', 'LineWidth',1.3, 'Color',cmap(3,:)); % LF
plot(t, err_cm(:,4), ':',  'LineWidth',1.3, 'Color',cmap(4,:)); % RF

xlabel('Time (s)');
ylabel('Position error (cm)');
legend({'LH','RH','LF','RF'}, 'Location','northeast');

xlim([0 10]);
ylim([0 ceil(max(err_cm(:))*1.1)]);

grid on;
set(gca, ...
    'Box','on', ...          % 四边框
    'LineWidth',0.5, ...     % 细边框
    'FontName','Times New Roman', ...
    'FontSize',10);

% print('-depsc','EndEffErr_Time.eps');

%% ============== 图2：MSE 柱状图（带数值标注） ==============
MSE_cm2 = mean(err_cm.^2, 1);   % 1 x 4

figure('Color','w');
b = bar(MSE_cm2, 0.6);
b.FaceColor = 'flat';

cmap = lines(4);
for i = 1:4
    b.CData(i,:) = cmap(i,:);
end

set(gca, 'XTick', 1:4, ...
         'XTickLabel', {'LH','RH','LF','RF'}, ...
         'FontName','Times New Roman', ...
         'FontSize',10, ...
         'LineWidth',0.5, ...
         'Box','on');

ylabel('MSE (cm^2)');

grid on;

% 自动设置 y 轴范围，留出顶部空间
ymax = max(MSE_cm2);
ylim([0 ymax*1.25]);

% 在柱顶添加数值标注
xtips  = b.XEndPoints;
ytips  = b.YEndPoints;
labels = arrayfun(@(x) sprintf('%.2f', x), MSE_cm2, 'UniformOutput', false);

text(xtips, ytips, labels, ...
    'HorizontalAlignment','center', ...
    'VerticalAlignment','bottom', ...
    'FontName','Times New Roman', ...
    'FontSize',9);

% print('-depsc','EndEffErr_MSE.eps');