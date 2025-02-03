Class {
	#name : 'DragonExamples',
	#superclass : 'Object',
	#category : 'Dragon-Model',
	#package : 'Dragon',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
DragonExamples class >> buildClassHierarchyDescription: aClass [

	| classesToDescribe builder |
	classesToDescribe := aClass withAllSubclasses.

	builder := DragonDescriptionBuilder new
		           packageToGenerate: DragonDescription package;
		           classesToGenerate: classesToDescribe;
		           verboseLevel: DragonVerboseLevel new;
		           yourself.

	[ builder build ] fork
]

{ #category : 'as yet unclassified' }
DragonExamples class >> buildPackageDescription: aPackage [

	| classesToDescribe builder |
	classesToDescribe := aPackage classes.

	builder := DragonDescriptionBuilder new
		           packageToGenerate: DragonDescription package;
		           classesToGenerate: classesToDescribe;
		           verboseLevel: DragonVerboseLevel new;
		           yourself.

	[ builder build ] fork
]

{ #category : 'as yet unclassified' }
DragonExamples class >> removeClassHierarchyDescription: aClass [

	| classesToDescribe |
	classesToDescribe := aClass withAllSubclasses.
	classesToDescribe do: [ :cls | cls removeDragonDescription ]
]

{ #category : 'see class side' }
DragonExamples >> seeClassSide [ 
]
