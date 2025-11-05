"
I am an in-memory database holder.

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

"
Class {
	#name : #InMemoryDatabaseHolder,
	#superclass : #Object,
	#traits : 'TLeInMemoryDatabaseHolder',
	#classTraits : 'TLeInMemoryDatabaseHolder classTrait',
	#category : #'Lepiter-Core-Utility'
}
