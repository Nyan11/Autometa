Class {
	#name : 'AutometaPropertyDescription',
	#superclass : 'Object',
	#instVars : [
		'name',
		'knownTypeValues',
		'possibleSetterSelectors',
		'possibleGetterSelectors',
		'multiplicity'
	],
	#category : 'Autometa-Model',
	#package : 'Autometa',
	#tag : 'Model'
}

{ #category : 'visiting' }
AutometaPropertyDescription >> acceptAutometaVisitor: aDragonVisitor [ 
	aDragonVisitor visitPropertyDescription: self.
]

{ #category : 'as yet unclassified' }
AutometaPropertyDescription >> combineWithSlotDescription: aDragonSlotDescription [

	self name = aDragonSlotDescription name ifFalse: [
		^ AutometaErrorCombineDifferentSlotDescription new signal ].
	self knownTypeValues:
		(self knownTypeValues , aDragonSlotDescription knownTypeValues)
			asSet asArray.
	self possibleGetterSelectors: (self possibleGetterSelectors
		 , aDragonSlotDescription possibleGetterSelectors) asSet asArray.
	self possibleSetterSelectors: (self possibleSetterSelectors
		 , aDragonSlotDescription possibleSetterSelectors) asSet asArray
]

{ #category : 'initialization' }
AutometaPropertyDescription >> initialize [

	super initialize.
	knownTypeValues := {  }.
	possibleGetterSelectors := {  }.
	possibleSetterSelectors := {  }.
]

{ #category : 'as yet unclassified' }
AutometaPropertyDescription >> installDragonDescriptionOn: aClass [

	| methodSelector methodString knownTypeValuesString possibleGetterSelectorsString possibleSetterSelectorsString |
	aClass dragonInstanceDescription
		slotDescriptionNamed: self name
		ifFound: [ :description |
		self combineWithSlotDescription: description ].

	methodString := 'dragon<1s><r><r><t>%<dragonDescription><r><t>^ DragonSlotDescription new name: #<2s>; knownTypeValues: { <3s> }; possibleGetterSelectors: { <4s> }; possibleSetterSelectors: { <5s> }; yourself'.

	knownTypeValuesString := ''.
	self knownTypeValues
		do: [ :class |
			knownTypeValuesString := knownTypeValuesString , class name ]
		separatedBy: [
		knownTypeValuesString := knownTypeValuesString , ' . ' ].

	possibleGetterSelectorsString := ''.
	self possibleGetterSelectors
		do: [ :getter |
			possibleGetterSelectorsString := possibleGetterSelectorsString
			                                 , '#' , getter ]
		separatedBy: [
			possibleGetterSelectorsString := possibleGetterSelectorsString
			                                 , ' . ' ].

	possibleSetterSelectorsString := ''.
	self possibleSetterSelectors
		do: [ :setter |
			possibleSetterSelectorsString := possibleSetterSelectorsString
			                                 , '#' , setter ]
		separatedBy: [
			possibleSetterSelectorsString := possibleSetterSelectorsString
			                                 , ' . ' ].


	methodSelector := aClass compile:
		                  (methodString expandMacrosWithArguments: {
				                   self name capitalized.
				                   self name.
				                   knownTypeValuesString.
				                   possibleGetterSelectorsString.
				                   possibleSetterSelectorsString }).
	(aClass methodNamed: methodSelector) protocol: '*Dragon'
]

{ #category : 'accessing' }
AutometaPropertyDescription >> knownTypeValues [

	^ knownTypeValues
]

{ #category : 'accessing' }
AutometaPropertyDescription >> knownTypeValues: anObject [

	knownTypeValues := anObject
]

{ #category : 'accessing' }
AutometaPropertyDescription >> multiplicity [

	^ multiplicity
]

{ #category : 'as yet unclassified' }
AutometaPropertyDescription >> multiplicity: anAssociation [ 
	multiplicity:=anAssociation
]

{ #category : 'accessing' }
AutometaPropertyDescription >> name [

	^ name
]

{ #category : 'accessing' }
AutometaPropertyDescription >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
AutometaPropertyDescription >> possibleGetterSelectors [

	^ possibleGetterSelectors
]

{ #category : 'as yet unclassified' }
AutometaPropertyDescription >> possibleGetterSelectors: aCollection [

	possibleGetterSelectors := aCollection
]

{ #category : 'accessing' }
AutometaPropertyDescription >> possibleSetterSelectors [
	^ possibleSetterSelectors
]

{ #category : 'as yet unclassified' }
AutometaPropertyDescription >> possibleSetterSelectors: aCollection [ 
	possibleSetterSelectors := aCollection
]
