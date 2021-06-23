Class {
	#name : #LeShellSnippetViewModel2,
	#superclass : #LePharoSnippetViewModel,
	#instVars : [
		'result',
		'workingDirectory'
	],
	#category : #'LeShellSnippet2-LeShellSnippet2'
}

{ #category : #initialization }
LeShellSnippetViewModel2 >> initialize [
	super initialize.
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> result [
	^ result
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> result: aBrEditableLable [
	result := aBrEditableLable
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
