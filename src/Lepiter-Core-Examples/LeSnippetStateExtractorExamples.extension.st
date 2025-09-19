Extension { #name : #LeSnippetStateExtractorExamples }

{ #category : #'*Lepiter-Core-Examples' }
LeSnippetStateExtractorExamples >> extractCommonStateForAllEmptySnippetTypes [
	<gtExample>
	<return: #OrderedCollection>
	^ (LeSnippet allSubclasses reject: #isAbstract)
		collect: [ :aSnippetClass | 
			| snippet state |
			snippet := aSnippetClass empty.
			state := snippet extractCommonState.

			self assertCommonStateAttributesFor: state.
			state attributes
				do: [ :anAttribute | self assert: anAttribute attributeValue isNil ].

			snippet -> state ]
]

{ #category : #'*Lepiter-Core-Examples' }
LeSnippetStateExtractorExamples >> extractCommonStateForAllSnippetTypes [
	<gtExample>
	<return: #OrderedCollection>
	| createEmail createTime editEmail editTime |
	createEmail := 'unknown@email.com'.
	createTime := DateAndTime now.
	editEmail := 'unknown@email.com'.
	editTime := createTime + 1 second.

	^ (LeSnippet allSubclasses reject: #isAbstract)
		collect: [ :aSnippetClass | 
			| snippet state |
			snippet := aSnippetClass empty
					createEmail: createEmail;
					createTime: createTime;
					editEmail: editEmail;
					editTime: editTime.
			state := snippet extractCommonState.
			self
				assert: (state attributeNamed: 'createEmail') attributeValue
				equals: createEmail.
			self
				assert: (state attributeNamed: 'createTime') attributeValue
				equals: createTime.
			self
				assert: (state attributeNamed: 'editEmail') attributeValue
				equals: editEmail.
			self
				assert: (state attributeNamed: 'editTime') attributeValue
				equals: editTime.
			snippet -> state ]
]

{ #category : #'*Lepiter-Core-Examples' }
LeSnippetStateExtractorExamples >> extractSpecificStateForAllEmptySnippetTypes [
	<gtExample>
	<return: #OrderedCollection>
	^ (LeSnippet allSubclasses reject: #isAbstract)
		collect: [ :aSnippetClass | 
			| snippet state |
			snippet := aSnippetClass empty.
			state := snippet extractSpecificState.
			self
				assert: state attributesCount
				equals: aSnippetClass leJsonV4AttributeMapping size
						- LeSnippet leJsonV4AttributeMapping size.
			snippet -> state ]
]
