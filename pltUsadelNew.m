clear all
%Add ffmatlib to the search path
addpath('c:\Users\Mike\Work\Jyvaskyla2016\MagneticVortex\NEWKaveh\Calculation\2D\ffmatlib\');
%Load the mesh

 ShX=20; 
 ShY=20;

indD=20;
dR=100;


[p,b,t,nv,nbe,nt,labels]=ffreadmesh(['SFIndD' num2str(indD) 'ShX' num2str(ShX) 'ShY' num2str(ShY) 'R' num2str(dR) '_mesh.msh']);
vh=ffreaddata(['SFIndD' num2str(indD) 'ShX' num2str(ShX) 'ShY' num2str(ShY) 'R' num2str(dR) '_vh.txt']);
uF=ffreaddata(['SFIndD' num2str(indD) 'ShX' num2str(ShX) 'ShY' num2str(ShY) 'R' num2str(dR) 'F_dataU.txt']);
uS=ffreaddata(['SFIndD' num2str(indD) 'ShX' num2str(ShX) 'ShY' num2str(ShY) 'R' num2str(dR) 'S_dataU.txt']);
%uSum=ffreaddata(['SFDeepCircIndD' num2str(indD) 'ShX' num2str(ShX) 'ShY' num2str(ShY) 'R' num2str(dR) 'Sum_dataU.txt']);
Curr=ffreaddata(['SFIndD' num2str(indD) 'ShX' num2str(ShX) 'ShY' num2str(ShY) 'R' num2str(dR) '_dataCurr.txt']);
[Mx,My]=ffreaddata(['SFIndD' num2str(indD) 'ShX' num2str(ShX) 'ShY' num2str(ShY) 'R' num2str(dR) '_dataM.txt']);


xv=-0.1*ShX;
yv=-0.1*ShY;
x=(xv-0.4):0.01:(xv+0.4);
y=(yv-0.4):0.01:(yv+0.4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure

ffpdeplot(p,b,t,'VhSeq',vh,'XYData',uF,'Mesh','off','Boundary','on','ColorMap',jet,'ColorBar','on');
      
      hold on
      ffpdeplot(p,b,t,'VhSeq',vh,'XYData',uF,'Mesh','off','Boundary','on','BDColors','k', ...
                     'Contour','on','CColor','w', 'CLevels',0,'XYStyle','off', 'CGridParam',[150, 150],'ColorMap',bluewhitered,'ColorBar','on', ...
          'FlowData',[Mx,My],'FColor',[105/256,105/256,105/256],'FGridParam',[24, 24]);
     
hold on

xlabel(gca,'x/\xi_0','FontSize',26)
ylabel(gca,'y/\xi_0','FontSize',26)
set(gca,'FontSize',26)
set(gca,'PlotBoxAspectRatio',[1 1 1],'FontSize',26)
grid on
box on

plot(x,y,'linewidth',2,'color','k')
plot(x,-y+2*yv,'linewidth',2,'color','k')

print(gcf,['1SF2DplotSumD' num2str(indD) 'ShX' num2str(ShX) 'ShY' num2str(ShY) 'R' num2str(dR)],'-dpng','-r300')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure

ffpdeplot(p,b,t,'VhSeq',vh,'XYData',uS,'Mesh','off','Boundary','on','ColorMap',jet,'ColorBar','on');
      
      hold on
      ffpdeplot(p,b,t,'VhSeq',vh,'XYData',uS,'Mesh','off','Boundary','on','BDColors','k', ...
                     'Contour','on','CColor','w', 'CLevels',0,'XYStyle','off', 'CGridParam',[150, 150],'ColorMap',bluewhitered,'ColorBar','on', ...
          'FlowData',[Mx,My],'FColor',[105/256,105/256,105/256],'FGridParam',[24, 24]);
     
hold on

xlabel(gca,'x/\xi_0','FontSize',26)
ylabel(gca,'y/\xi_0','FontSize',26)
set(gca,'FontSize',26)
set(gca,'PlotBoxAspectRatio',[1 1 1],'FontSize',26)
grid on

plot(x,y,'linewidth',2,'color','k')
plot(x,-y+2*yv,'linewidth',2,'color','k')

print(gcf,['1SUPER2DplotSumD' num2str(indD) 'ShX' num2str(ShX) 'ShY' num2str(ShY) 'R' num2str(dR)],'-dpng','-r300')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,pdeData]=convert_pde_data(p,t,vh,Curr');
[xmesh,~,ymesh,~]=prepare_mesh(p,t);
% x=linspace(-2,2,100);
% y=linspace(-2,2,100);
x=linspace(-4,4,100);
y=linspace(-10,10,100);
[X,Y]=meshgrid(x,y);
U=fftri2grid(X,Y,xmesh,ymesh,pdeData{1});

figure; 
plot( Y(:,50), U(:,50) , 'Linewidth', 2)
xlabel(gca,'y','FontSize',26)
ylabel(gca,'(\xi_0/d_F) j_c/j_0','FontSize',26)
set(gca,'FontSize',26)
set(gca,'PlotBoxAspectRatio',[1 1 1],'FontSize',26)
grid on
%print(gcf,['IplotD' num2str(indD) 'Sh' num2str(Sh) 'R' num2str(dR)],'-dpng','-r300')




