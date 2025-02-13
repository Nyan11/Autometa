Class {
	#name : 'AutometaCmdMenuGroup',
	#superclass : 'CmdMenuGroup',
	#category : 'Autometa-Commands',
	#package : 'Autometa',
	#tag : 'Commands'
}

{ #category : 'accessing' }
AutometaCmdMenuGroup >> buildContextMenu: aMenu [

	aMenu addLine.
	super buildContextMenu: aMenu
]

{ #category : 'accessing' }
AutometaCmdMenuGroup >> description [

	^ 'Autometa contextual menu'
]
