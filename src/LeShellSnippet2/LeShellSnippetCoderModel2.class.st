Class {
	#name : #LeShellSnippetCoderModel2,
	#superclass : #GtPharoSnippetCoder,
	#category : #'LeShellSnippet2-LeShellSnippet2'
}

{ #category : #initialization }
LeShellSnippetCoderModel2 >> initialize [
	super initialize.
	"self traceCr."
	"Halt now."
]

{ #category : #'UI specific' }
LeShellSnippetCoderModel2 >> initializeAddOns: addOns [
	addOns addStyler: GtPharoStyler new.
	addOns addStyler: GtPharoDynamicHighlightStyler new.
	addOns addStyler: GtPharoDeprecationStyler new.
	addOns addStyler: GtPharoMethodExpanderStyler new.
	addOns addStyler: (GtFixItStyler new isForWorkspace: true).
	addOns
		addMainAction: 'Evaluate' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anEvent | 
			GtCoderCodeExecutor doIt
				coderUIModel: aCoderUIModel;
				event: anEvent;
				execute ]
		id: GtSourceCoderDoItActionId.
	addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | 
			GtCoderCodeExecutor doItAndGo
				coderUIModel: aCoderUIModel;
				event: anEvent;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.
	addOns
		addMainAction: 'Debug' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :aCoderUIModel :anEvent | aCoderUIModel debug ]
		id: GtSourceCoderDebugActionId.
	addOns
		addMainAction: 'Help' translated
		icon: BrGlamorousVectorIcons question
		action: [ :aCoderUIModel :anEvent | Halt now. ]
		id: LeShellSnippetCoderModelHelpActionId
]

{ #category : #'private - actions' }
LeShellSnippetCoderModel2 >> primitiveEvaluate: aSourceString inContext: aGtPharoCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| aCompiledMethodToEvaluate pharoEvaluationResult shellCommandResult |
	aCompiledMethodToEvaluate := self
		primitiveAnonymousCompile: aSourceString
		inContext: aGtPharoCoderEvaluationContext
		onFailDo: [ ^ anEvaluationFailBlock value ].
	pharoEvaluationResult := aGtPharoCoderEvaluationContext
		receiverObject
		withArgs:
			(aGtPharoCoderEvaluationContext runtimeContext
				ifNil: [ #() ]
				ifNotNil: [ {aGtPharoCoderEvaluationContext runtimeContext} ])
		executeMethod: aCompiledMethodToEvaluate.
	Halt now.
	aCompiledMethodToEvaluate := self
		primitiveAnonymousCompile:
			'RunInShell new
		workingDirectory: (thisSnippet asSnippetViewModel snippetView asElement query // #directoryPicker) anyOne label asString;
		command: (''' , pharoEvaluationResult asString , ''')'
		inContext: aGtPharoCoderEvaluationContext
		onFailDo: [ ^ anEvaluationFailBlock value ].
	shellCommandResult := aGtPharoCoderEvaluationContext receiverObject
		withArgs:
			(aGtPharoCoderEvaluationContext runtimeContext
				ifNil: [ #() ]
				ifNotNil: [ {aGtPharoCoderEvaluationContext runtimeContext} ])
		executeMethod: aCompiledMethodToEvaluate.
	aGtPharoCoderEvaluationContext
		bindingAt:
			(((aGtPharoCoderEvaluationContext bindingOf: #thisSnippet) value
				asSnippetViewModel snippetView asElement query // #resultBinding)
				anyOne text asString asSymbol)
		put: shellCommandResult.
	"self asCoderUIModel get to some button label to bind. If lable changes react"
	^ shellCommandResult
]
