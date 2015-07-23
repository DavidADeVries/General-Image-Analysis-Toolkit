function [ ] = giantExportAsImage(hObject, handles)
%[ ] = giantNextSeries(hObject, handles)
% for any module from GIANT, this function will go to the next series
% in a study
%
% Required functions:
%
% Required constants:
%   SNAPSHOT_DIRECTORY

width = 6; %inches




if ~isempty(handles.currentImage)%make sure something is there
    path = strcat(Constants.SNAPSHOT_DIRECTORY, '*.png');
    popupTitle = 'Save Snapshot';
    
    [snapshotFilename, snapshotPathname] = uiputfile(path, popupTitle);
    
    if snapshotFilename ~= 0 %didn't click cancel
        dpiString = 'Please enter snapshot DPI (leave both blank for auto):';
        widthString = 'Please enter snapshot width in inches (leave blank for auto);';
        
        title = 'Snapshot Settings';
        
        answer = inputdlg({dpiString, widthString}, title);
        
        if ~isempty(answer) %if empty, user clicked 'Cancel'
            dpi = str2double(answer{1});
            width = str2double(answer{2});
            
            if isnan(dpi) && ~isnan(width) %only invalid combination
                message = 'Cannot specify width and not a DPI. Please try to save snapshot again.';
                icon = 'none';
                title = 'Snapshot Error';
                
                waitfor(msgbox(message, title, icon)); %handle used for waiting
            else
                frame = getframe(handles.imageAxes);
                image = frame2im(frame);
                
                savePath = strcat(snapshotPathname, snapshotFilename);
                
                error = false;
                
                if ~isnan(dpi)
                    inchToMeter = 0.0254;

                    pixelsPerMeter = dpi / inchToMeter;
                    
                    if ~isnan(width)
                        dims = size(image);
                        
                        imageWidthInPixels = dims(2);
                        
                        widthInPixels = width * dpi;
                        
                        scaleFactor = widthInPixels / imageWidthInPixels;
                        
                        image = imresize(image, scaleFactor);
                    end
                    
                    try
                        imwrite(image, savePath, 'ResolutionUnit', 'meter', 'XResolution', pixelsPerMeter, 'YResolution', pixelsPerMeter);
                    catch
                        error = true;
                    end
                else
                    try
                        imwrite(image, savePath);
                    catch
                        error = true;
                    end                        
                end
                
                if error
                    message = 'An error occurred when trying to save the snapshot!';
                    icon = 'error';
                    title = 'Save Error';
                    
                    msgbox(message, title, icon);
                else
                    message = 'Snapshot successfully saved.';
                    icon = 'none';
                    title = 'Snapshot Saved';
                    
                    waitfor(msgbox(message, title, icon)); %handle used for waiting
                end
            end
        end
    end
end

end

