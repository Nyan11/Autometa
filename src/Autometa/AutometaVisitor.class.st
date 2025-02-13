Class {
	#name : 'AutometaVisitor',
	#superclass : 'Object',
	#category : 'Autometa-Model',
	#package : 'Autometa',
	#tag : 'Model'
}

{ #category : 'visiting' }
AutometaVisitor >> visitDescription: aDragonDescription [ 
	self explicitRequirement.
]

{ #category : 'visiting' }
AutometaVisitor >> visitPropertyDescription: aDragonPropertyDescription [

	self explicitRequirement
]
