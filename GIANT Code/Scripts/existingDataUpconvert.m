function [ ] = existingDataUpconvert( inDir, outDir )
% [ ] = existingDataUpconvert( inDir, outDir )
% this bad boy is used for when a new version of GIANT or a sub-module is
% pushed and a new property is added to a class. It basically takes all the
% saved patient files in the "inDir", loads 'em up, does the neccessary
% maps, and the spit 'em out in the "outDir", all pretty like.

addpath('/data/projects/General Image Analysis Toolkit/GIANT/metadata/GIANT Code/Classes');
addpath('/data/projects/GJ Tube/GAS-SAM/metadata/GUI/Classes');

dirList = dir(inDir);

for i=1:length(dirList)
    entry = dirList(i);
    
    name = entry.name;
    len = length(name);
    
    if len >= 4 && strcmp(name(len-3:len), '.mat') %is a MATLAB file so let's load it up
        error = false;
        
        try
            loadedData = load(strcat(inDir, '/', name));
        catch
            error = true;
        end
        
        if ~error && isfield(loadedData, 'patient')
            patient = loadedData.patient;
            
            studies = patient.studies;
            
            for j=1:length(studies)
                studies(j) = upconvertStudy(studies(j));
            end
            
            patient.studies = studies;
            
            % other changes be made if needed to the patient, or even get
            % it to be a new class, but we're good here
            
            % NOTE!!!
            % patient.savePath will still point to the originally location
            % (aka the 'inDir' location, not the 'outDir' location where it
            % will actually be saved)
            % Please move the new patient files to 'inDir' as soon as
            % possible. Either delete or cache the originals after checking
            % that the data upconvert was successful
            
            save(strcat(outDir,'/',name), 'patient');
        end
    end
    
end


end

function study = upconvertStudy(study)
    series = study.series;

    for i=1:length(series)
        series(i) = upconvertSeries(series(i));
    end
    
    study.series = series;
    % no other changes done to study (could change class if you need)
end

function series = upconvertSeries(series)
    files = series.files;

    for i=1:length(files)
        files(i) = upconvertFile(files(i));
    end
    
    series.files = files;
    % no other changes done to series (could change class if you need)
end

function newFile = upconvertFile(file)
    image = dicomread(file.imagePath);

    newFile = GasSamFile(file.name, file.dicomInfo, file.imagePath, image, file.originalLimits);
    
    % from File
    
    %newFile.dicomInfo = file.dicomInfo; % the constructor took care of it
    %newFile.name = file.name; % the constructor took care of it
    %newFile.imagePath = file.imagePath; % the constructor took care of it
    
    if file.roiOn
        roiCoords = file.roiCoords;
        
        xLim = [roiCoords(1), roiCoords(1) + roiCoords(3)];
        yLim = [roiCoords(2), roiCoords(2) + roiCoords(4)];
        
        newFile = newFile.setZoomLims(xLim, yLim);
    else
        % the constructor took care of it
    end
    
    %newFile.date % the constructor took care of it
    
    newFile.undoCache = file.undoCache; %you might have to upconvert the undoCache as well, but not in this case
    
    % from GasSamFile
    newFile.roiCoords = file.roiCoords;
    %newFile.originalLimits % the constructor took care of it
    newFile.contrastLimits = file.contrastLimits;
    
    newFile.roiOn = file.roiOn;
    newFile.contrastOn = file.contrastOn;
    newFile.waypointsOn = file.waypointsOn;
    newFile.tubeOn = file.tubeOn;
    newFile.refOn = file.refOn;
    newFile.midlineOn = file.midlineOn;
    newFile.metricsOn = file.metricsOn;
    newFile.quickMeasureOn = file.quickMeasureOn;
    newFile.displayUnits = file.displayUnits;
    
    newFile.waypoints = file.waypoints;
    newFile.tubePoints = file.tubePoints;
    newFile.refPoints = file.refPoints;
    newFile.midlinePoints = file.midlinePoints;
    newFile.metricPoints = file.metricPoints;
    newFile.quickMeasurePoints = file.quickMeasurePoints;
    
    newFile.longitudinalOverlayOn = file.longitudinalOverlayOn;
end

