function [ file ] = createFile(imageFilename, dicomInfo, imagePath, image)
%[ file ] = createFile(imageFilename, dicomInfo, imagePath, image)
%
% ** REQUIRED BY GIANT **
%
% provides an abstraction layer for GIANT to create files
% the provided image may be used to extract data from (size, max, min,
% etc.), but DO NOT save it in your module-specific file type. This will
% make saving patient data very slow, due to all the data being saved. The
% GIANT File type saves the path the image so that this is not necessary
% and save times can stay fast

%EX:

% these are all very dumb things to be storing, but hey, it's an example :)
newVar1 = max(max(image));
newVar2 = image(5,4);
newVar3 = image(4,5);

file = NewModuleFile(imageFilename, dicomInfo, imagePath, image, newVar1, newVar2, newVar3);


end

