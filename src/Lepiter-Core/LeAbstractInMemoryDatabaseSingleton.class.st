"
I am an abstract class for singleton in-memory databases that are initialized from a not-loaded Lepiter database.

Subclasses should define `databaseName`, for example, by sending `databaseName:` in their `initialize` method.
The database name should be the name of a lepiter database that may or may not be loaded, but should be present in the image.

An example is the the subclass `TMHelpDatabase`. It refers to the database named `'feenkcom/gtoolkit-roadmaps/roadmaps-help'`.
As long as this database is not loaded, you can access an in-memory version of the database as follows:
```
TMHelpDatabase database
```
In case the database *is* loaded, however, then the actual loaded database is returned instead. 
The former case addresses ordinary users who can access an in-memory, read-only version of the help pages, without the overhead of loading the lepiter database.
The latter case is useful if the help database needs to be edited or extended.

Subclasses may choose to implement class-side utility methods to load or unload the database.

The in-memory database is initialized lazily. To pre-load it, send `initializeDatabase`, for example in the `initialize` method, after setting the `databaseName`.
"
Class {
	#name : #LeAbstractInMemoryDatabaseSingleton,
	#superclass : #Object,
	#traits : 'TLeInMemoryDatabaseHolder + TGtUniqueInstance',
	#classTraits : 'TLeInMemoryDatabaseHolder classTrait + TGtUniqueInstance classTrait',
	#category : #'Lepiter-Core-Utility'
}

{ #category : #loading }
LeAbstractInMemoryDatabaseSingleton class >> database [
	^ self uniqueInstance database
]
