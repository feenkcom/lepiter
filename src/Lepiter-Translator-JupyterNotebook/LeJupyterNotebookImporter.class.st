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
	| rawNotebook |
	rawNotebook := LeJupyterRawNotebook fromIpynbFile: aFileReference.
	^ rawNotebook createLepiterPage
]
