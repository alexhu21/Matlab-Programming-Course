clear all;
n_sp=100;
lt=[3 7; 5 2];
sp=[randn(1,n_sp);randn(1,n_sp)];
sp=lt*sp;
M=sum(sp,2)./n_sp;
C=cov(sp(1,:),sp(2,:));
x=linspace(-max(abs(sp(:)))*1.2,max(abs(sp(:)))*1.2,350);
y=linspace(-max(abs(sp(:)))*1.2,max(abs(sp(:)))*1.2,350);
[X,Y]=meshgrid(x,y);
for p=1:length(x)
    for q=1:length(y)
        Z(q,p)=exp((-1/2)*([x(p) ; y(q)]-M).'*inv(C)*([x(p) ; y(q)]-M))/sqrt((2*pi)^2*det(C));
    end
end
imagesc(x,y,Z);
set(gca,'YDir','normal');
hold on;
contour(X,Y,Z,'LineColor', 'k');
plot(sp(1,:),sp(2,:),'x','color','w');