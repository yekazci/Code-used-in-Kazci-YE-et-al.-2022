%
% load a tracing from an swc file
%
% zscale is the z-axis scaling factor.  If not set it defaults
% to 4.39
%
% charless fowlkes (c) 2020
%

function trace = load_trace(swcfile,zscale) 

xcoords = [];
ycoords = [];
zcoords = [];
radius = [];
parent = [];
nodect = 0;

trace = [];
trace.name = swcfile;
fileID = fopen(swcfile);
if (fileID>0)
  %Colums are: id type x y z radius parentid
  A = textscan(fileID, '%n %n %f %f %f %f %f', 'Delimiter', ' ', 'CommentStyle','#');
  xcoords = A{3};
  ycoords = A{4};
  zcoords = A{5};
  radius = A{6};
  parent = A{7};
end
fclose(fileID);

trace.x = [xcoords ycoords zcoords];
trace.radius = radius;
trace.parent = parent;
trace.nodect = size(trace.x,1);

if (nargin>1)
  trace.zscale = zscale
else
  trace.zscale = 4.39; 
end
