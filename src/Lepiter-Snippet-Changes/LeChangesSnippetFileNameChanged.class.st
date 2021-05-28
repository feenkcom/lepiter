Class {
	#name : #LeChangesSnippetFileNameChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'fileName'
	],
	#category : #'Lepiter-Snippet-Changes-Snippet - Events'
}

{ #category : #generated }
LeChangesSnippetFileNameChanged >> fileName [
	<objectGetter: #changes>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ fileName
]

{ #category : #generated }
LeChangesSnippetFileNameChanged >> fileName: aFileName [
	<objectSetter: #changes>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	fileName := aFileName
]
