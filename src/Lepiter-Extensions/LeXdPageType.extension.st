Extension { #name : #LeXdPageType }

{ #category : #'*Lepiter-Extensions' }
LeXdPageType classSide >> extractAndUpdateDatabaseFor: aXdFile [
	| manifestFile |
	aXdFile extract.
	aXdFile streamingStrategy extracted ifNil: [^ self].
	
	manifestFile := aXdFile streamingStrategy extracted / XdConstants manifestFileName.
	manifestFile exists ifTrue: [
		manifestFile renameTo: XdConstants manifestFileName, '-old' ].
]

{ #category : #'*Lepiter-Extensions' }
LeXdPageType classSide >> mainPageForDocument: aXdDocument ofXdFileInPharo: aXdFile [
	| localStore database |
	aXdFile streamingStrategy extracted ifNil: [ 
		self extractAndUpdateDatabaseFor: aXdFile ].
		
	aXdFile streamingStrategy extracted ifNil: [ ^ nil ].
	
	localStore := LeLocalStoreLoad current.
	database := localStore loadFrom: aXdFile streamingStrategy extracted.
	localStore dbProperties.
	^ database pages first
]

{ #category : #'*Lepiter-Extensions' }
LeXdPageType classSide >> toolForDocument: aXdDocument ofXdFileInPharo: aXdFile [
	| page |
	page := self mainPageForDocument: aXdDocument ofXdFileInPharo: aXdFile.
	page ifNil: [ ^ BlElement new ].
	^ LePageToolContentTreeElement new 
		withEmptyHeader;
		pageViewModel: (LePageViewModel new pageModel: page); 
		matchParent
]
