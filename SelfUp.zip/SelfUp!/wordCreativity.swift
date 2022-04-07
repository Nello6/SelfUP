//
//  ContentView.swift
//  WordGame
//
//  Created by Diego Castro on 18/11/21.
//

import SwiftUI

struct wordCreativity: View {
    @State private var currentWord = ""
    @State private var usedWords = [String]()
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    var body: some View {
        //        NavigationView{
        
        ZStack{
            // Sfondo totale
            Color("Grigio6")
                .edgesIgnoringSafeArea(.all)
            
        VStack(alignment: .leading){
            
            Text("Use some of the letters in the word below")
                .fontWeight(.regular)
                .padding(.top, 16)
            
            Text("\(String(currentWord))".capitalized)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/,2)
            Text("to create as many new words as you can")
                .fontWeight(.regular)
            
            HStack{
                
                TextField("Write a word...", text: $newWord, onEditingChanged: { (changed) in
                    print("Username onEditingChanged - \(changed)")
                })   {
                    self.addNewWord()
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 340, alignment: .leading)
                .textFieldStyle(.roundedBorder)
                .padding([.bottom])
                
                Button(
                    action:{
                        self.usedWords = [String]()
                        startGame()
                    })
                
                {
                    Image(systemName: "shuffle")
                    
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(Color.blue)
                        .padding(.bottom)
                        .font(.system(size:25))
                }
                
                
            }
            
            
            List{
                ForEach(usedWords, id: \.self) { word in
                    Text(word)
                }
            }.multilineTextAlignment(.center)
        }
        .padding(.leading, 16)
        }
        

        
        .onAppear{
            
            self.startGame()
        }.alert(isPresented: $showingError){
            Alert(
                title: Text(errorTitle),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }.navigationTitle("Problem Solving")
            
}
    
    
    
    func startGame () {
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                currentWord = allWords.randomElement() ?? "silkworm"
                return
            }
            
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    func addNewWord (){
        let lowerAnswer = newWord.lowercased()
        guard isOriginal (word: lowerAnswer) else {
            wordError(title: "word already used", message: "Need to be more original")
            return
        }
        
        guard isPossible(word: lowerAnswer) else {
            wordError(title: "Not recognized", message: "That word even exists?")
            return
        }
        
        guard isReal(word: lowerAnswer) else {
            wordError(title: "Word not possible", message: "Did you just make up that word?")
            return
        }
        
        //        if currentWord == newWord{
        //            self.usedWords = [String]()
        //            startGame()
        //
        //        }
        
        usedWords.insert(lowerAnswer, at: 0)
        newWord = ""
        
        //        if lowerAnswer == newWord{
        //
        //        }
        
    }
    
    //    Avoid user from repiting the same word
    func isOriginal (word:String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible (word: String) -> Bool {
        var tempWord = currentWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.range (of: String(letter)){
                tempWord.remove(at: pos.lowerBound)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal (word:String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
        
    }
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    //    func Correct (word:String) -> Bool {
    //
    //    }
    
    
    //    -------------------------------------
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        wordCreativity()
    }
}

