function [CC,imL]=cclabel(im)
sz=size(im);
zone=[-1 1 -sz(1) sz(1)];
imL=zeros(sz(1),sz(2));
nCC=0;
for p=1:sz(1)*sz(2)
    if im(p)==0 || imL(p)>0
        continue;
    end
    nCC=nCC+1;
    Q(1)=p;
    while ~isempty(Q)
        q=Q(1);
        Q(1)=[];
        if im(q)>0 && imL(q)==0
            imL(q)=nCC;
            for ii=1:4
                if q+zone(ii)>0 && q+zone(ii)<=sz(1)*sz(2)
                    Q(length(Q)+1)=q+zone(ii);
                end
            end
        end
    end
end
imL=uint32(imL);
for ii=1:nCC
    CC(ii).count=length(find(imL==ii));
    CC(ii).index=find(imL==ii);
    [x,y]=ind2sub(sz,find(imL==ii));
    CC(ii).xmin=min(x);
    CC(ii).xmax=max(x);
    CC(ii).ymin=min(y);
    CC(ii).ymax=max(y);
end
imshow(imL,[0 0 0;jet(nCC)]);
