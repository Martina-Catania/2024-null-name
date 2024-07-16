"
handles battles between ships and determines who participates
"
Class {
	#name : 'ShipBattleHandler',
	#superclass : 'Object',
	#instVars : [
		'dice',
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'events' }
ShipBattleHandler class >> withDice: aCollectionOfDice withShips: aCollectionOfShips [

	^ self new
		  initializeWithShips: aCollectionOfShips
		  withDice: aCollectionOfDice
]

{ #category : 'event' }
ShipBattleHandler >> armyDiceThrow: aShipArmy with: aCardHandler [

	| anArmyDiceRoll |
	anArmyDiceRoll := 0.
	aShipArmy do: [ :aShipInArmy |
		| cardMovement |
		cardMovement := aCardHandler movementCardsActivated: aShipInArmy.
		anArmyDiceRoll := anArmyDiceRoll + (aCardHandler
			                   extraBuffs: aShipInArmy
			                   onThrow: dice throw + cardMovement) ].
	^ anArmyDiceRoll
]

{ #category : 'initialization' }
ShipBattleHandler >> checkShipBattle: currentTurnShip withCardHandler: gameCardHandler [

	| shipsInSamePosition |
	currentTurnShip position = 1 ifTrue: [ ^ self ].
	shipsInSamePosition := ships select: [ :aShip |
		                       (currentTurnShip inSamePositionAs: aShip)
			                       and:
				                       ((gameCardHandler mercenariesOf:
					                         currentTurnShip) includes:
					                        aShip shipName) not ].
	shipsInSamePosition do: [ :aShipInSamePosition |
		currentTurnShip position = 1 ifTrue: [ ^ self ].
		self
			resolveBattleBetween: currentTurnShip
			and: aShipInSamePosition
			with: gameCardHandler ]
]

{ #category : 'initialization' }
ShipBattleHandler >> initializeWithShips: aCollectionOfShips withDice: aCollectionOfDice [

	dice := aCollectionOfDice.
	ships := aCollectionOfShips.
]

{ #category : 'event' }
ShipBattleHandler >> resolveBattleBetween: aShip and: anotherShip with: aCardHandler [

	| anArmyDiceRoll anotherArmyDiceRoll loserShipArmy anArmy anotherArmy |
	
	anArmy := self shipsNames: (aCardHandler mercenariesOf: aShip).
	anotherArmy := self shipsNames:
		               (aCardHandler mercenariesOf: anotherShip).

	anArmyDiceRoll := self armyDiceThrow: anArmy with: aCardHandler.
	anotherArmyDiceRoll := self
		                       armyDiceThrow: anotherArmy
		                       with: aCardHandler.

	loserShipArmy := anArmyDiceRoll > anotherArmyDiceRoll
		                 ifTrue: [ anotherArmy ]
		                 ifFalse: [ anArmy ].

	loserShipArmy do: [ :aShipInArmy |
		aShipInArmy loseOneShield.
		aShipInArmy moveToFirstTile ]
]

{ #category : 'event' }
ShipBattleHandler >> shipWithName: aShipName [

	^ ships detect: [ :ship | ship shipName = aShipName ]
]

{ #category : 'event' }
ShipBattleHandler >> shipsNames: aShipsNameCollection [
	
	^ aShipsNameCollection collect: [ :shipName | self shipWithName: shipName  ].
]
