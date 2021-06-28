Class {
	#name : #LeShellSnippet,
	#superclass : #LePharoSnippet,
	#instVars : [
		'resulVariable',
		'workingDirectory'
	],
	#category : #'LeShellSnippet2-Snippet'
}

{ #category : #'lepiter-store' }
LeShellSnippet class >> leJsonV3AttributeMapping [
	^ super leJsonV3AttributeMapping
		add: #resultVariable -> #resultVariable;
		add: #workingDirectory -> #workingDirectory;
		yourself
]

{ #category : #accessing }
LeShellSnippet class >> leJsonV3Name [

	^ 'shellSnippet'
]

{ #category : #'lepiter-store' }
LeShellSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #resultVariable -> #resultVariable;
		add: #workingDirectory -> #workingDirectory;
		yourself
]

{ #category : #accessing }
LeShellSnippet class >> leJsonV4Name [

	^ 'shellSnippet'
]

{ #category : #converting }
LeShellSnippet >> asPreviewElement [
	| viewModel snippetElement |

	viewModel := self asSnippetViewModel.
	snippetElement := viewModel snippetView asElement.
	snippetElement snippetViewModel: viewModel.
	snippetElement padding: (BlInsets all: 10).
	^ snippetElement
]

{ #category : #accessing }
LeShellSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>

	^ LeShellSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeShellSnippet >> contextMenuItemSpecification [
	<leSnippetSpecification>

	^ LeContextMenuItemSpecification new
		priority: 20;
		snippetClass: self;
		title: 'LeShell'
]

{ #category : #initialization }
LeShellSnippet >> newCoder [
	^ LeShellSnippetCoderModel new
]

{ #category : #accessing }
LeShellSnippet >> resultVariable [
	^ resulVariable
]

{ #category : #accessing }
LeShellSnippet >> resultVariable: aString [
	resulVariable := aString
]

{ #category : #accessing }
LeShellSnippet >> workingDirectory [
	^ workingDirectory
]

{ #category : #accessing }
LeShellSnippet >> workingDirectory: aString [
	workingDirectory := aString
]
