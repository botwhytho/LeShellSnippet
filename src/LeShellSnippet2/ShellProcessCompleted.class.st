Class {
	#name : #ShellProcessCompleted,
	#superclass : #Announcement,
	#category : #'LeShellSnippet2-LeShellSnippet2'
}

{ #category : #'api - enable / disable' }
ShellProcessCompleted class >> enableInZ: anEventDispatcher [
	anEventDispatcher enableGeneralEventType: self
]
