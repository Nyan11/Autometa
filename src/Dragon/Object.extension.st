Extension { #name : 'Object' }

{ #category : '*Dragon' }
Object >> dragonDescription [

	^ self class dragonInstanceDescription
]

{ #category : '*Dragon' }
Object class >> dragonInstanceDescription [

	| description |
	description := DragonDescription new objectClass: self.
	description slotDescriptions:
		((Pragma allNamed: #dragonDescription from: self to: Object)
			 collect: [ :pragma | pragma method valueWithReceiver: nil ]).
	^ description
]

{ #category : '*Dragon' }
Object class >> generateDragonDescription [

	^ self generateDragonDescriptionInPackage: nil
]

{ #category : '*Dragon' }
Object >> generateDragonDescription [

	^ self class generateDragonDescription
]

{ #category : '*Dragon' }
Object class >> generateDragonDescriptionInPackage: aPackage [

	^ DragonDescriptionBuilder new
		  classToGenerate: self;
		  packageToGenerate: aPackage;
		  build
]

{ #category : '*Dragon' }
Object >> generateDragonDescriptionInPackage: aPackage [

	^ self class generateDragonDescriptionInPackage: aPackage
]
