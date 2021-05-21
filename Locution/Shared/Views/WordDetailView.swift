//
//  WordDetailView.swift
//  Locution
//
//  Created by Pratyush  on 5/3/21.
//

import SwiftUI

struct WordDetailView: View {
    
    @Environment(\.presentationMode) private var presentationMode
//    @Binding var wordTitle: String
//    @Binding var wordMeaning: String
    var word: String
    //@Binding var addButtonTapped: Bool
    
    var viewModel: AppViewModel
    //var viewContext: NSManagedObjectContext
    
    var body: some View {
            VStack {
                Text(word)
            }
    }
}

//struct WordDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WordDetailView()
//    }
//}
