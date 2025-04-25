// LoadingContentTableViewCell.swift
// TechnologyAssisment
// Created by Mashhood Qadeer on 25/04/2025.

import UIKit

class ErrorMessageCell: UITableViewCell{

    @IBOutlet weak var errorMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func showMessage(message: String){
         self.errorMessage.text = message
    }
    
}
