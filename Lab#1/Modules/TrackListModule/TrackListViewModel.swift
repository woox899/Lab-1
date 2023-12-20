//
//  TrackListViewModel.swift
//  Lab#1
//
//  Created by Андрей Бабкин on 20.12.2023.
//

import Foundation

protocol TrackListViewModelProtocol: AnyObject {
    var delegate: TrackListViewModelDelegate? { get set }
    func getTracks()
}

final class TrackListViewModel: TrackListViewModelProtocol {
    weak var delegate: TrackListViewModelDelegate?
    private let servive = APIService()
    
    func getTracks() {
        servive.getTracks() { [weak self] result in
            switch result {
            case .success(let tracks):
                self?.delegate?.updateTracks(tracks: tracks)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


