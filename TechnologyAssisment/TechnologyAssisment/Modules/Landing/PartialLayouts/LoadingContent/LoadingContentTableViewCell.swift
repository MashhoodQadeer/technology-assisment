// LoadingContentTableViewCell.swift
// TechnologyAssisment
// Created by Mashhood Qadeer on 25/04/2025.

import UIKit

class LoadingContentTableViewCell: UITableViewCell{

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.activityIndicator?.startAnimating()
    }

}
