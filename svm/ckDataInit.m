function data = ckDataInit(data)
    if ~exist('data','var')
        data = ckFileNavigator();
    end
 
    for i = 1: size(data,2)
        feature = data(i);
        feature.label = feature.label(4);
        
        n = zeros(size(feature.neutral, 1), 2);
        n(:,1) = feature.neutral(:,4);
        n(:,2) = feature.neutral(:,7);        
        feature.neutral = n;
        
        e = zeros(size(feature.extreme, 1),2);
        e(:,1) = feature.extreme(:,4);
        e(:,2) = feature.extreme(:,7);
        feature.extreme = e;
        
        data(i) = feature;   
        
        [~, e_align] = procrustes(n,e);
        
        data(i).e_align = e_align;
        data(i).difference = n - e_align;
    end
end