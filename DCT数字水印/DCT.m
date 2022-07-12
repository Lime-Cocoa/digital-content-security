P=imread('fruit.bmp');
[M,M]=size(P);
F=imread('cuc.bmp');
[N,N]=size(F);
I=zeros(M,M);
J=zeros(N,N);
K=8;
BLOCK=zeros(K,K);
figure;
subplot(1,3,1);
I=imread('fruit.bmp');
imshow(I);
title('原始图像');
subplot(1,3,2);
J=imread('cuc.bmp');
imshow(J);
title('水印图像');

%嵌入水印
for p=1:N
    for q=1:N
        x=(p-1)*K+1;
        y=(q-1)*K+1;
        BLOCK=I(x:x+K-1,y:y+K-1);
        BLOCK=dct2(BLOCK);
        if J(p,q)==0
            a=-1;
        else
            a=1;
        end
        BLOCK(1,1)=BLOCK(1,1)*(1+a*0.03);
        BLOCK=idct2(BLOCK);
        I(x:x+K-1,y:y+K-1)=BLOCK;
    end
end
subplot(1,3,3);
imshow(I);
title('嵌入水印后的图像');
imwrite(I,'watermarked.bmp');
imwrite(I,'watermarked.jpg');

%提取水印
I=imread('fruit.bmp');
J=imread('watermarked.bmp');
for p=1:N
    for q=1:N
        x=(p-1)*K+1;
        y=(q-1)*K+1;
        BLOCK1=I(x:x+K-1,y:y+K-1);
        BLOCK2=J(x:x+K-1,y:y+K-1);
        BLOCK1=idct2(BLOCK1);
        BLOCK2=idct2(BLOCK2);
        a=BLOCK2(1,1)/BLOCK1(1,1)-1;
        if a<0
            W(p,q)=0;
        else
            W(p,q)=1;
        end
    end
end
figure
subplot(1,3,1);
imshow('watermarked.bmp');
title('嵌入水印后的图像');
subplot(1,3,2);
imshow('cuc.bmp');
title('原始水印图像');
subplot(1,3,3);
imshow(W);
title('提取水印图像');
imwrite(W,'cuc_ditong.bmp')

% figure;
% subplot(1,2,1);
% histogram(P);
% title('原始图像灰度直方图');
% subplot(1,2,2);
% histogram(J);
% title('嵌入水印图像灰度直方图');