Extension { #name : #LeContextMenuSpotterStart }

{ #category : #'*Lepiter-Snippet-Picture' }
LeContextMenuSpotterStart >> gtSpotterForOnlineWardleyMapFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		title: 'Add Wardley Map';
		priority: 2;
		itemName: #title;
		search: [ :aContext | 
			((aContext searchQuery asAsyncFuture asAsyncStream
				collect: [ :aQuery | 
					(aQuery beginsWith: 'https://onlinewardleymaps.com/')
						ifTrue: [ aQuery removePrefix: 'https://onlinewardleymaps.com/#' ]
						ifFalse: [ nil ] ]) select: #notNil)
				collect: [ :aMapId | 
					LeContextMenuItemValuableSpecification new
						valuable: [ 
							| url json dictionary map |
							url := 'https://api.onlinewardleymaps.com/v1/maps/fetch?id='
									, (aMapId gtRemovePrefix: 'https://onlinewardleymaps.com/#').
							json := ZnClient new get: url.
							dictionary := STONJSON fromString: json.
							map := GtWardleyMapScriptImporter
									forString: (dictionary at: 'text') asString.
							LeWardleyMapSnippet new wardleyMap: map ];
						title: aMapId ] ]
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeContextMenuSpotterStart >> gtSpotterForOnlineYouTubeVideoFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		title: 'Add YouTube video';
		priority: 2;
		itemName: #title;
		search: [ :aContext | 
			((aContext searchQuery asAsyncFuture asAsyncStream
				collect: [ :aQuery | 
					| aYouTubeUrl |
					aYouTubeUrl := LeYoutubeUrl new string: aQuery.
					aYouTubeUrl isValidYoutubeUrl
						ifFalse: [ nil ]
						ifTrue: [ aYouTubeUrl ] ]) select: #notNil)
				collect: [ :aYouTubeUrl | 
					LeContextMenuItemValuableSpecification new
						valuable: [ 
							LeYoutubeReferenceSnippet new
								urlString: aYouTubeUrl url asString. ];
						title: aYouTubeUrl string ] ]
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeContextMenuSpotterStart >> gtSpotterForPictureFor: aSearch [
	<gtSearch>

	^ aSearch explicit
		title: 'Add picture snippet';
		priority: 2;
		itemName: #title;
		search: [ :aContext |
			((aContext searchQuery asAsyncFuture asAsyncStream
				collect: [ :aQuery | self spotterPictureFileStringFor: aQuery trimBoth ])
				select: #notNil)
				collect: [ :aPicturePath |
					LeContextMenuItemValuableSpecification new
						valuable: [ LePictureSnippet new urlString: aPicturePath ];
						title: aPicturePath ] ]
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeContextMenuSpotterStart >> spotterPictureFileStringFor: pictureString [
	"Answer the Picture Snippet URL string for the given pictureString, which may be a local file or URL.
	If the string doesn't have a known image file type, answer nil.
	If the picture is a local file and not already part of the database, copy it in."
	| mimeType extension urlUtility url |

	extension := (pictureString copyAfterLast: $.) asLowercase.
	mimeType := ZnMimeType forFilenameExtension: extension.
	mimeType main = 'image' ifFalse: [ ^ nil ].
	urlUtility := GtUrlStringUtility new
		rootDirectory: self database localStoreRootDirectory;
		urlString: pictureString.
	^ urlUtility isValid ifTrue: 
		[ (pictureString beginsWith: 'attachments') ifTrue:
			"The file is already in the database, don't add it a second time"
			[ pictureString ]
		ifFalse: [ url := urlUtility urlString asZnUrl.
			url isFile ifFalse:
				"It's not a local file, use as is"
				[ pictureString ]
			ifTrue:
				"The file is local and isn't in the database, copy it in (and answer the relative path string"
				[ self database addAttachmentByCopy: pictureString asFileReference ] ] ]
	ifFalse:
		[ nil ].

]
