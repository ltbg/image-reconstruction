Sen_distribution1=ones(318,1);
Sen_distribution=ones(318,1);
Sen_distribution1=Sen(:,1);
for i=1:318
    Sen_distribution(i,1)=(Sen_distribution1(i,1)-min(Sen_distribution1))/(max(Sen_distribution1)-min(Sen_distribution1));
end


Flat=[Topo,Sen_distribution];
Interp=ones(681,1);
for i=1:1:681
    e=0;sum=0;
 for j=1:1:318
    for k=1:1:3
       if Flat(j,k)==i
        e=e+1;sum=sum+Flat(j,4);
       end
    end
 end
 if e==0,Interp(i,1)=0;
 else
 Interp(i,1)=sum/e;
 end
end


Num=[Coord,Interp];
for i=681:-1:1
    if Num(i,3)==0
        Num(i,:)=[];
    end     
end
% X=Num(:,1);Y=Num(:,2);Gray=Num(:,3);
% tri=delaunay(X,Y);
% figure
% patch('Faces',tri,'Vertices',[X,Y],'FaceVertexCData',Gray,...
% 'FaceColor','interp','EdgeColor','none'); 
x=Num(:,1);y=Num(:,2);z=Num(:,3);
% scatter(x,y,5,z)%散点图
figure
[X,Y,Z]=griddata(x,y,z,linspace(min(x),max(x))',linspace(min(y),max(y)),'v4');%插值
% pcolor(X,Y,Z);shading interp%伪彩色图
% figure,contourf(X,Y,Z) %等高线图
figure,mesh(X,Y,Z)%三维曲面