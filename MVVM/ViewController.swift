//  ViewController.swift
//  MVVM
//  Created by Brijen Patel on 06/09/21.

import UIKit

class ViewController: UIViewController {
   
    var viewModelUser = UserViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        viewModelUser.vc = self
        viewModelUser.getAllUserDataAF()
        
        let nib = UINib(nibName: "userCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "userCell")
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
       
        tableView.refreshControl = UIRefreshControl()
        tableView.frame = view.bounds
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    
    
    @objc func didPullToRefresh(){
//        viewModelUser.getAllUserDataAF()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
        
            self.tableView.refreshControl?.endRefreshing()
        }
        
        if tableView.refreshControl?.isRefreshing == true{
            print("refreshing data")
        }
//        tableView.removeFromSuperview()
    }
    func doPopBack() {
        navigationController?.popViewController(animated: true)
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate,DoneProtocol
    
    {
    func onClickEdit(at indexPath: IndexPath)
    {
        let vc = self.storyboard?.instantiateViewController(identifier: "UserVC")
            as! UserVC
        
        vc.userEdit = "1"
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        viewModelUser.arrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)as! userCell
        let modelUser = viewModelUser.arrUsers[indexPath.row]
        let status = modelUser.getSatuts()
        
        cell.lblStatus.text = status.0
        cell.lblStatus.textColor = status.1
        
        if modelUser.completed == true{
            cell.btnEdit.isHidden = true
        }else{
            cell.btnEdit.isHidden = false
          
//            cell.lblID.text = Identifiable
        }
        
        if let id = modelUser.id
        {
            cell.lblID.text = "\(id)"
        }
        else
        {
            cell.lblID.text = "no id"
        }
       
        cell.lblTitle.text = modelUser.title
       
        cell.editClouser =
        {
           
            let data = self.viewModelUser.arrUsers[indexPath.row]
            let vc = self.storyboard?.instantiateViewController(identifier: "UserVC")
                as! UserVC
            
            vc.userEdit = "1"
            vc.context = self
            vc.Title = data.title!
            vc.ID = ("\(String(describing: data.id ?? 0))")
            vc.Status = "\(String(describing: data.completed ?? false))"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    
    {
        let detail:UserVC = self.storyboard?.instantiateViewController(identifier: "UserVC")
            as! UserVC
        detail.context = self
      
//        detail.UserArray = viewModelUser.arrUsers[indexPath.row]
//        detail.id = viewModelUser.arrUsers[indexPath.row].id ?? 0
//        detail.status = viewModelUser.arrUsers[indexPath.row].completed ?? true
//        detail.Title = viewModelUser.arrUsers[indexPath.row].title ?? ""
       
        self.navigationController?.pushViewController(detail, animated: true)
    }
  
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }

}
