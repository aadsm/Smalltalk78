UserView understands: 'classInit  "UserView classInit."
	[screenMenu _ Menu new string:
''go to parent project
go to next project
restore display
open a project
help
open a browser
open a workspace
open a space report
open form ...
create an arrow
create a rectangle
create an ellipse
create a star
tablet demo
turtle demo
edit file ...
file in ...
delete file ...
publish update ...
load updates
save
download'']' classified: 'project state and content'

UserView understands: 'bugScreenMenu | m w turtle i f index file
	[m _ 0.
	screenMenu bug
	= (m_m+1)  [projectWindow runParent];
	= (m_m+1)  [user shiftKey  [projectSequencer visitPrevious] projectSequencer visitNext];
	= (m_m+1)  [self restore];
	= (m_m+1)  [self schedule: ProjectWindow init];
	= (m_m+1)  [Smalltalk help];
	= (m_m+1)  [self schedule: BrowseWindow default];
	= (m_m+1)  [self schedule: (CodeWindow new title: ''Workspace'' para: '''')];
	= (m_m+1)  [self schedule: (CodeWindow new title: ''Space Report'' para: self reportSpace)];
	= (m_m+1)  [w _ self loadFormWindow  [self schedule: w enter]];
	= (m_m+1)  [self schedule: ArrowWindow default];
	= (m_m+1)  [self schedule: RectWindow default];
	= (m_m+1)  [self schedule: EllipseWindow default];
	= (m_m+1)  [self schedule: StarWindow default];
	= (m_m+1)  [self schedule: D1TopWindow default];
	= (m_m+1)  [self turtleDemo];
	= (m_m+1) 
		[f _ self fileMenu: ''edit'' directory: '''' matching: ''*''
			 [self editFile: f]];
	= (m_m+1) 
		[f _ self fileMenu: ''file in'' directory: '''' matching: ''*.st''
			 [self filin: f]];
	= (m_m+1) 
		[f _ self fileMenu: ''file delete'' directory: '''' matching: ''*''
			 [self confirm: ''Really delete '' + f  [self fileString: f _ nil]]];
	= (m_m+1) 
		[f _ self fileMenu: ''publish'' directory: '''' matching: ''*.st''
			 [file _ self fileString: f.
			self fileString: (self update: f _ file) _ file.
			self fileString: f _ nil]];
	= (m_m+1)  [self loadUpdates];
	= (m_m+1)  [user save];
	= (m_m+1)  [user download]]' classified: 'mouse, cursor and kbd'

UserView understands: 'primDownload [self croak] primitive: 300'

UserView understands: 'download | log
	[self currentDisplay: (Form new extent: 11 bits: ''--'' offset: nil).
	self primDownload.
	self restoredisplay.
	self restartTicks.
	self restore]'

UserView classInit

