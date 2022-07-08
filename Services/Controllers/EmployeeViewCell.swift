//
//  EmployeeViewCell.swift
//  Services
//
//  Created by leila on 22.06.2022.
//

import UIKit

class EmployeeViewCell: UICollectionViewCell {
    
    @IBOutlet weak var employyeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    func configure(with employee: Employee, image: UIImage) {
        nameLabel.text = employee.firstName
        positionLabel.text = employee.position
        self.employyeImageView.image = image
    }
}
