//
//  StateController.swift
//  MusicByLocation
//
//  Created by Compton-Burnett, Peter (PGW) on 28/02/2022.
//

import Foundation

class StateController: ObservableObject {
    @Published var lastKnownLocation: String = ""
    @Published var artistNames: String = ""
    let locationHandler: LocationHandler = LocationHandler()
    
    func findMusic() {
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorisation()
    }
    
    func getArtists() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=Lionel%20Richie&entity=musicArtist")
        else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
         
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                if let response = self.parseJson(json: data) {
                    let names = response.results.map {
                        return $0.name
                    }
                    
                    DispatchQueue.main.async {
                        self.artistNames = names.joined(separator: ", ")
                    }
                }
                
                
            }
        }).resume()
    }
    
    func parseJson(json: Data) -> ArtistResponse? {
        let decoder = JSONDecoder()
        
        if let artistResponse = try? decoder.decode(ArtistResponse.self, from: json) {
            return artistResponse
        } else {
            print("Error decoding JSON")
            return nil
        }
        
        /*
        do {
            let artistResponse = try decoder.decode(ArtistResponse.self, from: json)
            return artistResponse
        } catch {
            print("Error decoding JSON")
            return nil
        }
         */
        
    }
}
