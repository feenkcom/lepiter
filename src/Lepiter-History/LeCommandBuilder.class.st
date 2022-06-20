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
LeCommandBuilder >> insertChildSnippetCommand [
	^ LeContentInsertChildSnippetCommand new
		targetContent: self targetContent
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
LeCommandBuilder >> targetContent [

	^ targetContent
]

{ #category : #accessing }
LeCommandBuilder >> targetContent: aLeContent [

	targetContent := aLeContent
]
