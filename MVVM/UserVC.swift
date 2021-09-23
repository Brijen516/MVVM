//  UserVC.swift
//  MVVM
//  Created by Brijen Patel on 06/09/21.

import UIKit

class UserVC: UIViewController {
  
    var id = 0
    var status = true
    var Title = ""
    var ID = ""
    var Status = ""
    var UserArray : UserModel!
    var ArrUsers = [UserModel]()
    var context : ViewController!
    var userEdit = ""
    
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var UserDetailEditStack: UIStackView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var UserDetialStack: UIStackView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfID: UITextField!
    @IBOutlet weak var tfStatus: UITextField!
    
    //    var update : (()->())!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDetailEditStack.isHidden = true
        if userEdit == "1"{
            UserDetialStack.isHidden = true
            UserDetailEditStack.isHidden = false
//            tfTitle.text = context.viewModelUser.arrUsers[0].title
            
            tfTitle.text = Title
            tfID.text = ID
            tfStatus.text = "\(String(Status))"
        }else{
            UserDetialStack.isHidden = false
            UserDetailEditStack.isHidden = true
        }
        

//        lblID.text = "\(id)"
//        lblStatus.text = " \(status)"
//        lblTitle.text = "\(Title)"
//        let idd : String = String(UserArray.id!)
//        lblID.text = idd //"\(String(describing: UserArray.id))"
//        lblStatus.text = "\(Bool(UserArray.completed!))"
//        lblTitle.text = UserArray.title
//
        let userId : String = String(context.viewModelUser.arrUsers[0].id!)
        lblID.text = userId
        lblStatus.text = "\(Bool(context.viewModelUser.arrUsers[0].completed!))"
        lblTitle.text = context.viewModelUser.arrUsers[0].title!
        
//        lblID.text = mainID
//        lblStatus.text = mainstatus
//        lblTitle.text = mainTitle
    
    }
    

   @IBAction func onClickSubmit(_ sender: Any) {
   }
    
}
