clc; clear; close all;

%% =========================
% 1. 文件路径
%% =========================
file_path = 'data/humanoutput.txt';

%% =========================
% 2. 读取数据
%% =========================
tbl = readtable(file_path, ...
    'FileType', 'text', ...
    'Delimiter', ' ', ...
    'MultipleDelimsAsOne', true, ...
    'VariableNamingRule', 'preserve');

var_names = tbl.Properties.VariableNames;

%% =========================
% 3. 时间轴
%% =========================
if any(strcmp(var_names, 'time'))
    t = tbl.time;
else
    t = (0:height(tbl)-1)';
end
t = t - t(1);

%% =========================
% 4. 定义父子关系
%    child 相对 parent 计算局部关节角
%% =========================
joint_pairs = {
    'Left_Hip',      'Pelvis';
    'Right_Hip',     'Pelvis';
    'Spine1',        'Pelvis';
    'Left_Knee',     'Left_Hip';
    'Right_Knee',    'Right_Hip';
    'Spine2',        'Spine1';
    'Left_Ankle',    'Left_Knee';
    'Right_Ankle',   'Right_Knee';
    'Spine3',        'Spine2';
    'Left_Foot',     'Left_Ankle';
    'Right_Foot',    'Right_Ankle';
    'Neck',          'Spine3';
    'Left_Collar',   'Spine3';
    'Right_Collar',  'Spine3';
    'Head',          'Neck';
    'Left_Shoulder', 'Left_Collar';
    'Right_Shoulder','Right_Collar';
    'Left_Elbow',    'Left_Shoulder';
    'Right_Elbow',   'Right_Shoulder';
    'Left_Wrist',    'Left_Elbow';
    'Right_Wrist',   'Right_Elbow';
    'Left_Hand',     'Left_Wrist';
    'Right_Hand',    'Right_Wrist';
    };

n_pairs = size(joint_pairs, 1);
N = length(t);

%% =========================
% 5. 存储局部欧拉角
%    euler_angles.(joint) = [roll pitch yaw]
%% =========================
euler_angles = struct();

for i = 1:n_pairs
    child  = joint_pairs{i,1};
    parent = joint_pairs{i,2};

    % 列名
    child_cols = {sprintf('%s_qx', child), sprintf('%s_qy', child), ...
                  sprintf('%s_qz', child), sprintf('%s_qw', child)};
    parent_cols = {sprintf('%s_qx', parent), sprintf('%s_qy', parent), ...
                   sprintf('%s_qz', parent), sprintf('%s_qw', parent)};

    % 检查列是否存在
    if ~all(ismember(child_cols, var_names)) || ~all(ismember(parent_cols, var_names))
        warning('关节 %s 或其父关节 %s 的四元数字段缺失，跳过。', child, parent);
        continue;
    end

    % 提取四元数
    qc = [tbl.(child_cols{1}), tbl.(child_cols{2}), tbl.(child_cols{3}), tbl.(child_cols{4})];
    qp = [tbl.(parent_cols{1}), tbl.(parent_cols{2}), tbl.(parent_cols{3}), tbl.(parent_cols{4})];

    % 归一化
    qc = normalize_quat(qc);
    qp = normalize_quat(qp);

    % 相对旋转：q_rel = q_parent^{-1} * q_child
    q_rel = quat_multiply(quat_conjugate(qp), qc);

    % 转欧拉角（XYZ顺序）
    eul = quat_to_euler_xyz(q_rel);   % rad

    euler_angles.(child) = eul;
end

%% =========================
% 6. 可选：选择要画的关节
%% =========================
plot_joints = { ...
    'Left_Hip', 'Right_Hip', ...
    'Left_Knee', 'Right_Knee', ...
    'Left_Ankle', 'Right_Ankle', ...
    'Left_Shoulder', 'Right_Shoulder', ...
    'Left_Elbow', 'Right_Elbow', ...
    'Left_Wrist', 'Right_Wrist'};

