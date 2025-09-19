"
{{gtClass:LeSingleSnippetUpdateExamples}} provides utility methods for testing the change of a single snippet in a page.
"
Class {
	#name : #LeSingleSnippetUpdateExamples,
	#superclass : #LeSnippetUpdateExamples,
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #testing }
LeSingleSnippetUpdateExamples class >> isAbstract [
	^ self = LeSingleSnippetUpdateExamples
]

{ #category : #actions }
LeSingleSnippetUpdateExamples >> addSnippetsInPage: targetPage [
	targetPage addSnippet: self createTargetSnippet.
]

{ #category : #asserting }
LeSingleSnippetUpdateExamples >> assertModificationAnnouncements: announcements [
	"This assertion should be overriden by subclasses to check that a modification to the snippet resulted in the right announcements"
]

{ #category : #asserting }
LeSingleSnippetUpdateExamples >> assertOneModificationAnnouncementIn: anAnnouncementsCollection ofType: aAnnouncementClass do: aBlock [
	| targetAnnouncement|
	
	self assert: anAnnouncementsCollection size equals: 1.
	
	targetAnnouncement := anAnnouncementsCollection first.
	self 
		assert: targetAnnouncement class 
		equals: aAnnouncementClass.
	aBlock cull: targetAnnouncement 
]

{ #category : #asserting }
LeSingleSnippetUpdateExamples >> assertSnippetModifiedFor: aSnippet [ 
	self subclassResponsibility
]

{ #category : #asserting }
LeSingleSnippetUpdateExamples >> assertSnippetsModifiedInPage: aTargetPage [ 
	self assert: aTargetPage children size equals: 1.
	self assertSnippetModifiedFor: aTargetPage children first
]

{ #category : #'examples - snippets' }
LeSingleSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #SubclassResponsibility>
	self subclassResponsibility
]

{ #category : #actions }
LeSingleSnippetUpdateExamples >> modifySnippet: aSnippet [ 
	self subclassResponsibility
]

{ #category : #actions }
LeSingleSnippetUpdateExamples >> modifySnippetsInPage: aTargetPage [
	| announcements |
	self assert: aTargetPage children size equals: 1.
	
	announcements := OrderedCollection new.
	aTargetPage weak 
		when: Announcement send: #add: to: announcements.
	self modifySnippet: aTargetPage children first.

	self assertModificationAnnouncements: announcements.
]
