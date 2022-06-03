//
//  ContentView.swift
//  tic-tac-toe WatchKit Extension
//
//  Created by Maya Krolik on 3/20/22.
//

import SwiftUI

struct ContentView: View {
    @State var position_values = Array(repeating: Array(repeating: " ", count: 3), count:3) // array of arrays of strings to hold which player selected given button
    @State var color_values = Array(repeating: Array(repeating: Color.clear, count:3), count:3) // array of arrays of color defaulted to clear and will change depending on which player selected button
    
    @State var current_player = "X" //
    
    @State var x_score = 0
    @State var o_score = 0
    @State var d_score = 0
    @State var message = ""
    @State var win_message = Text("")
        .font(.footnote)
        .foregroundColor(.white)
    @State var disabled = true
    @State var button_width = 0.0
    @State var button_height = 0.0
    
    func ResetGame() { // reset the game to all starting values
        if (current_player == "X") { // let the loosing player start the next game
            current_player = "O"
        } else {
            current_player = "O"
        }
        // reset which button belongs to which player
        position_values = Array(repeating: Array(repeating: " ", count: 3), count:3)
        // reset button colors
        color_values = Array(repeating: Array(repeating: Color.clear, count:3), count:3)
        // make button disabled and hide it by making its dimensions 0
        disabled = true
        button_width = 0.0
        button_height = 0.0
    }
    
    func ResetScore() {
        // clears all game information
        x_score = 0
        o_score = 0
        d_score = 0
        message = ""
        win_message = Text(message)
            .font(.title)
            .foregroundColor(Color.clear)
    }
    
    func DisplayWinner(){
        // displays win screen
        disabled = false // make button activated (so player can press)
        button_width = 185.0 // set dimensions of button
        button_height = 50.0
        win_message = Text(message) // set the message of the button to be depending on the person who won
            .font(.title)
            .foregroundColor(Color.white)
    }
    
    func UpdateScore(player: String){
        // updates the score and win message depending on which player wins
        if (player == "X") // if X wins
        {
            x_score += 1
            message = "X Wins!"
        } else { // if O wins
            o_score += 1
            message = "O Wins!"
        }
        DisplayWinner() // display win screen
    }
    
    func CheckWinner() {
        // only check if the current player won
        
        // layout of buttons
        // | 0,0 | 0,1 | 0,2 |
        // | 1,0 | 1,1 | 1,2 |
        // | 2,0 | 2,1 | 2,2 |
        
        // check top row if all values in it correspond to the current player
        if (position_values[0][0] == current_player && position_values[0][1] == current_player && position_values[0][2] == current_player)
        {
            UpdateScore(player: current_player)
    
        }
        // check middle row
        if (position_values[1][0] == current_player && position_values[1][1] == current_player && position_values[1][2] == current_player)
        {
            UpdateScore(player: current_player)

        }
        // check bottomr row
        if (position_values[2][0] == current_player && position_values[2][1] == current_player && position_values[2][2] == current_player)
        {
            UpdateScore(player: current_player)

        }
        // check left column
        if (position_values[0][0] == current_player && position_values[1][0] == current_player && position_values[2][0] == current_player)
        {
            UpdateScore(player: current_player)

        }
                                                                                                                  
        // check middle column
        if (position_values[0][1] == current_player && position_values[1][1] == current_player && position_values[2][1] == current_player)
        {
            UpdateScore(player: current_player)

        }
        // check right column
        if (position_values[0][2] == current_player && position_values[1][2] == current_player && position_values[2][2] == current_player)
        {
            UpdateScore(player: current_player)

        }
        // check diagnol top left to bottom right
        if (position_values[0][0] == current_player && position_values[1][1] == current_player && position_values[2][2] == current_player)
        {
            UpdateScore(player: current_player)

        }
        // check diagnol top right to bottom left
        if (position_values[0][2] == current_player && position_values[1][1] == current_player && position_values[2][0] == current_player)
        {
            UpdateScore(player: current_player)

        }
        
        // check if draw by iterating through every square and checking if they are all filled without the code for an X or O win triggering
        outerLoop: for i in 0...2 { // iterate through rows
            for j in 0...2 { // iterate through columns
                if (position_values[i][j] == " ") { // if there are still values open, there is no draw, so break out of whole loop
                    break outerLoop
                }
                if (i == 2 && j == 2 && position_values[i][j] != " ") {
                    // if bottom right corner is filled, then all the other boxes are filled, therefore there is a draw
                    d_score += 1
                    message = "Its a Draw!"
                    DisplayWinner() // display win screen
                }
            }
        }
        ChangePlayer() // after checking for all win possibilities, change player
    }
    
