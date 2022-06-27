Class {
	#name : #LeCommandBuilder,
	#superclass : #Object,
	#instVars : [
		'targetContent'
	],
	#category : #'Lepiter-History-Builders'
}

{ #category : #'instance creation' }
LeCommandBuilder class >> forContent: aLeContent [
	^ self new
		targetContent: aLeContent
]

{ #category : #'build - commands' }
LeCommandBuilder >> compositeCommand [
	^ LeGenericCompositeCommand new 
		targetContent: self targetContent
]

{ #category : #'build - commands' }
LeCommandBuilder >> insertChildSnippetCommand [
	^ LeContentInsertChildSnippetCommand new
		targetContent: self targetContent;
		uid: self newSnippetUid
]

{ #category : #'build - commands' }
LeCommandBuilder >> insertChildSnippetOfTypeCommandForType: aSnippetType [
	^ self insertChildSnippetCommand
		snippetTypeName: aSnippetType name
]

{ #category : #'build - commands' }
LeCommandBuilder >> insertChildTextSnippetCommand [
	^ self insertChildSnippetOfTypeCommandForType: LeTextSnippet
]

{ #category : #accessing }
LeCommandBuilder >> newSnippetUid [ 
	^ self targetDatabase isDatabase 
		ifFalse:  [ LeUID new uid: UUID new ]
		ifTrue: [ self targetDatabase newUID ]
]

{ #category : #'build - commands' }
LeCommandBuilder >> removeChildSnippetCommand [
	^ LeContentRemoveChildSnippetCommand new
		targetContent: self targetContent
]

{ #category : #'build - commands' }
LeCommandBuilder >> removeChildSnippetCommandFor: aChildSnippet [
	^ self removeChildSnippetCommand
		childSnippet: aChildSnippet
]

{ #category : #accessing }
LeCommandBuilder >> targetContent [

	^ targetContent
]

{ #category : #accessing }
LeCommandBuilder >> targetContent: aLeContent [

	targetContent := aLeContent
]

{ #category : #accessing }
LeCommandBuilder >> targetDatabase [ 
	^ self targetContent database
]
