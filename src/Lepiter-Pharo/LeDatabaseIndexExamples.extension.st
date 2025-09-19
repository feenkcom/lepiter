Extension { #name : #LeDatabaseIndexExamples }

{ #category : #'*Lepiter-Pharo' }
LeDatabaseIndexExamples >> database [
	<gtExample>
	<return: #LeDatabase>
	| page pageUID database |
	database := LeDatabase new.

	page := LePage named: self pageTitle.
	database addPage: page.
	pageUID := page uid.

	page
		addSnippet: (LePharoSnippet new
				code: 'OrderedCollection withAll: {#printString. #Object. #''a b c''. #printOn:}').

	page addSnippet: (LePharoSnippet new code: '2 printString').

	page addSnippet: (LePharoSnippet new code: 'OrderedCollection new').

	page
		addSnippet: (LePharoSnippet new code: '(Smalltalk at: #OrderedCollection) new').

	page
		addSnippet: (LeTextSnippet new
				string: '{{gtClass:Object}} {{gtMethod:name=Set>>grow}} {{gtExample:LeDatabaseIndexExamples>>#database}}').


	self assert: (database pageWithID: pageUID) uid equals: pageUID.

	^ database
]
