piccover=double(imread('cameraman.bmp'));%载体图像
pic2ray=double(imread('1.bmp'));%隐藏信息

%获取两个图像的大小
[M,N] = size(piccover);
[m,n] = size(pic2ray);

subplot(2,3,1),imshow(piccover,[]); %展示封面和隐藏信息后图像的对比
title('隐藏前');

pichide=LSB(piccover,pic2ray,M,N,m,n);%M,N为封面行列，m，n为二值图行列，将二值图隐写进封面中
subplot(2,3,2),imshow(pichide,[]);%显示隐藏后图像
title('隐藏后');

subplot(2,3,3),imshow(pic2ray,[]);%显示需隐藏的信息
title('隐藏信息');

for i=1:M
     for j=1:N
      tmp_qian(i,j) = bitget(piccover(i,j),1);%bitget函数首先将X(i,j)处灰度值分解为二进制串，然后取第1位
     end
end
 subplot(2,3,4),imshow(tmp_qian,[]);%显示隐藏前的最低位平面
 title('隐藏前的最低位平面');

 for i=1:M
     for j=1:N
      tmp_hou(i,j) = bitget(pichide(i,j),1);%bitget函数首先将X(i,j)处灰度值分解为二进制串，然后取第1位
     end
end
 subplot(2,3,5),imshow(tmp_hou,[]);%显示隐藏后的最低位平面
 title('隐藏后的最低位平面');

picjie=inLSB(pichide,m,n);%提取出隐藏信息
subplot(2,3,6),imshow(picjie,[]);%显示提取信息
%imshow(picjie,[]);
title('提取信息');

B=8;  %编码一个像素用多少二进制位 
MAX=2^B-1;   %图像有多少灰度级        
MES=sum(sum((piccover-pichide).^2))/(M*N);     %均方差  
PSNR=20*log10(MAX/sqrt(MES));           %峰值信噪比
fprintf ('psnr: % f\n' ,PSNR); 



