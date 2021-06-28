Class {
	#name : #LeShellSnippetViewModel,
	#superclass : #LePharoSnippetViewModel,
	#instVars : [
		'workingDirectory',
		'resultVariable',
		'resultButton',
		'directoryButton',
		'progressButton'
	],
	#category : #'LeShellSnippet-Snippet'
}

{ #category : #accessing }
LeShellSnippetViewModel >> directoryButton [
	^ directoryButton
]

{ #category : #accessing }
LeShellSnippetViewModel >> directoryButton: aBrFileSelector [
	directoryButton := aBrFileSelector
]

{ #category : #initialization }
LeShellSnippetViewModel >> initialize [
	super initialize.
]

{ #category : #accessing }
LeShellSnippetViewModel >> progressButton [
	^ progressButton
]

{ #category : #accessing }
LeShellSnippetViewModel >> progressButton: aBrButton [
	progressButton := aBrButton
]

{ #category : #accessing }
LeShellSnippetViewModel >> resultButton [
	^ resultButton
]

{ #category : #accessing }
LeShellSnippetViewModel >> resultButton: aBrEditableLabel [
	resultButton := aBrEditableLabel
]

{ #category : #accessing }
LeShellSnippetViewModel >> resultVariable [
	^ self snippetModel resultVariable
]

{ #category : #accessing }
LeShellSnippetViewModel >> resultVariable: aString [
	self snippetModel resultVariable: aString
]

{ #category : #accessing }
LeShellSnippetViewModel >> snippetElementClass [
	^ LeShellSnippetElement
]

{ #category : #accessing }
LeShellSnippetViewModel >> workingDirectory [
	^ self snippetModel workingDirectory
]

{ #category : #accessing }
LeShellSnippetViewModel >> workingDirectory: aString [
	self snippetModel workingDirectory: aString
]
