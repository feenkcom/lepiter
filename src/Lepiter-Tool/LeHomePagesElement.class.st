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
	BlSpace spawnPage: aLePageViewModel pageModel from: self
]

{ #category : #'private - accessing' }
LeHomePagesElement >> todayPage [
	^ self database 
		pageNamed: (LeDailyNoteTitleBuilder new 
			title: Date today)
		ifAbsent: [ LePage builder 
			todayNote;
			createdNowBy: self database userEmail;
			build ].
]
