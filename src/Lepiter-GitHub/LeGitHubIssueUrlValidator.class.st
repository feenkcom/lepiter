"
I validate a GitHub Issue URL link.
## Valid GitHub Issue URL Example
{{gtExample:LeGitHubIssueUrlValidatorExamples>>#validator_ValidUrl|codeExpanded=false|previewExpanded=true|previewHeight=250}}
## Invalid GitHub Issue URL Example
{{gtExample:LeGitHubIssueUrlValidatorExamples>>#validator_InvalidUrl|codeExpanded=false|previewExpanded=true|previewHeight=250}}

"
Class {
	#name : #LeGitHubIssueUrlValidator,
	#superclass : #Object,
	#instVars : [
		'url',
		'isValid',
		'ownerName',
		'projectName',
		'issueNumber'
	],
	#category : #'Lepiter-GitHub-Client'
}

{ #category : #initialization }
LeGitHubIssueUrlValidator >> beInvalid [
	isValid := false
]

{ #category : #'gt - extensions' }
LeGitHubIssueUrlValidator >> gtOverviewFor: aView [
	<gtView>
	self url ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Overview';
		priority: 1;
		items: [ 
			Array streamContents: [ :aStream | 
				aStream nextPut: ('URL' -> self url).
				isValid 
					ifNil: [ aStream nextPut: ('Status' -> 'Not validated') ]
					ifNotNil: [
						aStream nextPut: ('Valid' -> isValid).
						aStream nextPut: ('Owner' -> self ownerName).
						aStream nextPut: ('Project' -> self projectName).
						aStream nextPut: ('Issue number' -> self issueNumber).
						aStream nextPut: ('Identifier' -> self identifier) ] ] ];
		column: 'Name' text: #key;
		column: 'Value' text: [ :anAssoc |  anAssoc value ifNil: [ String empty ] ];
		send: #value
]

{ #category : #'api - issue' }
LeGitHubIssueUrlValidator >> identifier [
	self isValid ifFalse: [ ^ self url ].

	^ String streamContents: [ :aStream |		
		aStream
			nextPut: $[;
			nextPutAll: self ownerName;
			nextPut: $/;
			nextPutAll: self projectName;
			nextPut: $#;
			nextPutAll: self issueNumber;
			nextPut: $] ]
]

{ #category : #initialization }
LeGitHubIssueUrlValidator >> initialize [
	super initialize.
	self initializeValidation
]

{ #category : #initialization }
LeGitHubIssueUrlValidator >> initializeValidation [
	url := nil.
	isValid := nil.
	ownerName := nil.
	projectName := nil.
	issueNumber := nil.
]

{ #category : #'api - testing' }
LeGitHubIssueUrlValidator >> isValid [
	<return: #Boolean>
	self
		assert: [ isValid isNotNil ] 
		description: [ 'GitHub issue must be first validated calling #validate' ].
	^ isValid
]

{ #category : #'api - issue' }
LeGitHubIssueUrlValidator >> issueNumber [
	^ issueNumber
]

{ #category : #'api - issue' }
LeGitHubIssueUrlValidator >> ownerName [
	^ ownerName
]

{ #category : #'api - issue' }
LeGitHubIssueUrlValidator >> projectName [
	^ projectName
]

{ #category : #'api - accessing' }
LeGitHubIssueUrlValidator >> url [
	^ url
]

{ #category : #'api - accessing' }
LeGitHubIssueUrlValidator >> url: anObject [
	self initializeValidation.
	url := anObject asString
]

{ #category : #'api - validating' }
LeGitHubIssueUrlValidator >> validate [
	| anUrl anIssueNumber |
	isValid ifNotNil: [ ^ isValid ].

	anUrl := [ self url asZnUrl ] on: Error do: [ ^ self beInvalid ].
	isValid := true.

	anUrl scheme = 'https' ifFalse: [ ^ self beInvalid ].
	anUrl host = 'github.com' ifFalse: [ ^ self beInvalid ].
	anUrl pathSegments size = 4 ifFalse: [ ^ self beInvalid ].
	anUrl pathSegments third = 'issues' ifFalse: [ ^ self beInvalid ].

	anIssueNumber := (NumberParser on: anUrl pathSegments fourth asString)
			failBlock: [ ^ self beInvalid ];
			nextNumber.
	anIssueNumber asString = anUrl pathSegments fourth
		ifFalse: [ ^ self beInvalid ].

	ownerName := anUrl pathSegments at: 1.
	projectName := anUrl pathSegments at: 2.
	issueNumber := anUrl pathSegments at: 4
]
