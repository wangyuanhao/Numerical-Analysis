function [an, bn, M] = fftIntplt(f, N, M, visable)
% 对函数f的N个点使用M阶三角多项式进行插值
% 输入：
%   f:被插值函数，定义域[-pi, pi]
%   N:N个等距点xj = -pi + 2*pi*j/N, j=0,...,N-1
%   M:三角多项式的阶数，要求2*M  <= N
%   visable: 是否输出拟合曲线图像，0不输出，1输出，默认
%            值为1
% 输出：
%   an: 1 x N, 其中an(1:M+1)为M阶三角多项式的余弦系数
%   bn: 1 x N,其中bn(1:M+1)为M阶三角多项式的正弦系数
%   M:三角多项式的阶
% 计算实习题P95 Q3调用方式
%   fcos = @(x)x.^2.*cos(x);
%   N = 32;
%   M = 16;
%  [an, bn, M] = fftIntplt(fcos, N, M);
format long

if nargin < 4
    visable = 1;
end

if 2*M > N
    M = floor(N/2);
end

j = 0:N-1;
x = -pi+j.*2*pi/N;
f = f(x);

% 快速傅里叶变换
c = fft(f);

an = 2/N*real(c.*exp(-1i.*j.*pi));
bn = -2/N*imag(c.*exp(-1i.*j*pi));

if visable == 1
    figure()
    scatter(x, f)
    hold on
    xfit = -pi:0.01:pi;
    evalf = eval_trifunc(xfit, an, bn, M);
    plot(xfit, evalf)
    legend('插值点',strcat(num2str(M),'阶三角多项式插值曲线'))
    grid on
end

end

