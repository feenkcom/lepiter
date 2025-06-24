Class {
	#name : #LeExportSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithClassAnnotation [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet string: '{{gtClass:' , BrButton name , '}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithClassAnnotationCollapsed [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtClass:' , BrButton name , ' | expanded=false}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithClassAnnotationExpanded [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet string: '{{gtClass:' , BrButton name , ' | expanded}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithClassAnnotationLabeledAndText [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtClass:BrButton|label=Button}} **has** *very* nice API.'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExampleAnnotation [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet new
			string: '{{gtExample:' , BrExamplesShowroom name , ' >> #' , #glamorousLargeButton
					, '}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExampleAnnotationWithLabel [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet new
			string: '{{gtExample:' , BrExamplesShowroom name , ' >> #' , #glamorousLargeButton
					, ' | label=#printString}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExampleAnnotationWithPreviewExpanded [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet new
			string: '{{gtExample:' , BrExamplesShowroom name , ' >> #' , #glamorousLargeButton
					, ' | previewExpanded=true}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExternalLabelUrlLink [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet string: '[GToolkit](https://gtoolkit.com)'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExternalUrlLink [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet string: '<https://gtoolkit.com>'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithImageLinkWithAbsolutePath [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet database page temporaryDirectory imageFile |
	temporaryDirectory := GtTemporaryDirectory new.
	database := LeLocalStoreLoad current onlyLoadFrom: temporaryDirectory reference.
	database optionAt: #temporaryDirectory put: temporaryDirectory.

	imageFile := FileLocator gtResource / 'feenkcom' / 'gtoolkit' / 'doc'
			/ 'gtoolkit.png'.
	self assert: imageFile exists.

	page := database pageBuilder
			title: 'Image link';
			add.

	snippet := page snippetBuilder
			string: ('![Attachment Image Link]({1})' format: {imageFile asZnRelativeUrl});
			add.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithImageLinkWithRelativeAttachmentPath [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet database page temporaryDirectory imageFile attachmentPath |
	temporaryDirectory := GtTemporaryDirectory new.
	database := LeLocalStoreLoad current onlyLoadFrom: temporaryDirectory reference.
	database optionAt: #temporaryDirectory put: temporaryDirectory.

	imageFile := FileLocator gtResource / 'feenkcom' / 'gtoolkit' / 'doc'
			/ 'gtoolkit.png'.
	self assert: imageFile exists.

	attachmentPath := database addAttachmentByCopy: imageFile.

	page := database pageBuilder
			title: 'Image link';
			add.

	snippet := page snippetBuilder
			string: ('![Attachment Image Link](file:///{1})' format: {attachmentPath});
			add.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithImageLinkWithRelativeAttachmentPathWithTwoSlashes [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet database page temporaryDirectory imageFile attachmentPath |
	temporaryDirectory := GtTemporaryDirectory new.
	database := LeLocalStoreLoad current onlyLoadFrom: temporaryDirectory reference.
	database optionAt: #temporaryDirectory put: temporaryDirectory.

	imageFile := FileLocator gtResource / 'feenkcom' / 'gtoolkit' / 'doc'
			/ 'gtoolkit.png'.
	self assert: imageFile exists.

	attachmentPath := database addAttachmentByCopy: imageFile.

	page := database pageBuilder
			title: 'Image link';
			add.

	snippet := page snippetBuilder
			string: ('![Attachment Image Link](file://{1})' format: {attachmentPath});
			add.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithMethodAnnotation [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtMethod:' , (BrButton >> #action:) printString , '}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithMethodAnnotationCollapsed [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtMethod:' , (BrButton >> #action:) printString , ' | expanded=false}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithMethodAnnotationExpanded [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtMethod:' , (BrButton >> #action:) printString , ' | expanded}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithMethodAnnotationLabeled [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtMethod:' , (BrButton >> #action:) printString , ' | label=Button}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithPackageAnnotation [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtPackage:' , BrButton package name asString , '}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithPackageAnnotationLabeled [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtPackage:' , BrButton package name asString , ' | label=Button package}}'.

	^ snippet
]
