Class {
	#name : #LeShellSnippetViewModel2,
	#superclass : #LePharoSnippetViewModel,
	#instVars : [
		'workingDirectory',
		'resultVariable',
		'resultButton',
		'directoryButton',
		'progressButton'
	],
	#category : #'LeShellSnippet2-LeShellSnippet2'
}

{ #category : #accessing }
LeShellSnippetViewModel2 >> directoryButton [
	^ directoryButton
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> directoryButton: aBrFileSelector [
	directoryButton := aBrFileSelector
]

{ #category : #initialization }
LeShellSnippetViewModel2 >> initialize [
	super initialize.
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> progressButton [
	^ progressButton
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> progressButton: aBrButton [
	progressButton := aBrButton
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> resultButton [
	^ resultButton
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> resultButton: aBrEditableLabel [
	resultButton := aBrEditableLabel
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> resultVariable [
	^ self snippetModel resultVariable
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> resultVariable: aString [
	self snippetModel resultVariable: aString
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> snippetElementClass [
	^ LeShellSnippetElement2
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> workingDirectory [
	^ self snippetModel workingDirectory
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> workingDirectory: aString [
	self snippetModel workingDirectory: aString
]
