//
//  ServicesViewCell.swift
//  Services
//
//  Created by leila on 20.06.2022.
//

import UIKit

class ServicesViewCell: UICollectionViewCell {
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    func configure(with service: Service) {
            serviceNameLabel.text = service.name
            durationLabel.text = "\(service.duration) хв"
            priceLabel.text = String(service.price)
            currencyLabel.text = service.currency
        }
    }
