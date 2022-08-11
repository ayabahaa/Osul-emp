//
//  ContractSettingVC.swift
//  AL-HHALIL
//
//  Created by Sayed Abdo && Aya Bahaa on 7/21/20.
//  Copyright © 2020 Sayed Abdo && Aya Bahaa. All rights reserved.
//

import UIKit
import JSSAlertView
import TransitionButton

class ContractSettingVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addContractView: UIView!
    
    //MARK: - Properties
    var refreshControl = UIRefreshControl()
    var contract : Contracts?
    
    //status views
    var loaderView = UIView()
    var noDataView = UIView()
    var refresDatahBtn = TransitionButton()
    var refreshInterNetBtn = TransitionButton()
    var noInterNetView = UIView()
    var errorView = UIView()
    var refreshErrorBtn = TransitionButton()
    var addFBtn = TransitionButton()

    //MARK: - View Controller Builder
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   }
   override func viewWillAppear(_ animated: Bool) {
       config()
   }
   func config(){
       addAllViews()
       self.tableView.delegate = self
       self.tableView.dataSource = self
       tableView.registerHeaderNib(cellClass: phaseTitleCell.self)
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addContract))
       addContractView.addGestureRecognizer(tap)
       refreshControl.addTarget(self, action: #selector(get_all_contracts), for: UIControl.Event.valueChanged)
       tableView.addSubview(refreshControl)
       addFBtn.addTarget(self, action: #selector(addContract), for: UIControl.Event.touchUpInside)
       get_all_contracts()
       self.getTokenReq()
   }

    @objc func addContract (){
        let view = self.storyboard?.instantiateViewController(withIdentifier: "EditContractSettingVC") as! EditContractSettingVC
        view.newContract = true
        hideAllViews()
        self.navigationController?.pushViewController(view, animated: true)
    }
}
//MARK: - table View protocol methods
extension ContractSettingVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "phaseTitleCell") as! phaseTitleCell
           return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contract?.data.count ?? 0 
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "phaseSettingCell", for: indexPath) as! phaseSettingCell
            cell.typeLabel.text = contract?.data[indexPath.row].title
            cell.numberLabel.text = "\(indexPath.row + 1)"
            let color = UIColor(hexString: (contract?.data[indexPath.row].color)!)
            cell.colorLabel.backgroundColor = color
            cell.selectAction = {
                let view = self.storyboard?.instantiateViewController(withIdentifier: "EditContractSettingVC") as! EditContractSettingVC
                view.newContract = false
                view.id = self.contract?.data[indexPath.row].id ?? ""
                self.navigationController?.pushViewController(view, animated: true)
            }
            return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
//MARK: - Request
extension ContractSettingVC{
    @objc func get_all_contracts(){
        startAllAnimationBtn()
        if Reachability.connectedToNetwork() {
            NetworkClient.performRequest(Contracts.self, router: .get_all_contracts, success: { [weak self] (models) in
                self?.contract = models
                self?.refreshControl.endRefreshing()
                if(models.status == 1){
                    self?.tableView.reloadData()
                    self?.hideAllViews()
                }
                else if (models.status == 0 ){
                    self?.hideAllViews()
                    self?.noDataView.isHidden = false
                    self?.refresDatahBtn.addTarget(self, action: #selector(self?.get_all_contracts), for: UIControl.Event.touchUpInside)
                }
            }){ [weak self] (error) in
                    self?.hideAllViews()
                    self?.errorView.isHidden = false
                    self?.refreshErrorBtn.addTarget(self, action: #selector(self?.get_all_contracts), for: UIControl.Event.touchUpInside)
                }
        }else{
                    hideAllViews()
                    noInterNetView.isHidden = false
                    self.refreshInterNetBtn.addTarget(self, action: #selector(self.get_all_contracts), for: UIControl.Event.touchUpInside)
        }
    }
}
//MARK: - Loader
extension ContractSettingVC {
    func addAllViews(){
        self.errorView(mainNoDataView : &self.errorView, refreshBtn : &self.refreshErrorBtn)
        self.noInterNetView(mainNoDataView : &self.noInterNetView, refreshBtn :  &self.refreshInterNetBtn)
        self.noDataView(mainNoDataView: &self.noDataView, labelData: "لا توجد عقود حاليا", refreshBtn: &self.refresDatahBtn, addStatus : 0, addFBtn : &addFBtn)
        self.showLoader(mainView: &loaderView)
        
        startAllAnimationBtn()
    }
    func hideAllViews(){
        self.hideLoader(mainView: &self.loaderView)
        self.hideNoDataView( mainNoDataView : &self.noDataView)
        self.hideNoInterNetView( mainNoInterNetView : &self.noInterNetView)
        self.hideErrorView( mainNoInterNetView : &self.errorView)
        self.getTokenReq()
        stopAllAnimationBtn()
    }
    func stopAllAnimationBtn(){
        self.refresDatahBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 2, completion:nil)
        self.refreshErrorBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 2, completion:nil)
        self.refreshInterNetBtn.stopAnimation(animationStyle: .shake, revertAfterDelay: 2, completion:nil)
    }
    func startAllAnimationBtn(){
        refreshInterNetBtn.startAnimation()
        refresDatahBtn.startAnimation()
        refreshErrorBtn.startAnimation()
    }
}
