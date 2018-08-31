//
//  DocumentsTableViewCell.swift
//  Documents
//
//  Created by Liam Flaherty on 8/29/18.
//  Copyright © 2018 Liam Flaherty. All rights reserved.
//

import UIKit

class DocumentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var DocumentLabel: UILabel!
    @IBOutlet weak var SizeLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
