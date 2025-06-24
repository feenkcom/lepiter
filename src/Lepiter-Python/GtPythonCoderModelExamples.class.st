Class {
	#name : #GtPythonCoderModelExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Python-Examples'
}

{ #category : #examples }
GtPythonCoderModelExamples >> returnWithAssignment [
	"Ensure that the python parser indicates the last statement in the script is a statement with the correct value"

	<gtExample>
	<return: #PyFileNode>
	| ast source lastStatement |
	source := 'def my_log():
    return 1
x = 42'.

	ast := PythonParser parseWithErrors: source.
	lastStatement := ast statements last.
	self assert: lastStatement isValueStatement.
	^ ast
]

{ #category : #examples }
GtPythonCoderModelExamples >> returnWithFunction [
	"Ensure that the python parser indicates the last statement in the script is not a statement"

	<gtExample>
	<return: #PyFileNode>
	| ast source lastStatement |
	source := 'def my_log():
    return 1
'.

	ast := PythonParser parseWithErrors: source.
	lastStatement := ast statements last.
	self deny: lastStatement isValueStatement.
	^ ast
]

{ #category : #examples }
GtPythonCoderModelExamples >> returnWithImport [
	"Ensure that the python parser indicates the last statement in the script is not a statement"

	<gtExample>
	<return: #PyFileNode>
	| ast source lastStatement |
	source := 'import exif
'.

	ast := PythonParser parseWithErrors: source.
	lastStatement := ast statements last.
	self deny: lastStatement isValueStatement.
	^ ast
]

{ #category : #examples }
GtPythonCoderModelExamples >> returnWithImportFrom [
	"Ensure that the python parser indicates the last statement in the script is not a statement"

	<gtExample>
	<return: #PyFileNode>
	| ast source lastStatement |
	source := 'from exif import Image
'.

	ast := PythonParser parseWithErrors: source.
	lastStatement := ast statements last.
	self deny: lastStatement isValueStatement.
	^ ast
]

{ #category : #examples }
GtPythonCoderModelExamples >> returnWithStatement [
	"Ensure that the python parser indicates the last statement in the script is a statement with the correct value"

	<gtExample>
	<return: #PyFileNode>
	| ast source lastStatement |
	source := 'def my_log():
    return 1
42'.

	ast := PythonParser parseWithErrors: source.
	lastStatement := ast statements last.
	self assert: lastStatement isValueStatement.
	self assert: lastStatement expression numberToken value equals: '42'.
	^ ast
]
