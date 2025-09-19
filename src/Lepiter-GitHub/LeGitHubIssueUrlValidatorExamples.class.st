Class {
	#name : #LeGitHubIssueUrlValidatorExamples,
	#superclass : #Object,
	#category : #'Lepiter-GitHub-Client'
}

{ #category : #'examples - validator' }
LeGitHubIssueUrlValidatorExamples >> basicValidator [
	<gtExample>
	<return: #LeGitHubIssueUrlValidator>
	| aValidator |
	aValidator := LeGitHubIssueUrlValidator new.
	^ aValidator
]

{ #category : #'examples - url' }
LeGitHubIssueUrlValidatorExamples >> invalidUrl [
	^ 'https://github.com/feenkcom/gtoolkit/issues/anythingelse'
]

{ #category : #'examples - url' }
LeGitHubIssueUrlValidatorExamples >> shortInvalidUrl [
	^ 'https://github.com/feenkcom/gtoolkit/issues/'
]

{ #category : #'examples - url' }
LeGitHubIssueUrlValidatorExamples >> validUrl [
	^ 'https://github.com/feenkcom/gtoolkit/issues/1822'
]

{ #category : #'examples - validator' }
LeGitHubIssueUrlValidatorExamples >> validator_IllegalUrl [
	<gtExample>
	<return: #LeGitHubIssueUrlValidator>
	| aValidator |
	aValidator := LeGitHubIssueUrlValidator new.
	aValidator url: 'Tudor Gîrba'.
	aValidator validate.
	self assert: aValidator isValid not.
	^ aValidator
]

{ #category : #'examples - validator' }
LeGitHubIssueUrlValidatorExamples >> validator_InvalidUrl [
	<gtExample>
	<return: #LeGitHubIssueUrlValidator>
	| aValidator anUrl |
	aValidator := LeGitHubIssueUrlValidator new.

	anUrl := self invalidUrl.
	aValidator url: anUrl.
	self assert: aValidator url equals: anUrl.

	aValidator validate.
	self assert: aValidator isValid equals: false.
	self assert: aValidator identifier equals: anUrl.

	^ aValidator
]

{ #category : #'examples - validator' }
LeGitHubIssueUrlValidatorExamples >> validator_ShortInvalidUrl [
	<gtExample>
	<return: #LeGitHubIssueUrlValidator>
	| aValidator anUrl |
	aValidator := LeGitHubIssueUrlValidator new.

	anUrl := self shortInvalidUrl.
	aValidator url: anUrl.
	self assert: aValidator url equals: anUrl.

	aValidator validate.
	self assert: aValidator isValid equals: false.
	self assert: aValidator identifier equals: anUrl.

	^ aValidator
]

{ #category : #'examples - validator' }
LeGitHubIssueUrlValidatorExamples >> validator_ValidUrl [
	<gtExample>
	<return: #LeGitHubIssueUrlValidator>
	| aValidator anUrl |
	aValidator := LeGitHubIssueUrlValidator new.

	anUrl := self validUrl.
	aValidator url: anUrl.
	self assert: aValidator url equals: anUrl.

	aValidator validate.
	self assert: aValidator isValid equals: true.
	self assert: aValidator ownerName equals: 'feenkcom'.
	self assert: aValidator projectName equals: 'gtoolkit'.
	self assert: aValidator issueNumber equals: '1822'.
	self assert: aValidator identifier equals: '[feenkcom/gtoolkit#1822]'.

	^ aValidator
]
