Class {
	#name : #LeJsonV4IntegrityExamples,
	#superclass : #Object,
	#category : #'Lepiter-Store-Examples'
}

{ #category : #examples }
LeJsonV4IntegrityExamples >> supportedClassesNotDuplicated [
	"Check that there are no classes that both define #leJsonV4Name and are in LeJsonV4>>explicitClassNamesToMap"
	<gtExample>
	| leJsonV4NameImplementers explicitClasses common |

	leJsonV4NameImplementers := (SystemNavigation default allImplementorsOf: #leJsonV4Name) collect: [ :method |
		method methodClass instanceSide ].
	explicitClasses := LeJsonV4 explicitClassNamesToMap.
	common := leJsonV4NameImplementers asSet intersection: explicitClasses asSet.
	self assert: common isEmpty description:
		[ 'The following classes have duplicate LeJsonV4 definitions: ', common printString ].
]
