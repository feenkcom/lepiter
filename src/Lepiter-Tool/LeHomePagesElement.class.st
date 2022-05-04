Class {
	#name : #LeHomePagesElement,
	#superclass : #LeHomeBasicElement,
	#category : #'Lepiter-Tool-UI'
}

{ #category : #'private - testing' }
LeHomePagesElement >> isForTodayNote [
	"Disable the creation of daily notes"
	^ false


	"Only primary and logical databases display daily notes"
	"<return: #Boolean>
	^ self database isPrimary or: [ 
		self database isLogicalDatabase ]"
]

{ #category : #'private - event handling' }
LeHomePagesElement >> onPageClick: aLePageViewModel [
	
	GtWorldUtility 
		showSpaceWithTitle: aLePageViewModel printPageTabLabel
		icon: LeIcons lepiterPage
		inPagerWith: [ aLePageViewModel asPhlowTool asElementDo: [ :e | e ] ] asStencil
		from: self
	
	"GtWorldUtility 
		showSpaceWithTitle: aLePageViewModel printPageTabLabel
		inPagerWith: [ aLePageViewModel asPhlowTool asElementDo: [ :e | e ] ] asStencil
		from: self"
]
