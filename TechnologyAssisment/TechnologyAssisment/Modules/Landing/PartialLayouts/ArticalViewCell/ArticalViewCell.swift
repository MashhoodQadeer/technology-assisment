// LoadingContentTableViewCell.swift
// TechnologyAssisment
// Created by Mashhood Qadeer on 25/04/2025.

import UIKit

class ArticalViewCell: UITableViewCell{
    
    @IBOutlet weak var articalImage: AsyncImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var articalByLabel: UILabel!
    @IBOutlet weak var articalDateLabel: UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
 
    var data:NYTArticle!{
        didSet{
            
           self.setupLayout()
        }
        
    }
    
    func setupLayout( data: Any ){
        
        if let value = data as? NYTArticle {
           self.data = value
        }
        
    }
    
    func setupLayout(){
         self.headingLabel.text = self.data.title
         self.articalByLabel.text = self.data.byline
         self.articalDateLabel.text = self.data.publishedDate
         if let mediaThumbnail = self.data.mediaThumbnail{
            articalImage.loadImage(from: mediaThumbnail)
         }
    }
    
    
}
