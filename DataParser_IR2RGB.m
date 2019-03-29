%% L3:  Transform an IR (monochrome) image to a colorized RGB
%
% Choose a natural scene that extends to IR
%  Make a monochrome sensor with an IR only filter for a particular lens and sensor
%  Make a matched RGB sensor image with the same lens
%  Render the image on the two different sensors
%  Store the matched sensor data
%
% Possibe approaches
%  Transform patches of high resolution IR data to a 2x2 RGB superpixel

% BW, 2018

%% Basic parameters to keep things organized

wave = 415:10:940;
fov = 10;

%% Create a matched IR and RGB camera

% Start with an rgb camera
rgbSensor = sensorCreate;
rgbSensor = sensorSetSizeToFOV(rgbSensor,fov);
rgbSensor = sensorSet(rgbSensor,'wave',wave);
rgbSensor = sensorSet(rgbSensor,'name','RGB');

% Build the irSensor.  Matched except uses the irPassFilter.
irSensor = sensorSet(rgbSensor,'pattern',1);
irFname  = 'irPassFilter';
irPass   = ieReadColorFilter(wave,irFname);
irSensor = sensorSet(irSensor,'color filters',irPass);
irSensor = sensorSet(irSensor,'filter names',{'kIR'});  % Shows up as black.
irSensor = sensorSet(irSensor,'name','IR');

%% The stanford hyperspectral data on the RDT site contain data to 950

% These are in several directories
%   fruit, landscape, faces1m and faces3m
% 
% The data are large, with densely sampled wavelength
% We reduce the sampling to make the computations faster.  No real loss of
% precision, IMHO.

%% Parse all the Image in nir foler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
current_dir = pwd;
nir_database_dir = [current_dir,'/nir/'];
S = dir(fullfile(nir_database_dir,'*.mat')); 

for k = 1:numel(S)
    disp(S(k).name);
    filename = S(k).name;
    image = load([nir_database_dir,filename]);
    scene = sceneFromBasis(image);
    scene = sceneInterpolateW(scene,wave);

    oi = oiCreate;
    oi = oiCompute(oi,scene);

    rgbSensor = sensorCompute(rgbSensor,oi);
    irSensor = sensorCompute(irSensor,oi);

    %% hide display to speed storing the data
    % % the oiCompute only needs to be run once.
    % ieAddObject(rgbSensor); sensorWindow;
    % ieAddObject(irSensor); sensorWindow;

    %% Show them image processed
    % disp('here')
    ip = ipCreate;
    ipIR = ipCompute(ip,irSensor);
    ipRGB = ipCompute(ip,rgbSensor);

    %% hide display speed storing the data
    % ieAddObject(ipIR); ieAddObject(ipRGB); ipWindow;
    % disp('here')

    %% Save IR sensor data as input data, and RGB Image data as target data
    ir_sensor_data = irSensor.data.volts;
    save_ir_dir = [current_dir, '/IRSensorData/', 'ir_',filename];
    save(save_ir_dir, 'ir_sensor_data')
    
    ir_image_data = ipIR.data.result;
    save_irImg_dir = [current_dir, '/IRImageData/', 'irImg_',filename];
    save(save_irImg_dir, 'ir_image_data')

    rgb_image_data = ipRGB.data.result;
    save_RGB_dir = [current_dir,'/RGBImageData/','rgb_',filename];
    save(save_RGB_dir, 'rgb_image_data')
    disp('saved')
    
end
%% END
