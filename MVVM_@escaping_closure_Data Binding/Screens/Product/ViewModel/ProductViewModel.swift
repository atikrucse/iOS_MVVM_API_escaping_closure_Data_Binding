//
//  ProductViewModel.swift
//  MVVM_@escaping_closure_Data Binding
//
//  Created by Atik  on 19/9/23.
//

import Foundation

final class ProductViewModel {
    
    var products: [Product] = []
    
    var eventHandler: ((_ event: Event) -> Void)?  //Data Binding Closure
    
    func fetchProducts() {
        
        self.eventHandler?(.loading)
        APIManager.shared.fetchProduct { response in
            
            self.eventHandler?(.stopLoading)
            
            switch response {
                case .success(let products):
                    self.products = products
                    self.eventHandler?(.dataLoaded)

                case .failure(let error):
                    self.eventHandler?(.error(error))
            }
            
        }
    }
}

extension ProductViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
