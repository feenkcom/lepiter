Class {
	#name : #TMStyleNode,
	#superclass : #TMAbstractTreeNode,
	#instVars : [
		'style'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMStyleNode class >> for: aString within: aPageGroup [
^ self new
	pageGroup: aPageGroup;
	style: aString;
	yourself 
]

{ #category : #accessing }
TMStyleNode >> children [
	^ self pages collect: [ :aPage | TMPageNode for: aPage within: self pageGroup ]
]

{ #category : #accessing }
TMStyleNode >> name [
	^ 'Style: ' , self style
]

{ #category : #querying }
TMStyleNode >> pages [
	"NB: We only want the pages in *this* page group with this style."

	^ self pageGroup pages
		select: [ :aPage | (self topicMap page2Style at: aPage) = self style ]
]

{ #category : #accessing }
TMStyleNode >> style [
	^ style
]

{ #category : #accessing }
TMStyleNode >> style: anObject [
	style := anObject
]
