Class {
	#name : 'DragonDescriptionBuilder',
	#superclass : 'Object',
	#instVars : [
		'classToGenerate',
		'packageToGenerate'
	],
	#category : 'Dragon-Model',
	#package : 'Dragon',
	#tag : 'Model'
}

{ #category : 'building' }
DragonDescriptionBuilder >> build [

	(self classToGenerate withAllSuperclasses difference: {
			 Object.
			 ProtoObject }) do: [ :cls |
		self buildSlotsFor: cls.
		self buildAccessorsFor: cls ]
]

{ #category : 'building' }
DragonDescriptionBuilder >> buildAccessorsDescriptionForSelector: selector andInstances: allInstances [

	| allValues allValueTypes description |
	allValues := allInstances collect: [ :inst |
		             [ inst perform: selector ]
			             on: Error
			             do: [ ^ self ] ].

	allValueTypes := (allValues collect: #class) asSet.

	description := DragonSlotDescription new
		               slot: selector;
		               possibleGetterSelectors: { selector };
		               possibleSetterSelectors: { selector asMutator };
		               knownTypeValues: allValueTypes;
		               yourself.

	self installDragonDescription: description
]

{ #category : 'building' }
DragonDescriptionBuilder >> buildAccessorsFor: aClass [

	| allInstances allZeroArgMethod allOneArgMethod allGetterWithAssociatedMutator |
	"We check for each class all instances and subinstances that could contains the value for each slot."
	allInstances := aClass withAllSubclasses flatCollect: #allInstances.
	allZeroArgMethod := aClass methods
		                    select: [ :m | m numArgs = 0 ]
		                    thenCollect: #selector.
	allOneArgMethod := aClass methods
		                   select: [ :m | m numArgs = 1 ]
		                   thenCollect: #selector.
	allGetterWithAssociatedMutator := allZeroArgMethod select: [ :getter |
		                                  allOneArgMethod anySatisfy: [
			                                  :setter |
			                                  setter = getter asMutator ] ].
	allGetterWithAssociatedMutator do: [ :selector |
		self
			buildAccessorsDescriptionForSelector: selector
			andInstances: allInstances.
		 ]
]

{ #category : 'building' }
DragonDescriptionBuilder >> buildSlotsFor: aClass [

	| allInstances |
	"We check for each class all instances and subinstances that could contains the value for each slot."
	allInstances := aClass withAllSubclasses flatCollect: #allInstances.
	aClass slots do: [ :slot |
		| allValues allValueTypes description matcherSetter matcherGetter possibleSetterSelectors possibleGetterSelectors |
		allValues := allInstances collect: [ :inst | slot read: inst ].
		allValueTypes := (allValues collect: #class) asSet.
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
			               slot: slot name;
			               possibleSetterSelectors: possibleSetterSelectors;
			               possibleGetterSelectors: possibleGetterSelectors;
			               knownTypeValues: allValueTypes;
			               yourself.
		self installDragonDescription: description ]
]

{ #category : 'accessing' }
DragonDescriptionBuilder >> classToGenerate [
	^ classToGenerate
]

{ #category : 'as yet unclassified' }
DragonDescriptionBuilder >> classToGenerate: aClass [

	classToGenerate := aClass 
]

{ #category : 'as yet unclassified' }
DragonDescriptionBuilder >> installDragonDescription: aDragonSlotDescription [

	| methodSelector methodString knownTypeValuesString possibleGetterSelectorsString possibleSetterSelectorsString protocol |
	self classToGenerate dragonInstanceDescription
		slotDescriptionNamed: aDragonSlotDescription slot
		ifFound: [ :description |
			aDragonSlotDescription combineWithSlotDescription: description ].

	methodString := 'dragon<1s><r><r><t>%<dragonDescription><r><t>^ DragonSlotDescription new slot: #<2s>; knownTypeValues: { <3s> }; possibleGetterSelectors: { <4s> }; possibleSetterSelectors: { <5s> }; yourself'.

	knownTypeValuesString := String streamContents: [ :s |
		                         aDragonSlotDescription knownTypeValues
			                         do: [ :each | s << each name ]
			                         separatedBy: [ s << ' . ' ] ].
	possibleGetterSelectorsString := String streamContents: [ :s |
		                         aDragonSlotDescription possibleGetterSelectors
			                         do: [ :each | s << '#' << each ]
			                         separatedBy: [ s << ' . ' ] ].
	possibleSetterSelectorsString := String streamContents: [ :s |
		                         aDragonSlotDescription possibleSetterSelectors
			                         do: [ :each | s << '#' << each ]
			                         separatedBy: [ s << ' . ' ] ].

	methodSelector := self classToGenerate compile:
		                  (methodString expandMacrosWithArguments: {
				                   aDragonSlotDescription slot capitalized.
				                   aDragonSlotDescription slot.
				                   knownTypeValuesString.
				                   possibleGetterSelectorsString.
				                   possibleSetterSelectorsString }).
	self packageToGenerate
		ifNil: [ protocol := 'dragon meta description' ]
		ifNotNil: [ protocol := '*' , self packageToGenerate name ].
	(self classToGenerate methodNamed: methodSelector) protocol: protocol
]

{ #category : 'accessing' }
DragonDescriptionBuilder >> packageToGenerate [

	^ packageToGenerate
]

{ #category : 'accessing' }
DragonDescriptionBuilder >> packageToGenerate: anObject [

	packageToGenerate := anObject
]
