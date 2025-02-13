Class {
	#name : 'AutometaVisitor',
	#superclass : 'Object',
	#category : 'Autometa-Visitors',
	#package : 'Autometa',
	#tag : 'Visitors'
}

{ #category : 'visiting' }
AutometaVisitor >> visitDescription: aDragonDescription [ 
	self explicitRequirement.
]

{ #category : 'visiting' }
AutometaVisitor >> visitPropertyDescription: aDragonPropertyDescription [

	self explicitRequirement
]
