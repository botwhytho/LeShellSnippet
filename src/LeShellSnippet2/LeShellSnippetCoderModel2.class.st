Class {
	#name : #LeShellSnippetCoderModel2,
	#superclass : #GtPharoSnippetCoder,
	#category : #'LeShellSnippet2-LeShellSnippet2'
}

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
		action: [ :aCoderUIModel :anEvent | 
			anEvent target
				enqueueTask:
					(BlTaskAction new
						action: [ anEvent target phlow
								spawnObject: LeShellSnippetExplainerExamples new leShellSnippetExplainerExample ]) ]
		id: LeShellSnippetCoderModelHelpActionId
]

{ #category : #'private - actions' }
LeShellSnippetCoderModel2 >> primitiveEvaluate: aSourceString inContext: aGtPharoCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| aCompiledMethodToEvaluate pharoEvaluationResult progressButton shellCommandResult snippetViewModel |
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
	aCompiledMethodToEvaluate := self
		primitiveAnonymousCompile:
			'RunInShell runInBackground: (''' , pharoEvaluationResult asString
				,
					''') workingDirectory: thisSnippetViewModel directoryButton label asString announceOn: thisSnippetViewModel announcer'
		inContext: aGtPharoCoderEvaluationContext
		onFailDo: [ ^ anEvaluationFailBlock value ].
	shellCommandResult := aGtPharoCoderEvaluationContext receiverObject
		withArgs:
			(aGtPharoCoderEvaluationContext runtimeContext
				ifNil: [ #() ]
				ifNotNil: [ {aGtPharoCoderEvaluationContext runtimeContext} ])
		executeMethod: aCompiledMethodToEvaluate.
	snippetViewModel := (aGtPharoCoderEvaluationContext
		bindingOf: #thisSnippetViewModel) value.
	aGtPharoCoderEvaluationContext
		bindingAt: snippetViewModel resultButton text asString asSymbol
		put: shellCommandResult.
	progressButton := snippetViewModel progressButton.
	progressButton
		visibility: BlVisibility visible;
		label: 'Running...';
		icon: BrGlamorousIcons graycircle asElement;
		action: [ progressButton
				enqueueTask:
					(BlTaskAction new
						action: [ progressButton phlow
								spawnObject: shellCommandResult
								withDestination: self spawnDestination ]) ].
	^ shellCommandResult
]
