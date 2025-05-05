Class {
	#name : #LeBlockStylerVisitorExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-UI-Snippet-Examples'
}

{ #category : #examples }
LeBlockStylerVisitorExamples >> isValidLinkWideString [
	"Check that a file url with non-ascii characters (ěščřžýáíé) is accepted.
	The reference to the file must either be a path, which can be a wide string, or a valid URL"

	<gtExample>
	<return: #LeBlockStylerVisitorExamples>
	| file fileUrl visitor |
	file := FileReference newTempFilePrefix: 'sýr' suffix: '.txt'.
	fileUrl := file asZnUrl.
	[ file ensureCreateFile.
	visitor := LeSnippetStyler new visitorForText: fileUrl asString.
	self assert: (visitor isValidLink: fileUrl asString).
	self assert: (visitor isValidLink: file fullName) ] ensure: [ file delete ]
]
