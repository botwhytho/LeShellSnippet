Class {
	#name : #ShellProcessCompleted,
	#superclass : #Announcement,
	#instVars : [
		'shellCommand'
	],
	#category : #'LeShellSnippet2-LeShellSnippet2'
}

{ #category : #accessing }
ShellProcessCompleted >> shellCommand [
	^ shellCommand
]

{ #category : #accessing }
ShellProcessCompleted >> shellCommand: aCommand [
	shellCommand := aCommand
]
