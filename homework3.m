close all;
clear all;
img=(rgb2gray(imread('2.jpg')));
imshow(img);
img=double(img);
g=fftshift(fft2(img));
%���и���Ҷ�任��fft2�Ƕ�ά�ĸ���Ҷ�任��
%���Ļ�
figure,imshow(abs(g),[])
[sx,sy]=size(g);
n=2;
d0=30; 
%d0����ֹƵ��
n1=fix(sx/2);
n2=fix(sy/2);%��0ȡ��
%n1��n2���ĵ�����
for i=1:sx   %��ͨ�˲�
  for j=1:sy
      d=sqrt((i-n1)^2+(j-n2)^2);
      h(i,j)=1*exp(-1/2*(d^2/d0^2));
      result(i,j)=h(i,j)*g(i,j);
  end
end
result=uint8(real(ifft2(ifftshift(result))));%����Ҷȥ���Ļ��Լ����任
figure,imshow(result);