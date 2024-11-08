
%%qq群：765384772
% 轴距和车宽
L = 6.10; W = 5.54;

% 车胎轮廓
xt = 0.4*[0.60, 0.90, 1.00, 1.00, 0.90, 0.60,-0.60,-0.90,-1.00,-1.00,-0.90,-0.60 0.60]';
yt = 1.4*[1.00, 0.98, 0.95,-0.95,-0.98,-1.00,-1.00,-0.98,-0.95, 0.95, 0.98, 1.00 1.00]';

% 绘制后车轮
plot(xt+[-W, W]/2, yt-[L, L]/2,'b', [-W, W]/2, -[L,L]/2, 'b')
hold on

rlx0 = -W*[1,0.733,0.628]'/2; % 左前轮转向连杆坐标，第二个点为转轴点
rly0 =  L*[1,1.000,0.703]'/2; 

rrx0 =  W*[1,0.733,0.628]'/2; % 右前轮转向连杆坐标，第二个点为转轴点
rry0 =  L*[1,1.000,0.703]'/2;

% 绘制前轴
plot([rlx0(2); rrx0(2)], [rly0(2);rry0(2)], 'b');

% 绘制前轮转向曲轴
hr = plot([rlx0, rrx0], [rly0, rry0], 'o-r', 'linewidth',2);

% 绘制前车轮
wlx0 = xt-W/2; wly0 = yt+L/2;  % 左前轮
wrx0 = xt+W/2; wry0 = yt+L/2;  % 右前轮
hw = plot([wlx0 wrx0], [wly0 wry0],'r');

% 绘制前轮转向连杆
hc = plot([rlx0(3); rrx0(3)], [rly0(3);rry0(3)], 'b');

% 绘制参考线
xc = rlx0(2)-L/tand(0); yc = -L/2;
hl = plot([rlx0(1),xc,-W/2],[rly0(1),yc,-L/2],'o:k', ...
          [rrx0(1),xc     ],[rry0(1),yc     ],'o:k');

axis image
axis([-3*W W*0.75 -L L])

for degl = 0:0.1:40 % 左轮转向角

    % 旋转左轮和左轴
    [rlx, rly] = rotxyd(rlx0, rly0, rlx0(2), rly0(2), degl);
    [wlx, wly] = rotxyd(wlx0, wly0, rlx0(2), rly0(2), degl);
    set(hw(1), 'XData', wlx, 'YData', wly)
    set(hr(1), 'XData', rlx, 'YData', rly)
    
    % 计算参考线焦点并确定右轮转角
    xc = rlx0(2)-L/tand(degl);
    degr = atand(L/(rrx0(2)-xc));
    
    % 旋转右轮和右轴
    [rrx, rry] = rotxyd(rrx0, rry0, rrx0(2), rry0(2), degr);
    [wrx, wry] = rotxyd(wrx0, wry0, rrx0(2), rry0(2), degr);
    set(hw(2), 'XData', wrx, 'YData', wry)
    set(hr(2), 'XData', rrx, 'YData', rry)
        
    % 更新连杆
    set(hc, 'XData',[rlx(3); rrx(3)], 'YData', [rly(3);rry(3)])
    
    % 更新参考线
    set(hl(1), 'XData', [rlx(1),xc,-W/2],'YData', [rly(1),yc,-L/2])
    set(hl(2), 'XData', [rrx(1),xc     ],'YData', [rry(1),yc     ])
    
    drawnow
end
