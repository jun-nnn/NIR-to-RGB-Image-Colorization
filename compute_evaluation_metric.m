% Return mean value of the delta E (CIELAB) which measure the color difference between
% output and target
% deltaE = ((deltaL^2 + deltaa^2 + deltab^2))^(1/2)
function mean = compute_evaluation_metric(target, output, patchSize)
%     size before crop
    [x, y, ~ ]= size(target);
    crop_value = (patchSize - 1)/2;
    target = target(crop_value+1:x-crop_value, crop_value+1:y-crop_value,:);
%     disp(size(target));
%     disp(size(output));
    target_lab = rgb2lab(target);
    output_lab = rgb2lab(output);
    diff = output_lab - target_lab;
    [row, col, ~] = size(diff);
    deltaE = 0;
    count = 0;
    for i = 1:row
        for j = 1:col
            count = count + 1;
            pixel = diff(i,j,:);
            labsum =  sum(pixel.^2);
            deltaE = deltaE + sqrt(labsum);
        end
    end
    mean = deltaE/count;
end
