% trainSet, Cell array of input images, input sensor data and target images
% testSet, Cell array of input images, input sensor data and target images
% input sensor data and target images are used as inImg/outImg in L3
% simulation
function [trainSet, testSet] = CreateDataSet_sensor_image()
    disp('--- Process: Creating Trainning Set and Test Set ---');
    data_size = 26;
    testIdx = [4,11,12,26];
    test_size = size(testIdx,2);
    train_size = data_size - test_size;
    
    
    trainSet = cell(1,3);
    testSet = cell(1,3);
    
    if(train_size>0)
        train_inImg = cell(1, train_size);
        train_inSensor = cell(1, train_size);
        train_outImg = cell(1, train_size);
    end
    
    test_inImg = cell(1, test_size);
    test_inSensor = cell(1, test_size);
    test_outImg = cell(1, test_size);
    
    current_dir = pwd;
    ir_dir = [current_dir,'/IRSensorData/'];
    ir_S = dir(fullfile(ir_dir,'*.mat')); 
    
    irImg_dir = [current_dir,'/IRImageData/'];
    irImg_S = dir(fullfile(irImg_dir,'*.mat')); 
    
    rgb_dir = [current_dir,'/RGBImageData/'];
    rgb_S = dir(fullfile(rgb_dir,'*.mat')); 
    
    % Todo: check database size boundary/*numel(ir_S)*/, now data_size is between 0~27

    count_train = 0;
    count_test = 0;
    for k = 1:data_size
       
        % disp(ir_S(k).name);
        % disp(rgb_S(k).name);    
        % ToDo: make sure ir and rgb match
        
        if(ismember(k,testIdx))
            %disp(k)
            disp(ir_S(k).name);
            count_test = count_test + 1;
            temp_ir_file = fullfile(ir_dir,ir_S(k).name);
            temp_in = load(temp_ir_file);
            % disp(size(temp_in.ir_sensor_data));
            test_inSensor{count_test} = temp_in.ir_sensor_data;

            temp_irImg_file = fullfile(irImg_dir,irImg_S(k).name);
            temp_inImg = load(temp_irImg_file);
            % disp(size(temp_in.ir_sensor_data));
            test_inImg{count_test} = temp_inImg.ir_image_data;

            temp_rgb_file = fullfile(rgb_dir,rgb_S(k).name);
            temp_out = load(temp_rgb_file);
            % disp(size(temp_out.rgb_image_data));
            test_outImg{count_test} = temp_out.rgb_image_data;
      
        else
            count_train = count_train + 1;
            temp_ir_file = fullfile(ir_dir,ir_S(k).name);
            temp_in = load(temp_ir_file);
            % disp(size(temp_in.ir_sensor_data));
            train_inSensor{count_train} = temp_in.ir_sensor_data;

            temp_irImg_file = fullfile(irImg_dir,irImg_S(k).name);
            temp_inImg = load(temp_irImg_file);
            % disp(size(temp_in.ir_sensor_data));
            train_inImg{count_train} = temp_inImg.ir_image_data;

            temp_rgb_file = fullfile(rgb_dir,rgb_S(k).name);
            temp_out = load(temp_rgb_file);
            % disp(size(temp_out.rgb_image_data));
            train_outImg{count_train} = temp_out.rgb_image_data;
        end
      
    end
    
    %disp(size(train_inImg));
    trainSet{1} = train_inImg;
    trainSet{2} = train_inSensor;
    trainSet{3} = train_outImg;
    
    %disp(size(test_inImg)); 
    %disp(test_size);
    testSet{1} = test_inImg;
    testSet{2} = test_inSensor;
    testSet{3} = test_outImg; 
      
end