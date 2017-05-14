function varargout = multiPNHandSeg(varargin)
% MULTIPNHANDSEG MATLAB code for multiPNHandSeg.fig
%      MULTIPNHANDSEG, by itself, creates a new MULTIPNHANDSEG or raises the existing
%      singleton*.
%
%      H = MULTIPNHANDSEG returns the handle to a new MULTIPNHANDSEG or the handle to
%      the existing singleton*.
%
%      MULTIPNHANDSEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTIPNHANDSEG.M with the given input arguments.
%
%      MULTIPNHANDSEG('Property','Value',...) creates a new MULTIPNHANDSEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before multiPNHandSeg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to multiPNHandSeg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help multiPNHandSeg

% Last Modified by GUIDE v2.5 04-Apr-2017 16:25:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @multiPNHandSeg_OpeningFcn, ...
    'gui_OutputFcn',  @multiPNHandSeg_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before multiPNHandSeg is made visible.
function multiPNHandSeg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to multiPNHandSeg (see VARARGIN)

% Choose default command line output for multiPNHandSeg
handles.output = hObject;


handles.synapseVolsDir='/Users/williamtobin/Desktop/wfly1_synapseVols2';

% %Load elementSizes matrix
% load([handles.synapseVolsDir,'/elementSizes.mat'])
% handles.elementSizes=elementSizes;

%Load segIDs matrix
load([handles.synapseVolsDir,'/segIDs.mat'])
handles.segIDs=segIDs;

%Load forHandSeg matrix
load([handles.synapseVolsDir,'/forHandSeg.mat'])
handles.forHandSeg=forHandSeg;

%Load connID matrix, matrix is Conn ID by orn ID by pn ID
load([handles.synapseVolsDir,'/multiSynList.mat'])
handles.connIDs=multiSynList;

%initialize some lists we will need
handles.leftORNSubset=[337396,401197,492811,320688,699676];
handles.rightORNSubset=[360235,362982,332797,379044,362999];
handles.ORNSubset=[handles.leftORNSubset,handles.rightORNSubset];
handles.users={'JK','HY','BS','WC'};

% Load annotations json. Generated by Wei's code gen_annotation_map.py
annotations=loadjson('~/tracing/sid_by_annotation.json');

%return all skeleton IDs of DM6 PNs
handles.PNs=sort(annotations.DM6_0x20_PN);

% %Load the connector structure
% load('~/tracing/conns.mat')
%
% %gen conn fieldname list
% connFields=fieldnames(conns);

%Set textbox 2's fontsize
set(handles.text2,'FontSize',18)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes multiPNHandSeg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = multiPNHandSeg_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



if exist(handles.todoPath)~=0
    load(handles.todoPath)
    handles.segFilesToDo=segFilesToDo;
%     
%     localPaths=segFilesToDo;
%     
%     for i=1:length(segFilesToDo)
%         path=segFilesToDo{i,1};
%         slashes=find(path=='/');
%         localPath=[handles.synapseVolsDir,path(slashes(4):end)];
%         localPaths{i,1}=localPath;
%     end
%         

     handles.curTracerFilesToDo=segFilesToDo;
else
    %Create a list of all segFiles that the current tracer produced
    segFilesToDo={};
    counter=1;
    
    for f =1:length(handles.forHandSeg)
        
        %Generating paths appropriate for local machine
        myLaptopPath=handles.forHandSeg{f}(1:end-1);
        connLoc=myLaptopPath(regexp(myLaptopPath,'\d*_\d*\/\d*$'):end);
        connID=myLaptopPath(regexp(myLaptopPath,'\d*$'):end);
        connFolder=[handles.synapseVolsDir,'/',connLoc];
        curSegFileDir=dir(strcat(connFolder,'/',connID,'_**.nii'));
        
        
        if size(curSegFileDir,1)<3
            
            error('There are not three seg files for the current connector')
            
        else
            for s=1:size(curSegFileDir,1)
                
                %See if the current tracer was the author
                if sum(curSegFileDir(s).name(end-5:end-4)==handles.users{handles.tracerIDNum})==2
                    
                    segFilesToDo{counter,1}=[connFolder,'/',curSegFileDir(s).name];
                    segFilesToDo{counter,2}=f;
                    counter=counter+1;
                else
                end
                
            end
        end
    end
    
    %cell array of segmentation file paths that need to be dona
    % and the corresponding index for forHandSeg matrix
    
    handles.curTracerFilesToDo=segFilesToDo;
    save(handles.todoPath,'segFilesToDo')
    
