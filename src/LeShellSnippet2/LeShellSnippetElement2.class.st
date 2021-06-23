Class {
	#name : #LeShellSnippetElement2,
	#superclass : #LePharoSnippetElement,
	#category : #LeShellSnippet2
}

{ #category : #initialization }
LeShellSnippetElement2 >> initialize [
	super initialize.
	"self traceCr."
	coderToolbar addChild: self settingsToolbar at: 3 as: #settings.
	Halt now.
]

{ #category : #initialization }
LeShellSnippetElement2 >> initializeDirectoryPicker [
	| aDropdownLook buttonElement dropdownButtonElement |
	buttonElement := BrButton new
		id: #directoryPicker;
		aptitude: BrGlamorousButtonWithLabelAptitude;
		label: FileLocator imageDirectory pathString.
	aDropdownLook := BrGlamorousWithDropdownAptitude
		handle: [ dropdownButtonElement := BrButton new.
			dropdownButtonElement
				label: buttonElement label;
				aptitude: BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude ]
		content: [ BrFileSelector new
				folder: FileLocator imageDirectory;
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
	| label shellSnippetsInPage |
	"shellSnippetsInPage := (thisContext stack
		detect: [ :each | each contextClass = LePageToolContentTreeElement ])
		receiver snippetsViewModel children
		sum: [ :each | (each isKindOf: LeShellSnippetViewModel2) asBit ]."
	shellSnippetsInPage := 123.
	label := BrEditableLabel new.
	label
		id: #resultBinding;
			text: 'leShell' , shellSnippetsInPage asString;
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
