areas=ones(10,1);
areas(1,1)=bwarea(imEr);
for i=2:10
    areas(i,1)=bwarea(imdilate(imerode(imEr,strel("disk",round(6.8*5*i))),strel("disk",round(6.8*5*i))));
end
plot(areas)