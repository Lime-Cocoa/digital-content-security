# 基于matlab实现的LSB 图像信息隐藏算法

载体图片

![](https://raw.githubusercontent.com/Lime-Cocoa/shellexample/main/cameraman.bmp )

秘密信息

![](https://raw.githubusercontent.com/Lime-Cocoa/shellexample/main/1.bmp )

首先将载体图片的8个位平面提取出来

![](https://github.com/Lime-Cocoa/shellexample/blob/main/1.png?raw=true)

然后将秘密信息嵌入

![](https://github.com/Lime-Cocoa/shellexample/blob/main/2.png?raw=true)

最后算一下峰值信噪比

![](https://github.com/Lime-Cocoa/shellexample/blob/main/3.png?raw=true)

PSNR=51.166892分贝，效果良好。

以下是该算法的源代码：


inputbmp.m

```matlab
X=double(imread('cameraman.bmp'));
[h,w] = size(X); %取图像的长宽像素点个数
subplot(3,3,1); %将多个图画到一个平面上的工具
imshow(X,[]); %matlab中显示图像的函数
title('原始图像');

%遍历每个位平面，画出八个图
for k=1:8  %k在1~8间循环,遍历每个像素点，取第k位
 for i=1:h 
     for j=1:w
      tmp(i,j) = bitget(X(i,j),k); %bitget函数首先将X(i,j)处灰度值分解为二进制串，然后取第k位
     end
 end
 subplot(3,3,k+1); %图排成3行3列，p表示图所在的位置，p=1表示从左到右从上到下的第一个位置。
 imshow(tmp,[]);
 ind = num2str(k); %把数值转换成字符串，用于标题
 imti = ['第',ind,'个位平面'];
 title(imti);
end
```

LSB.m

```natlab
function  piccover = LSB( piccover,pic2ray,M,N,m,n ) %piccover封面，pic2ray二值图，M,N封面行列，m，n二值图行列
if(m<=M&&n<=N)
    for i=1:m
        for j=1:n
            if pic2ray(i,j)==1&&mod(piccover(i,j),2)==1
                continue;
            elseif pic2ray(i,j)==1&&mod(piccover(i,j),2)==0
                piccover(i,j)=piccover(i,j)+1;
            elseif pic2ray(i,j)==0&&mod(piccover(i,j),2)==0
                continue;
            elseif pic2ray(i,j)==0 && mod(piccover(i,j),2)==1
                piccover(i,j)=piccover(i,j)-1;
            end
        end         
    end
else
    fprintf('载体对象大小不够！')
end
end
```

inLSB.m

```matlab
function pichide = inLSB(pichide,m,n)
    for i=1:m
        for j=1:n
            if mod(pichide(i,j),2)==1
                pichide(i,j)=255;
                %fprintf('1');
            else
                pichide(i,j)=0;
                %fprintf('0');
            end
        end
    end
end
```

main.m

```matlab
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

%计算峰值信噪比
B=8;  
MAX=2^B-1;         
MES=sum(sum((piccover-pichide).^2))/(M*N);     %均方差  
PSNR=20*log10(MAX/sqrt(MES));           %峰值信噪比
fprintf ('psnr: % f\n' ,PSNR); 
```

