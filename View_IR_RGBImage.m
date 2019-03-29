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


%%
current_dir = pwd;
nir_database_dir = [current_dir,'/nir/'];

% The filename of the Image that you want to see
filename = 'LoResFemale9.mat';

image = load([nir_database_dir,filename]);
scene = sceneFromBasis(image);
scene = sceneInterpolateW(scene,wave);

oi = oiCreate;
oi = oiCompute(oi,scene);

rgbSensor = sensorCompute(rgbSensor,oi);
irSensor = sensorCompute(irSensor,oi);

ieAddObject(rgbSensor); sensorWindow;
ieAddObject(irSensor); sensorWindow;


ip = ipCreate;ipIR = ipCompute(ip,irSensor);
ipRGB = ipCompute(ip,rgbSensor);
ieAddObject(ipIR); ieAddObject(ipRGB); ipWindow;


