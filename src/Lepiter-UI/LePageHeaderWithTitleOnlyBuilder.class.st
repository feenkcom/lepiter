"
I add a title to a header.
I am used by {{gtClass:LePageToolContentElement}} in {{gtMethod:LePageToolContentElement>>#withTitleOnly|label=#selector}}.
## Example
{{gtExample:LeUIExamples>>#pageToolContentElement_TitleOnly|previewExpanded|codeExpanded=false}}

"
Class {
	#name : #LePageHeaderWithTitleOnlyBuilder,
	#superclass : #LePageHeaderBuilder,
	#category : 'Lepiter-UI-Support - Page Toolbar'
}

{ #category : #'api - building' }
LePageHeaderWithTitleOnlyBuilder >> build [
	self removeAllItems.
	self addTitle
]
