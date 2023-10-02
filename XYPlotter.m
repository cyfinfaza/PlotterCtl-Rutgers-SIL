classdef XYPlotter < handle
    properties
        SerialPort   % Serial port object
        CurrentX     % Current X position
        CurrentY     % Current Y position
    end
    
    methods
        % Constructor to initialize the plotter object
        function obj = XYPlotter(serialPort)
            obj.SerialPort = serialport(serialPort, 250000); % Replace with your baud rate
            obj.CurrentX = 0;
            obj.CurrentY = 0;
            
            % Initialize the plotter position to (0, 0)
            obj.sendGCode('G1 X0 Y0 F100'); % Move to (0, 0) at 100 mm/s
            
            % Optionally, you can add a pause here to allow time for the move to complete
            pause(2); % Adjust as needed
        end
        
        % Destructor to close the serial connection when the object is cleared
        function delete(obj)
            delete(obj.SerialPort);
        end
        
        % Method to move the plotter to a new position with a specified time
        function [distance, dt] = moveTo(obj, newX, newY, dt)
            % Calculate the distance to the new position
            dx = newX - obj.CurrentX;
            dy = newY - obj.CurrentY;
            distance = sqrt(dx^2 + dy^2);
            
            % Calculate the speed required to reach the new position in dt seconds
            speed = distance / dt * 60;
            
            % Generate G-code command to move to the new position with speed
            gcode = sprintf('G1 X%.2f Y%.2f F%.2f', newX, newY, speed);
            fprintf("%s\n", gcode);
            
            % Send the G-code command over the serial connection
            obj.sendGCode(gcode);
            pause(dt);
            
            % Update the current position
            obj.CurrentX = newX;
            obj.CurrentY = newY;
        end
        
        % Method to send a G-code command to the plotter
        function sendGCode(obj, gcode)
            writeline(obj.SerialPort, gcode);
        end
    end
end
