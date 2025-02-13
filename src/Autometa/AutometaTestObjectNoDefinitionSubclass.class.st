Class {
	#name : 'AutometaTestObjectNoDefinitionSubclass',
	#superclass : 'AutometaTestObjectNoDefinition',
	#instVars : [
		'subclassSlot'
	],
	#category : 'Autometa-Tests',
	#package : 'Autometa',
	#tag : 'Tests'
}

{ #category : 'accessing' }
AutometaTestObjectNoDefinitionSubclass >> subclassSlot [

	^ subclassSlot
]

{ #category : 'accessing' }
AutometaTestObjectNoDefinitionSubclass >> subclassSlot: anObject [

	subclassSlot := anObject
]
