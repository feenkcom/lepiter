"
I add a title and an inspect button to a header.
I am used by {{gtClass:LePageToolContentElement}} in {{gtMethod:LePageToolContentElement>>#withTitleAndButtons|label=#selector}}.
## Example
{{gtExample:LeUIExamples>>#pageToolContentElement_TitleAndInspectButton|previewExpanded|codeExpanded=false}}

"
Class {
	#name : #LePageHeaderWithTitleAndButtonsBuilder,
	#superclass : #LePageHeaderBuilder,
	#category : #'Lepiter-UI-Support - Page Toolbar'
}

{ #category : #'api - building' }
LePageHeaderWithTitleAndButtonsBuilder >> build [
	self removeAllItems.
	self addTitle.
	self addToolbarToFrame.
	self addExtensionButtons.
]
