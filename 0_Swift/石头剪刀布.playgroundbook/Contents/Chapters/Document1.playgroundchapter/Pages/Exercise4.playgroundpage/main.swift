//#-hidden-code
//
//  main.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//
//#-end-hidden-code
/*:#localized(key: "FirstProseBlock")
 **Goal:** Add hidden actions to give your game more depth.
 
 You can create a hidden action for your game. A hidden action isn’t selectable. When you define a hidden action, a “?” action is added to the game to randomly select any action in the game, including a hidden action.
 
 * callout(Example):
 
    `game.addHiddenAction("🦄")`


 1. Convert the action that loses to all other actions (from the previous page) into a hidden action.

 2. Add a second hidden action that beats all other actions.
 
 When you’re ready, move on to the [next page](@next) to add more opponents.
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
viewController.needAssessment = true
PlaygroundPage.current.liveView = viewController
//#-end-hidden-code
//#-editable-code
let game = Game()

setup(game: game)

//#-localizable-zone(ex4k01)
// Example: Creates a hidden action that beats all other actions.
// Add this code to setup(game:) to use it across all pages.
//#-end-localizable-zone
let tRex = game.addHiddenAction("🦖")

for action in game.actions {
    tRex.beats(action)
}

game.play()


//#-end-editable-code
//#-hidden-code
viewController.game = game
//#-end-hidden-code
