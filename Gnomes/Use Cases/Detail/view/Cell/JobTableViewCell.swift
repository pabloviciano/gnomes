//
//  JobTableViewCell.swift
//  Gnomes
//
//  Created by Pablo Viciano Negre on 22/9/17.
//  Copyright © 2017 Pablo Viciano Negre. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    public static let CellIdentifier = "JobTableViewCell"
    var viewModel: JobCellViewModel? = nil 
    
    @IBOutlet weak var jobNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with viewModel: JobCellViewModel) {
        self.viewModel = viewModel
        self.jobNameLabel.text = viewModel.job
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
