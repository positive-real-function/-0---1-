%% qq群：765384772

clc; clear

% 特斯拉 Model S 尺寸参数
l = 2.959; % 轴距	2,959 mm（116.5英寸）
L = 4.976; % 长度	4,976 mm（195.9英寸）
W = 1.943; % 宽度 1,963 mm（ 77.3英寸）

[z0, fv, fphi, t, xb, yb] = testcase('Parking');
% [z0, fv, fphi, t, xb, yb] = testcase('Circle');
% [z0, fv, fphi, t, xb, yb] = testcase('Tesla'); 

%% 计算机模拟车辆运动
figure('position',[50,50,900, 600])
% 绘制车辆和轨迹
h1 = plotcar(0, 0, 0, 0, L, W, l); hold on
h2 = plot(   0, 0, ':m', 'linewidth',2);
h3 = plot(-l/2, 0, ':b', 'linewidth',2);
if ~isempty(xb); plot(xb, yb, '--k', 'linewidth',2); end
axis image


% 求解微分方程数值解，得到任意时刻车身的转角 phi(t) 和车身中心位置 (xc(t), yc(t))
[t, z] = ode45(@odecar, t, z0, [], fv, fphi, l);
theta = z(:,3); x = z(:,1); y = z(:,2);

% 动态绘图
for i = 1:100:length(t)
    [~,xv,yv] = plotcar(x(i),y(i), theta(i), fphi(t(i)), L, W, l, h1);
    set(h2, 'XData', x(1:i)+l/2*cosd(theta(1:i)),'YData', y(1:i)+l/2*sind(theta(1:i)));
    set(h3, 'XData', x(1:i),'YData', y(1:i));
    drawnow
    
    % 超出边界则停止动画并输出停止时刻
    if ~isempty(xb) & any(~inpolygon(xv,yv,xb,yb)); break; end
end

figure
subplot(1,2,1); plot(t,fphi(t)*10); 
xlabel('时间(s)'); ylabel('方向盘角度(deg)')

subplot(1,2,2); plot(t,fv(t));      
xlabel('时间(s)'); ylabel('后车轮速度(m/s)')