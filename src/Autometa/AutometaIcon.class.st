Class {
	#name : 'AutometaIcon',
	#superclass : 'Object',
	#classInstVars : [
		'icons'
	],
	#category : 'Autometa-Command',
	#package : 'Autometa',
	#tag : 'Command'
}

{ #category : 'as yet unclassified' }
AutometaIcon class >> dragonIcon [

	<script: 'self dragonIcon inspect'>
	^ self icons at: #dragon ifAbsentPut: [
		  Form fromBinaryStream:
			  self dragonIconEncoding base64Decoded readStream ]
]

{ #category : 'as yet unclassified' }
AutometaIcon class >> dragonIconEncoding [

	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABmJLR0QA/wD/AP+gvaeTAAAA+0lEQVQ4jWNwc3O7k5ubW8BAAsjIyGi3tbV9zsDAwMBiaWmprKCg0B8eHt7Mysq6R15evqC1tfUhuqby8nKbt2/f1ggLC1tERETwFxRA7ayvr/8PA/fv3/9fX1//Pykp6QLMVRkZGe0ZGRk35s+f///9+/dwtfb29v8xDEAG69ev/19fX////PnzWOVhBrDg8mdAQABDQEAAwfBgIiXwsAEUF3DIajJwadkQpfHb3ZeYBnBp2TBI5swkyoDnU9IZfj65gWrAt2tHGJ5PSSfOBdeOMDAwUDsMRqgXGOXl5f8rKCgwMDAwMJy4+5L4dHDtCMPPJzcYSXMvFgAAP4WjKBIQHIwAAAAASUVORK5CYII='
]

{ #category : 'as yet unclassified' }
AutometaIcon class >> icons [

	<script: 'self icons inspect'>
	icons ifNil: [ icons := Dictionary new ].
	^ icons
]
