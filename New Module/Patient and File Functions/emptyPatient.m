function [ patient ] = emptyPatient(varargin)
%[ patient ] = emptyPatient(varargin)
% varargin:
%   1 - 1D array of empty patients
%   2 - 2D array of empty patients
%   0, >2 - single empty patient
%
% ** REQUIRED BY GIANT **
%
% provides an abstraction layer for GIANT to create empty patients.
% useful from pre-allocating memory

% EX:

numArg = length(varargin);

if numArg == 1
    patient = NewModulePatient.empty(varargin{1});
elseif numArg == 2
    patient = NewModulePatient.empty(varargin{1}, varargin{2});
else
    patient = NewModulePatient.empty;
end

end

