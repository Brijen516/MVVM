//  ViewController.swift
//  MVVM
//  Created by Brijen Patel on 06/09/21.

import UIKit
import Alamofire
import SwiftUI

class ViewController: UIViewController, UITextFieldDelegate {
   
    var filterList = [UserModel](){
        didSet{
            self.tableView.reloadData()
        }
    }
    var viewModelUser = UserViewModel()
    @IBOutlet weak var tfSearch: UITextField!
   // @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
//    var pollingList = [UserModel](){
//        didSet{
//            self.filterList = self.pollingList
//        }
//    }
//
//    var filterList = [UserModel](){
//        didSet{
//            self.tableView.reloadData()
//        }
//    }

    weak var vc: ViewController?
    var arrUsers = [UserModel]()
   
    var searching = false
    var searched = [UserModel]()
    var selected: String?
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // self.searchBar.delegate = self
       
        viewModelUser.vc = self
        
        tfSearch.delegate = self
        tfSearch.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        let nib = UINib(nibName: "userCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "userCell")
        
        tableView.estimatedRowHeight = UITableView.automaticDimension
       
        tableView.refreshControl = UIRefreshControl()
        tableView.frame = view.bounds
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        ApiCall()
        
    }
    @objc func textFieldDidChange(textField: UITextField) {
        
      
        
            searched = textField.text!.isEmpty ? arrUsers : arrUsers.filter({ (item:UserModel) -> Bool in

                return item.title?.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil) != nil
                })

                tableView.reloadData()
            }
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        searched = tfSearch.text!.isEmpty ? arrUsers : arrUsers.filter({(item: UserModel)-> Bool in
//            return item.title?.range(of: textField.text!) != nil
//
//        })
//        tableView.reloadData()
//    }
    @objc func searchChanged(_ sender : UITextField) {
        
    }
    
    func ApiCall(){
        
        AF.request("https://jsonplaceholder.typicode.com/todos/").response {
            response in
            if let data = response.data{
                do{
                    print("Fetch data")
                    let userResponse = try JSONDecoder().decode([UserModel].self, from: data)
                    self.arrUsers.append(contentsOf: userResponse)
                    self.searched = self.arrUsers
                    //self.tableView.reloadData()
                    
                    self.tableView.reloadData()
                    
                    
                }catch let err{
                    print(err.localizedDescription)
                }
            }
        }
    }
    
  
//    private func setUpSearchBar() {
//        searchBar.delegate = self
//    }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsviewcontrollerseg" {
            let DestViewController = segue.destination as! UserVC
            DestViewController.selected = selected
        }
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
         return searched.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)as! userCell
        let modelUser = searched[indexPath.row]
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
           
            let data = self.searched[indexPath.row]
            let vc = self.storyboard?.instantiateViewController(identifier: "UserVC")
                as! UserVC
            
            vc.userEdit = "1"
//            vc.context = self
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
        detail.context = searched[indexPath.row]
     
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



//extension ViewController: UISearchBarDelegate {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searched = arrUsers.filter({$0.prefix(searchText.count) == searchText.lowercased()})
//        searching = true
//        tableView.reloadData()
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searching = false
//        searchBar.text = ""
//        tableView.reloadData()
//    }
//}
