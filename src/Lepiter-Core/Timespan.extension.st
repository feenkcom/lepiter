Extension { #name : #Timespan }

{ #category : #'*Lepiter-Core' }
Timespan >> dayWithSuffix [
	"Answer the dayOfMonth with its suffix, i.e. one of st, nd, rd, th"
	| dayOfMonth lastDigit suffix |

	dayOfMonth := self dayOfMonth.
	lastDigit := dayOfMonth asString last.
	suffix := (lastDigit = $1 and: [ dayOfMonth ~= 11 ]) ifTrue: 
		[ 'st' ]
	ifFalse: [ (lastDigit = $2 and: [ dayOfMonth ~= 12 ]) ifTrue: 
		[ 'nd' ]
	ifFalse: [ (lastDigit = $3 and: [ dayOfMonth ~= 13 ]) ifTrue: 
		[ 'rd' ]
	ifFalse: 
		[ 'th' ] ] ].
	^ dayOfMonth asString, suffix
]
