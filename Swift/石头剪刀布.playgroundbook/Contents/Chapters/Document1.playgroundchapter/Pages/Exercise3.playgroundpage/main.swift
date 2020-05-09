//#-hidden-code
//
//  main.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//
//#-end-hidden-code
/*:#localized(key: "FirstProseBlock")
 **Goal:** Define new actions for your game.

 You can add an action that beats more than one other action, by defining multiple `beats` statements.
 
 * callout(Example):
    
    `let hardRock = game.addAction("🤘")`\
    `hardRock.beats(rock)`\
    `hardRock.beats(scissors)`
 
 Another way to add an action is by defining an array. You include actions that the new action beats within the `[` and `]` brackets, separated by commas.
 
 * callout(Example):
    
    `hardRock.beats([rock, scissors])`

 1. In the **SharedCode** file, add an action to the game that beats two or more other actions.
 
 2. Add an action that loses to all other actions. **Tip:** You can get an array of all the actions in the game by calling `game.actions`.
 
 When you’re ready, move on to the [next page](@next) to add hidden actions.
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
//#-code-completion(module, show, MyFiles, Book)
//#-code-completion(literal, show, array, boolean, color, integer, string)
//#-code-completion(identifier, show, if, for, while, func, var, let, ., =, (, ))
//#-code-completion(identifier, hide, GameViewController, viewController, GameResult, Game, Action, canPlay, Play())
import CoreGraphics
import PlaygroundSupport

let viewController = GameViewController.makeFromStoryboard()
PlaygroundPage.current.liveView = viewController
viewController.needAssessment = true
//#-end-hidden-code
//#-editable-code
let game = Game()

//#-localizable-zone(ex3k01)
// To modify your setup code, edit setup(game:) in the SharedCode file.
//#-end-localizable-zone
setup(game: game)

//#-localizable-zone(ex3k02)
// Example: Adds an action that loses to all other actions.
// Add this code to setup(game:) to use it across all pages.
//#-end-localizable-zone
let sadPanda = game.addAction("🐼")

for action in game.actions {
    action.beats(sadPanda)
}

game.play()
//#-end-editable-code
//#-hidden-code
viewController.game = game
//#-end-hidden-code