end


%Set the first entry in the todolist as the current working file to sort

handles.workingFile=handles.curTracerFilesToDo{1,1};

%store the parent dir as well
slashes=find(handles.workingFile=='/');
handles.workingDir=handles.workingFile(1:slashes(end));

% curTracerFilesToDo{1,2} this is the index of the forHandSeg matrix that
% corresponds to the segmentation file listed in curTracerFilesToDo{1,1}.
% This is the same index as in multiSynList(handles.connIDs) which has the
% ORN, PN and Connector IDs in it

handles.workingPNLabel=handles.forHandSeg{handles.curTracerFilesToDo{1,2},2};
handles.workingConnID=handles.connIDs(handles.curTracerFilesToDo{1,2},1);
handles.workingORNID=handles.connIDs(handles.curTracerFilesToDo{1,2},2);
handles.workingPNID=handles.connIDs(handles.curTracerFilesToDo{1,2},3);

%Load the stack image
curImFile=load_nii(strcat(handles.workingDir,num2str(handles.workingConnID),'.nii'));

handles.imStack=uint8(curImFile.img);

%load the segementation file for this synapse
curSegFile=load_nii(handles.workingFile);
handles.segIm=uint8(curSegFile.img);

%Load the locations file
locations=loadjson(strcat( handles.workingDir,'locations.json'));
handles.locations=locations;

%Start with the first pn profile at this synapse
handles.curProfNum=1;

%Highlight this profile with a red square, black out the rest

strP=num2str(handles.workingPNID);
handles.pnField=['x0x3',strP(1),'_',strP(2:end)];
pnField=['x0x3',strP(1),'_',strP(2:end)];

locFieldNames=fieldnames(handles.locations);

for field=1:length(fieldnames(locations))
    %Ignore catmaid coords
    if strcmp(locFieldNames{field},'catmaidCoords')==1
        
    elseif strcmp(locFieldNames{field},pnField)==1
        
        %loop over each profile tagged in this stack
        for i=1:size(handles.locations.(pnField),1)
            
            pos=handles.locations.(pnField)(i,:);
            %I think this should correct for the fact that pixels are
            %numbered according to python convention which starts at 0
            
            pos=pos+1;
            %if its the first one, mark it red
            if i==handles.curProfNum
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),1)=255;
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),2)=0;
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),3)=0;
                
            else
                
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),1)=0;
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),2)=0;
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),3)=0;
                
            end
        end
        
    else %Mark any other pns and the tbar black
        
        for i=1:size(handles.locations.(locFieldNames{field}),1)
            
            pos=handles.locations.(locFieldNames{field})(i,:);
            %I think this should correct for the fact that pixels are
            %numbered according to python convention which starts at 0
            
            pos=pos+1;
            
            handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),1)=0;
            handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),2)=0;
            handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),3)=0;
            
        end
        
        
    end
end


%Binerize the segmentation image
handles.pnSeg=handles.segIm;
handles.pnSeg(handles.pnSeg~=handles.workingPNLabel)=0;
handles.pnSeg(handles.pnSeg==handles.workingPNLabel)=1;


%Identify the sections of the image containing sementations of the
%current PN

handles.targSlices=[];

for z=1:size(handles.pnSeg,3)
    
    if sum(sum(handles.pnSeg(:,:,z)==1))>0
        
        handles.targSlices=[handles.targSlices,z];
        
    else
    end
    
end

 handles.targSlices=[handles.targSlices(1)-5:1:handles.targSlices(end)+5];


%Display the first slice of the stack
handles.curSlice=1;
handles.curFrame=squeeze(handles.imStack(:,:,handles.targSlices(handles.curSlice),:));
mask=logical(handles.pnSeg(:,:,handles.targSlices(1)));
handles.curFrame(mask)=255;
image(handles.curFrame)

