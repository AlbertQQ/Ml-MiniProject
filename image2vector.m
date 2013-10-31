%TODO: This function transform image to the vector
function [tranVector] = image2vector(filePath)
%Initialise the vector
tranVector = zeros(1,1024);

%open image file
fid = fopen(filePath);

%Read 32 characters in a line once, and sotre all 32 lines data in the
%vector

for i = 1:32
    lineChars = fgetl(fid);
    %Transform lineChars from string tonumbers
    for j = 1:32
        tranVector(32*(i-1)+j) = str2double(lineChars(j));
    end
end




%close file
fclose(fid);


end  % end of function