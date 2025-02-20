Class {
	#name : 'AutometaDescription',
	#superclass : 'Object',
	#instVars : [
		'objectClass',
		'properties'
	],
	#category : 'Autometa-Model',
	#package : 'Autometa',
	#tag : 'Model'
}

{ #category : 'visiting' }
AutometaDescription >> acceptAutometaVisitor: aAutometaVisitor [

	aAutometaVisitor visitDescription: self
]

{ #category : 'testing' }
AutometaDescription >> isFinalType [

	^ self objectClass isAutometaFinal
]

{ #category : 'accessing' }
AutometaDescription >> objectClass [

	^ objectClass
]

{ #category : 'accessing' }
AutometaDescription >> objectClass: anObject [

	objectClass := anObject
]

{ #category : 'accessing' }
AutometaDescription >> properties [

	^ properties
]

{ #category : 'accessing' }
AutometaDescription >> properties: anObject [

	properties := anObject
]

{ #category : 'as yet unclassified' }
AutometaDescription >> propertyNamed: aString [

	self
		propertyNamed: aString
		ifFound: [ :dragonDescription | ^ dragonDescription ]
		ifNotFound: [
			AutometaErrorNoPropertyNamed new
				objectClass: self objectClass;
				slotName: aString;
				signal ]
]

{ #category : 'as yet unclassified' }
AutometaDescription >> propertyNamed: aString ifFound: aBlockClosureFound [

	self
		propertyNamed: aString
		ifFound: aBlockClosureFound
		ifNotFound: [  ]
]

{ #category : 'as yet unclassified' }
AutometaDescription >> propertyNamed: aString ifFound: aBlockClosureFound ifNotFound: aBlockClosureNotFound [

	| possibleSolutions |
	possibleSolutions := self properties select: [ :desc |
		                     desc name = aString ].
	possibleSolutions ifEmpty: [ ^ aBlockClosureNotFound value ].
	possibleSolutions size > 1 ifTrue: [
		^ AutometaErrorMultipePropertiesNamed new
			  objectClass: self objectClass;
			  slotName: aString;
			  signal ].
	^ aBlockClosureFound value: possibleSolutions first
]
