%%% this script takes the .swc file of each tile X * Y 
%%% and renames it properly for the later stitching function.

%%% Provide the directory that contains only the tile .swc files to be renamed  stitched later.

swcdir = 'my_path_to_swc_files';

tile_x = 2;    %enter number of X tiles.
tile_y = 2;    %enter num. of Y tiles.

num_tiles = tile_x*tile_y;

cd(swcdir);

swc_files = dir('*.swc');

cd('my_path_to_natsortfiles'); %%% go to the directory of natsortfiles functions.

swc_files = natsortfiles({swc_files.name});  %%% sort the names according to number in the names.
swc_files = string(swc_files); %%% convert cell array to the string array.

cd(swcdir);


tile_names = [];


%%% assignment of x coordinate of each tile:

for ii = 1:tile_y 
    
    for jj = 1:tile_x
        
      tile_names = [tile_names sprintf("tile_0_%d_%d.swc",jj-1,ii-1)];
      
      %%fprintf(append(tile_names(end),'\n')); %%% only the new element will be printed. 
      
    end
end

%%% Rename each .swc files:

for kk = 1:num_tiles 

    movefile(swc_files(kk),tile_names(kk));
    
end