%display the number of PN profs in the segmentation
set(handles.text2,'String',size(handles.locations.(pnField),1))

%initialize an array to store the curent profiles segmentation
handles.curProfSeg=zeros(size(handles.pnSeg));

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if handles.curSlice == numel(handles.targSlices)
    disp('Last Segmented Slice')
else
    
    handles.curSlice=handles.curSlice+1;
    handles.curFrame=squeeze(handles.imStack(:,:,handles.targSlices(handles.curSlice),:));
    mask=logical(handles.pnSeg(:,:,handles.targSlices(handles.curSlice)));
    handles.curFrame(mask)=255;
    image(handles.curFrame)
    
    
end

% Update handles structure
guidata(hObject, handles);







% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%Display the first slice of the stack
if handles.curSlice == 1
    disp('First Segmented Slice')
else
    
    handles.curSlice=handles.curSlice-1;
    handles.curFrame=squeeze(handles.imStack(:,:,handles.targSlices(handles.curSlice),:));
    mask=logical(handles.pnSeg(:,:,handles.targSlices(handles.curSlice)));
    handles.curFrame(mask)=255;
    image(handles.curFrame)
    
    
end

% Update handles structure
guidata(hObject, handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

%handles.curProfNum=str2double(get(hObject,'String'));
handles.tracerIDNum=str2double(get(hObject,'String'));

%Set ToDo list path
handles.todoPath=[handles.synapseVolsDir,'/tracer_',num2str(handles.tracerIDNum),'_ToDo.mat'];

%Check to see if there is a user copy of the elementSizes matrix, if not
%make one

if exist([handles.synapseVolsDir,'/tracer_',num2str(handles.tracerIDNum),'_elementSizes.mat'])~=0
    
    %Load elementSizes matrix
    load([handles.synapseVolsDir,'/tracer_',num2str(handles.tracerIDNum),'_elementSizes.mat'])
    handles.elementSizes=elementSizes;
    
else
    
    %make a copy of elementSizes to work with
    copyfile([handles.synapseVolsDir,'/elementSizes.mat'],...
        [handles.synapseVolsDir,'/tracer_',num2str(handles.tracerIDNum),'_elementSizes.mat'])
    
    %load it and store it
    load([handles.synapseVolsDir,'/tracer_',num2str(handles.tracerIDNum),'_elementSizes.mat'])
    handles.elementSizes=elementSizes;
    
end



% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
    
end




% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Store the segmented pixels within the drawn ROI in our single profile
%segmentation stack

handles.singleProfPx=logical( handles.pnSeg(:,:,handles.targSlices(handles.curSlice)))...
    & handles.roiMask;

handles.curProfSeg(:,:,handles.targSlices(handles.curSlice))=handles.singleProfPx;

%Delete these pixels from the pnSeg file
dispPNSeg=handles.pnSeg(:,:,handles.targSlices(handles.curSlice));
dispPNSeg(handles.singleProfPx)=0;
handles.pnSeg(:,:,handles.targSlices(handles.curSlice))=dispPNSeg;

%redisplay the image
handles.curFrame=squeeze(handles.imStack(:,:,handles.targSlices(handles.curSlice),:));
mask=logical(handles.pnSeg(:,:,handles.targSlices(handles.curSlice)));
handles.curFrame(mask)=255;
image(handles.curFrame)


% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%delete these pixels from the curProfSeg stack
curPNSeg=handles.curProfSeg(:,:,handles.targSlices(handles.curSlice));
curPNSeg(handles.singleProfPx)=0;
handles.curProfSeg(:,:,handles.targSlices(handles.curSlice))=curPNSeg;

%Add these pixels back to the pnSeg stack
handles.pnSeg(:,:,handles.targSlices(handles.curSlice))=...
    handles.pnSeg(:,:,handles.targSlices(handles.curSlice))+...
    uint8(handles.singleProfPx);


%redisplay the image
handles.curFrame=squeeze(handles.imStack(:,:,handles.targSlices(handles.curSlice),:));
mask=logical(handles.pnSeg(:,:,handles.targSlices(handles.curSlice)));
handles.curFrame(mask)=255;
image(handles.curFrame)



% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%save the segmentation for this profile
segToSave=handles.curProfSeg;
save([handles.workingDir,num2str(handles.workingConnID),'_',...
    num2str(handles.workingPNID),'_',num2str(handles.curProfNum),'_',...
    handles.users{handles.tracerIDNum},'.mat'],'segToSave')


%store postsynaptic pn area in the proper position in elementSizes
ornNum=find(handles.ORNSubset==handles.workingORNID);
pnNum=find(handles.PNs==handles.workingPNID);
curProfLoc=handles.locations.(handles.pnField)(handles.curProfNum,:);
tbarVol=sum(measureSeg(handles.segIm,6));

%Find this position in the elementSizes matrix
connArray=handles.elementSizes{ornNum,pnNum,handles.tracerIDNum};
rowPos=find(ismember(connArray(:,[1,5,6,7]),[tbarVol,curProfLoc],'rows'));

%Calculate pn membrane area
pnArea=sum(measureSeg(handles.curProfSeg,1));

%store it and save it
handles.elementSizes{ornNum,pnNum,handles.tracerIDNum}(rowPos,2)=pnArea;
handles.elementSizes{ornNum,pnNum,handles.tracerIDNum}(rowPos,:)
elementSizes=handles.elementSizes;
save([handles.synapseVolsDir,'/tracer_',num2str(handles.tracerIDNum),'_elementSizes.mat'],...
    'elementSizes')

%increment the profile counter
handles.curProfNum=handles.curProfNum+1;


%Highlight this profile with a red square, black out the rest
strP=num2str(handles.workingPNID);
handles.pnField=['x0x3',strP(1),'_',strP(2:end)];
pnField=['x0x3',strP(1),'_',strP(2:end)];

locFieldNames=fieldnames(handles.locations);
locations=handles.locations;

for field=1:length(fieldnames(locations))
    %Ignore catmaid coords
    if strcmp(locFieldNames{field},'catmaidCoords')==1
        
    elseif strcmp(locFieldNames{field},pnField)==1
        
        %loop over each profile tagged in this stack
        for i=1:size(handles.locations.(pnField),1)
            
            pos=handles.locations.(pnField)(i,:);
            %I think this should correct for the fact that pixels are
            %numbered according to python convention which starts at 0
            
            pos=pos+1;
            %if its the current prof, mark it red
            if i==handles.curProfNum
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),1)=255;
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),2)=0;
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),3)=0;
                
            else
                
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),1)=0;
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),2)=0;
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),3)=0;
                
            end
        end
        
    else %Mark any other pns and the tbar black
        
        for i=1:size(handles.locations.(locFieldNames{field}),1)
            
            pos=handles.locations.(locFieldNames{field})(i,:);
            %I think this should correct for the fact that pixels are
            %numbered according to python convention which starts at 0
            
            pos=pos+1;
            
            handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),1)=0;
            handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),2)=0;
            handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),3)=0;
            
        end
        
        
    end
