Class {
	#name : #LeShellSnippet2,
	#superclass : #LePharoSnippet,
	#category : #'LeShellSnippet2-LeShellSnippet2'
}

{ #category : #accessing }
LeShellSnippet2 class >> leJsonV3Name [

	^ 'shellSnippet2'
]

{ #category : #accessing }
LeShellSnippet2 class >> leJsonV4Name [

	^ 'shellSnippet2'
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
LeShellSnippet2 >> newCoder [
	^ LeShellSnippetCoderModel2 new
]
