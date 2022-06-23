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
    
    func configure(with employee: Employee) {
        nameLabel.text = employee.firstName
        positionLabel.text = employee.position
        DispatchQueue.global().async {
            guard let url = URL(string: employee.imageUrl ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.employyeImageView.image = UIImage(data: imageData)
            }
        }
    }
}