end


%Display the first slice of the stack
handles.curSlice=1;
handles.curFrame=squeeze(handles.imStack(:,:,handles.targSlices(handles.curSlice),:));
mask=logical(handles.pnSeg(:,:,handles.targSlices(1)));
handles.curFrame(mask)=255;
image(handles.curFrame)

%display the number of PN profs in the segmentation
set(handles.text2,'String',size(handles.locations.(pnField),1))

%initialize an array to store the curent profiles segmentation
handles.curProfSeg=zeros(size(handles.pnSeg));

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

roi=imfreehand;
handles.roiMask=roi.createMask;
clear roi


% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


confirm=input('Are you sure you want to move to the next file? y or n', 's');

if confirm =='y'
    %toc
    %Remove the working file from the todolist and resave it
    handles.curTracerFilesToDo(1,:)=[];
    handles.segFilesToDo(1,:)=[];
    segFilesToDo=handles.segFilesToDo;
    save(handles.todoPath,'segFilesToDo')
    size(handles.curTracerFilesToDo)
       
    
    %Set the first entry in the todolist as the current working file to sort
    handles.workingFile=handles.curTracerFilesToDo{1,1};
    
    %store the parent dir as well
    slashes=find(handles.workingFile=='/');
    handles.workingDir=handles.workingFile(1:slashes(end));
    
    % curTracerFilesToDo{1,2} this is the index of the forHandSeg matrix that
    % corresponds to the segmentation file listed in curTracerFilesToDo{1,1}.
    % This is the same index as in multiSynList(handles.connIDs) which has the
    % ORN, PN and Connector IDs in it
    
    handles.workingPNLabel=handles.forHandSeg{handles.curTracerFilesToDo{1,2},2};
    handles.workingConnID=handles.connIDs(handles.curTracerFilesToDo{1,2},1);
    handles.workingORNID=handles.connIDs(handles.curTracerFilesToDo{1,2},2);
    handles.workingPNID=handles.connIDs(handles.curTracerFilesToDo{1,2},3);
    
    %Load the stack image
    curImFile=load_nii(strcat(handles.workingDir,num2str(handles.workingConnID),'.nii'));
    handles.imStack=uint8(curImFile.img);
    
    %load the segementation file for this synapse
    curSegFile=load_nii(handles.workingFile);
    handles.segIm=uint8(curSegFile.img);
    
    %Load the locations file
    locations=loadjson(strcat( handles.workingDir,'locations.json'));
    handles.locations=locations;
    
    %Start with the first pn profile at this synapse
    handles.curProfNum=1;
    
    %Highlight this profile with a red square, black out the rest
    
    strP=num2str(handles.workingPNID);
    handles.pnField=['x0x3',strP(1),'_',strP(2:end)];
    pnField=['x0x3',strP(1),'_',strP(2:end)];
    
    locFieldNames=fieldnames(handles.locations);
    
    for field=1:length(fieldnames(locations))
        %Ignore catmaid coords
        if strcmp(locFieldNames{field},'catmaidCoords')==1
            
        elseif strcmp(locFieldNames{field},pnField)==1
            
            %loop over each profile tagged in this stack
            for i=1:size(handles.locations.(pnField),1)
                
                pos=handles.locations.(pnField)(i,:);
                %I think this should correct for the fact that pixels are
                %numbered according to python convention which starts at 0
                
                pos=pos+1;
                %if its the first one, mark it red
                if i==handles.curProfNum
                    handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),1)=255;
                    handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),2)=0;
                    handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),3)=0;
                    
                else
                    
                    handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),1)=0;
                    handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),2)=0;
                    handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),3)=0;
                    
                end
            end
            
        else %Mark any other pns and the tbar black
            
            for i=1:size(handles.locations.(locFieldNames{field}),1)
                
                pos=handles.locations.(locFieldNames{field})(i,:);
                %I think this should correct for the fact that pixels are
                %numbered according to python convention which starts at 0
                
                pos=pos+1;
                
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),1)=0;
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),2)=0;
                handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),3)=0;
                
            end
            
            
        end
    end
    
    
    %Binerize the segmentation image
    handles.pnSeg=handles.segIm;
    handles.pnSeg(handles.pnSeg~=handles.workingPNLabel)=0;
    handles.pnSeg(handles.pnSeg==handles.workingPNLabel)=1;
    
    
    %Identify the sections of the image containing sementations of the
    %current PN
    
    handles.targSlices=[];
    
    for z=1:size(handles.pnSeg,3)
        
        if sum(sum(handles.pnSeg(:,:,z)==1))>0
            
            handles.targSlices=[handles.targSlices,z];
            
        else
        end
        
    end
    
    handles.targSlices=[handles.targSlices(1)-5:1:handles.targSlices(end)+5];
    
    
    %Display the first slice of the stack
    handles.curSlice=1;
    handles.curFrame=squeeze(handles.imStack(:,:,handles.targSlices(handles.curSlice),:));
    mask=logical(handles.pnSeg(:,:,handles.targSlices(1)));
    handles.curFrame(mask)=255;
    image(handles.curFrame)
    
    %initialize an array to store the curent profiles segmentation
    handles.curProfSeg=zeros(size(handles.pnSeg));
    
    %display the number of PN profs in the segmentation
    set(handles.text2,'String',size(handles.locations.(pnField),1))
    tic
