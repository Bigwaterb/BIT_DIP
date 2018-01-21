im=imread('1.jpg');
[sx,sy,sz]=size(im);
subplot(2,2,1);
imshow(im);
title('原图像');

x1=imnoise(im,'gaussian',0,0.008);%添加高斯噪声(,,均值，方差)
subplot(2,2,2);
imshow(x1);
title('高斯噪声图');
K=0.1;   
k=0.0025;
for u=1:sx 
    for  v=1:sy
        H(u,v)=exp(-k*(((u-sx/2)^2+(v-sy/2)^2)^(5/6)));
        H0(u,v)=(abs(H(u,v)))^2;
        H1(u,v)=H0(u,v)/(H(u,v)*(H0(u,v)+K));
    end
end
subplot(2,2,3);imshow(wiener2(x1));
title('维纳滤波复原图');
F0=fftshift(fft2(x1));
F2=H1.*F0;
I3=ifft2(fftshift(F2));
subplot(2,2,4);
imshow(uint8(I3));title('维纳滤波复原图1');






%

