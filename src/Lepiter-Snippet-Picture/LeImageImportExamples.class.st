"
Demonstrate visiting a {{gtClass:name=LeDatabase}} and importing all externally referenced images as local attachments.

"
Class {
	#name : #LeImageImportExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Picture-Examples'
}

{ #category : #examples }
LeImageImportExamples >> importImages [
	"Demonstrate importing images through text & picture snippets and check that images that can't be downloaded are flagged correctly."

	<gtExample>
	<return: #LeImageImportVisitor>
	| database memStore page textSnippet pictureSnippet badUrlSnippet badUrl visitor |
	memStore := FileSystem memory root / 'db'.
	memStore ensureCreateDirectory.
	database := LeLocalStoreLoad current loadAndMonitorFrom: memStore.
	database monitor savePersonalInformation: true.
	page := LePage named: #Page1.
	textSnippet := LeTextSnippet
			string: '![Feenk](https://feenk.com/assets/pictures/feenk.png)'.
	page addSnippet: textSnippet.
	pictureSnippet := LePictureSnippet new
			urlString: 'https://feenk.com/assets/pictures/casestudy-connections.png'.
	page addSnippet: pictureSnippet.
	badUrl := '![](https://feenk.com/assets/pictures/doesntexist.png)'.
	badUrlSnippet := LeTextSnippet string: badUrl.
	page addSnippet: badUrlSnippet.
	database addPage: page.
	visitor := LeImageImportVisitor new.
	database acceptVisitor: visitor.
	self assert: visitor addedImages size equals: 2.
	self assert: visitor failedImages size equals: 1.
	self assert: ('attachments/.*/feenk.png' asRegex search: textSnippet string).
	self assert: badUrlSnippet string equals: badUrl.
	visitor cleanUp.
	^ visitor
]
