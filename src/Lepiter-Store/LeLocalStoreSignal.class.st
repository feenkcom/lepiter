"
LeLocalStoreSignal is emitted each time a {{gtClass:name=LeLocalStoreMonitor}} saves or removes a page.


"
Class {
	#name : #LeLocalStoreSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'pageTitle',
		'operation'
	],
	#category : #'Lepiter-Store-LocalJSON-Beacon'
}

{ #category : #accessing }
LeLocalStoreSignal >> operation [
	^ operation
]

{ #category : #accessing }
LeLocalStoreSignal >> operation: anObject [
	operation := anObject
]

{ #category : #accessing }
LeLocalStoreSignal >> pageTitle [
	^ pageTitle
]

{ #category : #accessing }
LeLocalStoreSignal >> pageTitle: anObject [
	pageTitle := anObject
]

{ #category : #printing }
LeLocalStoreSignal >> printOneLineContentsOn: stream [

	stream 
		print: pageTitle;
		<< ' ';
		print: operation.
]
