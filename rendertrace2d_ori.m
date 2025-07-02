function rendertrace2d_ori(trace)

nonroot = find(trace.parent>0);
dx = trace.x(nonroot,1)-trace.x(trace.parent(nonroot),1);
dy = trace.x(nonroot,2)-trace.x(trace.parent(nonroot),2);
theta = zeros(size(trace.x(:,1)));
theta(nonroot) = atan(dy./dx);

rrange = linspace(0.4,3,6);
rrange = [rrange(1:end-1) linspace(3,6,5)];
rmap = 1*rrange;
rrange = [rrange 100];
rmap = [0.2 rmap];

thetarange = linspace(-pi/2,pi/2,10);
cmap = 0.9*hsv(length(thetarange));
for t = 2:length(thetarange)
  for s = 2:length(rrange)
    ind = find((theta>=thetarange(t-1)) & (theta<thetarange(t)) & (trace.radius>=rrange(s-1)) & (trace.radius<rrange(s)));
    plot(trace.x(ind,1),trace.x(ind,2),'.','MarkerSize',rmap(s),'Color',cmap(t,:));
    hold on;
    ind = ind(trace.parent(ind)>0);
    for u = 1:3
      dx = (u/4)*trace.x(ind,1)+((4-u)/4)*trace.x(trace.parent(ind),1);
      dy = (u/4)*trace.x(ind,2)+((4-u)/4)*trace.x(trace.parent(ind),2);
      plot(dx,dy,'.','MarkerSize',rmap(s),'Color',cmap(t,:));
    end
  end
end
axis image; axis vis3d; grid on;

