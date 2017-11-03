 function varargout = start(varargin)

 
 
%--------------------------------------------------------------------------
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @start_OpeningFcn, ...
                       'gui_OutputFcn',  @start_OutputFcn, ...
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
%--------------------------------------------------------------------------


%-------------Executes just before FIGURE is made visible------------------
 function start_OpeningFcn(hObject, ~, handles, varargin)
    clc
    movegui(gcf,'center')  
    folder = fileparts(which(mfilename)); 
    addpath(genpath(folder));
    tmp = matlab.desktop.editor.getActive;
    cd(fileparts(tmp.Filename));  
    currentFolder = pwd;
    
    set(handles.acse,'Value',1)
    set(handles.dcse,'Value',0)
    set(handles.power,'Value',1)
    set(handles.user,'Value',0)
    set(handles.bus_terminal,'Value',1)
    
    cd input_data/a1_ac/power_flow;    
    s = what;                                                    
    matfiles = s.mat;
    cd(currentFolder)                      
    handles.matfiles = matfiles;
    set(handles.listbox1, 'string', matfiles)
    
    handles.output = hObject;
    guidata(hObject, handles);
      
 function varargout = start_OutputFcn(~, ~, handles) 
    varargout{1} = handles.output;
%--------------------------------------------------------------------------


%-----------------------------Button Run-----------------------------------
 function pushbutton1_Callback(hObject, ~, handles)                         %#ok<DEFNU>
    clc 
    choose{1} = get(handles.acse,'Value');
    choose{2} = get(handles.dcse,'Value');
    choose{3} = get(handles.power,'Value');
    choose{4} = get(handles.user,'Value');
    choose{5} = get(handles.listbox1,'Value');
    choose{6} = handles.matfiles;
    choose{7} = [get(handles.bus_terminal,'Value') ...
                 get(handles.reactive_terminal,'Value') ...
                 get(handles.active_terminal,'Value') ...
                 get(handles.shunt_terminal,'Value') ...
                 get(handles.measurement_terminal,'Value') ...
                 get(handles.evaluation_terminal,'Value')];
        
    col = get(hObject,'backg');  
    set(hObject,'str','Running','backg',uint8([153 204 255]))
    pause(.01)  
    
    set(hObject,'Enable','off') 
    leeloo(choose);
    
    set(hObject,'Enable','on')
    set(hObject,'str','Run','backg',col)  
%--------------------------------------------------------------------------

 
%----------------------------Radio Button acse-----------------------------
 function acse_Callback(hObject, ~, handles)                                %#ok<DEFNU>
    acse = get(hObject,'Value');
    set(handles.acse,'Value',1);
    set(handles.shunt_terminal,'Enable','on') 
    set(handles.reactive_terminal,'Enable','on')
    currentFolder = pwd;
    power = get(handles.power,'Value');
    if acse == 1
       set(handles.dcse,'Value',0)
       set(handles.listbox1,'Value',1);
       if power == 1
          cd input_data/a1_ac/power_flow;
          s = what;                                                    
          matfiles = s.mat;                
       else
          cd input_data/a1_ac/user_data;
          s = what;                                                    
          matfiles = s.m;                
       end
    cd(currentFolder)                      
	handles.matfiles = matfiles;
	set(handles.listbox1, 'string', matfiles)
	guidata(hObject, handles);
    end   
%--------------------------------------------------------------------------


%----------------------------Radio Button dcse-----------------------------
 function dcse_Callback(hObject, ~, handles)                                %#ok<DEFNU>
    dcse = get(hObject,'Value');  
    set(handles.dcse,'Value',1);
    set(handles.shunt_terminal,'Value',0) 
    set(handles.reactive_terminal,'Value',0) 
    set(handles.shunt_terminal,'Enable','off') 
    set(handles.reactive_terminal,'Enable','off')
    currentFolder = pwd;
    power = get(handles.power,'Value');
    if dcse == 1
       set(handles.acse,'Value',0)
       set(handles.listbox1,'Value',1);
       if power == 1
          cd input_data/a2_dc/power_flow;
          s = what;                                                    
          matfiles = s.mat;
       else
          cd input_data/a2_dc/user_data; 
          s = what;                                                    
          matfiles = s.m;                
       end
	cd(currentFolder)                      
    handles.matfiles = matfiles;
    set(handles.listbox1, 'string', matfiles)
    guidata(hObject, handles);
    end       
%--------------------------------------------------------------------------


%---------------------------Radio Button power-----------------------------
 function power_Callback(hObject, ~, handles)                               %#ok<DEFNU>
    power = get(hObject,'Value');
    set(handles.power,'Value',1);    
    currentFolder = pwd;
    acse = get(handles.acse,'Value');
    if power == 1
       set(handles.user,'Value',0)
       set(handles.listbox1,'Value',1);
       if acse == 1
          cd input_data/a1_ac/power_flow;
       else
          cd input_data/a2_dc/power_flow; 
       end
    s = what;                                                    
    matfiles = s.mat;
    cd(currentFolder)                      
    handles.matfiles = matfiles;
    set(handles.listbox1, 'string', matfiles)
    guidata(hObject, handles);
    end      
%--------------------------------------------------------------------------


%----------------------------Radio Button user-----------------------------
 function user_Callback(hObject, ~, handles)                                %#ok<DEFNU>
    user = get(hObject,'Value');
    set(handles.user,'Value',1);
    currentFolder = pwd;
    acse = get(handles.acse,'Value');
    if user == 1
       set(handles.power,'Value',0)
       set(handles.listbox1,'Value',1);
       if acse == 1
          cd input_data/a1_ac/user_data;
       else
          cd input_data/a2_dc/user_data; 
       end
    s = what;                                                    
    matfiles = s.m;
    cd(currentFolder)                      
    handles.matfiles = matfiles;
    set(handles.listbox1, 'string', matfiles)
    guidata(hObject, handles);
    end      
%--------------------------------------------------------------------------


%----------------------Radio Button Bus Display----------------------------
 function bus_terminal_Callback(~, ~, handles)                              %#ok<DEFNU>
	get(handles.bus_terminal,'Value'); 
%--------------------------------------------------------------------------


%--------------------Radio Button Shunt Display----------------------------
 function shunt_terminal_Callback(~, ~, handles)                            %#ok<DEFNU>
	get(handles.shunt_terminal,'Value'); 
%--------------------------------------------------------------------------
    

%-------------------Radio Button Reactive Display--------------------------
 function reactive_terminal_Callback(~, ~, handles)                         %#ok<DEFNU>
	get(handles.reactive_terminal,'Value'); 
%--------------------------------------------------------------------------


%--------------------Radio Button Active Display---------------------------
 function active_terminal_Callback(~, ~, handles)                           %#ok<DEFNU>
	get(handles.active_terminal,'Value');
%--------------------------------------------------------------------------


%------------------Radio Button Measurement Display------------------------
 function measurement_terminal_Callback(~, ~, handles)                      %#ok<DEFNU>
	get(handles.measurement_terminal,'Value');
%--------------------------------------------------------------------------


%-------------------Radio Button Evaluation Display------------------------
 function evaluation_terminal_Callback(~, ~, handles)                       %#ok<DEFNU>
	get(handles.evaluation_terminal,'Value');
%--------------------------------------------------------------------------
