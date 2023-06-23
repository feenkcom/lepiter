Class {
	#name : #LeNullContent,
	#superclass : #LeNullModel,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#category : #'Lepiter-Core-Model'
}

{ #category : #announcer }
LeNullContent >> announcer [
	<return: #Announcer>
	^ GtNullAnnouncer default
]

{ #category : #'api - accessing' }
LeNullContent >> blocks [
	^ #()
]

{ #category : #'api - accessing' }
LeNullContent >> children [
	^ #()
]

{ #category : #accessing }
LeNullContent >> content [ 

	^ nil
]

{ #category : #'api - accessing' }
LeNullContent >> createEmail [
	^ nil
]

{ #category : #'api - accessing' }
LeNullContent >> createTime [
	^ nil
]

{ #category : #'api - accessing' }
LeNullContent >> database [
	^ LeDatabase null
]

{ #category : #'api - accessing' }
LeNullContent >> editEmail [
	^ nil
]

{ #category : #'api - accessing' }
LeNullContent >> editOrCreateTime [
	^ nil
]

{ #category : #'api - accessing' }
LeNullContent >> editTime [
	^ nil
]

{ #category : #'api - testing' }
LeNullContent >> hasIncomingLinks [
	^ false
]

{ #category : #'private - accessing' }
LeNullContent >> incomingLinks [
	<return: #Collection of: #LeTextualLink>

	^ #()
]

{ #category : #'api - testing' }
LeNullContent >> isExplicitLinks [
	^ false
]

{ #category : #'api - testing' }
LeNullContent >> isPage [
	^ false
]

{ #category : #testing }
LeNullContent >> isSnippet [

	^ false
]

{ #category : #testing }
LeNullContent >> isTableOfContents [
	^ false
]

{ #category : #'api - accessing' }
LeNullContent >> latestEditTime [
	^ nil
]

{ #category : #'api - accessing' }
LeNullContent >> page [ 
	self flag: 'this looks suspicious, we should have only one null instance'.
	^ self class new
]

{ #category : #'api - accessing' }
LeNullContent >> paragraphStyle [
	^ LeParagraphStyle text
]

{ #category : #'api - adding / removing' }
LeNullContent >> removeSelf [
	"do nothing"
]

{ #category : #'api - accessing' }
LeNullContent >> string [
	^ ''
]

{ #category : #'api - accessing' }
LeNullContent >> text [ 

	^ '' asRopedText
]

{ #category : #'api - accessing' }
LeNullContent >> title [
	^ ''
]
