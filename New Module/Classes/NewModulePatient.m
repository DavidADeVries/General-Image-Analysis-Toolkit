classdef NewModulePatient < Patient
    % NewModulePatient 
    % (please rename to be unique to your module, e.g. GasSamPatient, FamSamPatient, etc.)
    %
    % ** REQUIRED BY GIANT **
    %
    % this class is the paitent type specific to your module.
    % it inherits from the GIANT Patient type to already have all base fields
    % needed (studies, patientId, savePath, etc.), all you need to do is add the fields relevant for the
    % analysis your module will conduct.
    % Your constuctor may take any form you wish, though you must make the
    % functions:
    %
    %   - createPatient(patientId, studies)
    %   - emptyPatient(varargin)
    %
    % these functions give GIANT a standard abstraction layer to leverage
    %
    % NOTE: You do not have to define this if no new Patient properities or
    % methods are needed
    
    properties
        % new fields for your analysis
        %
        % EX:
        
        patientField1
        patientField2
        patientField3
    end
    
    methods
        %% Constructor %%
        function newModulePatient = NewModulePatient(patientId, studies, newVar1, newVar2, newVar3)
            newModulePatient@Patient(patientId, studies); % must use Patient constructor first
            
            % Set any new fields if needed
            %
            % EX:
            
            newModulePatient.patientField1 = newVar1;
            newModulePatient.patientField2 = newVar2;
            newModulePatient.patientField3 = newVar3;
        end
               
        
        %% newFunction1 %%
        % write any new functions you need
        function patient = newFunction1(patient)
        end
        
        %% newFunction2 %%
        % write any new functions you need
        function patient = newFunction2(patient)
        end
        
        %% newFunction3 %%
        % write any new functions you need
        function patient = newFunction3(patient)
        end    
       
    end
    
end

