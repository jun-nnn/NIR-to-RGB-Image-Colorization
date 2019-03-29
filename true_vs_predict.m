function true_vs_predict(target, output,patchSize)
    [x, y, ~ ]= size(target);
    crop_value = (patchSize - 1)/2;
    target = target(crop_value+1:x-crop_value, crop_value+1:y-crop_value,:);
    
    targetR = target(:,:,1);
    targetG = target(:,:,2);
    targetB = target(:,:,3);
    
    outputR = output(:,:,1);
    outputG = output(:,:,2);
    outputB = output(:,:,3);
    
    suptitle('True R values v.s Predict R values')
    subplot(3,1,1); plot(targetR(:),targetR(:)); hold on; plot(targetR(:),outputR(:)); 
    xlabel('True R values');
    ylabel('Predict R value');
    subplot(3,1,2); plot(targetG(:),targetG(:)); hold on; plot(targetG(:),outputG(:)); 
    xlabel('True G values');
    ylabel('Predict G value');
    subplot(3,1,3); plot(targetB(:),targetB(:)); hold on; plot(targetB(:),outputB(:)); 
    xlabel('True B values');
    ylabel('Predict B value');
    
end
