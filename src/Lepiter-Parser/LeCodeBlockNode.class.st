Class {
	#name : #LeCodeBlockNode,
	#superclass : #LeContentNode,
	#instVars : [
		'language',
		'code',
		'begin',
		'end'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeCodeBlockNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitCodeBlock: self
]

{ #category : #generated }
LeCodeBlockNode >> begin [
	^ begin
]

{ #category : #generated }
LeCodeBlockNode >> begin: aSmaCCToken [
	begin := aSmaCCToken
]

{ #category : #accessing }
LeCodeBlockNode >> beginWithLanguageStopPosition [
	^ language ifNil: [ begin stopPosition ] ifNotNil: [ language stopPosition ]
]

{ #category : #generated }
LeCodeBlockNode >> code [
	^ code
]

{ #category : #generated }
LeCodeBlockNode >> code: anObject [
	self setParent: self code to: nil.
	code := anObject.
	self setParent: self code to: self
]

{ #category : #generated }
LeCodeBlockNode >> end [
	^ end
]

{ #category : #generated }
LeCodeBlockNode >> end: aSmaCCToken [
	end := aSmaCCToken
]

{ #category : #testing }
LeCodeBlockNode >> isForLanguage: aLanguageString [
	^ language isNotNil
		and: [ aLanguageString = language source asLowercase ]
]

{ #category : #testing }
LeCodeBlockNode >> isForSmalltalk [
	^ language isNil
		or: [ #('smalltalk' 'st' 'pharo') includes: language source asLowercase ]
]

{ #category : #generated }
LeCodeBlockNode >> language [
	^ language
]

{ #category : #generated }
LeCodeBlockNode >> language: anObject [
	self setParent: self language to: nil.
	language := anObject.
	self setParent: self language to: self
]

{ #category : #generated }
LeCodeBlockNode >> otherVariables [
	^ #(#language #code)
]

{ #category : #generated }
LeCodeBlockNode >> tokenVariables [
	^ #(#begin #end)
]
