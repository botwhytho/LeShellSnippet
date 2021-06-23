Class {
	#name : #LeShellSnippetElement2,
	#superclass : #LePharoSnippetElement,
	#category : #LeShellSnippet2
}

{ #category : #initialization }
LeShellSnippetElement2 >> initialize [
	super initialize.
	coderToolbar addChild: self settingsToolbar at: 3 as: #settings
]

{ #category : #initialization }
LeShellSnippetElement2 >> initializeDirectoryPicker [
	| aDropdownLook buttonElement dropdownButtonElement |
	buttonElement := BrButton new
		id: #directoryPicker;
		aptitude: BrGlamorousButtonWithLabelAptitude;
		"TODO: get values from serialized snippet if exists"
		label: FileLocator imageDirectory pathString.
	aDropdownLook := BrGlamorousWithDropdownAptitude
		handle: [ dropdownButtonElement := BrButton new.
			dropdownButtonElement
				label: buttonElement label;
				aptitude: BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude ]
		content: [ BrFileSelector new
				folder: FileLocator imageDirectory;
				"TODO: get values from serialized snippet if exists"
				fileFilterBlock: [ :aFile | aFile isDirectory ];
				okAction: [ :aDirectory :aButton | 
					aDirectory isDirectory
						ifTrue: [ buttonElement
								dispatchEvent: (BrDropdownHideWish new anchor: buttonElement).
							dropdownButtonElement label: aDirectory pathString.
							buttonElement label: aDirectory pathString ] ];
				buttonLabel: 'Choose Working Directory';
				exact: self extent;
				padding: (BlInsets all: 20);
				matchParent;
				vFitContentLimited ].
	buttonElement addAptitude: aDropdownLook.
	^ buttonElement
]

{ #category : #initialization }
LeShellSnippetElement2 >> initializeResultBinding [
	| label |
	label := BrEditableLabel new.
	label
		id: #resultBinding;
		inputFilter: BrTextEditorClassNameInputFilter new;
		constraintsDo: [ :c | c minWidth: 100 ];
		aptitude:
			(BrGlamorousEditableLabelAptitude new
				glamorousCodeFont;
				fontSize: 12);
		padding: (BlInsets all: 1);
		when: BrEditorAcceptWish
			do: [ :aWish | 
			label text: aWish text.
			self inform: aWish text asString , ' has been bound'.
			self inform: label text asString
			"label acceptEdition"
			"TODO: Re-bind OSSUnixSubprocess to new variable name" ];
		when: BrEditorCancelWish
			do:
				[ :aWish | "NEED anything here? aWish currentTarget fireEvent: BrDropdownHideWish new" ];
		whenKey: BlKeyCombination primaryC
			labelDo:
				[ :aShortcutEvent :aShortcut | Clipboard clipboardText: aShortcutEvent currentTarget text asString ].
	^ label
]

{ #category : #initialization }
LeShellSnippetElement2 >> newCoder [
	^ LeShellSnippetCoderModel2 new
]

{ #category : #'api - snippet view model' }
LeShellSnippetElement2 >> onSnippetViewModelChanged [
	| snippetsInPage |
	super onSnippetViewModelChanged.
	"self snippetViewModel coderViewModel bindingStrategy bindings
		localAt: #thisSnippetViewModel
		put: self snippetViewModel.
	self snippetViewModel coderViewModel bindingStrategy bindings
		localAt: #thisSnippet
		put: self snippetViewModel snippetModel."
	snippetsInPage := (self snippetViewModel snippetModel page children
		items select: [ :each | each isKindOf: LeShellSnippet2 ]) size.
	self snippetViewModel
		result: (self snippetToolbar query // #resultBinding) anyOne.
	self snippetViewModel result
		text: 'leShell' , snippetsInPage asString.
	self snippetViewModel
		workingDirectory: (self snippetToolbar query // #directoryPicker) anyOne
	"TODO: If serialized snippet has a value, retain that, otherwise pre-populate like above"
]

{ #category : #initialization }
LeShellSnippetElement2 >> settingsToolbar [
	| toolbar label |
	toolbar := BrToolbar new
		aptitude: (BrGlamorousToolbarAptitude new spacing: 4);
		padding: (BlInsets left: -4).
	toolbar
		addItems:
			{(BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				text: 'LeShellSnippet @ ').
			self initializeDirectoryPicker.
			(BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				text: 'Output Variable: ').
			self initializeResultBinding}.
	^ toolbar
]
