function varargout = prog4(varargin)
% PROG4 MATLAB code for prog4.fig
%      PROG4, by itself, creates a new PROG4 or raises the existing
%      singleton*.
%
%      H = PROG4 returns the handle to a new PROG4 or the handle to
%      the existing singleton*.
%
%      PROG4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROG4.M with the given input arguments.
%
%      PROG4('Property','Value',...) creates a new PROG4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before prog4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prog4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prog4

% Last Modified by GUIDE v2.5 08-Jun-2015 03:12:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @prog4_OpeningFcn, ...
                   'gui_OutputFcn',  @prog4_OutputFcn, ...
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


% --- Executes just before prog4 is made visible.
function prog4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to prog4 (see VARARGIN)

% Choose default command line output for prog4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes prog4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = prog4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
do=1;
if get(handles.save,'UserData')==0
    button=questdlg('Do you want to save the image before opening a new one?');
    if strcmp(button,'Yes')==1
        filename1=uiputfile({'*.png;*.jpg;*.bmp;*.tif;*.pxd'});
        if filename1~=0
            imwrite(getimage(handles.axes),filename1);
            set(handles.save,'UserData',1);
        else
            do=0;
        end
    elseif strcmp(button,'Cancel')==1 || strcmp(button,'')==1
        do=0;
    end
end
if do==1
    filename=uigetfile({'*.jpg;*.bmp;*.png;*.tif;*.pxd'});
    if filename~=0
        im=imread(filename);
        imshow(im);
        set(handles.un_do_all,'UserData',im);
        set(handles.save,'Enable','on');
        set(handles.save,'UserData',1);
        set(handles.un_do_all,'Enable','off');
        set(handles.un_do,'Enable','off');
        set(handles.re_do,'Enable','off');
        set(handles.n,'UserData',int16(get(handles.n,'Value')*length(getimage(handles.axes))/20)*2+1);
    end
end


function r_Callback(hObject, eventdata, handles)
% hObject    handle to r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of r as text
%        str2double(get(hObject,'String')) returns contents of r as a double
r=str2double(get(hObject,'String'));
if r>=0 && r<=1
    set(handles.color,'BackgroundColor',[r str2double(get(handles.g,'String')) str2double(get(handles.b,'String'))]);
else
    msgbox('Invalid RGB value', 'Error','error');
    c=get(handles.color,'BackgroundColor');
    set(hObject,'String',c(1));
end


% --- Executes during object creation, after setting all properties.
function r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=uiputfile({'*.png;*.jpg;*.bmp;*.tif;*.pxd'});
if filename~=0
    imwrite(getimage(handles.axes),filename);
    set(hObject,'UserData',1);
end



function g_Callback(hObject, eventdata, handles)
% hObject    handle to g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g as text
%        str2double(get(hObject,'String')) returns contents of g as a double
g=str2double(get(hObject,'String'));
if g>=0 && g<=1
    set(handles.color,'BackgroundColor',[ str2double(get(handles.r,'String')) g str2double(get(handles.b,'String'))]);
else
    msgbox('Invalid RGB value', 'Error','error');
    c=get(handles.color,'BackgroundColor');
    set(hObject,'String',c(2));
end


% --- Executes during object creation, after setting all properties.
function g_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_Callback(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b as text
%        str2double(get(hObject,'String')) returns contents of b as a double
b=str2double(get(hObject,'String'));
if b>=0 && b<=1
    set(handles.color,'BackgroundColor',[str2double(get(handles.r,'String')) str2double(get(handles.g,'String')) b]);
else
    msgbox('Invalid RGB value', 'Error','error');
    c=get(handles.color,'BackgroundColor');
    set(hObject,'String',c(3));
end


% --- Executes during object creation, after setting all properties.
function b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function n_Callback(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(hObject,'UserData',int16(get(hObject,'Value')*length(getimage(handles.axes))/20)*2+1);


% --- Executes during object creation, after setting all properties.
function n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'UserData',int16(1));


% --- Executes on button press in un_do.
function un_do_Callback(hObject, eventdata, handles)
% hObject    handle to un_do (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imshow(get(hObject,'UserData'));
set(hObject,'Enable','off');
set(handles.re_do,'Enable','on');
if get(hObject,'UserData')==get(handles.un_do_all,'UserData')
    set(handles.save,'UserData',1);
else
    set(handles.save,'UserData',0);
end


% --- Executes on button press in re_do.
function re_do_Callback(hObject, eventdata, handles)
% hObject    handle to re_do (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imshow(get(hObject,'UserData'));
set(hObject,'Enable','off');
set(handles.un_do,'Enable','on');
set(handles.save,'UserData',0);


% --- Executes on button press in un_do_all.
function un_do_all_Callback(hObject, eventdata, handles)
% hObject    handle to un_do_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imshow(get(hObject,'UserData'));
set(hObject,'Enable','off');
set(handles.un_do,'Enable','off');
set(handles.re_do,'Enable','off');
set(handles.save,'UserData',1);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
p=int16(get(handles.axes,'CurrentPoint'));
im=getimage(handles.axes);
sz=size(im);
if p(1)>0 && p(3)>0 && p(3)<sz(1) && p(1)<sz(2)
    set(handles.save,'UserData',0);
    set(handles.un_do_all,'Enable','on');
    set(handles.un_do,'Enable','on');
    set(handles.re_do,'Enable','off');
    set(handles.un_do,'UserData',im);
    n=(get(handles.n,'UserData')-1)/2;
    color=get(handles.color,'BackgroundColor');
    r=uint8(color(1)*256);
    g=uint8(color(2)*256);
    b=uint8(color(3)*256);
    if p(3)-n<=0
        x(1)=1;
    else
        x(1)=p(3)-n;
    end
    if p(3)+n>sz(1)
        x(2)=sz(1);
    else
        x(2)=p(3)+n;
    end
    if p(1)-n<=0
        y(1)=1;
    else
        y(1)=p(1)-n;
    end
    if p(1)+n>sz(2)
        y(2)=sz(2);
    else
        y(2)=p(1)+n;
    end
    im(x(1):x(2),y(1):y(2),1)=r;
    im(x(1):x(2),y(1):y(2),2)=g;
    im(x(1):x(2),y(1):y(2),3)=b;
    set(handles.re_do,'UserData',im);
    imshow(im);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.save,'UserData')==0
    button=questdlg('Do you want to save the image before closing the window?');
    if strcmp(button,'Yes')==1
        filename1=uiputfile({'*.png;*.jpg;*.bmp;*.tif;*.pxd'});
        if filename1~=0
            imwrite(getimage(handles.axes),filename1);
            set(handles.save,'UserData',1);
            delete(hObject);
        end
    elseif strcmp(button,'No')==1
        delete(hObject);
    end
else
    delete(hObject);
end
