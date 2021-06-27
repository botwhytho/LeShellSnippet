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
	| aDropdownLook buttonElement |
	buttonElement := BrButton new
		id: #directoryPicker;
		aptitude: BrGlamorousButtonWithLabelAptitude.
	aDropdownLook := BrGlamorousWithDropdownAptitude
		handle: [ BrButton new
				label: buttonElement label;
				aptitude: BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude ]
		content: [ BrFileSelector new
				folder: self snippetViewModel workingDirectory asFileReference;
				fileFilterBlock: [ :aFile | aFile isDirectory ];
				okAction: [ :aDirectory :aButton | 
					aDirectory isDirectory
						ifTrue: [ buttonElement
								dispatchEvent: (BrDropdownHideWish new anchor: buttonElement).
							buttonElement label: aDirectory pathString.
							self snippetViewModel workingDirectory: aDirectory pathString.
							self snippetViewModel snippetModel
								announceContentChangedBy: self snippetViewModel snippetModel ] ];
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
			self snippetViewModel resultVariable: aWish text asString.
			self snippetViewModel snippetModel
				announceContentChangedBy: self snippetViewModel snippetModel ];
		"TODO: Re-bind OSSUnixSubprocess to new variable name if process already ran?"
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
	| page resultName snippetsInPage |
	super onSnippetViewModelChanged.
	page := self snippetViewModel snippetModel page.
	snippetsInPage := page
		ifNil: [ 1 ]
		ifNotNil: [ :aPage | 
			(aPage children items
				select: [ :each | each isKindOf: LeShellSnippet2 ]) size ].
	resultName := 'leShell' , snippetsInPage asString.
	self snippetViewModel
		resultButton: (self snippetToolbar query // #resultBinding) anyOne.
	self snippetViewModel resultButton
		text:
			(self snippetViewModel resultVariable
				ifNil: [ self snippetViewModel resultVariable: resultName.
					resultName ]).
	self snippetViewModel
		directoryButton: (self snippetToolbar query // #directoryPicker) anyOne.
	self snippetViewModel directoryButton
		label:
			(self snippetViewModel workingDirectory
				ifNil: [ self snippetViewModel
						workingDirectory: FileLocator imageDirectory pathString.
					FileLocator imageDirectory pathString ]).
	self aptitude removeEventHandler: BlFocusOutEvent.
	self aptitude
		when: BlFocusOutEvent
		do: [ (self aptitude instVarNamed: #toolbarContainer)
				visibility: BlVisibility visible ].
	(self aptitude instVarNamed: #toolbarContainer)
		visibility: BlVisibility visible
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
