"
{{gtClass:LeContentTreeChanged}} is a common parent for Add, Move and Remove announcements.  Changes to a {{gtClass:LeSnippet}}'s content should be announced with {{gtClass:LeSnippetTextChanged}}

Historically, {{gtClass:LeContentTreeChanged}} has been used as a general announcement that the entire tree should be re-processed, however this should be avoided for performance reasons. 

 
## Internal Representation and Key Implementation Points.

### Instance Variables
	commonContent:		<Object>
	content:				<Object>


### Implementation Points

"
Class {
	#name : #LeContentTreeChanged,
	#superclass : #LeAnnouncement,
	#instVars : [
		'content'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeContentTreeChanged >> content [
	^ content
]

{ #category : #accessing }
LeContentTreeChanged >> content: anObject [
	content := anObject
]

{ #category : #accessing }
LeContentTreeChanged >> page [

	^ content page
]
