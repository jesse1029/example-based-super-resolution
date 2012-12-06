%This file is the entry function for the GUI represented in the .fig file


function varargout = superResolutionGUI(varargin)
% SUPERRESOLUTION MATLAB code for superResolution.fig
%      SUPERRESOLUTION, by itself, creates a new SUPERRESOLUTION or raises the existing
%      singleton*.
%
%      H = SUPERRESOLUTION returns the handle to a new SUPERRESOLUTION or the handle to
%      the existing singleton*.
%
%      SUPERRESOLUTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUPERRESOLUTION.M with the given input arguments.
%
%      SUPERRESOLUTION('Property','Value',...) creates a new SUPERRESOLUTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before superResolution_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to superResolution_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help superResolution

% Last Modified by GUIDE v2.5 05-Dec-2012 19:55:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @superResolution_OpeningFcn, ...
                   'gui_OutputFcn',  @superResolution_OutputFcn, ...
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
end
% End initialization code - DO NOT EDIT


% --- Executes just before superResolution is made visible.
function superResolution_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to superResolution (see VARARGIN)

axes(handles.subsampled);
axis off;
axes(handles.interpolated);
axis off;
axes(handles.superRes);
axis off;
axes(handles.differenceInterp);
axis off;
axes(handles.differenceSuperres);
axis off;
axes(handles.originalHiRes);
axis off;

axes(handles.selectImage);
axis off;

% Choose default command line output for superResolution
handles.output = hObject;
guidata(hObject, handles);

global alpha;
alpha = .5444;

global bucketSize;
bucketSize = 50;

set(handles.alphaEdit, 'String', num2str(alpha));
set(handles.bucketSizeEdit, 'String', num2str(bucketSize));

end

% --- Outputs from this function are returned to the command line.
function varargout = superResolution_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


% --- Executes on button press in generateTrainingSet.
function generateTrainingSet_Callback(hObject, eventdata, handles)
% hObject    handle to generateTrainingSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

existingImageNames = get(handles.trainingImages, 'String')

global alpha;
global bucketSize;
global saveFileName;
mkdir('training-data');
saveFileName = 'training-data/trainingData.mat';

buildTrainingSet(existingImageNames', saveFileName, alpha)

end

% --- Executes on button press in superResifyButton.
function superResifyButton_Callback(hObject, eventdata, handles)
% hObject    handle to superResifyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global alpha;
global bucketSize;
global saveFileName;
global inputImageName;

[subsampled interpolated superResImage differenceInterpolated differenceSuperres originalHiRes] = superRes(saveFileName, inputImageName, alpha, bucketSize);

axes(handles.selectImage);
cla;
imshow(im2double(imread(inputImageName)));

axes(handles.subsampled);
cla;
imshow(subsampled);

axes(handles.interpolated);
cla;
imshow(interpolated);

axes(handles.superRes);
cla;
imshow(superResImage);

axes(handles.differenceInterp);
cla;
imshow(uint8(differenceInterpolated));%hack for now

axes(handles.differenceSuperres);
cla;
imshow(uint8(differenceSuperres));%hack for now

axes(handles.originalHiRes);
cla;
imshow(originalHiRes);

end



% --- Executes on button press in selectImageButton.
function selectImageButton_Callback(hObject, eventdata, handles)
% hObject    handle to selectImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile('*.*');

global inputImageName;
inputImageName = strcat(pathname, filename);

inputImage = im2double(imread(inputImageName));

axes(handles.selectImage);
cla;
imshow(inputImage);


end


% --- Executes on button press in addTrainingImage.
function addTrainingImage_Callback(hObject, eventdata, handles)
% hObject    handle to addTrainingImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname] = uigetfile('*.*');

existingImageNames = get(handles.trainingImages, 'String');
existingImageNames{end+1} = strcat(pathname, filename);
set(handles.trainingImages, 'String', existingImageNames);

end



function alphaEdit_Callback(hObject, eventdata, handles)
% hObject    handle to alphaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alphaEdit as text
%        str2double(get(hObject,'String')) returns contents of alphaEdit as a double

global alpha;
alpha = str2double(get(hObject, 'String'));

end



function bucketSizeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to bucketSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bucketSizeEdit as text
%        str2double(get(hObject,'String')) returns contents of bucketSizeEdit as a double
global bucketSize;
bucketSize = str2double(get(hObject, 'String'));
end


% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, eventdata, handles)
% hObject    handle to resetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
existingImageNames = get(handles.trainingImages, 'String');
existingImageNames = {};
set(handles.trainingImages, 'String', existingImageNames);

end
