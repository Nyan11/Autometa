Class {
	#name : 'DragonGenerateDescriptionTest',
	#superclass : 'TestCase',
	#category : 'Dragon',
	#package : 'Dragon'
}

{ #category : 'running' }
DragonGenerateDescriptionTest >> tearDown [

	super tearDown.
	DragonTestObjectNoDefinition removeDragonDescription.
	DragonTestObjectNoDefinitionSubclass removeDragonDescription.
	DragonTestObjectNoDefinitionSubclassSublClass removeDragonDescription
]

{ #category : 'tests' }
DragonGenerateDescriptionTest >> testGenerateDragonDescription1 [

	| object1 |
	object1 := DragonTestObjectNoDefinition new
		           slot: 'Hello World !';
		           yourself.
	self assertEmpty: object1 dragonDescription slotDescriptions.
	object1 generateDragonDescription.
	self
		assert: object1 dragonDescription slotDescriptions size
		equals: 1.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #slot)
				knownTypeValues
		equals: { ByteString }.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #slot)
				possibleSetterSelectors
		equals: { #slot: }.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #slot)
				possibleGetterSelectors
		equals: { #slot }
]

{ #category : 'tests' }
DragonGenerateDescriptionTest >> testGenerateDragonDescription2 [

	| object1 object2 |
	object1 := DragonTestObjectNoDefinition new
		           slot: 'Hello World !';
		           yourself.
	object2 := DragonTestObjectNoDefinition new
		           slot: 'Goodbye World !';
		           yourself.
	self assertEmpty: object1 dragonDescription slotDescriptions.
	object1 generateDragonDescription.
	self
		assert: object1 dragonDescription slotDescriptions size
		equals: 1.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #slot)
				knownTypeValues
		equals: { ByteString }
]

{ #category : 'tests' }
DragonGenerateDescriptionTest >> testGenerateDragonDescription3 [

	| object1 object2 |
	object1 := DragonTestObjectNoDefinition new
		           slot: 'Hello World !';
		           yourself.
	object2 := DragonTestObjectNoDefinition new
		           slot: 5;
		           yourself.
	self assertEmpty: object1 dragonDescription slotDescriptions.
	object1 generateDragonDescription.
	self
		assert: object1 dragonDescription slotDescriptions size
		equals: 1.
	self
		assertCollection: (object1 dragonDescription slotDescriptionNamed: #slot)
				knownTypeValues
		includesAll: { SmallInteger . ByteString }
]

{ #category : 'tests' }
DragonGenerateDescriptionTest >> testGenerateDragonDescription4 [

	| object1 |
	object1 := DragonTestObjectNoDefinitionSubclass new
		           slot: 'Hello World !';
		           subclassSlot: 4;
		           yourself.
	self assertEmpty: object1 dragonDescription slotDescriptions.
	object1 generateDragonDescription.
	self
		assert: object1 dragonDescription slotDescriptions size
		equals: 2.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #slot)
				knownTypeValues
		equals: { ByteString }.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #slot)
				possibleSetterSelectors
		equals: { #slot: }.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #subclassSlot)
				possibleSetterSelectors
		equals: { #subclassSlot: }.
	self
		assert: (object1 dragonDescription slotDescriptionNamed: #subclassSlot)
				knownTypeValues
		equals: { SmallInteger }.
]
