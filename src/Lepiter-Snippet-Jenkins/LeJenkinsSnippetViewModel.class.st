Class {
	#name : #LeJenkinsSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#traits : 'TLeWithJenkinsSnippetModel',
	#classTraits : 'TLeWithJenkinsSnippetModel classTrait',
	#instVars : [
		'showForm'
	],
	#category : #'Lepiter-Snippet-Jenkins-View-Model'
}

{ #category : #accessing }
LeJenkinsSnippetViewModel >> hideForm [
	showForm := false.
	self announce: LeJenkinsSnippetShowFormAnnouncement new.
]

{ #category : #accessing }
LeJenkinsSnippetViewModel >> initialize [
	super initialize.
	showForm := false.
]

{ #category : #accessing }
LeJenkinsSnippetViewModel >> jenkinsUrl [
	^ self jenkinsSnippetModel jenkinsUrl
]

{ #category : #accessing }
LeJenkinsSnippetViewModel >> jenkinsUrl: aJenkinsUrl [
 	self jenkinsSnippetModel jenkinsUrl:  aJenkinsUrl.
]

{ #category : #'api - jenkins snippet model' }
LeJenkinsSnippetViewModel >> onJenkinsSnippetModelChanged [
	"Is sent when a new jenkinsSnippet model is assigned to the view model"
	
	"self explicitRequirement"
]

{ #category : #accessing }
LeJenkinsSnippetViewModel >> shouldShowForm [
	^ true
]

{ #category : #accessing }
LeJenkinsSnippetViewModel >> showForm [
	showForm := true.
	self announce: LeJenkinsSnippetShowFormAnnouncement new.
]

{ #category : #accessing }
LeJenkinsSnippetViewModel >> snippetElementClass [
	^ LeJenkinsSnippetElement
]

{ #category : #accessing }
LeJenkinsSnippetViewModel >> snippetModel [
	^ self jenkinsSnippetModel
]
