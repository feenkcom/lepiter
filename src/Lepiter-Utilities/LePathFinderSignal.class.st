Class {
	#name : #LePathFinderSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'backlinksSize',
		'pagesLeftSize'
	],
	#category : 'Lepiter-Utilities-Beacon'
}

{ #category : #accessing }
LePathFinderSignal >> backlinksSize [
	^ backlinksSize
]

{ #category : #accessing }
LePathFinderSignal >> backlinksSize: anObject [
	backlinksSize := anObject
]

{ #category : #accessing }
LePathFinderSignal >> pagesLeftSize [
	^ pagesLeftSize
]

{ #category : #accessing }
LePathFinderSignal >> pagesLeftSize: anObject [
	pagesLeftSize := anObject
]

{ #category : #printing }
LePathFinderSignal >> printOneLineContentsOn: stream [

	stream 
		<< 'backlinks left: ';
		print: backlinksSize;
		<< ', pages left: ';
		print: pagesLeftSize.
]
