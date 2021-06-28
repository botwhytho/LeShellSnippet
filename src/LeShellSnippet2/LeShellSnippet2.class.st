Class {
	#name : #LeShellSnippet2,
	#superclass : #LePharoSnippet,
	#instVars : [
		'resulVariable',
		'workingDirectory'
	],
	#category : #'LeShellSnippet2-Snippet'
}

{ #category : #'lepiter-store' }
LeShellSnippet2 class >> leJsonV3AttributeMapping [
	^ super leJsonV3AttributeMapping
		add: #resultVariable -> #resultVariable;
		add: #workingDirectory -> #workingDirectory;
		yourself
]

{ #category : #accessing }
LeShellSnippet2 class >> leJsonV3Name [

	^ 'shellSnippet2'
]

{ #category : #'lepiter-store' }
LeShellSnippet2 class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #resultVariable -> #resultVariable;
		add: #workingDirectory -> #workingDirectory;
		yourself
]

{ #category : #accessing }
LeShellSnippet2 class >> leJsonV4Name [

	^ 'shellSnippet2'
]

{ #category : #converting }
LeShellSnippet2 >> asPreviewElement [
	| viewModel snippetElement |

	viewModel := self asSnippetViewModel.
	snippetElement := viewModel snippetView asElement.
	snippetElement snippetViewModel: viewModel.
	snippetElement padding: (BlInsets all: 10).
	^ snippetElement
]

{ #category : #accessing }
LeShellSnippet2 >> asSnippetViewModel [
	<return: #LeSnippetViewModel>

	^ LeShellSnippetViewModel2 new snippetModel: self
]

{ #category : #accessing }
LeShellSnippet2 >> contextMenuItemSpecification [
	<leSnippetSpecification>

	^ LeContextMenuItemSpecification new
		priority: 20;
		snippetClass: self;
		title: 'Shell2'
]

{ #category : #initialization }
LeShellSnippet2 >> initialize [
	"TODO: If not doing anything else here, remove"
	super initialize.
]

{ #category : #initialization }
LeShellSnippet2 >> newCoder [
	^ LeShellSnippetCoderModel2 new
]

{ #category : #accessing }
LeShellSnippet2 >> resultVariable [
	^ resulVariable
]

{ #category : #accessing }
LeShellSnippet2 >> resultVariable: aString [
	resulVariable := aString
]

{ #category : #accessing }
LeShellSnippet2 >> workingDirectory [
	^ workingDirectory
]

{ #category : #accessing }
LeShellSnippet2 >> workingDirectory: aString [
	workingDirectory := aString
]
