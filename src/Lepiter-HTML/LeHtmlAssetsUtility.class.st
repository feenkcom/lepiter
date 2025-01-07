Class {
	#name : #LeHtmlAssetsUtility,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Resources - Buiders'
}

{ #category : #'api - resources' }
LeHtmlAssetsUtility class >> addAssetResourcesFrom: directory into: resources [
	LeHtmlAssetsInDirectoryResourceBuilder new
		rootDiretory: directory;
		resources: resources;
		build
]

{ #category : #'api - resources' }
LeHtmlAssetsUtility class >> addGtBookAssetsInto: resources [
	self
		addAssetResourcesFrom: self gtBookAssetsDirectory
		into: resources
]

{ #category : #'api - resources' }
LeHtmlAssetsUtility class >> gtBookAssetsDirectory [
	^ FileLocator gtResource 
		/ 'feenkcom' 
		/ 'lepiter' 
		/ 'doc' 
		/ 'gtbook' 
		/ 'assets'
]
