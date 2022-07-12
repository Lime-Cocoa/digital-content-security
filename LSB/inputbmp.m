X=double(imread('cameraman.bmp'));%将原始图像转换为灰度图像，如果本身就是灰度图可以去掉rgb2gray函数
[h,w] = size(X);%取图像的长宽像素点个数
subplot(3,3,1);%将多个图画到一个平面上的工具
imshow(X,[]);%matlab中显示图像的函数
title('原始图像');

%遍历每个位平面，画出八个图
for k=1:8 %k在1~8间循环
 %遍历每个像素点，取第k位
 for i=1:h 
     for j=1:w
      tmp(i,j) = bitget(X(i,j),k);%bitget函数首先将X(i,j)处灰度值分解为二进制串，然后取第k位
     end
 end
 subplot(3,3,k+1);%图排成3行3列，p表示图所在的位置，p=1表示从左到右从上到下的第一个位置。
 imshow(tmp,[]);
 ind = num2str(k); %把数值转换成字符串，用于标题
 imti = ['第',ind,'个位平面'];
 title(imti);
end
