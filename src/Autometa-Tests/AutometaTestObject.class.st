Class {
	#name : 'AutometaTestObject',
	#superclass : 'Object',
	#instVars : [
		'name',
		'otherSlot'
	],
	#category : 'Autometa-Tests',
	#package : 'Autometa-Tests'
}

{ #category : 'as yet unclassified' }
AutometaTestObject >> autometaName [

	<autometaDescription>
	^ AutometaPropertyDescription new
		  name: #name;
		  knownTypeValues: { String };
		  yourself
]

{ #category : 'as yet unclassified' }
AutometaTestObject >> autometaOtherSlot [

	<autometaDescription>
	^ AutometaPropertyDescription new
		  name: #otherSlot;
		  knownTypeValues: { UndefinedObject };
		  yourself
]

{ #category : 'as yet unclassified' }
AutometaTestObject >> autometaOtherSlot2 [

	<autometaDescription>
	^ AutometaPropertyDescription new
		  name: #otherSlot;
		  knownTypeValues: { UndefinedObject };
		  yourself
]
