'Changes from (10 April 2023 11:27:19 pm )'
Class new title: ClassPane
	subclassof: ListPane
	fields: 'systemPane organizationPane'
	declare: 'editmenu ';
	classified: 'Panes and Menus'

AnimWindow understands: 'tick  | time lastTick s
	["Do nothing unless at least 250 ms has elapsed since last tick"
	lastTick_ self style: lastTick.
	time _ user ticks.
	lastTickfalsefalse and time<(lastTick+stepTime)  [].
	self style: lastTick _ time.

	self showNextFrame.
	"Test hack to not disturb windows on top"
	false[user restore.
		for s from: ScrollBar allInstances do
			[s showing[s reshow]]]
	]' classified: 'as yet unclassified'

BrowseWindow understands: 'default 	"Let the user draw a five-paned window to browse through classes."
		| systemPane classPane orgPane selectorPane codePane
	["Create the panes."
	systemPane _ SystemPane new. classPane _ ClassPane new.
	orgPane _ OrganizationPane new. selectorPane _ SelectorPane new.
	codePane _ CodePane new.
	"Acquire them."
	self title: ''Classes''
		with: (systemPane, classPane, orgPane, selectorPane, codePane)
		at: stdTemplates.
	self newframe; show.
	"Interconnect them."
	systemPane to: classPane.
	classPane from: systemPane to: orgPane.
	orgPane from: classPane to: selectorPane.
	selectorPane from: orgPane to: codePane.
	codePane from: selectorPane.
	"Display them."
	systemPane update]' classified: 'as yet unclassified'

Class understands: 'inheritanceText | sups subs txt depth cls i t
	"Integer allSuperclasses"  "Integer allSubclasses"
	"String hierarchyText"
	[sups _ self allSuperclasses reverse.
	txt _ Stream default.
	depth _ 0.
	for i to: sups length do
		[cls _ supsi.
		for t to: i-1 do [txt tab].
		txt append: (supsi) title; cr.
		depth _ depth + 1].
	txt append: (self withSubclassesText: depth).
	 txt contents]'

Class understands: 'subclasses | cls classes
	"Array subclasses "
	[classes _ Set default.
	for cls from: Smalltalk allClasses
		do [cls superclass self
			[classes add: cls]].
	 classes contents]'

Class understands: 'subclassesText: depth | sups subs txt cls i t
	"Array subclassesText: 0"
	[txt _ Stream default.
	for t to: depth do [txt tab].
	txt append: self title; cr.

	subs _ self subclasses.  "Integer subclasses"
	for i to: subs length do
		[cls _ subsi.
		for t to: depth do [txt tab].
		txt append: ((subsi) subclassesText: depth+1)].
	 txt contents]'

Class understands: 'withSubclassesText: depth | sups subs txt cls i t
	"Array withSubclassesText: 0"
	[txt _ Stream default.
	for t to: depth do [txt tab].
	txt append: self title; cr.

	subs _ self subclasses.  "Integer subclasses"
	for i to: subs length do
		[cls _ subsi.
		"for t to: depth do [txt tab]."
		txt append: ((subsi) withSubclassesText: depth+1)].
	 txt contents]'

ClassPane understands: 'classInit   "ClassPane classInit. "
	[editmenu _ Menu new string:
''filout
print
forget
spawn
references
variables
classvars
inheritance'']' classified: 'as yet unclassified'

ClassPane understands: 'yellowbug | bug cls varName
	[selection = 0  [window flash]
	bug _ editmenu bug.
	cls _ Smalltalk  (list  selection).
	bug = 1  [cls filout]
	bug = 2  [cls printout]
	bug = 3  [systemPane forget: list  selection]
	bug = 4  [user schedule: (BrowseWindow new browseClass: cls). user run: true]
	bug = 5  [Smalltalk browseAllRefsTo: list  selection]
	bug = 6  [varName _ (cls instvars + (''- - - - -'') + cls classvars contents) choose.
			varNamefalsefalse[cls browseAllSourceWIthString: varName]]
	bug = 7  [cls classvars inspectWithTitle: cls title + '' classvars'']
	bug = 8  [user leaveTop; restartup: (CodeWindow new title: ''Inheritance of '' + cls title para: cls inheritanceText)]
	]' classified: 'as yet unclassified'

