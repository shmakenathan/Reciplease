//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Nathan on 22/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var cuisineTypeLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        infoView.layer.cornerRadius = 10
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        
        gradientLayer.locations = [0.2, 1]
        
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
