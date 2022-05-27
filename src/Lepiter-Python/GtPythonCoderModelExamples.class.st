Class {
	#name : #GtPythonCoderModelExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Python-Examples'
}

{ #category : #'as yet unclassified' }
GtPythonCoderModelExamples >> returnWithFunction [
	"Ensure that the python parser indicates the last statement in the script is not a statement"
	<gtExample>
	| ast source lastStatement |

	source :=
'def my_log():
    return 1
'.

	ast := PythonParser parseWithErrors: source.
	lastStatement := ast statements last.
	self deny: lastStatement isStatement.
	^ ast.
]

{ #category : #'as yet unclassified' }
GtPythonCoderModelExamples >> returnWithStatement [
	"Ensure that the python parser indicates the last statement in the script is a statement with the correct value"
	<gtExample>
	| ast source lastStatement |

	source :=
'def my_log():
    return 1
42'.

	ast := PythonParser parseWithErrors: source.
	lastStatement := ast statements last.
	self assert: lastStatement isStatement.
	self assert: lastStatement stmts first testlist atom numberToken value equals: '42'.
	^ ast.
]
