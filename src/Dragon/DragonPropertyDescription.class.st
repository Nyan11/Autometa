Class {
	#name : 'DragonPropertyDescription',
	#superclass : 'Object',
	#instVars : [
		'name',
		'knownTypeValues',
		'possibleSetterSelectors',
		'possibleGetterSelectors',
		'multiplicity'
	],
	#category : 'Dragon-Model',
	#package : 'Dragon',
	#tag : 'Model'
}

{ #category : 'visiting' }
DragonPropertyDescription >> acceptDragonVisitor: aDragonVisitor [ 
	aDragonVisitor visitPropertyDescription: self.
]

{ #category : 'as yet unclassified' }
DragonPropertyDescription >> combineWithSlotDescription: aDragonSlotDescription [

	self name = aDragonSlotDescription name ifFalse: [
		^ DragonErrorCombineDifferentSlotDescription new signal ].
	self knownTypeValues:
		(self knownTypeValues , aDragonSlotDescription knownTypeValues)
			asSet asArray.
	self possibleGetterSelectors: (self possibleGetterSelectors
		 , aDragonSlotDescription possibleGetterSelectors) asSet asArray.
	self possibleSetterSelectors: (self possibleSetterSelectors
		 , aDragonSlotDescription possibleSetterSelectors) asSet asArray
]

{ #category : 'initialization' }
DragonPropertyDescription >> initialize [

	super initialize.
	knownTypeValues := {  }.
	possibleGetterSelectors := {  }.
	possibleSetterSelectors := {  }.
]

{ #category : 'as yet unclassified' }
DragonPropertyDescription >> installDragonDescriptionOn: aClass [

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
DragonPropertyDescription >> knownTypeValues [

	^ knownTypeValues
]

{ #category : 'accessing' }
DragonPropertyDescription >> knownTypeValues: anObject [

	knownTypeValues := anObject
]

{ #category : 'accessing' }
DragonPropertyDescription >> multiplicity [

	^ multiplicity
]

{ #category : 'as yet unclassified' }
DragonPropertyDescription >> multiplicity: anAssociation [ 
	multiplicity:=anAssociation
]

{ #category : 'accessing' }
DragonPropertyDescription >> name [

	^ name
]

{ #category : 'accessing' }
DragonPropertyDescription >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
DragonPropertyDescription >> possibleGetterSelectors [

	^ possibleGetterSelectors
]

{ #category : 'as yet unclassified' }
DragonPropertyDescription >> possibleGetterSelectors: aCollection [

	possibleGetterSelectors := aCollection
]

{ #category : 'accessing' }
DragonPropertyDescription >> possibleSetterSelectors [
	^ possibleSetterSelectors
]

{ #category : 'as yet unclassified' }
DragonPropertyDescription >> possibleSetterSelectors: aCollection [ 
	possibleSetterSelectors := aCollection
]
