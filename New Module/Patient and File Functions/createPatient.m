function [ patient ] = createPatient(patientId, studies)
%[ patient ] = createPatient(patientId, studies)
%
% ** REQUIRED BY GIANT **
%
% provides an abstraction layer for GIANT to create patients

%EX:

% very dumb things to be storing for a patient, but this is an example, so
% I'm justified
newVar1 = 13;
newVar2 = 'Cats';
newVar3 = 'Pickle';

patient = NewModulePatient(patientId, studies, newVar1, newVar2, newVar3);

end

