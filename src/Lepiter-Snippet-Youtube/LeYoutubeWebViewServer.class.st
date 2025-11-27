Class {
	#name : #LeYoutubeWebViewServer,
	#superclass : #Object,
	#instVars : [
		'webViewCounter',
		'zincServer'
	],
	#classVars : [
		'ServerSingleton'
	],
	#category : #'Lepiter-Snippet-Youtube-View-Model'
}

{ #category : #'class initialization' }
LeYoutubeWebViewServer class >> initialize [
	ServerSingleton := AsyncMutex for: (nil asWeakReference)
]

{ #category : #accessing }
LeYoutubeWebViewServer class >> runningInstance [
	^ ServerSingleton
		lock: [ :aWeakReference |
			(aWeakReference at: 1)
				ifNil: [
					| aServer |
					aServer := self new.
					aWeakReference at: 1 put: aServer.
					aServer ]
				ifNotNil: [ :aServer | aServer ] ]
]

{ #category : #finalization }
LeYoutubeWebViewServer >> finalize [
	zincServer stop
]

{ #category : #initialization }
LeYoutubeWebViewServer >> initialize [
	super initialize.
	
	zincServer := ZnServer defaultOn: 0.
	zincServer onRequestRespond: (WeakMessageSend receiver: self selector: #onRequestRespond:).
	zincServer start.
	self class finalizationRegistry add: self
]

{ #category : #'as yet unclassified' }
LeYoutubeWebViewServer >> onRequestRespond: aRequest [
	| query html |

	query := aRequest uri query.
	html := self responseTemplate format: query.
	
	^ ZnResponse ok: (ZnEntity html: html)
]

{ #category : #initialization }
LeYoutubeWebViewServer >> responseTemplate [
	^ '<html><body><iframe 
	style="aspect-ratio: 16 / 9; height: 100%;" 
	src="https://www.youtube.com/embed/{videoIdAndStart}" 
	title="YouTube video player" 
	frameborder="0"
	allow="accelerometer;autoplay;clipboard-write;encrypted-media;gyroscope;picture-in-picture;web-share"
	referrerpolicy="strict-origin-when-cross-origin" 
	allowfullscreen>
</iframe>
</body></html>'
]

{ #category : #accessing }
LeYoutubeWebViewServer >> urlForVideoId: aVideoId [
	| aUrl |
	aUrl := zincServer localUrl.
	aUrl queryAt: 'videoIdAndStart' put: aVideoId.
	^ aUrl
]
