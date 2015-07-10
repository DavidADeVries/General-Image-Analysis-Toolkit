classdef Line
    %Line consists of a start and end point (in [x,y] format), and the
    %place for a tag (label) and it's string
    
    properties
        startPoint
        endPoint
        tagPoint
        tagStringPrefix = '';
        textAlign %text 'HorizontalAlginment' property value 'left', 'center', or 'right'
        isBridge = false; % a bridge is a line used to not show a measurement, but to be a reference line for another line that does display a measurement
        isNeg = false; %for some lines, depending on the orientation of the points, the length will be 'negative'. Since the rules for this are different for horizontal and vertical measures, and sometimes are not set (always positive), the logic for this will be requested to be done outside of the Line class
    end
    
    methods
        %% Constructor %%
        function line = Line(varargin) %params: (startPoint, endPoint, tagPoint, textAlign, isBridge*, tagString*, isNeg*)
            if length(varargin) >= 4
                line.startPoint = varargin{1};
                line.endPoint = varargin{2};
                line.tagPoint = varargin{3};
                line.textAlign = varargin{4};
            end
            
            if length(varargin) >= 5
                line.isBridge = varargin{5};
            end
            
            if length(varargin) >= 6
                line.tagStringPrefix = varargin{6};
            end
            
            if length(varargin) >= 7
                line.isNeg = varargin{7}; %describes for lines where negative/positive is important, which the line is
            end
        end
        
        %% getHalfwayPoint %%
        function [ halfwayPoint ] = getHalfwayPoint(line) %getHalfwayPoint returns the point halfway between the two points
            
            halfwayPoint = getHalfwayPoint(line.startPoint, line.endPoint);
                        
        end
        
        %% getLength %%
        function [ length ] = getLength( line, unitConversion )
            %lineLength return the length of a Line
            
            diff = line.startPoint - line.endPoint;
            
            diff(1) = diff(1) * unitConversion(1);
            diff(2) = diff(2) * unitConversion(2);
            
            length = norm(diff); 
            
            if line.isNeg
                length = -length;
            end
        end
        
        %% getTagString %%
        function [ tagString] = getTagString( line, unitString, unitConversion)
            %getTagString gives a string that may be uses to tag the line given
            
            if ~isempty(unitString) && ~line.isBridge
                convertedLength = line.getLength(unitConversion);
                
                roundedLength = round(10*convertedLength) / 10; % round to one decimal place
                
                tagString = [line.tagStringPrefix, num2str(roundedLength), unitString];
                
                %tagString = ['\bf', tagString]; %bold if desired
            else
                tagString = '';
            end
            
        end

    end
    
end