else
end
    % Update handles structure
    guidata(hObject, handles);
    


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Because this is the last prof, we can assign everything left to it
handles.curProfSeg=handles.pnSeg;

%save the segmentation for this profile
segToSave=handles.curProfSeg;
save([handles.workingDir,num2str(handles.workingConnID),'_',...
    num2str(handles.workingPNID),'_',num2str(handles.curProfNum),'_',...
    handles.users{handles.tracerIDNum},'.mat'],'segToSave')


%store postsynaptic pn area in the proper position in elementSizes
ornNum=find(handles.ORNSubset==handles.workingORNID);
pnNum=find(handles.PNs==handles.workingPNID);
curProfLoc=handles.locations.(handles.pnField)(handles.curProfNum,:);
tbarVol=sum(measureSeg(handles.segIm,6));

%Find this position in the elementSizes matrix
connArray=handles.elementSizes{ornNum,pnNum,handles.tracerIDNum};
rowPos=find(ismember(connArray(:,[1,5,6,7]),[tbarVol,curProfLoc],'rows'));

%Calculate pn membrane area
pnArea=sum(measureSeg(handles.curProfSeg,1));

%store it and save it
handles.elementSizes{ornNum,pnNum,handles.tracerIDNum}(rowPos,2)=pnArea;
handles.elementSizes{ornNum,pnNum,handles.tracerIDNum}(rowPos,:)
elementSizes=handles.elementSizes;
save([handles.synapseVolsDir,'/tracer_',num2str(handles.tracerIDNum),'_elementSizes.mat'],...
    'elementSizes')

