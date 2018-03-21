//
//  BikeCell.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit
import ModelLayer
import RxSwift

class BikeCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var bookBikeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookBikeButton.layer.cornerRadius = 6
    }
    
    var bike: Bike! {
        didSet {
            guard let bike = bike else { return }
            switch bike.frameColor {
            case .blue:
                icon.tintColor = UIColor.cobiBlue
            case .green:
                icon.tintColor = UIColor.greenBike
            case .red:
                icon.tintColor = UIColor.redBike
            }
            name.text = bike.name
        }
    }
    
}
