function [measurements]= measureSeg(segStack,label)

%Function that accepts a stack of segmentation masks, a
%target structure pixel value. The function will 1) determine whether a
%missing section interrupts the segmentation or not and 2) if it does
%return a series of volume or area measurements where the gap has been
%filled in by linear interpolation.



%Binerize the image
singleSeg=segStack;
singleSeg(singleSeg~=label)=0;
singleSeg(singleSeg==label)=1;

%Identify slices containing the segmented element
targSlices=[];

for z=1:size(segStack,3)
    
    if sum(sum(singleSeg(:,:,z)==1))>0
        targSlices=[targSlices,z];
    else
    end
    
end

%Identify section gaps in the segmentation
missing=find(diff(targSlices)>1);

% count seg pixels in each slice
pxNums=squeeze(sum(sum(singleSeg)));

%If this is a tbar seg stack
if label == 6
    
    %Multiply pxNum by pixel length,width, depth
    measurements=pxNums*4*4*40;
    
    %if its a pn seg
else
    
    %Multiply pxNum by pixel length,width
    measurements=pxNums*4*4;
    
end


%For each gap
for m=missing
    
    edgeSlice1=targSlices(m);
    edgeSlice2=targSlices(m+1);
    
    gapSections=[edgeSlice1+1:1:edgeSlice2-1];
    
    %Linear interpolation
    fill=interp1([edgeSlice1 edgeSlice2],[measurements(edgeSlice1), measurements(edgeSlice2)]...
        ,gapSections);
    
    %Put these values into my measurment array
    measurements(gapSections)=fill;
    
    
    
    
end


end