close all;
clear all;
im=imread('1.jpg');
imshow(im);
%img = rgb2gray(img);
%im =double(im);
[sx sy]=size(double(im));

tmp=zeros(sx+2,sy+2);
tmp(2:sx+1,2:sy+1)=im;
Ix=zeros(sx+2,sy+2);
Iy=zeros(sx+2,sy+2);

E=zeros(sx+2,sy+2);

Ix(:,2:sy)=tmp(:,3:sy+1)-tmp(:,1:sy-1);
Iy(2:sx,:)=tmp(3:sx+1,:)-tmp(1:sx-1,:);

Ix2=Ix(2:sx+1,2:sy+1).^2;
Iy2=Iy(2:sx+1,2:sy+1).^2;
Ixy=Ix(2:sx+1,2:sy+1).*Iy(2:sx+1,2:sy+1);

h=fspecial('gaussian',[7 7],2);
Ix2=filter2(h,Ix2);
Iy2=filter2(h,Iy2);
Ixy=filter2(h,Ixy);

Rmax=0;
R=zeros(sx,sy);
for i=1:sx
    for j=1:sy
        M=[Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)];
        R(i,j)=det(M)-0.06*(trace(M))^2;
        
        if R(i,j)>Rmax
            Rmax=R(i,j);
        end
    end
end
re=zeros(sx+2,sy+2);

tmp(2:sx+1,2:sy+1)=R;
imout=zeros(sx+2,sy+2);
imout(2:sx+1,2:sy+1)=im;
for i=2:sx+1
    for j=2:sy+1
        
        if tmp(i,j)>0.02*Rmax &&...
           tmp(i,j)>tmp(i-1,j-1) && tmp(i,j)>tmp(i-1,j) && tmp(i,j)>tmp(i-1,j+1) &&...
           tmp(i,j)>tmp(i,j-1) && tmp(i,j)>tmp(i,j+1) &&...
           tmp(i,j)>tmp(i+1,j-1) && tmp(i,j)>tmp(i+1,j) && tmp(i,j)>tmp(i+1,j+1)
                imout(i,j)=255; 
        end   
    end
end

imout=mat2gray(imout(2:sx+1,2:sy+1));
figure,imshow(imout);
