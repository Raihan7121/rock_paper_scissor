import SwiftUI

struct ContentView: View {
    // Possible choices for the game
    let choices = ["Rock", "Paper", "Scissors"]
    
    // State variables
    @State private var userChoice: String? = nil
    @State private var aiChoice: String? = nil
    @State private var result: String? = nil
    
    var body: some View {
        ZStack {
            // Background image from the asset catalog
            Image("image") // Replace "backgroundImage" with the name of your asset
                .resizable()
                .scaledToFill()
                .ignoresSafeArea() // Ensures the image covers the entire screen
            
            VStack {
                // Title of the game
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
                // Buttons for user choice
                HStack {
                    ForEach(choices, id: \.self) { choice in
                        Button(action: {
                            userChoice = choice
                            aiChoice = getRandomChoice()
                            result = determineWinner(userChoice: choice, aiChoice: aiChoice!)
                        }) {
                            Text(choice)
                                .font(.title)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                
                Spacer()
                
                // Display user's and AI's choices
                if let userChoice = userChoice, let aiChoice = aiChoice {
                    Text("You chose: \(userChoice)")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    // AI's choice with a background for contrast
                    Text("Computer chose: \(aiChoice)")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black.opacity(0.5)) // Semi-transparent black background
                        .cornerRadius(10)
                }
                
                Spacer()
                
                // Display the result
                if let result = result {
                    Text(result)
                        .font(.title)
                        .padding()
                        .foregroundColor(result == "You Win!" ? .green : result == "You Lose!" ? .red : .yellow)
                }
            }
            .padding()
        }
    }
    
    // Function to get a random choice for the AI
    private func getRandomChoice() -> String {
        return choices[Int.random(in: 0..<choices.count)]
    }
    
    // Function to determine the winner
    private func determineWinner(userChoice: String, aiChoice: String) -> String {
        if userChoice == aiChoice {
            return "It's a Draw!"
        } else if (userChoice == "Rock" && aiChoice == "Scissors") ||
                    (userChoice == "Paper" && aiChoice == "Rock") ||
                    (userChoice == "Scissors" && aiChoice == "Paper") {
            return "You Win!"
        } else {
            return "You Lose!"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
