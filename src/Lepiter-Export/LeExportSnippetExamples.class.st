Class {
	#name : #LeExportSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithClassAnnotation [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtClass:' , BrButton name , '}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithClassAnnotationCollapsed [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtClass:' , BrButton  name , ' | expanded=false}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithClassAnnotationExpanded [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtClass:' , BrButton name , ' | expanded}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithClassAnnotationLabeledAndText [
	<gtExample>
	| snippet |

	snippet := LeTextSnippet  string: '{{gtClass:BrButton|label=Button}} **has** *very* nice API.'.

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
LeExportSnippetExamples >> textSnippetWithExternalUrlLink [
	<gtExample>
	| snippet |

	snippet := LeTextSnippet  string: '<https://gtoolkit.com>'.

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

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithImageLinkWithRelativeAttachmentPathWithTwoSlashes [
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
			string: ('![Attachment Image Link](file://{1})' format: { attachmentPath });
			add.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithMethodAnnotation [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtMethod:' , (BrButton >> #action:) printString , '}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithMethodAnnotationCollapsed [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtMethod:' , (BrButton >> #action:) printString , ' | expanded=false}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithMethodAnnotationExpanded [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtMethod:' , (BrButton >> #action:) printString , ' | expanded}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithMethodAnnotationLabeled [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtMethod:' , (BrButton >> #action:) printString , ' | label=Button}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithPackageAnnotation [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtPackage:' , BrButton package name asString , '}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithPackageAnnotationLabeled [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet
			string: '{{gtPackage:' , BrButton package name asString , ' | label=Button package}}'.

	^ snippet
]
