Class {
	#name : #LeLepiterToolStencil,
	#superclass : #BrStencil,
	#category : #'Lepiter-Tool-Stencils'
}

{ #category : #converting }
LeLepiterToolStencil >> asPreviewElement [
	^ BlElement new
		background: Color white
]

{ #category : #'api - instantiation' }
LeLepiterToolStencil >> create [
	^ LeHomeDatabasesElement new 
		databaseViewModel: LeDatabasesRegistry uniqueInstance defaultLogicalDatabase asContentUIModel;
		padding: (BlInsets all: 20);
		background: BrGlamorousColors backdropColor
]

{ #category : #printing }
LeLepiterToolStencil >> gtDisplayOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #'gt-extensions' }
LeLepiterToolStencil >> gtSpotterActDefaultFrom: aSpotterElement [
	| aSpace |

	aSpace := BlSpace new.
	aSpace title: self name.
	aSpace icon: self icon.
	aSpace extent: 1200@600.
	aSpace addChild: self asElement.
	aSpace withHalos.
	aSpotterElement showSpace: aSpace
]

{ #category : #accessing }
LeLepiterToolStencil >> icon [
	^ LeIcons lepiterIcon
]

{ #category : #accessing }
LeLepiterToolStencil >> name [
	^ 'Lepiter'
]
