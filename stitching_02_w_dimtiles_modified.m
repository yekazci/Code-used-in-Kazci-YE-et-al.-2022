%
% load in collection of individually traced tiles
% and combine the resulting tracings into a single
% file
%
% charless fowlkes, (c) 2020
%

% directory where tiled trace results are stored
swcdir = 'my_path_to_tiled_neural_traces';

%%% Enter dimesions: 

dimtile_x = 2648; %%% our tiles are not square but reactangles. So we added two different variables for tile dimension (YEK).
dimtile_y = 4032;

zscale = 4.39;       %z-axis scale factor

xcoords = [];
ycoords = [];
zcoords = [];
radius = [];
parent = [];
nodect = 0;
DD = dir([swcdir '/*_*.swc']);   %%% we retrieved all files with .swc extension. Files were previously named as "tile_0_x_y.swc". 
for j = 1:length(DD)
  swcfile = [swcdir '\' DD(j).name]; %% we replaced '/' with '\'. Because windows uses the latter.  
  %%% first .swc file is assigned to the swcfile variable (i.e. tile_0_0_0.swc).
  xtile = str2double(swcfile(end-6)); %%% it gets the number corresponding to the X dimension.
  ytile = str2double(swcfile(end-4)); %%%  it gets the number corresponding to the Y dimension.
  fprintf('loading %d %d\n',xtile,ytile);
  fileID = fopen(swcfile);
  if (fileID>0)
    %Colums are: id type x y z radius parentid
    A = textscan(fileID, '%n %n %f %f %f %f %f', 'Delimiter', ' ', 'CommentStyle','#');
    if (any(isnan(A{7})))
      keyboard
    end
    xcoords = [xcoords ; A{3} + dimtile_x*xtile]; 
    ycoords = [ycoords; A{4} + dimtile_y*ytile];
    zcoords = [zcoords; A{5}];
    radius = [radius; A{6}];
    pp = A{7}+nodect;
    pp(A{7}==-1) = -1;
    parent = [parent; pp];
    nodect = nodect + length(A{3});
  end
  fclose(fileID);
end

trace.name = 'heart4 dorsal';
trace.x = [xcoords ycoords zcoords];
trace.radius = radius;
trace.parent = parent;
trace.nodect = nodect;
trace.zscale = zscale;

figure(1); clf;
plot(trace.x(:,1),trace.x(:,2),'.','markersize',1);
axis image; axis ij;
drawnow;
title(trace.name);

figure(2); clf;
plot3(trace.x(:,1),trace.x(:,2),trace.zscale*trace.x(:,3),'.','markersize',1);
axis image; axis vis3d; grid on;

%
% perform heuristic cleaning
%
trace = clean_trace(trace);

%
% save result as an swc file
%
save_trace(trace,'heart4_dorsal_clean.swc');

