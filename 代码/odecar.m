function dz = odecar(t, z, fv, fphi, l)
%% 模型微分方程：输入 y 向量包括车身角度和车身中心位置坐标，输出 dy 是相应的导数
% x = z(1); y = z(2)
theta = z(3);                    % [deg  ] 车身角度
v = fv(t);                       % [m/s  ] 沿车身方向的速度
phi = fphi(t);                   % [deg  ] 前轮转角，由方向盘控制

dx = v*cosd(theta);              % [m/s  ] 后轴中点水平速度
dy = v*sind(theta);              % [m/s  ] 后轴中点竖直速度
dtheta = rad2deg(v/l*tand(phi)); % [deg/s] 车身角速度

dz = [dx; dy; dtheta];