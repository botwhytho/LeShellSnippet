Class {
	#name : #LeShellSnippetElement2,
	#superclass : #LePharoSnippetElement,
	#instVars : [
		'progressButton',
		'resultButton',
		'directoryButton',
		'helpButton'
	],
	#classInstVars : [
		'suggestHelp'
	],
	#category : #LeShellSnippet2
}

{ #category : #acccessing }
LeShellSnippetElement2 class >> suggestHelp [
	^ suggestHelp
		ifNil: [ suggestHelp := false.
			true ]
]

{ #category : #initialization }
LeShellSnippetElement2 >> initialize [
	super initialize.
	coderToolbar addChild: self settingsToolbar at: 3 as: #settings
]

{ #category : #initialization }
LeShellSnippetElement2 >> initializeDirectoryButton [
	| aDropdownAptitude |
	directoryButton := BrButton new.
	directoryButton
		beSmallSize;
		id: #directoryPicker;
		aptitude: BrGlamorousButtonWithLabelAptitude.
	aDropdownAptitude := BrGlamorousWithDropdownAptitude
		handle: [ BrButton new
				label: directoryButton label;
				aptitude: BrGlamorousButtonWithLabelAptitude - BrGlamorousButtonExteriorAptitude ]
		content: [ BrFileSelector new
				folder: self snippetViewModel workingDirectory asFileReference;
				fileFilterBlock: [ :aFile | aFile isDirectory ];
				okAction: [ :aDirectory :aButton | 
					aDirectory isDirectory
						ifTrue: [ directoryButton
								dispatchEvent: (BrDropdownHideWish new anchor: directoryButton).
							directoryButton label: aDirectory pathString.
							self snippetViewModel workingDirectory: aDirectory pathString.
							self snippetViewModel snippetModel
								announceContentChangedBy: self snippetViewModel snippetModel ] ];
				buttonLabel: 'Choose Working Directory';
				exact: self extent;
				padding: (BlInsets all: 20);
				matchParent;
				vFitContentLimited ].
	directoryButton addAptitude: aDropdownAptitude.
	^ directoryButton
]

{ #category : #initialization }
LeShellSnippetElement2 >> initializeHelpButton [
	helpButton := BrButton new.
	helpButton
		beTinySize;
		label: 'Help' translated;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons question;
		action: [ helpButton
				enqueueTask:
					(BlTaskAction new
						action: [ helpButton phlow
								spawnObject: LeShellSnippetExplainerExamples new leShellSnippetExplainerExample ]) ];
		id: LeShellSnippetCoderModelHelpActionId.
	^ helpButton
]

{ #category : #initialization }
LeShellSnippetElement2 >> initializeProgressButton [
	progressButton := BrButton new.
	^ progressButton
		beSmallSize;
		id: #progressButton;
		aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
		visibility: BlVisibility hidden
]

{ #category : #initialization }
LeShellSnippetElement2 >> initializeResultButton [
	resultButton := BrEditableLabel new.
	resultButton
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
			resultButton text: aWish text.
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
	^ resultButton
]

{ #category : #initialization }
LeShellSnippetElement2 >> newCoder [
	^ LeShellSnippetCoderModel2 new
]

{ #category : #'api - snippet view model' }
LeShellSnippetElement2 >> onSnippetViewModelChanged [
	| page resultName snippetsInPage |
	super onSnippetViewModelChanged.
	self class suggestHelp
		ifTrue: [ helpButton addChild: (self onboardingUXOn: helpButton) ].
	page := self snippetViewModel snippetModel page.
	snippetsInPage := page
		ifNil: [ 1 ]
		ifNotNil: [ :aPage | 
			(aPage children items
				select: [ :each | each isKindOf: LeShellSnippet2 ]) size ].
	resultName := 'leShell' , snippetsInPage asString.
	resultButton
		text:
			(self snippetViewModel resultVariable
				ifNil: [ self snippetViewModel resultVariable: resultName.
					resultName ]).
	self snippetViewModel resultButton: resultButton.
	self snippetViewModel directoryButton: directoryButton.
	directoryButton
		label:
			(self snippetViewModel workingDirectory
				ifNil: [ self snippetViewModel
						workingDirectory: FileLocator imageDirectory pathString.
					FileLocator imageDirectory pathString ]).
	self snippetViewModel directoryButton: directoryButton.
	self snippetViewModel progressButton: progressButton.
	self snippetViewModel announcer
		when: ShellProcessCompleted
		do: [ :anAnnouncement | 
			self snippetViewModel progressButton
				label: 'Done';
				icon:
					(anAnnouncement shellCommand isSuccess
						ifTrue: [ BrGlamorousIcons greencircle asElement ]
						ifFalse: [ BrGlamorousIcons redcircle asElement ]) ].
	self aptitude removeEventHandler: BlFocusOutEvent.
	self aptitude
		when: BlFocusOutEvent
		do: [ (self aptitude instVarNamed: #toolbarContainer)
				visibility: BlVisibility visible ].
	(self aptitude instVarNamed: #toolbarContainer)
		visibility: BlVisibility visible
]

{ #category : #'api - snippet view model' }
LeShellSnippetElement2 >> onboardingUXOn: aButton [
	| anAnimation anOverlay fadeIn fadeOut |
	anOverlay := (BlOverlayElement on: aButton)
		background: ((Color fromHexString: #ffd666) alpha: 0).
	fadeIn := BlOpacityTransition new
		duration: 1.0 seconds;
		from: 0.0;
		to: 0.67;
		onStepDo: [ :eachColor | anOverlay background: eachColor ].
	fadeOut := BlOpacityTransition new
		duration: 1.0 seconds;
		from: 0.67;
		to: 0.0;
		onStepDo: [ :eachColor | anOverlay background: eachColor ].
	anAnimation := BlSequentialAnimation new
		addAll:
			{fadeIn.
			fadeOut};
		loops: 4;
		delay: 1 second;
		onFinishedDo: [ anOverlay removeFromParent ].
	anOverlay addAnimation: anAnimation.
	^ anOverlay
]

{ #category : #initialization }
LeShellSnippetElement2 >> settingsToolbar [
	| toolbar label |
	toolbar := BrToolbar new
		aptitude: (BrGlamorousToolbarAptitude new spacing: 4);
		padding: (BlInsets left: -4).
	toolbar
		addItems:
			{self initializeHelpButton.
			(BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				text: 'LeShellSnippet @ ').
			self initializeDirectoryButton.
			(BrLabel new
				aptitude: BrGlamorousLabelAptitude new;
				text: 'Output Variable: ').
			self initializeResultButton.
			self initializeProgressButton}.
	^ toolbar
]
