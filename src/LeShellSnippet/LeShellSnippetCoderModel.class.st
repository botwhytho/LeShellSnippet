Class {
	#name : #LeShellSnippetCoderModel,
	#superclass : #GtPharoSnippetCoder,
	#category : #'LeShellSnippet-Coder'
}

{ #category : #'UI specific' }
LeShellSnippetCoderModel >> initializeAddOns: addOns [
	addOns addStyler: GtPharoStyler new.
	addOns addStyler: GtPharoDynamicHighlightStyler new.
	addOns addStyler: GtPharoDeprecationStyler new.
	addOns addStyler: GtPharoMethodExpanderStyler new.
	addOns addStyler: (GtFixItStyler new isForWorkspace: true).
	addOns
		addMainAction: 'Evaluate' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doIt
				coderUIModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItActionId.
	addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anEvent | 
			GtCoderCodeExecutor doItAndGo
				coderUIModel: aCoderUIModel;
				element: anEvent;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.
	addOns
		addMainAction: 'Debug' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :aCoderUIModel :anEvent | aCoderUIModel debug ]
		id: GtSourceCoderDebugActionId.
]

{ #category : #'private - actions' }
LeShellSnippetCoderModel >> primitiveEvaluate: aSourceString inContext: aGtPharoCoderEvaluationContext onFailDo: anEvaluationFailBlock [
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
					''') workingDirectory: thisSnippetViewModel workingDirectory announceOn: thisSnippetViewModel announcer'
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
	(aGtPharoCoderEvaluationContext bindingOf:
		 snippetViewModel resultButton text asString asSymbol) value:
		shellCommandResult.
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
