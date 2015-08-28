function [ ] = BOOT( constantsDirectory )
% BOOT( constantsDirectory ) 
% this function boots up the module, loading all the necessary
% libraries. The path to the study's constants file (e.g. '../../Test
% Study/Code Files') must be given to BOOT to give it the context it will
% be running in.

% add needed librarys

addpath(genpath('.')); %add all subfolders in the current directory

% add in constant files that are specific to each study
addpath(constantsDirectory);

addpath(genpath(strcat(Constants.GIANT_PATH, 'GIANT Code')));

addpath(strcat(Constants.GIANT_PATH, 'Common Module Functions/Quick Measure')); %as an example

% Boot the GUI

GIANT_BASE();

end

