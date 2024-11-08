function [h, xv, yv] = plotcar(x, y, theta, phi, L, W, l, h)
%% 通过变标系旋转和平移变换绘制车身和车胎

% 车身轮廓
xv = L/2*[1.00, 0.95, 0.85,-0.90,-1.00,-1.00,-0.90, 0.85, 0.95, 1.00]' + l/2;
yv = W/2*[0.00, 0.60, 1.00, 1.00, 0.80,-0.80,-1.00,-1.00,-0.60, 0.00]';

% 车胎轮廓
xt = L/10*[1.00, 0.98, 0.95,-0.95,-0.98,-1.00,-1.00,-0.98,-0.95, 0.95, 0.98, 1.00, 1.00]';
yt = W/10*[0.60, 0.90, 1.00, 1.00, 0.90, 0.60,-0.60,-0.90,-1.00,-1.00,-0.90,-0.60, 0.60]';

% 前车胎：旋转车胎并平移至前车胎位置
[xf, yf] = rotxyd(xt, yt, 0, 0, phi);
xf = xf + [1, 1]*l;
yf = yf + [1,-1]*(W/2-W/6);

% 后车胎：平移至前后胎位置
xb = xt;
yb = yt + [1,-1]*(W/2-W/6);

% 旋转整车（包括车身、前后车胎）
[xv,yv] = rotxyd(xv, yv, 0, 0, theta);
[xf,yf] = rotxyd(xf, yf, 0, 0, theta);
[xb,yb] = rotxyd(xb, yb, 0, 0, theta);

% 平移整车（包括车身、前后车胎）
xv = xv + x; yv = yv + y;
xb = [xb(:,1); NaN; xb(:,2)] + x;
yb = [yb(:,1); NaN; yb(:,2)] + y;
xf = [xf(:,1); NaN; xf(:,2)] + x;
yf = [yf(:,1); NaN; yf(:,2)] + y;

% 绘制整车（包括车身、前后车胎）
if nargin<8
   h = plot(xv, yv,'k',xb, yb,'b', xf, yf, 'r', 'linewidth',2);
else
   set(h(1), 'XData', xv, 'YData', yv);
   set(h(2), 'XData', xb, 'YData', yb);
   set(h(3), 'XData', xf, 'YData', yf);
end

