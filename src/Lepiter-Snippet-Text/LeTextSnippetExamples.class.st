Class {
	#name : #LeTextSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Text-Examples'
}

{ #category : #'examples - text snippet' }
LeTextSnippetExamples >> basicTextSnippetElement [
	<gtExample>
	| anElement |

	anElement := LeTextCoderSnippetElement new.
	anElement aptitude: (LeSnippetExpandableAptitude new snippetContent: anElement snippetContent).

	self assert: anElement hasSnippetViewModel not.

	^ anElement
]

{ #category : #'api - accessing' }
LeTextSnippetExamples >> database [
	<gtExample>

	^ LeDatabase new
]

{ #category : #'examples - text snippet' }
LeTextSnippetExamples >> textSnippetElementWithViewModel [
	<gtExample>
	| anElement aBlock |

	anElement := self basicTextSnippetElement.
	aBlock := self textSnippetWithLinkToPage.

	anElement snippetViewModel: aBlock asSnippetViewModel.
	self assert: anElement snippet equals: aBlock.
	^ anElement
]

{ #category : #'examples - text snippet' }
LeTextSnippetExamples >> textSnippetElement_DoNotShareSameTextInstances [
	<gtExample>
	| anEditorOne aTextSnippetViewModel anEditorTwo |

	anEditorOne := self basicTextSnippetElement.
	anEditorTwo := self basicTextSnippetElement.

	aTextSnippetViewModel := self textSnippetWithLinkToPage asSnippetViewModel.
	
	anEditorOne snippetViewModel: aTextSnippetViewModel.
	anEditorTwo snippetViewModel: aTextSnippetViewModel.

	self 
		assert: [ anEditorOne editorElement text ~= anEditorTwo editorElement text ]
		description: [ 'Text editors must not share same BlText instances' ].
	
	^ anEditorOne
]

{ #category : #'examples - text snippet' }
LeTextSnippetExamples >> textSnippetWithLinkToPage [
	<gtExample>
	| aPage aSnippet |

	aSnippet := LeTextSnippet string: (String loremIpsum: 100) allButLast, ' [[two]] ', (String loremIpsum: 100).

	aPage := self database pageBuilder title: 'one'; add.
	aPage addSnippet: aSnippet.

	self assert: aSnippet class equals: LeTextSnippet.

	^ aSnippet
]
