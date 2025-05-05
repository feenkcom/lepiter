"
I exemplify {{gtClass:LeDatabaseSnippetUpdater}}.

"
Class {
	#name : #LeDatabaseSnippetUpdaterExamples,
	#superclass : #LeSnippetBuilderExamples,
	#category : #'Lepiter-Core-Examples-Builder'
}

{ #category : #'examples - updating' }
LeDatabaseSnippetUpdaterExamples >> updateSnippetOneToTwo [
	<gtExample>
	<return: #LeTextSnippet>
	| aSnippet aCreateTime aCreateEmail anEditTime anEditEmail aNewUserEmail aNewText |
	aSnippet := self textSnippetInPageAndDatabase.
	aCreateTime := aSnippet createTime.
	aCreateEmail := aSnippet createEmail.
	anEditTime := aSnippet editTime.
	anEditEmail := aSnippet editEmail.
	aNewUserEmail := 'connie@dogs.com'.
	aSnippet database userEmail: aNewUserEmail.
	aNewText := 'one > two' asRopedText.
	aSnippet updateText: aNewText.
	self assert: aSnippet text characters equals: aNewText characters.
	self assert: aSnippet string equals: aNewText asString.
	self assert: aSnippet createTime == aCreateTime.
	self assert: aSnippet createEmail == aCreateEmail.
	self assert: (aSnippet editTime == anEditTime) not.
	self assert: (aSnippet editEmail == anEditEmail) not.
	self assert: aSnippet editEmail equals: aSnippet database userEmail.
	self assert: aSnippet editEmail email equals: aNewUserEmail.
	self assert: aSnippet text equals: aNewText.
	^ aSnippet
]

{ #category : #'examples - updating' }
LeDatabaseSnippetUpdaterExamples >> updateSnippetOneToTwo_Simplified_String [
	<gtExample>
	<return: #LeTextSnippet>
	| aSnippet |
	aSnippet := self textSnippetInPageAndDatabase.
	aSnippet updateString: 'one > two'.
	self assert: aSnippet text characters equals: 'one > two'.
	^ aSnippet
]

{ #category : #'examples - updating' }
LeDatabaseSnippetUpdaterExamples >> updateSnippetOneToTwo_Simplified_Text [
	<gtExample>
	<return: #LeTextSnippet>
	| aSnippet |
	aSnippet := self textSnippetInPageAndDatabase.
	aSnippet updateText: 'one > two' asRopedText.
	self assert: aSnippet text characters equals: 'one > two'.
	^ aSnippet
]
