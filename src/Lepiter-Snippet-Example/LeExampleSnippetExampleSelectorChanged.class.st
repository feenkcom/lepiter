Class {
	#name : #LeExampleSnippetExampleSelectorChanged,
	#superclass : #LeExampleSnippetContentChanged,
	#instVars : [
		'exampleSelector'
	],
	#category : 'Lepiter-Snippet-Example-Snippet - Events'
}

{ #category : #generated }
LeExampleSnippetExampleSelectorChanged >> exampleSelector [
	<objectGetter: #example>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ exampleSelector
]

{ #category : #generated }
LeExampleSnippetExampleSelectorChanged >> exampleSelector: aExampleSelector [
	<objectSetter: #example>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	exampleSelector := aExampleSelector
]
