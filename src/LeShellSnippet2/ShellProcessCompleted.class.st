Class {
	#name : #ShellProcessCompleted,
	#superclass : #Announcement,
	#instVars : [
		'shellCommand'
	],
	#category : #'LeShellSnippet2-LeShellSnippet2'
}

{ #category : #'api - enable / disable' }
ShellProcessCompleted class >> enableInZ: anEventDispatcher [
	anEventDispatcher enableGeneralEventType: self
]

{ #category : #accessing }
ShellProcessCompleted >> shellCommand [
	^ shellCommand
]

{ #category : #accessing }
ShellProcessCompleted >> shellCommand: aCommand [
	shellCommand := aCommand
]