    func ChangePlayer() { // alternate between players
        if (current_player == "X") { // if X change to O
            current_player = "O"
        } else { // if O change to X
            current_player = "X"
        }
    }
    
    func GridClicked(row: Int, col: Int) // check which grid is clicked
    {
        if (position_values[row][col] == " ") { // check if spot is empty
            position_values[row][col] = current_player // set spot to the player who clicked
            if (current_player == "X") { // change color of spot depending on the player
                color_values[row][col] = Color.blue // blue if X
            }
            else {
                color_values[row][col] = Color.red // red if O
            }
            
            CheckWinner() // check if someone has won yet
        }
    }

    var body: some View {
        // constants for buttons for nice appearance on screen
        let MINWIDTH = 25.0
        let CORNER_RADIUS = 20.0
       
        // vertical stack to hold rows of horizontally places buttons
        VStack(
            alignment: .center,
                spacing: 0
            ) {
                
                // top row
                // horizontal stack to hold buttons evenly spaced horizontally
                HStack(
                        alignment: .center,
                        spacing: 10
                    ) {
                        // create button that will initiate GridClicked() and pass its position
                        Button(action: {
                            GridClicked(row: 0, col: 0)
                        }) {
                            // text of button will be determined by GridClicked() and will be either X or O
                            Text(position_values[0][0])
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: MINWIDTH)
                        .background(color_values[0][0])
                        .cornerRadius(CORNER_RADIUS)
                        // repeats for all other buttons with only position changing
                        
                        
                        Divider() // creates small grey line to divide buttons
                        Button(action: {
                            GridClicked(row: 0, col: 1)
                        }) {
                            Text(position_values[0][1])
                                .font(.title)
                                .foregroundColor(.white)

                        }
                        .frame(minWidth: MINWIDTH)
                        .background(color_values[0][1])
                        .cornerRadius(CORNER_RADIUS)
                        
                        Divider() // creates small grey line to divide buttons
                        Button(action: {
                            GridClicked(row: 0, col: 2)
                        }) {
                            Text(position_values[0][2])
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: MINWIDTH)
                        .background(color_values[0][2])
                        .cornerRadius(CORNER_RADIUS)
                    }
                
                // middle row
                Divider() // creates small grey line to divide rows
                HStack(
                        alignment: .center,
                        spacing: 10
                    ) {
                        Button(action: {
                            GridClicked(row: 1, col: 0)
                        }) {
                            Text(position_values[1][0])
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: MINWIDTH)
                        .background(color_values[1][0])
                        .cornerRadius(CORNER_RADIUS)
                        
                        Divider() // creates small grey line to divide buttons
                        Button(action: {
                            GridClicked(row: 1, col: 1)
                        }) {
                            Text(position_values[1][1])
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: MINWIDTH)
                        .background(color_values[1][1])
                        .cornerRadius(CORNER_RADIUS)
                        
                        Divider() // creates small grey line to divide buttons
                        Button(action: {
                            GridClicked(row: 1, col: 2)
                        }) {
                            Text(position_values[1][2])
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: MINWIDTH)
                        .background(color_values[1][2])
                        .cornerRadius(CORNER_RADIUS)
                    }
                
                // bottom row
                Divider() // creates small grey line to divide rows
                HStack(
                    alignment: .center,
                        spacing: 10
                    ) {
                        Button(action: {
                            GridClicked(row: 2, col: 0)
                        }) {
                            Text(position_values[2][0])
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: MINWIDTH)
                        .background(color_values[2][0])
                        .cornerRadius(CORNER_RADIUS)
                        
                        Divider() // creates small grey line to divide buttons
                        Button(action: {
                            GridClicked(row: 2, col: 1)
                        }) {
                            Text(position_values[2][1])
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: MINWIDTH)
                        .background(color_values[2][1])
                        .cornerRadius(CORNER_RADIUS)
                        
                        Divider() // creates small grey line to divide buttons
                        Button(action: {
                            GridClicked(row: 2, col: 2)
                        }) {
                            Text(position_values[2][2])
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: MINWIDTH)
                        .background(color_values[2][2])
                        .cornerRadius(CORNER_RADIUS)

                    }
                // display scores on the bottom of the screen
                (Text("Score:   X: ") + Text(String(x_score)) + Text("   O: ") + Text(String(o_score)) + Text("   D: ") + Text(String(d_score)) ).font(.footnote)
            }
            .padding()
            // display win message button ontop of the rest of the game
            .overlay(
                Button(action: { ResetGame() }) { win_message }
                    // opaque background
                    .background(Color.init(UIColor(red: 0, green:0, blue:0, alpha: 0.5)))
                    // button only works conditionally, var diaabled regualted by DisplayWinner() and ResetGame()
                    .disabled(disabled)
                    .frame(width: button_width, height: button_height)
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
