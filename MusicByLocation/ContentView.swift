//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Compton-Burnett, Peter (PGW) on 25/02/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var state = StateController()
    
    var body: some View {
        VStack{
            ScrollView{
                ForEach(state.artistsByLocation, id: \.self) { artist in
                    Text(artist)
                        .padding()
                }
                Spacer()
                Button("Find Music", action: {
                    state.findMusic()
                })
            }
            
        }.onAppear(perform: {
            state.requestAccessToLocationData()
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
