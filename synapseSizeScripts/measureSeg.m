function [measurements, failFlag]= measureSeg(segStack, label)

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

%Folowing section calculates the size of the segmented element for each
%plane it is located in

%If this is a tbar seg stack
if label == 6
    
    % count seg pixels in each slice
    pxNums=squeeze(sum(sum(singleSeg)));
    
    %Multiply pxNum by pixel length,width, depth
    measurements=pxNums*4*4*40;
    
    %if its a PN seg
else
    
    measurements=zeros(1,size(segStack,3));
    
    
    %calculate the ratio of edge pixel num
    %to total seg mask pixel number for the
    %pn segmentation in each plane it is
    %present. Also store bw masks for
    %current PN membrane in masks
    
    [masks,ratios]=maskEdgeToIntRatio(segStack,label);
    
    %For each layer of the segmentation stack
    for s=1:size(segStack,3)
        
        %if the PN is present at the
        %synapse in this layer
        if sum(sum(segStack(:,:,s)))>0
            
            
            if ratios(s)>.8 %If the membrane is segmented as a line
                skMask=bwmorph(masks(:,:,s),'skel',Inf);
                numPx=sum(sum(skMask==1));
                pxLength=numPx*4;
                
                %Store the area, calculated for a membrane marked as a line
                %(length*depth of section)
                measurements(s)=pxLength*40;
                
                
            else %If the membrane is segmented as a polygon
                numPx=sum(sum(masks(:,:,s)==1));
                %To get the area of a
                %polygon I am multiplying
                %pixel number by the widht
                %and heigh of a pixel
                pxArea=numPx*4*4;
                %Here I am adding the area
                %of PN membrane (in nm^2)
                %in the current
                %section to our running sum
                measurements(s)=pxArea;
                
            end
            
        end
        
        
        
    end
    
end


%Now we will loop over the gaps and fill them in by linearly interpolating
%between edge values.

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