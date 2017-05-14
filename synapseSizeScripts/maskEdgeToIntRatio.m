function [maskImgs, ratios]=maskEdgeToIntRatio(segStack,postLabel)

ratios=[];
maskImgs=[];

for s=1:size(segStack,3)
    
    curPlane=segStack(:,:,s);
    
    if sum(sum(curPlane==postLabel))>0
        bwIm=curPlane;
        bwIm(bwIm~=postLabel)=0;
        bwIm(bwIm==postLabel)=1;
        maskImgs(1:512,1:512,s)=bwIm;
        
        b=bwboundaries(bwIm);
        bNum=length(b);
        bPixels=0;
        
        for j=1:bNum
            
            bPixels=bPixels+size(b{j},1);
            
        end
        
        ratios(s)=bPixels/sum(sum(bwIm==1));
        
    else
        ratios(s)=0;
        maskImgs(1:512,1:512,s)=0;
    end
    
    
    
    
end

end