Extension { #name : 'BlElement' }

{ #category : '*Lepiter-UI' }
BlElement >> doBlockSoon: aBlock [
	"Some operations don't work if done immediately.  Defer the block by one or two pulses.
	This is only for debugging and should not be used in normal circumstances.
	A horrible hack"

	"^ aBlock value"
	^ self enqueueTask: (BlDelayedPulsesTaskAction new 
				count: 1;
				action: aBlock;
				yourself)
]
