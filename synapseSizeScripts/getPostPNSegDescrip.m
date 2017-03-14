function [segD, ims]=getPostPNSegDescrip(segStack,postLabel)

segD=[];
ims=[];

counter=1;
for s=1:size(segStack,3)
    
    curPlane=segStack(:,:,s);
    
    if sum(sum(curPlane==postLabel))>0
        bwIm=curPlane;
        bwIm(bwIm~=postLabel)=0;
        bwIm(bwIm==postLabel)=1;
        
        stats=regionprops(bwIm,'Eccentricity','MajorAxisLength','MinorAxisLength','Extent');
        segD=[segD;[stats.Eccentricity,stats.MajorAxisLength,stats.MinorAxisLength]];
        
        if stats.MinorAxisLength>8
            ims(:,:,counter)=bwIm;
            counter=counter+1
        else
        end
            
        
        
    else
    end
    
end

end