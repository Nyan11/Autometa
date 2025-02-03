Class {
	#name : 'DragonDescriptionBuilder',
	#superclass : 'Object',
	#instVars : [
		'classesToGenerate',
		'packageToGenerate',
		'verboseLevel'
	],
	#category : 'Dragon-Model',
	#package : 'Dragon',
	#tag : 'Model'
}

{ #category : 'building' }
DragonDescriptionBuilder >> build [

	| allClassesToDo |
	allClassesToDo := (self classesToGenerate flatCollect:
		                   #withAllSuperclasses) asSet difference: {
			                  Object.
			                  ProtoObject }.
	self verboseLevel startBuilding: allClassesToDo.
	allClassesToDo do: [ :cls | "self buildSlotsFor: cls."
		self verboseLevel startClass: cls.
		self buildAccessorsFor: cls.
		self verboseLevel endClass: cls ].
	self verboseLevel endBuilding
]

{ #category : 'as yet unclassified' }
DragonDescriptionBuilder >> buildAccessorsDescriptionForSelector: aSelector andInstances: aCollectionOfObject andClass: aClass [

	| allValues allValueTypes description |
	(aClass package name beginsWith: 'Collection') ifTrue: [ ^ self ].
	(aClass package name beginsWith: 'Display') ifTrue: [ ^ self ].
	(aClass package name beginsWith: 'Text') ifTrue: [ ^ self ].
	(aClass package name beginsWith: 'Graphics') ifTrue: [ ^ self ].
	(aClass package name beginsWith: 'System') ifTrue: [ ^ self ].
	(aClass package name beginsWith: 'Kernel') ifTrue: [ ^ self ].
	allValues := aCollectionOfObject collect: [ :inst |
		             [ inst perform: aSelector ]
			             on: Error
			             do: [ ^ self ] ].
	allValueTypes := self reduceAllValuesToTypeValues: allValues.

	description := DragonSlotDescription new
		               name: aSelector;
		               possibleGetterSelectors: { aSelector };
		               possibleSetterSelectors: { aSelector asMutator };
		               knownTypeValues: allValueTypes;
		               yourself.

	self installDragonDescription: description onClass: aClass
]

{ #category : 'building' }
DragonDescriptionBuilder >> buildAccessorsFor: aClass [

	| allInstances allZeroArgMethod allOneArgMethod allGetterWithAssociatedMutator |
	"We check for each class all instances and subinstances that could contains the value for each slot."
	allInstances := aClass withAllSubclasses flatCollect: #allInstances.
	allZeroArgMethod := aClass methods
		                    select: [ :m | m numArgs = 0 and: [ m protocol ~= 'private' ] ]
		                    thenCollect: #selector.
	allOneArgMethod := aClass methods
		                   select: [ :m | m numArgs = 1 and: [ m protocol ~= 'private' ] ]
		                   thenCollect: #selector.
	allGetterWithAssociatedMutator := allZeroArgMethod select: [ :getter |
		                                  allOneArgMethod anySatisfy: [
			                                  :setter |
			                                  setter = getter asMutator ] ].
	allGetterWithAssociatedMutator do: [ :selector |
		self
			buildAccessorsDescriptionForSelector: selector
			andInstances: allInstances
			andClass: aClass ]
]

{ #category : 'building' }
DragonDescriptionBuilder >> buildSlotsFor: aClass [

	| allInstances |
	"We check for each class all instances and subinstances that could contains the value for each slot."
	allInstances := aClass withAllSubclasses flatCollect: #allInstances.
	aClass slots do: [ :slot |
		| allValues allValueTypes description matcherSetter matcherGetter possibleSetterSelectors possibleGetterSelectors |
		allValues := allInstances collect: [ :inst | slot read: inst ].
		allValueTypes := self reduceAllValuesToTypeValues: allValues.
		"We need to find all possible setters for each slot.
		We recover all method that are using this slot and select only the one with one argument."
		matcherSetter := RBParseTreeSearcher setterMethod: slot name.
		matcherGetter := RBParseTreeSearcher getterMethod: slot name.
		possibleSetterSelectors := OrderedCollection new.
		possibleGetterSelectors := OrderedCollection new.
		slot usingMethods do: [ :method |
			| parseTree |
			parseTree := method parseTree.
			method numArgs = 1 ifTrue: [
				matcherSetter executeTree: parseTree.
				matcherSetter answer ifNotNil: [
					possibleSetterSelectors add: method selector ] ].
			method numArgs = 0 ifTrue: [
				matcherGetter executeTree: parseTree.
				matcherGetter answer ifNotNil: [
					possibleGetterSelectors add: method selector ] ] ].
		description := DragonSlotDescription new
			               name: slot name;
			               possibleSetterSelectors: possibleSetterSelectors;
			               possibleGetterSelectors: possibleGetterSelectors;
			               knownTypeValues: allValueTypes;
			               yourself.
		self installDragonDescription: description ]
]

{ #category : 'as yet unclassified' }
DragonDescriptionBuilder >> classToGenerate: aClass [

	classesToGenerate := { aClass }
]

{ #category : 'accessing' }
DragonDescriptionBuilder >> classesToGenerate [

	^ classesToGenerate
]

{ #category : 'accessing' }
DragonDescriptionBuilder >> classesToGenerate: aCollection [

	classesToGenerate := aCollection
]

{ #category : 'as yet unclassified' }
DragonDescriptionBuilder >> commonSuperClassBetween: aClass1 and: aClass2 [

	| class1Collection class2Collection |
	aClass1 = aClass2 ifTrue: [ ^ aClass1 ].
	((class1Collection := aClass1 withAllSuperclasses) includes: aClass2)
		ifTrue: [ ^ aClass2 ].
	((class2Collection := aClass2 withAllSuperclasses) includes: aClass1)
		ifTrue: [ ^ aClass1 ].
	class1Collection do: [ :each | (class2Collection includes: each) ifTrue: [ ^ each ] ].
	^ Object
]

{ #category : 'as yet unclassified' }
DragonDescriptionBuilder >> commonSuperClassExceptObjectBetween: aClass1 and: aClass2 [

	| clazz |
	"Return the common super class between the 2 classes. If it is Object return nil"
	clazz := self commonSuperClassBetween: aClass1 and: aClass2.
	clazz = Object ifTrue: [ ^ nil ].
	^ clazz
]

{ #category : 'building' }
DragonDescriptionBuilder >> initialize [


	super initialize .
	verboseLevel := DragonNoVerboseLevel new.
]

{ #category : 'as yet unclassified' }
DragonDescriptionBuilder >> installDragonDescription: aDragonSlotDescription onClass: aClass [

	| methodSelector methodString knownTypeValuesString possibleGetterSelectorsString possibleSetterSelectorsString protocol |
	aClass dragonInstanceDescription
		slotDescriptionNamed: aDragonSlotDescription name
		ifFound: [ :description |
			aDragonSlotDescription combineWithSlotDescription: description ].
	aDragonSlotDescription knownTypeValues:
		(self reduceAllTypeValues: aDragonSlotDescription knownTypeValues).

	methodString := 'dragon<1s><r><r><t>%<dragonDescription><r><t>^ DragonSlotDescription new name: #<2s>; knownTypeValues: { <3s> }; possibleGetterSelectors: { <4s> }; possibleSetterSelectors: { <5s> }; yourself'.

	knownTypeValuesString := String streamContents: [ :s |
		                         aDragonSlotDescription knownTypeValues
			                         do: [ :each | s << each name ]
			                         separatedBy: [ s << ' . ' ] ].
	possibleGetterSelectorsString := String streamContents: [ :s |
		                                 aDragonSlotDescription
			                                 possibleGetterSelectors
			                                 do: [ :each | s << '#' << each ]
			                                 separatedBy: [ s << ' . ' ] ].
	possibleSetterSelectorsString := String streamContents: [ :s |
		                                 aDragonSlotDescription
			                                 possibleSetterSelectors
			                                 do: [ :each | s << '#' << each ]
			                                 separatedBy: [ s << ' . ' ] ].

	methodSelector := aClass compile:
		                  (methodString expandMacrosWithArguments: {
				                   aDragonSlotDescription name capitalized.
				                   aDragonSlotDescription name.
				                   knownTypeValuesString.
				                   possibleGetterSelectorsString.
				                   possibleSetterSelectorsString }).
	self packageToGenerate
		ifNil: [ protocol := 'dragon meta description' ]
		ifNotNil: [ protocol := '*' , self packageToGenerate name ].
	(aClass methodNamed: methodSelector) protocol: protocol
]

{ #category : 'accessing' }
DragonDescriptionBuilder >> packageToGenerate [

	^ packageToGenerate
]

{ #category : 'accessing' }
DragonDescriptionBuilder >> packageToGenerate: anObject [

	packageToGenerate := anObject
]

{ #category : 'as yet unclassified' }
DragonDescriptionBuilder >> reduceAllTypeValues: aCollectionOfClass [

	| refinedClasses |
	refinedClasses := OrderedCollection new.
	aCollectionOfClass do: [ :classToAdd |
		refinedClasses ifEmpty: [ refinedClasses add: classToAdd ].
		refinedClasses do: [ :refinedClass |
			(self
				 commonSuperClassExceptObjectBetween: classToAdd
				 and: refinedClass)
				ifNil: [ refinedClasses add: classToAdd ]
				ifNotNil: [ :newClass |
					refinedClasses remove: refinedClass.
					refinedClasses add: newClass ] ] ].
	^ refinedClasses asArray
]

{ #category : 'as yet unclassified' }
DragonDescriptionBuilder >> reduceAllValuesToTypeValues: aCollectionOfObjects [

	| allClasses |
	allClasses := (aCollectionOfObjects collect: #class) asSet.
	^ self reduceAllTypeValues: allClasses
]

{ #category : 'accessing' }
DragonDescriptionBuilder >> verboseLevel [

	^ verboseLevel
]

{ #category : 'accessing' }
DragonDescriptionBuilder >> verboseLevel: anObject [

	verboseLevel := anObject
]
