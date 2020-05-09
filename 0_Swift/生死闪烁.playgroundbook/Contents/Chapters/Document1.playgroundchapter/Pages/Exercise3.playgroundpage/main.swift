//#-hidden-code
//
//  main.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//
//#-end-hidden-code
/*:#localized(key: "FirstProseBlock")
 In the previous page, a cell with 4 neighbors would die regardless if those neighbors were alive or dead. In this new version, the algorithm checks the number of neighbors in each state (alive, dead, or idle) to determine what happens. Under certain conditions, the algorithm also changes cells to the idle state, resulting in some interesting patterns.
 
 Play with the rules in the `advancedConfigureCell(cell:)` algorithm in the **SharedCode** file to see what kinds of complex simulations you can create.
 
 You can also create new functions in the **SharedCode** file and assign them to `simulation.configureCell`.
 
    simulation.configureCell = yourConfigureCellFunction
 
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
//#-code-completion(module, show, MyFiles)
//#-code-completion(literal, show, color, integer, string)
//#-code-completion(keyword, show, if, func, var, let)
//#-code-completion(identifier, show, ., =, <=, >=, <, >, ==, !=, +, -, true, false, &&, ||, !, *, /, alive, dead, idle, pulsar, glider, pentadecathlon, capitalL, cellDimension, placePattern(_:atColumn:row:), cell, speed, state, numberOfAliveNeighbors, simulation, set(_:forState:), gridLineThickness, gridColor, Pattern, configureCell(cell:), advancedConfigureCell(cell:), Simulation, configureCell)
//#-code-completion(identifier, hide, BlinkViewController, viewController, Coordinate, InitialStatePreset, Simulation, Cell, storyBoard)
import UIKit
import PlaygroundSupport

let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
let viewController = storyBoard.instantiateInitialViewController() as! BlinkViewController

PlaygroundPage.current.liveView = viewController
//#-end-hidden-code
//#-editable-code
let simulation = Simulation()

simulation.cellDimension = 32

simulation.placePattern(Pattern.pulsar, atColumn: 1, row: 1)

simulation.speed = 2

simulation.set("🌹", forState: .alive)
simulation.set(#colorLiteral(red: 0.6352941176, green: 0.8470588235, blue: 0.7176470588, alpha: 1), forState: .alive)
simulation.set(#imageLiteral(resourceName:"plant.png"), forState: .dead)
simulation.set(#colorLiteral(red: 0.6352941176, green: 0.8470588235, blue: 0.7176470588, alpha: 1), forState: .dead)
simulation.set(#colorLiteral(red: 0.2352941176, green: 0.7215686275, blue: 0.4705882353, alpha: 1), forState: .idle)

simulation.gridLineThickness = 4
simulation.gridColor = #colorLiteral(red: 0.6352941176, green: 0.8470588235, blue: 0.7176470588, alpha: 1)

simulation.configureCell = advancedConfigureCell
//#-end-editable-code
//#-hidden-code

viewController.simulation = simulation
//#-end-hidden-code
