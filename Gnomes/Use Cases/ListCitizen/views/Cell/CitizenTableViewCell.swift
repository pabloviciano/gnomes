//
//  CitizenTableViewCell.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 21/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import UIKit

public class CitizenTableViewCell: UITableViewCell, CitizenCellView {
    @IBOutlet weak var citizenNameLabel: UILabel!
    @IBOutlet weak var citizenImageView: UIImageView!
    
    public static let CellIdentifier = "CitizenTableViewCell"
    var viewModel: CitizenCellViewModel?
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with viewModel: CitizenCellViewModel){
        self.viewModel = viewModel
        self.citizenNameLabel.text = viewModel.name
        self.citizenNameLabel.adjustsFontSizeToFitWidth = true
        viewModel.load()
    }
    
    public func onLoad(withImage image: UIImage) {
        self.citizenImageView.image = image
    }

}
