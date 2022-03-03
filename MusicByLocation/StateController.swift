//
//  StateController.swift
//  MusicByLocation
//
//  Created by Compton-Burnett, Peter (PGW) on 28/02/2022.
//

import Foundation
import SwiftUI

class StateController: ObservableObject {
    let locationHandler: LocationHandler = LocationHandler()
    let iTunesAdapter = ITunesAdapter()
    @Published var artistsByLocation: [String] = []
    
    var lastKnownLocation: String = "" {
        didSet {
            iTunesAdapter.getArtists(search: lastKnownLocation, completion: updateArtistsByLocation)
        }
    }
    

    
    func findMusic() {
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorisation()
    }
    
    func updateArtistsByLocation(artists: [Artist]?) {
        let names = artists?.map {
            return $0.name
        }
        DispatchQueue.main.async {
            self.artistsByLocation = names ?? ["Error finding Artists from your Location"]
            //self.artistsByLocation = names?.joined(separator: ", ") ?? "Error finding Artists from your Location"

            
        }
    }
    

    
    
}
