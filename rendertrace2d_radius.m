function rendertrace_radius(trace)


rrange = linspace(0.4,3,6);
rrange = [rrange(1:end-1) linspace(3,6,5)];
rmap = 1.5*rrange;
rrange = [rrange 100];
rmap = [0.3 rmap];
cmap = max(jet(length(rrange))-0.1,0);

% visualization of fiber radius
for s = 2:length(rrange)
  ind = find((trace.radius>=rrange(s-1)) & (trace.radius<rrange(s)));
  plot(trace.x(ind,1),trace.x(ind,2),'.','MarkerSize',rmap(s),'Color',cmap(s,:));
  hold on;
  ind = ind(trace.parent(ind)>0);
  for t = 1:3
    dx = (t/4)*trace.x(ind,1)+((4-t)/4)*trace.x(trace.parent(ind),1);
    dy = (t/4)*trace.x(ind,2)+((4-t)/4)*trace.x(trace.parent(ind),2);
    plot(dx,dy,'.','MarkerSize',rmap(s),'Color',cmap(s,:));
  end
end
axis image; grid on;

