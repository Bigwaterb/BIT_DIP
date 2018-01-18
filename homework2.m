close all;
clear all;
im=imread('1.jpg');
imshow(im);

[sy,sx,sz]=size(im);
sigma=1.5;      %sigma赋值
n=5;            
N=2*n+1;
img=uint8(zeros(sy,sx));  %高斯滤波后的图像
imz=uint8(zeros(sy+2*n,sx+2*n));  %高斯滤波的中间间图像

for i=1:sx
    for j=1:sy
        imz(i+n,j+n)=im(i,j);
        %将原图像复制到中间图像中心，四周宽为N的区域为0
    end
end
G=[];                                        %求高斯模板G
for i=1:N
    for j=1:N
        G(i,j)=(1/(2*pi*sigma))*...
            exp(-(double((i-n-1)^2+(j-n-1)^2))/(2*sigma*sigma));
    end
end
add=0
for i=1:N
    for(j=1:N)
     add=add+G(i,j);
    end
end
G=G/add;

for i=1+n:sx+n
    for j=1+n:sy+n
        i1=i-n;
        j1=j-n;
        sum=0;
        for i2=1:N
            for j2=1:N
                sum=sum+(imz(i1+i2-1,j1+j2-1)*G(i2,j2));
            end
        end
        sum=mod(sum,256);
        img(i1,j1)=sum;
    end
end
img=uint8(img);
figure,imshow(img);            



