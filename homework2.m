close all;
clear all;
im=imread('1.jpg');
imshow(im);

[sy,sx,sz]=size(im);
sigma=1.5;      %sigma��ֵ
n=5;            
N=2*n+1;
img=uint8(zeros(sy,sx));  %��˹�˲����ͼ��
imz=uint8(zeros(sy+2*n,sx+2*n));  %��˹�˲����м��ͼ��

for i=1:sx
    for j=1:sy
        imz(i+n,j+n)=im(i,j);
        %��ԭͼ���Ƶ��м�ͼ�����ģ����ܿ�ΪN������Ϊ0
    end
end
G=[];                                        %���˹ģ��G
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



