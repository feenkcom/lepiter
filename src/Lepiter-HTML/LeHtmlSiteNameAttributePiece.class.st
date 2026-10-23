"
I write the name of the site (usually the name of the book) as the value of an HTML attribute, for example, of the og:site_name meta tag. I am used by the siteNameAttribute placeholder of a page template, see {{gtClass:LeHtmlGtBookPiece}}. The name comes from {{gtMethod:LeHtmlContext>>#siteName}}.
"
Class {
	#name : #LeHtmlSiteNameAttributePiece,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #'instance creation' }
LeHtmlSiteNameAttributePiece class >> asLeHtmlFormatPiece [
	^ self new
]

{ #category : #converting }
LeHtmlSiteNameAttributePiece >> asLeHtmlFormatPiece [
	^ self
]

{ #category : #'gt - extensions' }
LeHtmlSiteNameAttributePiece >> gtOutputFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Output';
		priority: 20;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ String streamContents: [ :aStream | 
			self writeWithContext: (LeHtmlContext new stream: aStream) ] ]
]

{ #category : #'api - writing' }
LeHtmlSiteNameAttributePiece >> writeWithContext: aContext [
	aContext siteName ifNotNil: [ :aSiteName | 
		aContext html escapeAttributeValue: aSiteName ]
]
