function [x, y] = rotxyd(x0, y0, xc, yc, deg)
%% 坐标系转换：将点 (x0, y0) 绕 (xc, yc) 旋转 deg 度
x = (x0-xc)*cosd(deg) - (y0-yc)*sind(deg) + xc; 
y = (x0-xc)*sind(deg) + (y0-yc)*cosd(deg) + yc;