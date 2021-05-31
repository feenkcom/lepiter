Class {
	#name : #LeBlockStylerVisitorExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-UI-Snippet-Examples'
}

{ #category : #examples }
LeBlockStylerVisitorExamples >> fileAbsoluteURL [
	<gtExample>
	| imagePath styler urlString |

	styler := LeSnippetStylerVisitor basicNew.
	imagePath := FileLocator image pathString.
	urlString := 'file://localhost', imagePath.
	self
		assert: (styler cleanURL: urlString in: FileLocator imageDirectory resolve)
		equals: urlString.
	^ urlString
]

{ #category : #examples }
LeBlockStylerVisitorExamples >> fileNoHostAbsoluteURL [
	<gtExample>
	| imagePath styler urlString |

	styler := LeSnippetStylerVisitor basicNew.
	imagePath := FileLocator image pathString.
	urlString := 'file://', imagePath.
	self
		assert: (styler cleanURL: urlString in: FileLocator imageDirectory resolve)
		equals: ('file://localhost', imagePath).
	^ urlString
]

{ #category : #examples }
LeBlockStylerVisitorExamples >> fileNoHostRelativeURL [
	<gtExample>
	| imagePath styler urlString |

	styler := LeSnippetStylerVisitor basicNew.
	imagePath := FileLocator image pathString.
	urlString := 'file://', FileLocator image basename.
	self
		assert: (styler cleanURL: urlString in: FileLocator imageDirectory resolve)
		equals: 'file://localhost', imagePath.
	^ urlString
]

{ #category : #examples }
LeBlockStylerVisitorExamples >> fileNoSchemeAbsoluteURL [
	<gtExample>
	| imagePath styler |

	styler := LeSnippetStylerVisitor basicNew.
	imagePath := FileLocator image pathString.
	self
		assert: (styler cleanURL: imagePath in: FileLocator imageDirectory resolve)
		equals: 'file://localhost', imagePath.
	^ imagePath
]

{ #category : #examples }
LeBlockStylerVisitorExamples >> fileNoSchemeRelativeURL [
	<gtExample>
	| imagePath styler urlString |

	styler := LeSnippetStylerVisitor basicNew.
	imagePath := FileLocator image pathString.
	urlString := FileLocator image basename.
	self
		assert: (styler cleanURL: urlString in: FileLocator imageDirectory resolve)
		equals: 'file://localhost', imagePath.
	^ urlString
]

{ #category : #examples }
LeBlockStylerVisitorExamples >> fileRelativeURL [
	<gtExample>
	| imagePath styler urlString |

	styler := LeSnippetStylerVisitor basicNew.
	imagePath := FileLocator image pathString.
	urlString := 'file://localhost/', FileLocator image basename.
	self
		assert: (styler cleanURL: urlString in: FileLocator imageDirectory resolve)
		equals: 'file://localhost', imagePath.
	^ urlString
]

{ #category : #examples }
LeBlockStylerVisitorExamples >> isValidLinkWideString [
	<noTest>
	<gtExample>
	"Check that a file url with non-ascii characters (ěščřžýáíé) is accepted"
	| file fileUrl visitor |

	file := FileReference newTempFilePrefix: 'sýr' suffix:  '.txt'.
	fileUrl := 'file://localhost', file fullName.
	visitor := LeSnippetStyler new visitorForText: fileUrl.
	[ file ensureCreateFile.
	self assert: (visitor isValidLink: fileUrl) ]
		ensure: [ file delete ].
]
