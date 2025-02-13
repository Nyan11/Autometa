Extension { #name : 'Object' }

{ #category : '*Autometa' }
Object >> asAutometaType [

	^ self class
]

{ #category : '*Autometa' }
Object class >> autometaFullDescription [

	| description |
	description := AutometaDescription new objectClass: self.
	description slotDescriptions:
		((Pragma allNamed: #autometaDescription from: self to: Object)
			 collect: [ :pragma | pragma method valueWithReceiver: nil ]).
	^ description
]

{ #category : '*Autometa' }
Object >> autometaFullDescription [

	^ self class autometaFullDescription
]

{ #category : '*Autometa' }
Object class >> autometaGenerateDescription [

	^ self autometaGenerateDescriptionInPackage: nil
]

{ #category : '*Autometa' }
Object >> autometaGenerateDescription [

	^ self class autometaGenerateDescription
]

{ #category : '*Autometa' }
Object class >> autometaGenerateDescriptionInPackage: aPackage [

	^ AutometaDescriptionBuilder new
		  classToGenerate: self;
		  packageToGenerate: aPackage;
		  build
]

{ #category : '*Autometa' }
Object >> autometaGenerateDescriptionInPackage: aPackage [

	^ self class autometaGenerateDescriptionInPackage: aPackage
]

{ #category : '*Autometa' }
Object class >> autometaInstanceDescription [

	| description |
	description := AutometaDescription new objectClass: self.
	description slotDescriptions:
		((Pragma allNamed: #dragonDescription from: self to: self) collect: [
			 :pragma | pragma method valueWithReceiver: nil ]).
	^ description
]

{ #category : '*Autometa' }
Object >> autometaInstanceDescription [

	^ self class autometaInstanceDescription
]

{ #category : '*Autometa' }
Object >> autometaObjectConstructor [

	<autometaConstructor>
	^ AutometaConstructorDescription new
		  constructorArguments: {  };
		  constructorValuable: [ :class | class new ];
		  yourself
]

{ #category : '*Autometa' }
Object class >> autometaRemoveDescription [

	^ self autometaRemoveDescriptionIf: [ :desc | true ]
]

{ #category : '*Autometa' }
Object >> autometaRemoveDescription [

	^ self autometaRemoveDescriptionIf: [ :desc | true ]
]

{ #category : '*Autometa' }
Object class >> autometaRemoveDescriptionIf: aBlock [

	| selectorRemoved |
	selectorRemoved := OrderedCollection new.
	(Pragma allNamed: #autometaDescription in: self) do: [ :pragma |
		(aBlock value: (pragma method valueWithReceiver: nil)) ifTrue: [
			self removeSelector: pragma method selector.
			selectorRemoved add: pragma method selector ] ].
	^ selectorRemoved asArray
]

{ #category : '*Autometa' }
Object >> autometaRemoveDescriptionIf: aBlock [

	^ self class autometaRemoveDescriptionIf: aBlock
]

{ #category : '*Autometa' }
Object class >> isAutometaFinal [

	^ false
]

{ #category : '*Autometa' }
Object >> isAutometaFinal [

	^ self class isAutometaFinal
]
