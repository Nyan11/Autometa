Class {
	#name : 'AutometaCmdMenuGroup',
	#superclass : 'CmdMenuGroup',
	#category : 'Autometa-Command',
	#package : 'Autometa',
	#tag : 'Command'
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