%% =========================
% 7. 绘制每个关节的三轴角度
%% =========================
for i = 1:length(plot_joints)
    joint = plot_joints{i};

    if ~isfield(euler_angles, joint)
        warning('关节 %s 没有可用的欧拉角数据。', joint);
        continue;
    end

    eul_deg = rad2deg(euler_angles.(joint));

    figure('Color','w','Name',joint,'Position',[100 100 900 700]);

    subplot(3,1,1);
    plot(t, eul_deg(:,1), 'LineWidth', 1.5);
    grid on;
    ylabel('X (deg)', 'FontName', 'Times New Roman', 'FontSize', 12);
    title(strrep(joint, '_', '\_'), 'FontName', 'Times New Roman', 'FontSize', 14);

    subplot(3,1,2);
    plot(t, eul_deg(:,2), 'LineWidth', 1.5);
    grid on;
    ylabel('Y (deg)', 'FontName', 'Times New Roman', 'FontSize', 12);

    subplot(3,1,3);
    plot(t, eul_deg(:,3), 'LineWidth', 1.5);
    grid on;
    ylabel('Z (deg)', 'FontName', 'Times New Roman', 'FontSize', 12);
    xlabel('时间 (s)', 'FontName', 'SimSun', 'FontSize', 14);

    set(findall(gcf,'Type','axes'), 'FontName', 'Times New Roman', 'FontSize', 11);
end

%% =========================
% 8. 也可以把所有关节画成总览图
%% =========================
joint_fields = fieldnames(euler_angles);
n = length(joint_fields);

figure('Color','w','Position',[100 100 1400 900]);
rows = ceil(n / 4);
cols = 4;

for i = 1:n
    subplot(rows, cols, i);
    eul_deg = rad2deg(euler_angles.(joint_fields{i}));

    plot(t, eul_deg(:,1), 'LineWidth', 1.0); hold on;
    plot(t, eul_deg(:,2), 'LineWidth', 1.0);
    plot(t, eul_deg(:,3), 'LineWidth', 1.0); hold off;
    grid on;

    title(strrep(joint_fields{i}, '_', '\_'), ...
        'FontName', 'Times New Roman', ...
        'FontSize', 11);

    if i == 1
        legend({'X','Y','Z'}, 'Location', 'best');
    end

    set(gca, 'FontName', 'Times New Roman', 'FontSize', 10);
end

sgtitle('人体局部关节角曲线（由四元数相对变换恢复）', ...
    'FontName', 'SimSun', 'FontSize', 16);

%% =========================
% 9. 辅助函数
%% =========================
function qn = normalize_quat(q)
    n = sqrt(sum(q.^2, 2));
    qn = q ./ n;
end

function qc = quat_conjugate(q)
    % q = [x y z w]
    qc = [-q(:,1), -q(:,2), -q(:,3), q(:,4)];
end

function q = quat_multiply(q1, q2)
    % 输入格式: [x y z w]
    x1 = q1(:,1); y1 = q1(:,2); z1 = q1(:,3); w1 = q1(:,4);
    x2 = q2(:,1); y2 = q2(:,2); z2 = q2(:,3); w2 = q2(:,4);

    x = w1.*x2 + x1.*w2 + y1.*z2 - z1.*y2;
    y = w1.*y2 - x1.*z2 + y1.*w2 + z1.*x2;
    z = w1.*z2 + x1.*y2 - y1.*x2 + z1.*w2;
    w = w1.*w2 - x1.*x2 - y1.*y2 - z1.*z2;

    q = [x y z w];
end

function eul = quat_to_euler_xyz(q)
    % 输入 q = [x y z w]
    x = q(:,1); y = q(:,2); z = q(:,3); w = q(:,4);

    % XYZ intrinsic / 等价常见 roll-pitch-yaw 近似
    t0 = 2.*(w.*x + y.*z);
    t1 = 1 - 2.*(x.^2 + y.^2);
    roll = atan2(t0, t1);

    t2 = 2.*(w.*y - z.*x);
    t2 = max(min(t2, 1), -1);
    pitch = asin(t2);

    t3 = 2.*(w.*z + x.*y);
    t4 = 1 - 2.*(y.^2 + z.^2);
    yaw = atan2(t3, t4);

    eul = [roll, pitch, yaw];
end