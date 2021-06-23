Class {
	#name : #LeShellSnippetViewModel2,
	#superclass : #LePharoSnippetViewModel,
	#instVars : [
		'workingDirectory',
		'resultVariable'
	],
	#category : #'LeShellSnippet2-LeShellSnippet2'
}

{ #category : #initialization }
LeShellSnippetViewModel2 >> initialize [
	super initialize.
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> resultVariable [
	^ resultVariable
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> resultVariable: aBrEditableLable [
	resultVariable := aBrEditableLable
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> snippetElementClass [
	^ LeShellSnippetElement2
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> workingDirectory [
	^ workingDirectory
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> workingDirectory: aBrFileSelector [
	workingDirectory := aBrFileSelector
]
