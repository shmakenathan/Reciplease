//
//  RecipleaseTabBarController.swift
//  Reciplease
//
//  Created by Nathan on 14/09/2021.
//  Copyright © 2021 NathanChicha. All rights reserved.
//

import UIKit

class RecipleaseTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItemsTitle()
        
        
    }
    
    
    private func setupTabBarItemsTitle() {
        guard let items = tabBar.items else { return }
        items[0].title = Strings.search
        items[1].title = Strings.favorite
    }
    
}
