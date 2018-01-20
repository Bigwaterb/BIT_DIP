close all;
clear all;
img=(rgb2gray(imread('2.jpg')));
imshow(img);
img=double(img);
g=fftshift(fft2(img));
%进行傅里叶变换，fft2是二维的傅立叶变换。
%中心化
figure,imshow(abs(g),[])
[sx,sy]=size(g);
n=2;
d0=30; 
%d0是终止频率
n1=fix(sx/2);
n2=fix(sy/2);%向0取整
%n1，n2中心点坐标
for i=1:sx   %低通滤波
  for j=1:sy
      d=sqrt((i-n1)^2+(j-n2)^2);
      h(i,j)=1*exp(-1/2*(d^2/d0^2));
      result(i,j)=h(i,j)*g(i,j);
  end
end
result=uint8(real(ifft2(ifftshift(result))));%傅里叶去中心化以及反变换
figure,imshow(result);