CodePane understands: 'help  "Smalltalk help."
	[user schedule: (CodeWindow new title: ''Useful expressions'' para: (SystemDictionary code: help)).
	"
 	Smalltalk browseChanges.
	Changes init.
	user filout: ''AlanChanges.st''.
	Smalltalk browseFiles.
	Smalltalk browseFiles: assetURL matching: ''*''.
	ShowAltoBounds_ true.

	user sched inspect -> vector of windows
	user findBuriedWindows.
	user schedule: ProjectSorter init.
	Undeclared inspectWithTitle: ''Undeclared''.
	Undeclared forgetUnreferencedEntries.
	Smalltalk inspectWithTitle: ''Smalltalk''.
	Smalltalk allGlobals inspectWithTitle: ''Globals''.
	Window browseAllSourceWIthString: ''exitflag''.
	Smalltalk browseAllSourceWIthString: '' t1 ''.
	Smalltalk browseSendersOf: unique.
	Smalltalk browseImplementersOf: title:rocessFrame:.
	user filoutWindowsOn: ''wintest.st''.
	Smalltalk _ SystemDictionary new copyfrom: Smalltalk.

	Things to clean up. . .
	Dorado, Notetaker, hardcopy, MethodKeeper, goBaby
		beAlto, NTCursor,
	CompiledMethod holdLiterals has bitBlt to nil ?? but works
	CompiledMethod numArgs:. crashes at BitBlt new bltObj:
		when edited in browser, but can compileAll
	MethodDict insert:method: etc
		same but can compileAll
	Decompiler/compile barfs onTextImage classInit
		and UserView bugScreenMenu
		and Window styleEdit
		These all have many literals
	Decompile/install gives scrollbar fibrillation
		This is because the decompile of ListPaneeachtime
		differs from its intended code  Try it: browse with
		shift key down (decompile) or not

	Get clipping working right for update of window titles
		see Classpane>selected and UserView>restore:without:
	"
	]'

Number understands: 'factorial  "I only work for positive integer values"
	[self  1[1]
	 self * (self-1) factorial]

"
A few to try
3 factorial
6 factorial
10 factorial
50 factorial
50 factorial / 49 factorial 50
"' classified: 'mathematical functions'

SystemDictionary understands: 'help  "Smalltalk help."
	[user schedule: (CodeWindow new title: ''Useful expressions'' para: (SystemDictionary code: help)).
	"
 	Smalltalk browseChanges.
	Changes init.
	user filout: ''ChangesApr10.st''.
	Smalltalk browseFiles.
	Smalltalk browseFiles: assetURL matching: ''*''.
	ShowAltoBounds_ true.

	user sched inspect -> vector of windows
	user findBuriedWindows.
	user schedule: ProjectSorter init.
	Undeclared inspectWithTitle: ''Undeclared''.
	Undeclared forgetUnreferencedEntries.
	Smalltalk inspectWithTitle: ''Smalltalk''.
	Smalltalk allGlobals inspectWithTitle: ''Globals''.
	Window browseAllSourceWIthString: ''exitflag''.
	Smalltalk browseAllSourceWIthString: '' t1 ''.
	Smalltalk browseSendersOf: unique.
	Smalltalk browseImplementersOf: title:rocessFrame:.
	user filoutWindowsOn: ''wintest.st''.
	Smalltalk _ SystemDictionary new copyfrom: Smalltalk.

	Things to clean up. . .
	Dorado, Notetaker, hardcopy, MethodKeeper, goBaby
		beAlto, NTCursor,
	CompiledMethod holdLiterals has bitBlt to nil ?? but works
	CompiledMethod numArgs:. crashes at BitBlt new bltObj:
		when edited in browser, but can compileAll
	MethodDict insert:method: etc
		same but can compileAll
	Decompiler/compile barfs onTextImage classInit
		and UserView bugScreenMenu
		and Window styleEdit
		These all have many literals
	Decompile/install gives scrollbar fibrillation
		This is because the decompile of ListPaneeachtime
		differs from its intended code  Try it: browse with
		shift key down (decompile) or not

	Get clipping working right for update of window titles
		see Classpane>selected and UserView>restore:without:
	"
	]'

UserView understands: 'restore
	[self restore: screenrect.
	ShowAltoBoundstrue
		[(6060 extent: 1808) clear: black]
	]' classified: 'displaying'

VariablePane understands: 'selected | class sel code
	[	[((self value is: String) and [self value has: ''''1]) 
			[valuePane browseMethodSpec: self value].
		((self value is: String) and [(self value1) = (''|''1)]) 
			[valuePane browseMethodSpec: self value].
		valuePane showing: self value asString].
	autoselect  nil []
	valuePane autoselect: autoselect]' classified: 'as yet unclassified'

Class derstands: 'hierarchyText' unique.

ClassPane derstands: 'noteCodePane:' unique.

ClassPane classInit

