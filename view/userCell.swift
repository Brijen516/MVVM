//
//  userCell.swift
//  MVVM
//
//  Created by Brijen Patel on 06/09/21.
//

import UIKit
protocol DoneProtocol {
    func onClickEdit(at indexPath : IndexPath)
}
class userCell: UITableViewCell {
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnEdit : UIButton!
    @IBOutlet weak var lbStackView: UIStackView!

    
    var delegate : DoneProtocol!
    var indexPath : IndexPath!
    var editClouser : (()->())!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        lbStackView.layer.cornerRadius = 10.0
        
       
    }

    @IBAction func onClickEditDetails(_ sender: UIButton) {
     //   self.delegate.onClickEdit(at: self.indexPath)
       editClouser()
        
        
    }
   
}
