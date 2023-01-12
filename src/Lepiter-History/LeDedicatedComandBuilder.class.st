Class {
	#name : #LeDedicatedComandBuilder,
	#superclass : #Object,
	#instVars : [
		'targetContent'
	],
	#category : #'Lepiter-History-Builders'
}

{ #category : #'instance creation' }
LeDedicatedComandBuilder class >> forContent: aLeContent [
	^ self new
		targetContent: aLeContent
]

{ #category : #accessing }
LeDedicatedComandBuilder >> targetContent [
	^ targetContent
]

{ #category : #accessing }
LeDedicatedComandBuilder >> targetContent: aLeContent [

	targetContent := aLeContent
]
