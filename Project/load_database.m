function out=load_database();
% Load the database the first time we run the program.
% The database can be found at
%   http://www.cl.cam.ac.uk/research/dtg/attarchive/facedatabase.html
% The code assumes that the pgm files can be found at
%   ./att_faces/s1/1.pgm, ...
persistent loaded;
persistent w;
if(isempty(loaded))
    v=zeros(10304,400);
    for i=1:40
        cd(strcat('att_faces/s',num2str(i)));
        for j=1:10
            a=imread(strcat(num2str(j),'.pgm'));
            v(:,(i-1)*10+j)=reshape(a,size(a,1)*size(a,2),1);
        end
        cd ..
        cd ..
    end
    w=uint8(v); % Convert to unsigned 8 bit numbers to save memory. 
end
loaded=1;  % Set 'loaded' to aviod loading the database again. 
out=w;