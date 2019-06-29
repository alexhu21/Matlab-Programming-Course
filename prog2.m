function [pic1,pic2]=prog2(filename,m)
orig=imread(filename);
sz=size(orig);
w=(sz(2)-mod(sz(2),m))/m;
h=(sz(1)-mod(sz(1),m))/m;
pic1=imcrop(orig,[0 0 w*m h*m]);
pic2=pic1;
colorset=[0 51 102 153 204 255];
for ii=0:h:h*m-h
    for jj=0:w:w*m-w
        for kk=1:sz(3)
            pic1(1+ii:h+ii,1+jj:w+jj,kk)=sum(sum(pic1(1+ii:h+ii,1+jj:w+jj,kk)))/h/w;
            [~,I]=min(abs(sum(sum(pic2(1+ii:h+ii,1+jj:w+jj,kk)))/h/w-colorset));
            pic2(1+ii:h+ii,1+jj:w+jj,kk)=colorset(I);
        end
    end
end
imwrite(pic1,'prog2_1.bmp')
imwrite(pic2,'prog2_2.bmp')
figure(1);
imshow(pic1);
figure(2);
imshow(pic2);