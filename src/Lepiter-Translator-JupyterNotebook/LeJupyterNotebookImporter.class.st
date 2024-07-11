Class {
	#name : #LeJupyterNotebookImporter,
	#superclass : #Object,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Translator-JupyterNotebook'
}

{ #category : #'instance creation' }
LeJupyterNotebookImporter class >> forDatabase: aDatabase [
	^ self new
		database: aDatabase
]

{ #category : #accessing }
LeJupyterNotebookImporter >> createLepiterPageForNotebookAt: aFileReference [
	| rawNotebook aPage |
	rawNotebook := LeJupyterRawNotebook fromIpynbFile: aFileReference.
	aPage := rawNotebook createLepiterPage.

	database ifNotNil: [ database addPage: aPage ].

	^ aPage
]

{ #category : #accessing }
LeJupyterNotebookImporter >> database [
	^ database
]

{ #category : #accessing }
LeJupyterNotebookImporter >> database: anObject [
	database := anObject
]
