Class {
	#name : 'DragonDescriptionTest',
	#superclass : 'TestCase',
	#category : 'Dragon',
	#package : 'Dragon'
}

{ #category : 'tests' }
DragonDescriptionTest >> testDragonDescription1 [

	self
		assert: DragonTestObject new dragonDescription objectClass
		equals: DragonTestObject.
	self
		assert: DragonTestObject new dragonDescription slotDescriptions size
		equals: 3.
	self
		assert:
			(DragonTestObject new dragonDescription slotDescriptionNamed: #name)
				slot
		equals: #name.
	self
		assert:
			(DragonTestObject new dragonDescription slotDescriptionNamed: #name)
				knownTypeValues size
		equals: 1.
	self
		assert:
			(DragonTestObject new dragonDescription slotDescriptionNamed: #name)
				knownTypeValues first
		equals: String
]

{ #category : 'tests' }
DragonDescriptionTest >> testDragonDescription2 [

	self should: [ DragonTestObject new dragonDescription slotDescriptionNamed: #doNotExist ] raise: DragonErrorNoSlotNamed
]

{ #category : 'tests' }
DragonDescriptionTest >> testDragonDescription3 [

	self
		should: [
			DragonTestObject new dragonDescription slotDescriptionNamed:
				#otherSlot ]
		raise: DragonErrorMultipeSlotNamed
]
