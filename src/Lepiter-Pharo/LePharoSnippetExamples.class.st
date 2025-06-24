Class {
	#name : #LePharoSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Pharo-Examples'
}

{ #category : #examples }
LePharoSnippetExamples >> database [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := LeDatabase new.
	database userEmail: self userEmail.

	self assert: database size equals: 0.

	^ database
]

{ #category : #examples }
LePharoSnippetExamples >> pageWithCodeAndTextSnippets [
	<gtExample>
	<return: #LePage>
	| database page snippet |
	database := self database.
	page := database pageBuilder
			title: 'Page 1';
			add.
	page addSnippet: (LePharoSnippet code: '1.').
	page addSnippet: (LeTextSnippet string: '2').
	page addSnippet: (LePharoSnippet code: '3.').
	page addSnippet: (LeTextSnippet string: '4').
	snippet := page children at: 1.
	self assert: snippet editEmail equals: self userEmail.
	self assert: snippet createEmail equals: self userEmail.
	self assert: page childrenCount equals: 4.
	^ page
]

{ #category : #examples }
LePharoSnippetExamples >> pageWithPharoSnippets [
	<gtExample>
	<return: #LePage>
	| database page snippet |
	database := self database.
	page := database pageBuilder
			title: 'Page 1';
			add.
	page addSnippet: (LePharoSnippet code: '1.').
	page addSnippet: (LePharoSnippet code: '2.').
	page addSnippet: (LePharoSnippet code: '3.').
	page addSnippet: (LePharoSnippet code: '4.').
	snippet := page children at: 1.
	self assert: snippet editEmail equals: self userEmail.
	self assert: snippet createEmail equals: self userEmail.
	self assert: page childrenCount equals: 4.
	^ page
]

{ #category : #private }
LePharoSnippetExamples >> userEmail [

	^ LeEmail address: 'snippets@email.com'
]
