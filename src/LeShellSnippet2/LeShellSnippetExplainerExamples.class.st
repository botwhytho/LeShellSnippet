Class {
	#name : #LeShellSnippetExplainerExamples,
	#superclass : #Object,
	#instVars : [
		'snippetElement'
	],
	#category : #'LeShellSnippet2-LeShellSnippet2'
}

{ #category : #example }
LeShellSnippetExplainerExamples >> addExplainerToButtons [
	<gtExample>
	| buttonsToExplain |
	snippetElement ifNil: [ snippetElement := self snippetElement ].
	buttonsToExplain := {
	(#doItButton
		-> (snippetElement query // #'Main toolbar') anyOne children first).
	(#doItAndGoButton
		-> (snippetElement query // #'Main toolbar') anyOne children second).
	(#debugButton
		-> (snippetElement query // #'Main toolbar') anyOne children third).
	(#helpButton
		-> (snippetElement query // LeShellSnippetCoderModelHelpActionId) anyOne).
	(#directoryButton
		-> (snippetElement query // #directoryPicker) anyOne).
	(#resultButton -> (snippetElement query // #resultBinding) anyOne).
	(#progressButton -> (snippetElement query // #progressButton) anyOne)}.
	buttonsToExplain
		do: [ :each | 
			each value
				addChild:
					(BrButton new
						constraintsDo: [ :c | c ignoreByLayout ];
						size: 5 @ 5;
						elevation: (BlRelativeElevation elevation: 10);
						geometry: BlCircle new;
						aptitude: (GtExplainerTargetAptitude new explanationModel: each key);
						relocate: 5 @ each value extent y / 2) ].
	^ snippetElement
]

{ #category : #example }
LeShellSnippetExplainerExamples >> explainerKeywords [
	<gtExample>
	^ {('Do It button' -> #doItButton).
	('Do It And Go' -> #doItAndGoButton).
	('Debug' -> #debugButton).
	('Help' -> #helpButton).
	('Directory Picker' -> #directoryButton).
	('Result Binding' -> #resultButton).
	('Progress' -> #progressButton)}
]

{ #category : #example }
LeShellSnippetExplainerExamples >> explanationString [
	<gtExample>
	^ 'A LeShellSnippet evaluates the Pharo code like a normal Pharo snippet, but after that sends `asString` to that result and sends that string to `OssUnixSubprocess` to be evaluated by the default shell. This will be run in the background so as not to block the main Pharo UI process. You will get visual feedback informing when the process is done. The underlying process is bound to a variable so that one can use the output of stdout/stderr in other Pharo/Pyton/JavaScript snippets. Currently piping input into the underlying shell''s stdin is not supported.


The UI of the LeShellSnippet is made of several parts:



- The Do It button evaluates the code in the snippet as described above.

- The Do It And Go button evaluates the code in the snippet as described above and inspects a wrapper object that contains an instance of `OssUnixSubprocess`
 as well as convenience variables for the process''s stdout/stderr.

- The Debug button debugs the snippet like a normal Pharo snippet. It DOES NOT send the output of the Pharo code to the shell. This is good to test the output of a programmatically generated string/command that will later be sent to the shell.

- The Help button brings up this UI explanation. For further documentation and implementation details look at the class comments.

- The Directory Picker button lets you define the working directory for the shell command to run in.


- The Result Binding button lets you specify the name of the variable you want to bind the results  to. After you run or inspect the snippet you can use that variable in other snippets, for example `leShell1 stdout` will get you the command''s standard output. By default, the name of the variable created is `leShell` + N, N being the number of shell snippets in the current page, so you should not have name clashes if you have multiple shell snippets in the same page.

- Finally, the Progress button will give you visual feedback to let you know if the command is still running or if it completed successfully or with errors (depending on the underlying process''s exit code). You can click on it to inspect the wrapper object that holds the underlying `OssUnixSubprocess` even if the command has not completed yet.'
]

{ #category : #example }
LeShellSnippetExplainerExamples >> explanationText [
	<gtExample>
	| text |
	text := self explanationString asRopedText.
	self keywordPositions
		do:
			[ :each | text perform: 'attribute:from:to:' asSymbol withArguments: each ].
	text glamorousRegularFont
		fontSize: 16;
		foreground: Color black.
	^ text
]

{ #category : #example }
LeShellSnippetExplainerExamples >> keywordPositions [
	<gtExample>
	| keywordPositions |
	keywordPositions := self explainerKeywords
		collect: [ :each | 
			| startPosition |
			startPosition := self explanationString findString: each key.
			{(GtExplainerExplanationAttribute new explanationModel: each value).
			startPosition.
			(startPosition + each key size)} ].
	^ keywordPositions
]

{ #category : #example }
LeShellSnippetExplainerExamples >> leShellSnippetExplainerExample [
	<gtExample>
	| container editor |
	container := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		layout: BlLinearLayout vertical.
	container explainer isExplanationHolder: true.
	editor := BrEditor new
		aptitude: (BrGlamorousRegularEditorAptitude new fontSize: 16);
		text: self explanationText;
		margin: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent.
			c linear weight: 0.3 ].
	container addChild: self snippetContainer.
	container addChild: editor.
	^ container
]

{ #category : #example }
LeShellSnippetExplainerExamples >> snippetContainer [
	<gtExample>
	| snippetContainer |
	snippetElement := self snippetElement.
	self addExplainerToButtons.
	snippetContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		layout: BlLinearLayout horizontal.
	snippetContainer addChild: snippetElement.
	^ snippetContainer
]

{ #category : #example }
LeShellSnippetExplainerExamples >> snippetElement [
	<gtExample>
	| snippetElement |
	snippetElement := BlUseAsyncFeatures
		disableDuring: [ LeShellSnippet2 new asPreviewElement ].
	(snippetElement query // #progressButton) anyOne
		visibility: BlVisibility visible;
		label: 'Running...';
		icon: BrGlamorousIcons graycircle asElement.
	snippetElement forceLayout.
	^ snippetElement
]
