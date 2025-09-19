Class {
	#name : #LeExportPageExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #examples }
LeExportPageExamples >> pageWithTextSnippetUsedAsPagePreview [
	<gtExample>
	<return: #LePage>
	| aPage |
	aPage := LePage new.

	aPage title: 'Page with Markdowns'.

	aPage snippetBuilder
		string: '[GToolkit](https://gtoolkit), {{gtClass:' , BrButton name asString
				, ' | label=Button}}, {{gtMethod: ' , (BrButton >> #action:) printString
				, ' | label=action method}}, **is** *italic*.';
		add.

	^ aPage
]
