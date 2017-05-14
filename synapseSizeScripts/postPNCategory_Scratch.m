function [segD]=getPostPNSegDescrip(stack,postLabel)


postMembraneFeatures=[];

%Find image planes containing current PN segmentation

postPNPlanes=[];
segD=[];

for s=1:size(curSegFile.img,3)
    
    curPlane=curSegFile.img(:,:,s);
    
    if sum(sum(curPlane==postLabel))>0
        bwIm=curPlane;
        bwIm(bwIm~=postLabel)=0;
        bwIm(bwIm==postLabel)=1;
        
        stats=regionprops(bwIm,'Eccentricity','MajorAxisLength','MinorAxisLength');
        segD=[segD;[stats.Eccentricity,stats.MajorAxisLength,stats.MinorAxisLength]]
        
    else
    end
    
end

end