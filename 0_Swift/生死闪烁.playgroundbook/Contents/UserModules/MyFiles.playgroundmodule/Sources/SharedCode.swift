//  /*#-localizable-zone(SharedCodeCopyright1)*/Copyright/*#-end-localizable-zone*/ © 2016-2019 Apple Inc. /*#-localizable-zone(SharedCodeCopyright2)*/All rights reserved./*#-end-localizable-zone*/

//#-localizable-zone(Blink01)
// Shared Code
// Code written in this file is available on all pages in this Playground Book.
//#-end-localizable-zone

// ------------------------------------
//#-localizable-zone(Blink02)
// Simple Configure Cell Function
//#-end-localizable-zone
// ------------------------------------
public func configureCell(cell: Cell) {
    switch cell.state {
//#-localizable-zone(Blink03)
    // Create rules for when your cells live or die.
//#-end-localizable-zone
    case .alive:
        if cell.numberOfAliveNeighbors < 2 {
            cell.state = .dead
        }
        else if cell.numberOfAliveNeighbors > 3 {
            cell.state = .dead
        }
    case .dead:
//#-localizable-zone(Blink04)
        // Try changing this value to >= 3 and see what happens.
//#-end-localizable-zone
        if cell.numberOfAliveNeighbors == 3 {
            cell.state = .alive
        }
    case .idle:
        if cell.numberOfAliveNeighbors == 3 {
            cell.state = .alive
        }
    }
}

// ------------------------------------
//#-localizable-zone(Blink05)
// Complex Configure Cell Function
//#-end-localizable-zone
// ------------------------------------
public func advancedConfigureCell(cell: Cell) {
    switch cell.state {
        
    case .alive:
        if cell.numberOfAliveNeighbors > 6 {
            cell.state = .idle
        }
        else if cell.numberOfAliveNeighbors < 2 && cell.numberOfIdleNeighbors > 5 {
            cell.state = .dead
        }
    case .dead:
        if cell.numberOfAliveNeighbors == 3 {
            cell.state = .alive
        }
        else if cell.numberOfIdleNeighbors > 5 {
            cell.state = .idle
        }
    case .idle:
//#-localizable-zone(Blink06)
        // Try changing this value to == 1 and see what happens.
//#-end-localizable-zone
        if cell.numberOfIdleNeighbors > 7 {
            cell.state = .alive
        }
        else if cell.numberOfAliveNeighbors > 3 {
            cell.state = .dead
        }
        else if cell.numberOfDeadNeighbors > 3 {
            cell.state = .dead
        }
    }
}


