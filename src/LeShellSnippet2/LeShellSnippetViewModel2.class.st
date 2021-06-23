Class {
	#name : #LeShellSnippetViewModel2,
	#superclass : #LePharoSnippetViewModel,
	#category : #'LeShellSnippet2-LeShellSnippet2'
}

{ #category : #initialization }
LeShellSnippetViewModel2 >> initialize [
	super initialize.
	"self traceCr."
	"Halt now."
]

{ #category : #accessing }
LeShellSnippetViewModel2 >> snippetElementClass [
	^ LeShellSnippetElement2
]
