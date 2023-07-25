Class {
	#name : #LeExportSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithClassAnnotation [
	<gtExample>
	| snippet |

	snippet := LeTextSnippet  string: '{{gtClass:BrButton|label=Button}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExampleAnnotation [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet new string: '{{gtExample:', BrExamplesShowroom name, ' >> #', #glamorousLargeButton, '}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExampleAnnotationWithLabel [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet new string: '{{gtExample:', BrExamplesShowroom name, ' >> #', #glamorousLargeButton, ' | label=#printString}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExampleAnnotationWithPreviewExpanded [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet new string: '{{gtExample:', BrExamplesShowroom name, ' >> #', #glamorousLargeButton, ' | previewExpanded=true}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExternalLabelUrlLink [
	<gtExample>
	| snippet |

	snippet := LeTextSnippet  string: '[GToolkit](https://gtoolkit.com)'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithImageLinkWithAbsolutePath [
	<gtExample>
	| snippet database page temporaryDirectory imageFile |
	temporaryDirectory := GtTemporaryDirectory new.
	database := LeLocalStoreLoad current onlyLoadFrom: temporaryDirectory reference.
	database optionAt: #temporaryDirectory put: temporaryDirectory.
	
	imageFile := FileLocator gtResource / 'feenkcom' / 'gtoolkit' / 'doc' / 'gtoolkit.png'.
	self assert: imageFile exists.
	
	page := database pageBuilder
			title: 'Image link';
			add.

	snippet := page snippetBuilder
			string: ('![Attachment Image Link]({1})' format: { imageFile asZnRelativeUrl });
			add.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithImageLinkWithRelativeAttachmentPath [
	<gtExample>
	| snippet database page temporaryDirectory imageFile attachmentPath |
	temporaryDirectory := GtTemporaryDirectory new.
	database := LeLocalStoreLoad current onlyLoadFrom: temporaryDirectory reference.
	database optionAt: #temporaryDirectory put: temporaryDirectory.
	
	imageFile := FileLocator gtResource / 'feenkcom' / 'gtoolkit' / 'doc' / 'gtoolkit.png'.
	self assert: imageFile exists.
	
	attachmentPath := database addAttachmentByCopy: imageFile.
	
	page := database pageBuilder
			title: 'Image link';
			add.

	snippet := page snippetBuilder
			string: ('![Attachment Image Link](file:///{1})' format: { attachmentPath });
			add.

	^ snippet
]
