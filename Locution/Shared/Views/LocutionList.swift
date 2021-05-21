//
//  ContentView.swift
//  Shared
//
//  Created by Pratyush  on 4/13/21.
//

import SwiftUI
import CoreData

struct LocutionList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Word.dateAdded, ascending: false)]) var words: FetchedResults<Word>
    
    @State var word: String = ""
    @State var meaning: String = ""
    @State var saveButtonTapped: Bool = false
    @State var addButtonTapped: Bool = false
    @State private var presentDetailSheet: Bool = false
    
    var viewModel: AppViewModel {
        return AppViewModel(savedWords: words)
    }

    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            
            NavigationView {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.words, id: \.self) { w in
                            NavigationLink(destination: WordDetailView(word: w.title, viewModel: viewModel)) {
                                WordCard(word: w, gradient: viewModel.colors)
                                    .id(w.id)
                                    .foregroundColor(Color.primary)
                                    .padding(.vertical, 5)
//                                    .sheet(isPresented: $presentDetailSheet){
//                                        WordDetailView(word: w.title,  viewModel: viewModel)
//                                    }
//                                    .onTapGesture {
//    //                                    withAnimation {
//    //                                        viewModel.remove(index: index, context: viewContext, from: words)
//    //                                    }
//                                        self.presentDetailSheet = true
//                                        print(w.title)
//                                }
                            }
                                
                        }
                        .navigationTitle("Words ")
                        .edgesIgnoringSafeArea(.bottom)
                    }
                    .padding(.horizontal, 16)
                }
                .toolbar {
                    Image("words")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                }
            }
//            .sheet(isPresented: $presentDetailSheet) {
//                WordDetailView(wordTitle: $word, wordMeaning: $meaning, viewModel: viewModel)
//            }
            .disabled(addButtonTapped)
            .opacity(addButtonTapped ? 0.0 : 1.0)
            .blur(radius: addButtonTapped ? 3.0 : 0.0)
            .onTapGesture {
                self.addButtonTapped = false
            }
            
            if viewModel.words.count == 0 {
                VStack {
                    Text("Your word library is empty. Tap on + to add new words.")
                        .padding()
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .opacity(addButtonTapped ? 0.0 : 1.0)
                        .minimumScaleFactor(3.0)
                }
            }
            
            AddWordView(wordTitle: $word, wordMeaning: $meaning, addButtonTapped: $addButtonTapped, viewModel: viewModel,viewContext: viewContext)
                .opacity(addButtonTapped ? 1 : 0.0)
                .scaleEffect(addButtonTapped ? 1: 0.0)
                .animation(.easeIn)
            
            
            VStack(alignment: .trailing) {
                if !addButtonTapped {
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action: {
                        self.addButtonTapped.toggle()
                    } , label: {
                        Image(systemName: "plus")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .frame(width: 44, height: 44)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Colors.Palette.lavender.color, Colors.Palette.cupid.color]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(Circle())
                            .scaleEffect(0.7)
                            .rotationEffect(.degrees(addButtonTapped ? 45 : 0))
                            .animation(.easeInOut(duration: 0.5))
                    })
                    .padding()
                    .scaleEffect(addButtonTapped ? 0.6 : 1.0)
                    
                }
                
                if addButtonTapped {
                    Spacer()
                }
            }
        }
        
    }
}

var word: [Words]  = [.init()]

struct LocutionList_Previews: PreviewProvider {
    static var previews: some View {
        LocutionList()
        //WordCard(word: word[0], gradient: [Color.green, Color.blue])
    }
}


struct WordCard: View {
    var word: Words
    var gradient: [Color]
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            ZStack(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: 10.0) {
                    HStack {
                        Text(word.title)
                            .bold()
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    HStack {
                        Text(word.meaning)
                            .font(.subheadline)
                            .italic()
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: gradient), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .clipShape(RoundedRectangle(cornerRadius: 30.0, style: .continuous))
            }
            
            
            
            WatermarkView(character: word.title.first?.uppercased() ?? "L", color: gradient[0] )
                .padding()
            
        }
    }
}




