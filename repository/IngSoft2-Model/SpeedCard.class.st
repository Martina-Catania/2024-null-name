"
+1 to target ship's dice throws
"
Class {
	#name : 'SpeedCard',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
SpeedCard >> applyMovementOn: aShip [

	| movementBuff |
	movementBuff := aShip shipName = target objective
		                ifTrue: [ 1 ]
		                ifFalse: [ 0 ].
	^ movementBuff
]
