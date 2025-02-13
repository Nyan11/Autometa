Class {
	#name : 'AutometaMissingDescriptionVisitor',
	#superclass : 'AutometaVisitor',
	#instVars : [
		'knownClasses',
		'missingDescription',
		'emptyProperties',
		'collectionDescriptions'
	],
	#category : 'Autometa-Visitors',
	#package : 'Autometa',
	#tag : 'Visitors'
}

{ #category : 'visiting' }
AutometaMissingDescriptionVisitor >> collectionDescriptions [

	^ collectionDescriptions
]

{ #category : 'accessing' }
AutometaMissingDescriptionVisitor >> emptyProperties [

	^ emptyProperties
]

{ #category : 'visiting' }
AutometaMissingDescriptionVisitor >> initialize [

	super initialize.
	knownClasses := Set new.
	missingDescription := Set new.
	emptyProperties := OrderedCollection new.
	collectionDescriptions := OrderedCollection new
]

{ #category : 'visiting' }
AutometaMissingDescriptionVisitor >> knownClasses [

	^ knownClasses
]

{ #category : 'accessing' }
AutometaMissingDescriptionVisitor >> missingDescription [

	^ missingDescription
]

{ #category : 'visiting' }
AutometaMissingDescriptionVisitor >> visitDescription: aDragonDescription [

	(self knownClasses includes: aDragonDescription objectClass) ifTrue: [
		^ self ].
	self knownClasses add: aDragonDescription objectClass.

	aDragonDescription slotDescriptions ifEmpty: [
		aDragonDescription isFinalType ifTrue: [ ^ self ].
		self missingDescription add: aDragonDescription.
		^ self ].
	aDragonDescription slotDescriptions do: [ :each |
		each acceptAutometaVisitor: self ]
]

{ #category : 'visiting' }
AutometaMissingDescriptionVisitor >> visitPropertyDescription: aDragonPropertyDescription [

	| allTypeDescriptions |
	aDragonPropertyDescription knownTypeValues ifEmpty: [
		self emptyProperties add: aDragonPropertyDescription.
		^ self ].
	(aDragonPropertyDescription knownTypeValues size = 1 and: [
		 aDragonPropertyDescription knownTypeValues anyOne = UndefinedObject ])
		ifTrue: [
			self emptyProperties add: aDragonPropertyDescription.
			^ self ].

	(aDragonPropertyDescription knownTypeValues anySatisfy: [ :cls | (cls isKindOf: Collection class) and: [ (cls isKindOf: String class) not ] ]) ifTrue: [ self collectionDescriptions add: aDragonPropertyDescription ].
	allTypeDescriptions := aDragonPropertyDescription knownTypeValues
		                       collect: [ :each |
		                       each autometaFullDescription ].
	allTypeDescriptions do: [ :each | each acceptAutometaVisitor: self ]
]
