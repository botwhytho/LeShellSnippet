Class {
	#name : #RunInShell,
	#superclass : #Object,
	#instVars : [
		'process',
		'stdout',
		'stderr'
	],
	#category : #LeShellSnippet2
}

{ #category : #initialization }
RunInShell class >> runInBackground: aCommand workingDirectory: aString announceOn: anAnnouncer [
	^ self new
		workingDirectory: aString;
		run: aCommand andAnnounceOn: anAnnouncer;
		yourself
]

{ #category : #accessing }
RunInShell >> command: aCommand [
	process
		shellCommand: aCommand;
		runAndWaitOnExitDo: [ :command :outString :errString | 
			stdout := outString.
			stderr := errString ]
]

{ #category : #initialization }
RunInShell >> initialize [
	super initialize.
	process := OSSUnixSubprocess new
		redirectStdout;
		redirectStderr
]

{ #category : #accessing }
RunInShell >> process [
	^ process
]

{ #category : #accessing }
RunInShell >> run: aCommand andAnnounceOn: anAnnouncer [
	[ process
		shellCommand: aCommand;
		runAndWaitOnExitDo: [ :command :outString :errString | 
			anAnnouncer
				announce: (ShellProcessCompleted new shellCommand: command).
			stdout := outString.
			stderr := errString ] ] forkAt: 29 named: 'LeShellBackgroundRun'.
]

{ #category : #accessing }
RunInShell >> stderr [
	^ stderr
]

{ #category : #accessing }
RunInShell >> stdout [
	^ stdout
]

{ #category : #accessing }
RunInShell >> workingDirectory: aString [
	process workingDirectory: aString
]
