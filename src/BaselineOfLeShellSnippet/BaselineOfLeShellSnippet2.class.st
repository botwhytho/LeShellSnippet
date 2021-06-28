Class {
	#name : #BaselineOfLeShellSnippet,
	#superclass : #BaselineOf,
	#category : #BaselineOfLeShellSnippet
}

{ #category : #baseline }
BaselineOfLeShellSnippet >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			package: 'LeShellSnippet'. ].

]
