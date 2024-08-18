//
//  SectionsViewModel.swift
//  Sport News
//
//  Created by Abdusalom on 15/08/2024.
//

import Combine


class SectionsViewModel {
    
    @Published var section: [CategoriesModel] = []
    
    let sectionNetwork = NetworkManager()
    
    
    func getCategories() {
        sectionNetwork.getCategories { result in
            switch result {
            case .success(let success):
                self.section = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
