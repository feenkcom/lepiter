Class {
	#name : #LeJupyterNotebookImporter,
	#superclass : #Object,
	#category : #'Lepiter-Translator-JupyterNotebook'
}

{ #category : #accessing }
LeJupyterNotebookImporter >> createLepiterPageForNotebookAt: aFileReference [
	| rawNotebook aPage |
	rawNotebook := LeJupyterRawNotebook fromIpynbFile: aFileReference.
	aPage := rawNotebook createLepiterPage.

	^ aPage
]