% %increment the profile counter
% handles.curProfNum=handles.curProfNum+1;
% 
% 
% %Highlight this profile with a red square, black out the rest
% strP=num2str(handles.workingPNID);
% handles.pnField=['x0x3',strP(1),'_',strP(2:end)];
% pnField=['x0x3',strP(1),'_',strP(2:end)];
% 
% locFieldNames=fieldnames(handles.locations);
% locations=handles.locations;
% 
% for field=1:length(fieldnames(locations))
%     %Ignore catmaid coords
%     if strcmp(locFieldNames{field},'catmaidCoords')==1
%         
%     elseif strcmp(locFieldNames{field},pnField)==1
%         
%         %loop over each profile tagged in this stack
%         for i=1:size(handles.locations.(pnField),1)
%             
%             pos=handles.locations.(pnField)(i,:);
%             %I think this should correct for the fact that pixels are
%             %numbered according to python convention which starts at 0
%             
%             pos=pos+1;
%             %if its the current prof, mark it red
%             if i==handles.curProfNum
%                 handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),1)=255;
%                 handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),2)=0;
%                 handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),3)=0;
%                 
%             else
%                 
%                 handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),1)=0;
%                 handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),2)=0;
%                 handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),3)=0;
%                 
%             end
%         end
%         
%     else %Mark any other pns and the tbar black
%         
%         for i=1:size(handles.locations.(locFieldNames{field}),1)
%             
%             pos=handles.locations.(locFieldNames{field})(i,:);
%             %I think this should correct for the fact that pixels are
%             %numbered according to python convention which starts at 0
%             
%             pos=pos+1;
%             
%             handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),1)=0;
%             handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),2)=0;
%             handles.imStack(pos(1)-2:pos(1)+2,pos(2)-2:pos(2)+2,pos(3),3)=0;
%             
%         end
%         
%         
%     end
% end
% 
% 
% %Display the first slice of the stack
% handles.curSlice=1;
% handles.curFrame=squeeze(handles.imStack(:,:,handles.targSlices(handles.curSlice),:));
% mask=logical(handles.pnSeg(:,:,handles.targSlices(1)));
% handles.curFrame(mask)=255;
% image(handles.curFrame)
% 
% %initialize an array to store the curent profiles segmentation
% handles.curProfSeg=zeros(size(handles.pnSeg));

% Update handles structure
guidata(hObject, handles);
