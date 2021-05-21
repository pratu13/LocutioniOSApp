//
//  AppViewModel.swift
//  Locution
//
//  Created by Pratyush  on 4/13/21.
//

import Foundation
import CoreData
import SwiftUI

class AppViewModel: ObservableObject {
    @Published var words = [Words]()
    
    let colors: [Color] =  [Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)), Colors.Palette.floralWhite.color.opacity(0.4), Colors.Palette.floralWhite.color.opacity(0.4)]
    
    init(savedWords: FetchedResults<Word>) {
        self.words = savedWords.map(Words.init)
    }
    
    func save(title: String, meaning: String, context: NSManagedObjectContext) {
        let newWord = Word(context: context)
        newWord.title = title
        newWord.meaning = meaning
        newWord.dateAdded = Date()
        words.append(.init(word: newWord))
        saveContext(with: context)
    }
    
    func remove(index: Int, context: NSManagedObjectContext, from wordS: FetchedResults<Word>) {
        context.delete(wordS[index])
        words.remove(at: index)
        saveContext(with: context)
    }
    
    func update() {
        
    }

    private func saveContext(with context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error \(error)")
        }
    }
}
