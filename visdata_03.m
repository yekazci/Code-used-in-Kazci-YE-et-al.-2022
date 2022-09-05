


% Following scpipt from "https://bitbucket.org/fowlkes/heart_mapping/src/master/"
 
% was used in Kazci YE et al., 2022 article.

%
% visualize example data (using the provided swc file)
%


% Enter your .swc file as input arguement:
trace = load_trace('x.swc',4.39);


figure(3); clf;
whitebg;
rendertrace2d_radius(trace); axis ij;
axis off;
set(gcf,'color',[0 0 0]);
set(gcf,'InvertHardcopy','off');
print('clean_final1.pdf','-dpdf','-bestfit','-r900') 

rrange = linspace(0.4,3,6);
rrange = [rrange(1:end-1) linspace(3,6,5) 30];
figure(3); %add a colorbar to figure 3
colormap(max(jet(512)-0.1,0));
cb = colorbar;
caxis([0,10]);
set(cb,'Ticks',0:10);
set(cb,'TickLabels',num2str(rrange'));

figure(4); clf;
whitebg;
rendertrace2d_ori(trace); axis ij;
axis off;
set(gcf,'color',[0 0 0]);
set(gcf,'InvertHardcopy','off');
print('clean_final_ori.pdf','-dpdf','-bestfit','-r900')

% orientation legend
figure(5); clf;
imagesc(ori_legend(400));
axis xy; axis off
set(gcf,'color',[0 0 0]);
print('ori_colorbar.pdf','-dpdf','-bestfit','-r900') 

