"
I am an in-memory database holder for a Lepiter database on disk, but not necessarily loaded.
I can be used:
- to explore databases without loading them, 
- to hold an in-memory version of a “help” database of documentation pages,
- to hold a mock database for testing purposes.

You can instantiate me like this:
```
InMemoryDatabaseHolder new databaseNamed: 'feenkcom/lepiter/test-data/toc'
```

To collect in-memory databases of all the lepiter folders in the image, you can inspect this:
```
(FileLocator gtResource allChildrenMatching: 'lepiter.properties')
	collect: [ :each | 
		each
			-> (InMemoryDatabaseHolder new
					databaseNamed: (each parent relativeToPath: FileLocator gtResource) fullName) ]
```
See also: {{gtClass:name=TDatabaseHolder}}, which creates an in-memory database without needed physical files on disk.
"
Class {
	#name : #InMemoryDatabaseHolder,
	#superclass : #Object,
	#traits : 'TLeInMemoryDatabaseHolder',
	#classTraits : 'TLeInMemoryDatabaseHolder classTrait',
	#category : #'Lepiter-Core-Utility'
}
