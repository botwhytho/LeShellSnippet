Class {
	#name : #BlOpacityTransition,
	#superclass : #BlTransition,
	#category : #'LeShellSnippet2-Animation'
}

{ #category : #pulse }
BlOpacityTransition >> valueForStep: aDelta [
	^ (self target background paint color) alpha: ((to - from ) * aDelta) + from
]
