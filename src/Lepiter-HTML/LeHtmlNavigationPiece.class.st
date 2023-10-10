Class {
	#name : #LeHtmlNavigationPiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #'api - writing' }
LeHtmlNavigationPiece >> writeWithContext: aContext [
	LeHtmlBookNavigationExporter new
		database: aContext database;
		pageLinks: aContext pageLinks;
		selectedPage: aContext page;
		writeStream: aContext html;
		hrefBuilder: aContext hrefBuilder;
		export
]
