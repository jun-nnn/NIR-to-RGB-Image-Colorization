% Initiate and Set up environment
addpath(genpath('/Users/chenyao/Documents/GitHub/psych221'));
addpath(genpath('/Users/chenyao/Documents/GitHub/isetcam'));
addpath(genpath('/Users/chenyao/Documents/GitHub/isetL3'));
addpath(genpath('/Users/chenyao/Documents/GitHub/RemoteDataToolbox'));

if ~exist('RGBImageData', 'dir')
       mkdir('RGBImageData')
end
 
if ~exist('IRSensorData', 'dir')
       mkdir('IRSensorData')
end
 
if ~exist('IRImageData', 'dir')
       mkdir('IRImageData')
end

%% To Run Simulation:
%   1 Run DataParser_IR2RGB.m
%   2 Run ir2RGB_L3DataSimulation (You should Run Section for this script)

% Other useful scripts
% * CreateDataset for creating a train set and test set
% * View_IR_RGBImage script for viewing a specfic image, you could compare it
% % computer_evaluation_metric for quantative comparsion between output and
% target
% with the output of the L3 training and testing

%% Possible try:
% 1. change images in the test set and train set, there are multiple
% combinations like:
%   * dataset contains fruit, people, landscape 
%   only train fruit, test on fruit
%   * train all kinds, test on one kind
%   * enlarge the dataset that do not perform well

% 2. try other options
%  l3TrainRidge  - Ridge regression (Tikhonov)
%  l3TrainWiener - Wiener regression
%  l3TrainOLS    - Ordinary least squares
% 
% 3.Tuning Paramters:
%  * cutPoints
%  * patch size
% 
% 4. Next step:
%   We might apply some color processing algorithm on simulated images
%   We might ask Brian about the possible approach


