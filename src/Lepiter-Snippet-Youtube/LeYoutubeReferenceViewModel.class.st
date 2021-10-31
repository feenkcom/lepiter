Class {
	#name : #LeYoutubeReferenceViewModel,
	#superclass : #LeSnippetViewModel,
	#instVars : [
		'showForm',
		'youtubeSnippetModel'
	],
	#category : #'Lepiter-Snippet-Youtube-View-Model'
}

{ #category : #accessing }
LeYoutubeReferenceViewModel >> hasYoutubeSnippet [
	"Return a true if jenkinsSnippet model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ youtubeSnippetModel notNil
]

{ #category : #accessing }
LeYoutubeReferenceViewModel >> initialize [
	super initialize.
	showForm := false.
]

{ #category : #accessing }
LeYoutubeReferenceViewModel >> onYoutubeSnippetModelChanged [
]

{ #category : #accessing }
LeYoutubeReferenceViewModel >> shouldShowForm [
	^ showForm
]

{ #category : #accessing }
LeYoutubeReferenceViewModel >> showForm [
	showForm := true.
	self announce: LeJenkinsSnippetShowFormAnnouncement new.
]

{ #category : #accessing }
LeYoutubeReferenceViewModel >> snippetElementClass [
	^ LeYoutubeReferenceElement
]

{ #category : #accessing }
LeYoutubeReferenceViewModel >> subscribeToYoutubeSnippetModel [
]

{ #category : #accessing }
LeYoutubeReferenceViewModel >> unsubscribeFromYoutubeSnippetModel [
]

{ #category : #accessing }
LeYoutubeReferenceViewModel >> youtubeSnippetModel [
	"Return a not-null jenkinsSnippet model assigned to the receiver view model"
	self
		assert: [ youtubeSnippetModel notNil ]
		description: [ 'jenkinsSnippet model should be initialized' ].

	^ youtubeSnippetModel
]
