Class {
	#name : #ShellProcessCompleted,
	#superclass : #Announcement,
	#instVars : [
		'shellCommand'
	],
	#category : #'LeShellSnippet-Shell'
}

{ #category : #accessing }
ShellProcessCompleted >> shellCommand [
	^ shellCommand
]

{ #category : #accessing }
ShellProcessCompleted >> shellCommand: aCommand [
	shellCommand := aCommand
]
