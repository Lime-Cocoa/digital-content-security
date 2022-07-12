I = imread('cameraman.bmp'); %长宽一致

[rows,cols] = size(I);

subplot(1,3,1),imshow(I);
title('原始图像');
n=10;
a=1;
b=1;
if rows<cols
    img_new = zeros(cols,cols);
    for x = rows+1:cols
        for y = 1:cols
            I(x,y)=0;
        end
    end
end
if rows>cols
    img_new = zeros(rows,rows);
    for x = cols+1:rows
        for y = 1:rows
            I(y,x)=0;
        end
    end
end
if rows==cols
    img_new = zeros(rows,cols);
end
imwrite(I,'I.bmp');


% 加密图像
S = imread('I.bmp');
[h,w] = size(S);
for i = 1:n
    for y = 1:h
        for x = 1:w
            xx = mod((x-1)+b*(y-1),h)+1;
            yy = mod(a*(x-1)+(a*b+1)*(y-1),w)+1;
            img_new(yy,xx)=S(y,x);
        end
    end
    S = img_new;
end
img_new = uint8(img_new);
subplot(1,3,2),imshow(img_new);
N = num2str(n);
imti = ['置乱',N,'次后的图像'];
title(imti);
imwrite(img_new,'arnold.bmp');
% 解密图像
img_arnold = imread('arnold.bmp');

for i = 1:n
    for y = 1:h
        for x = 1:w
            xx = mod((a*b+1)*(x-1)-b*(y-1),h)+1;
            yy = mod(-a*(x-1)+(y-1),w)+1;
            img_new(yy,xx)=img_arnold(y,x);
        end
    end
    img_arnold = img_new;
end
img_new = uint8(img_new);
subplot(1,3,3),imshow(img_new);
title('复原后的图像');



% A = imread('cameraman2.bmp'); %长宽一致
% % I = imread('key.bmp'); % 长宽不一致
% [rows,cols] = size(A);
% 
% subplot(2,3,4),imshow(A);
% title('原始图像(b)');
% 
% n=10;
% a=1;
% b=1;
% if rows<cols
%     img_new = zeros(cols,cols);
%     for x = rows+1:cols
%         for y = 1:cols
%             A(x,y)=0;
%         end
%     end
% end
% if rows>cols
%     img_new = zeros(rows,rows);
%     for x = cols+1:rows
%         for y = 1:rows
%             A(y,x)=0;
%         end
%     end
% end
% if rows==cols
%     img_new = zeros(rows,cols);
% end
% imwrite(A,'A.bmp');
% 
% 
% % 加密图像
% B = imread('A.bmp');
% [h,w] = size(B);
% for i = 1:n
%     for y = 1:h
%         for x = 1:w
%             xx = mod((x-1)+b*(y-1),h)+1;
%             yy = mod(a*(x-1)+(a*b+1)*(y-1),w)+1;
%             img_new(yy,xx)=B(y,x);
%         end
%     end
%     B = img_new;
% end
% img_new = uint8(img_new);
% subplot(2,3,5),imshow(img_new);
% N = num2str(n);
% imti = ['置乱',N,'次后的图像'];
% title(imti);
% imwrite(img_new,'arnold.bmp');
% % 解密图像
% img_arnold = imread('arnold.bmp');
% for i = 1:n
%     for y = 1:h
%         for x = 1:w
%             xx = mod((a*b+1)*(x-1)-b*(y-1),h)+1;
%             yy = mod(-a*(x-1)+(y-1),w)+1;
%             img_new(yy,xx)=img_arnold(y,x);
%         end
%     end
%     img_arnold = img_new;
% end
% img_new = uint8(img_new);
% subplot(2,3,6),imshow(img_new);
% title('复原后的图像');