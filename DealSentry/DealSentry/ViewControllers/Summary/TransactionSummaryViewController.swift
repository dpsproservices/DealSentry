//
//  TransactionSummaryViewController.swift
//

import UIKit

class TransactionSummaryViewController: UIViewController {
    var debugUtil = DebugUtility(thisClassName: "TransactionSummaryViewController", enabled: false)
    let vcCon = VCConnection.sharedInstance
    let viewStateManager = ViewStateManager.sharedInstance

    var detailViewController: DetailViewController!
    let appAttributes = AppAttributes()
    let sectionTitles = ["Validations", "Detail", "Companies", "M&A", "Contacts"]
    var sections = [TableData]()
    var errorSect:TableData = TableData()

    struct TableData {
        var transData = [TransactionSummary]()
        init() {}
    }
   // @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!   
    @IBOutlet weak var transactionIdLabel: UILabel!
    @IBOutlet weak var primaryClientLabel: UILabel!
    
    @IBOutlet weak var transactionStatusLabel: UILabel!
    @IBOutlet weak var dealStatusLabel: UILabel!
    
    //@IBOutlet weak var savedOnDateLabel: UILabel!
    
    ///this method is mapped with the error image present in storybaord so that touching the error image will take the user to the respective page
    /// - Parameter sender: this paramater ensures that this method will be invoked only using button
    @IBAction func touchdown(sender: UIButton) {
        showErr(sender)
    }
    
    ///this method is mapped with the error description present in storybaord so that touching the error description will take the user to the respective page
    /// - Parameter sender: this paramater ensures that this method will be invoked only using button
    @IBAction func touchdown2(sender: UIButton) {
        showErr(sender)
    }
    
    ///this method specifies a switch case where each error will trigger a segue to their respective page
    /// - Parameter sender: this paramater ensures that this method will be invoked only using button
    func showErr(sender: UIButton) {
        self.debugUtil.printLog("touchdown", msg: "BEGIN")
        //we have to get the index from transData
        //loop through all sections (EXCEPT validation section)
         for s in self.sections {
            
            for t in s.transData {
                self.debugUtil.printLog("touchdown ", msg: String(sender.tag) + " " + String(t.errorRowIndex))
                if (sender.tag == t.errorRowIndex) {
                    switch t.errorType {
                        
                        
                    case 1 :
                        self.detailViewController.selectTab("Companies")
                       // let appDel = UIApplication.sharedApplication().delegate! as! AppDelegate
                        vcCon.masterViewController.performSegueWithIdentifier("showCompanies", sender: nil)
                    case 4 :
                        self.detailViewController.selectTab("Companies")
                      //  let appDel = UIApplication.sharedApplication().delegate! as! AppDelegate
                        vcCon.masterViewController.performSegueWithIdentifier("showCompanies", sender: nil)

                    case 2 :
                        self.detailViewController.selectTab("Details")
                        self.detailViewController.embeddedTransactionDetailViewController.goToPage(1, whichWay: 1)
                    case 3 :
                        self.detailViewController.selectTab("Details")
                        self.detailViewController.embeddedTransactionDetailViewController.goToPage(3, whichWay: 1)
                    case 5 :
                        self.detailViewController.selectTab("Companies")
                        vcCon.masterViewController.performSegueWithIdentifier("showCompanies", sender: nil)
                        self.detailViewController.embeddedMaterialityViewController.goToPage(2, whichWay: 1)
                    case 6 :
                        self.detailViewController.selectTab("Companies")
                        vcCon.masterViewController.performSegueWithIdentifier("showCompanies", sender: nil)
                       self.detailViewController.changeToMaterialityVC()
                       
                        
                    case 7, 8, 16:
                        self.detailViewController.selectTab("M&A")
                        self.detailViewController.embeddedBusinessSelectionViewController.goToPage(2, whichWay: 1)
                    case 9, 10, 17:
                        self.detailViewController.selectTab("M&A")
                        self.detailViewController.embeddedBusinessSelectionViewController.goToPage(3, whichWay: 1)
                    case 11, 12 :
                        self.detailViewController.selectTab("Contacts")
                        vcCon.masterViewController.performSegueWithIdentifier("showContacts", sender: nil)
                    case 13:
                        self.detailViewController.selectTab("Details")
                        self.detailViewController.embeddedTransactionDetailViewController.goToPage(4, whichWay: 1)
                    case 14:
                        self.detailViewController.selectTab("Details")
                        self.detailViewController.embeddedTransactionDetailViewController.goToPage(3, whichWay: 1)
                    case 15:
                        self.detailViewController.selectTab("M&A")
                        self.detailViewController.embeddedBusinessSelectionViewController.goToPage(1, whichWay: 1)
                    case 18,19:
                        self.detailViewController.selectTab("M&A")
                        self.detailViewController.embeddedBusinessSelectionViewController.goToPage(4, whichWay: 1)
                    case 20:
                        self.detailViewController.selectTab("Companies")
                        vcCon.masterViewController.performSegueWithIdentifier("showCompanies", sender: nil)
                        self.detailViewController.embeddedMaterialityViewController.goToPage(1, whichWay: 1)
                    case 21:
                        self.detailViewController.selectTab("Details")
                        self.detailViewController.embeddedTransactionDetailViewController.goToPage(5, whichWay: 1)

                    default:
                        break
                    }

                    continue
                }
            }

        }
    }
    
    ///this method specifies a switch case where each error will trigger a segue to their respective page
    /// - Parameter gesture: this paramater ensures that this method will be invoked only using tap gesture
    func showErrForlabel(gesture:UITapGestureRecognizer) {
        self.debugUtil.printLog("touchdown", msg: "BEGIN")
        //we have to get the index from transData
        //loop through all sections (EXCEPT validation section)
        for s in self.sections {
            
            for t in s.transData {
               // self.debugUtil.printLog("touchdown ", msg: String(sender.tag) + " " + String(t.errorRowIndex))
                if (gesture.view!.tag == t.errorRowIndex) {
                    switch t.errorType {
                        
                        
                    case 1 :
                        self.detailViewController.selectTab("Companies")
                        // let appDel = UIApplication.sharedApplication().delegate! as! AppDelegate
                        vcCon.masterViewController.performSegueWithIdentifier("showCompanies", sender: nil)
                    case 4 :
                        self.detailViewController.selectTab("Companies")
                        //  let appDel = UIApplication.sharedApplication().delegate! as! AppDelegate
                        vcCon.masterViewController.performSegueWithIdentifier("showCompanies", sender: nil)
                        
                    case 2 :
                        self.detailViewController.selectTab("Details")
                        self.detailViewController.embeddedTransactionDetailViewController.goToPage(1, whichWay: 1)
                    case 3 :
                        self.detailViewController.selectTab("Details")
                        self.detailViewController.embeddedTransactionDetailViewController.goToPage(3, whichWay: 1)
                    case 5 :
                        self.detailViewController.selectTab("Companies")
                        vcCon.masterViewController.performSegueWithIdentifier("showCompanies", sender: nil)
                        self.detailViewController.embeddedMaterialityViewController.goToPage(2, whichWay: 1)
                    case 6 :
                        self.detailViewController.selectTab("Companies")
                        vcCon.masterViewController.performSegueWithIdentifier("showCompanies", sender: nil)
                        self.detailViewController.changeToMaterialityVC()
                        
                    case 7, 8, 16:
                        self.detailViewController.selectTab("M&A")
                        self.detailViewController.embeddedBusinessSelectionViewController.goToPage(2, whichWay: 1)
                    case 9, 10, 17:
                        self.detailViewController.selectTab("M&A")
                        self.detailViewController.embeddedBusinessSelectionViewController.goToPage(3, whichWay: 1)
                    case 11, 12 :
                        self.detailViewController.selectTab("Contacts")
                        vcCon.masterViewController.performSegueWithIdentifier("showContacts", sender: nil)
                    case 13:
                        self.detailViewController.selectTab("Details")
                        self.detailViewController.embeddedTransactionDetailViewController.goToPage(4, whichWay: 1)
                    case 14:
                        self.detailViewController.selectTab("Details")
                        self.detailViewController.embeddedTransactionDetailViewController.goToPage(3, whichWay: 1)
                    case 15:
                        self.detailViewController.selectTab("M&A")
                        self.detailViewController.embeddedBusinessSelectionViewController.goToPage(1, whichWay: 1)
                    case 18,19:
                        self.detailViewController.selectTab("M&A")
                        self.detailViewController.embeddedBusinessSelectionViewController.goToPage(4, whichWay: 1)
                    case 20:
                        self.detailViewController.selectTab("Companies")
                        vcCon.masterViewController.performSegueWithIdentifier("showCompanies", sender: nil)
                        self.detailViewController.embeddedMaterialityViewController.goToPage(1, whichWay: 1)
                    case 21:
                        self.detailViewController.selectTab("Details")
                        self.detailViewController.embeddedTransactionDetailViewController.goToPage(5, whichWay: 1)
                        
                    default:
                        break
                    }
                    
                    continue
                }
            }
            
        }
    }


    
    //@IBOutlet weak var counterpartyLabel: UILabel!
    
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productSubLabel: UILabel!

   
    var transData = [TransactionSummary]()
    var errRowIndex = 0
    func initData() {
        errRowIndex = 0
        let ct = viewStateManager.currentTransaction

        self.sections.removeAll(keepCapacity: false)
        var sect:TableData
        sect = TableData()
        var companyRoleCount = 0
        //create a error section as a placeholder
        self.sections.append(sect)

        sect = TableData()
        errorSect = TableData()
        sect.transData.append((TransactionSummary)(label: "Clearance approved on MM/DD/YY", value: ct.clearanceApprovedDate, error: false, errorText: "", specialRow: 1))
        sect.transData.append((TransactionSummary)(label: "Fulfillment condition", value: ct.fulfillmentCondition, error: false, errorText: "", specialRow: 1))
        sect.transData.append((TransactionSummary)(label: "TRue ID", value: ct.transactionId, error: false, errorText: "", specialRow: 1))
        
        for transComp in ct.transactionCompanies
        {
            if transComp.role == "Primary Client" {
                companyRoleCount++
            }
        }
        
        if(ct.transactionCompanies.isEmpty)
        {
            if ct.primaryClient == "" {
                sect.transData.append((TransactionSummary)(label: "Primary Client", value: "", error: true, errorText: "Primary Client cant be empty", specialRow: 1, errorType: 1, errorRowIndex: errRowIndex++))
                        errorSect.transData.append((TransactionSummary)(label: "Primary Client", value: "", error: true, errorText: "Primary Client cant be empty", specialRow: 1, errorType: 1, errorRowIndex: errRowIndex++))
            } else {
                sect.transData.append((TransactionSummary)(label: "Primary Client", value: ct.primaryClient, error: false, errorText: "", specialRow: 1))
            }
        }
        
        if (!ct.transactionCompanies.isEmpty && companyRoleCount == 0) {
            sect.transData.append((TransactionSummary)(label: "Primary Client", value: "", error: true, errorText: "At least one client must be a role of Primary Client", specialRow: 1, errorType: 1, errorRowIndex: errRowIndex++))
            errorSect.transData.append((TransactionSummary)(label: "Primary Client", value: "", error: true, errorText: "At least one client must be a role of Primary Client", specialRow: 1, errorType: 1, errorRowIndex: errRowIndex++))
        }
        else {
            sect.transData.append((TransactionSummary)(label: "Primary Client", value: ct.primaryClient, error: false, errorText: "", specialRow: 1))
        }
        
        if (companyRoleCount > 1) {
            sect.transData.append((TransactionSummary)(label: "Primary Client", value: "", error: true, errorText: "Duplicate Company/Role not allowed", specialRow: 1, errorType: 1, errorRowIndex: errRowIndex++))
            errorSect.transData.append((TransactionSummary)(label: "Primary Client", value: "", error: true, errorText: "Duplicate Company/Role not allowed", specialRow: 1, errorType: 1, errorRowIndex: errRowIndex++))
        }


        
        
        
        sect.transData.append((TransactionSummary)(label: "Project Name", value: ct.transactionDetail.projectName, error: false, errorText: "", specialRow: 1))
        sect.transData.append((TransactionSummary)(label: "*Deal Status", value: ct.transactionDetail.dealStatus, error: false, errorText: "", specialRow: 1))
        sect.transData.append((TransactionSummary)(label: "*Product/SubProduct", value: ct.transactionDetail.product + "  " + ct.transactionDetail.productSub, error: false, errorText: "", specialRow: 1))
        if ct.transactionDetail.dealDescription == "" {
            sect.transData.append((TransactionSummary)(label: "*Deal Description", value: "", error: true, errorText: "Deal Description cant be empty", specialRow: 1, errorType: 2, errorRowIndex: errRowIndex++))
            errorSect.transData.append((TransactionSummary)(label: "*Deal Description", value: "", error: true, errorText: "Deal Description cant be empty", specialRow: 1, errorType: 2, errorRowIndex: errRowIndex++))
        } else {
            sect.transData.append((TransactionSummary)(label: "*Deal Description", value: ct.transactionDetail.dealDescription, error: false, errorText: "", specialRow: 1))
        }
        sect.transData.append((TransactionSummary)(label: "*Bank Role", value: ct.transactionDetail.bankRole, error: false, errorText: "", specialRow: 1))
        sect.transData.append((TransactionSummary)(label: "Offering Format", value: ct.transactionDetail.offeringFormat, error: false, errorText: "", specialRow: 1))
        sect.transData.append((TransactionSummary)(label: "Offering Format Comments", value: ct.transactionDetail.offeringFormatComments, error: false, errorText: "", specialRow: 1))
        sect.transData.append((TransactionSummary)(label: "Deal Size (USD$)", value: ct.transactionDetail.dealSize, error: false, errorText: "", specialRow: 1))
        sect.transData.append((TransactionSummary)(label: "*Use of Proceeds", value: ct.transactionDetail.useOfProceeds, error: false, errorText: "", specialRow: 1))
        sect.transData.append((TransactionSummary)(label: "Use of Proceeds Comments", value: ct.transactionDetail.useOfProceedsComments, error: false, errorText: "", specialRow: 1))
        sect.transData.append((TransactionSummary)(label: "*Loan Type", value: ct.transactionDetail.loanType, error: false, errorText: "", specialRow: 1))
        if ct.transactionDetail.expectedAnnouncementDate == "" {
            sect.transData.append((TransactionSummary)(label: "*Expected Announcement Date", value: "", error: true, errorText: "Expected announce date cant be empty", specialRow: 1, errorType: 3, errorRowIndex: errRowIndex++))
            errorSect.transData.append((TransactionSummary)(label: "*Expected Announcement Date", value: "", error: true, errorText: "Expected announce date cant be empty", specialRow: 1, errorType: 3, errorRowIndex: errRowIndex++))

        } else {
            sect.transData.append((TransactionSummary)(label: "*Expected Announcement Date", value: ct.transactionDetail.expectedAnnouncementDate, error: false, errorText: "", specialRow: 1))
        }
        sect.transData.append((TransactionSummary)(label: "*Expected Closing Date", value: ct.transactionDetail.expectedClosingDate, error: false, errorText: "", specialRow: 1))
        
        if ct.transactionDetail.product == "M&A" {
            if ct.transactionDetail.estimatedPitchDate == "" {
                sect.transData.append((TransactionSummary)(label: "Estimated Pitch Date", value: "", error: true, errorText: "Pitch Date cannot be empty", specialRow: 1, errorType: 14, errorRowIndex: errRowIndex++))
                errorSect.transData.append((TransactionSummary)(label: "Esitmated Pitch Date", value: "", error: true, errorText: "Pitch Date cannot be empty", specialRow: 1, errorType: 14, errorRowIndex: errRowIndex++))

            } else {
                sect.transData.append((TransactionSummary)(label: "Estimated Pitch Date", value: ct.transactionDetail.estimatedPitchDate,error: false, errorText: "", specialRow: 1))
            }
        }
        sect.transData.append((TransactionSummary)(label: "Financial Sponsor Involvement", value: ct.transactionDetail.hasFinancialSponsor, error: false, errorText: "", specialRow: 1))
//        if ct.transactionDetail.hasNonProfitOrganization == "" {
//            sect.transData.append((TransactionSummary)(label: "Non Profit Organization", value: "", error: true, errorText: "Must select if non profit organization", specialRow: 1, errorType: 21, errorRowIndex: errRowIndex++))
//            errorSect.transData.append((TransactionSummary)(label: "Non Profit Organization", value: "", error: true, errorText: "Must select if non profit organization", specialRow: 1, errorType: 21, errorRowIndex: errRowIndex++))
//
//        } else {
//            sect.transData.append((TransactionSummary)(label: "Non Profit Organization", value: ct.transactionDetail.hasNonProfitOrganization, error: false, errorText: "", specialRow: 1))
//        }
//        if ct.transactionDetail.hasUSGovtAffiliatedMunicipality == "" {
//            sect.transData.append((TransactionSummary)(label: "US Govt Affiliated Owned", value: "", error: true, errorText: "Must select if govt affiliated owned", specialRow: 1, errorType: 21, errorRowIndex: errRowIndex++))
//            errorSect.transData.append((TransactionSummary)(label: "US Govt Affiliated Owned", value: "", error: true, errorText: "Must select if govt affiliated owned", specialRow: 1, errorType: 21, errorRowIndex: errRowIndex++))
//
//        } else {
//            sect.transData.append((TransactionSummary)(label: "US Govt Affiliated Owned", value: ct.transactionDetail.hasUSGovtAffiliatedMunicipality, error: false, errorText: "", specialRow: 1))
//        }
//        if ct.transactionDetail.isSubjectToTakeOver == "" {
//            sect.transData.append((TransactionSummary)(label: "Fullfill independance requirement", value: "", error: true, errorText: "Independence Requirement question cant be empty", specialRow: 1, errorType: 13, errorRowIndex: errRowIndex++))
//            errorSect.transData.append((TransactionSummary)(label: "Fullfill independance requirement", value: "", error: true, errorText: "Independence Requirement question cant be empty", specialRow: 1, errorType: 13, errorRowIndex: errRowIndex++))
//
//        } else {
//            sect.transData.append((TransactionSummary)(label: "Fullfill independance requirement", value: ct.transactionDetail.isSubjectToTakeOver, error: false, errorText: "", specialRow: 1))
//        }

        sect.transData.append((TransactionSummary)(label: "Likely to Occur", value: ct.transactionDetail.likelyToTakePlace, error: false, errorText: "", specialRow: 1))
        sect.transData.append((TransactionSummary)(label: "Requests", value: ct.transactionDetail.requests, error: false, errorText: "", specialRow: 1))
        sect.transData.append((TransactionSummary)(label: "", value: "", error: false, errorText: "", specialRow: 1))
        self.sections.append(sect)
        
        
        //show Companies
        sect = TableData()
        if viewStateManager.currentTransaction.transactionCompanies.count==0 {
            sect.transData.append((TransactionSummary)(label: "", value: "", error: true, errorText: "*Company cannot be empty", specialRow: 1, errorType: 4, errorRowIndex: errRowIndex++))
            errorSect.transData.append((TransactionSummary)(label: "", value: "", error: true, errorText: "*Company cannot be empty", specialRow: 1, errorType: 4, errorRowIndex: errRowIndex++))
            sect.transData.append((TransactionSummary)(label: "", value: "", error: false, errorText: "", specialRow: 1))
        } else {
            var transCount = 0
            var comp = ""
            for trans in ct.transactionCompanies {
                comp = trans.company.companyName
                sect.transData.append((TransactionSummary)(label: "Client", value: comp, error: false, errorText: "", specialRow: 2))
                sect.transData.append((TransactionSummary)(label: "   Country", value: trans.company.country, error: false, errorText: "", specialRow: 3))
                sect.transData.append((TransactionSummary)(label: "   Franchise/Industry", value: trans.company.franchiseIndustry, error: false, errorText: "", specialRow: 3))
                sect.transData.append((TransactionSummary)(label: "   Comments", value: "", error: false, errorText: "",specialRow: 3))

                //company traded securities? -- materiality
                sect.transData.append((TransactionSummary)(label: "Materiality", value: "", error: false, errorText: "", specialRow: 2))
                if trans.materiality.isMaterial == "" {
                    sect.transData.append((TransactionSummary)(label: "   Has Materiality", value: "", error: true, errorText: "Has Material must be selected", specialRow: 3, errorType: 20, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "   Has Materiality", value: "", error: true, errorText: comp + " - Has Material must be selected", specialRow: 3, errorType: 20, errorRowIndex: errRowIndex++))

                } else {
                    sect.transData.append((TransactionSummary)(label: "   Has Materiality", value: trans.materiality.isMaterial, error: false, errorText: "", specialRow: 3))
                    
                }
                
                
                
                
                if trans.materiality.isMaterial=="Yes" {
                    if trans.materiality.isMaterialDescription == ""{
                        sect.transData.append((TransactionSummary)(label: "   Materiality Description", value: "", error: true, errorText: "Material Description cannot be empty", specialRow: 3, errorType: 20, errorRowIndex: errRowIndex++))
                        errorSect.transData.append((TransactionSummary)(label: "   Materiality Description", value: "", error: true, errorText: comp + " - Material Description cannot be empty", specialRow: 3, errorType: 20, errorRowIndex: errRowIndex++))
                    } else {
                        sect.transData.append((TransactionSummary)(label: "   Materiality Description", value: trans.materiality.isMaterialDescription, error: false, errorText: "", specialRow: 3))
                    }
                }
               
                if trans.materiality.hasPubliclyTradedSecurities == "" {
                    sect.transData.append((TransactionSummary)(label: "   Publicly Traded Securities", value: "", error: true, errorText: "Company Security Question cant be empty", specialRow: 3, errorType: 20, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "   Publicly Traded Securities", value: "", error: true, errorText: comp + " - Company Security Question cant be empty", specialRow: 3, errorType: 20, errorRowIndex: errRowIndex++))
                    
                } else {
                    sect.transData.append((TransactionSummary)(label: "   Publicly Traded Securities", value: trans.materiality.hasPubliclyTradedSecurities, error: false, errorText: "", specialRow: 3))
                }
                
                if trans.materiality.isGovtOwned == "" {
                    sect.transData.append((TransactionSummary)(label: "   Govt Owned", value: "", error: true, errorText: "Must select is government owned", specialRow: 3, errorType: 20, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "   Govt Owned", value: "", error: true, errorText: comp + " - Must select is government owned", specialRow: 3, errorType: 20, errorRowIndex: errRowIndex++))
                } else {
                    sect.transData.append((TransactionSummary)(label: "   Govt Owned", value: trans.materiality.isGovtOwned, error: false, errorText: "", specialRow: 3))
                }
                if trans.materiality.isGovtOwned == "Yes" {
                    if trans.materiality.percentOwned == "" {
                        sect.transData.append((TransactionSummary)(label: "   Percent Owned", value: "", error: true, errorText: "Percent Owned Question cant be empty", specialRow: 3, errorType: 20, errorRowIndex: errRowIndex++))
                        errorSect.transData.append((TransactionSummary)(label: "   Percent Owned", value: "", error: true, errorText: comp + " - Percent Owned Question cant be empty", specialRow: 3, errorType: 20, errorRowIndex: errRowIndex++))
                    } else {
                        sect.transData.append((TransactionSummary)(label: "   Percent Owned", value: trans.materiality.percentOwned, error: false, errorText: "", specialRow: 3))
                    }
                }
                if(!(trans.materiality.isMaterial.isEmpty || trans.materiality.isMaterial == "No")){
                if trans.materiality.hasPRC == "" {
                    sect.transData.append((TransactionSummary)(label: "   *Companies listed on PRC", value: "", error: true, errorText: "PRC Listed Companies cant be empty", specialRow: 3, errorType: 5, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "   *Companies listed on PRC", value: "", error: true, errorText: comp + " - PRC Listed Companies cant be empty", specialRow: 3, errorType: 5, errorRowIndex: errRowIndex++))
                } else {
                    sect.transData.append((TransactionSummary)(label: "   *Companies listed on PRC", value: trans.materiality.hasPRC, error: false, errorText: "", specialRow: 3))
                }
                }
                if trans.materiality.hasStandardAgreements == "" {
                    sect.transData.append((TransactionSummary)(label: "   Standard Bank Legal Agreement", value: "", error: true, errorText: "Must select if has standard agreements", specialRow: 3, errorType: 5, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "   Standard Bank Legal Agreement", value: "", error: true, errorText: comp + " - Must select if has standard agreements", specialRow: 3, errorType: 5, errorRowIndex: errRowIndex++))
                } else {
                    sect.transData.append((TransactionSummary)(label: "   Standard Bank Legal Agreement", value: trans.materiality.hasStandardAgreements, error: false, errorText: "", specialRow: 3))
                }
                sect.transData.append((TransactionSummary)(label: "   Special Circumstances", value: trans.materiality.specialCircumstances, error: false, errorText: "", specialRow: 3))
                
                
                //agreements
                if trans.agreements.count>0 {
                    sect.transData.append((TransactionSummary)(label: "Agreements", value: "", error: false, errorText: "", specialRow: 2))
                    var agreementText = ""
                    //for agreements errors.  assign the index of the agreement to label
                    for (var index = 0; index<trans.agreements.count; index++) {
                        agreementText = "Agreement #" + String(index+1) + " for: " + trans.company.companyName + " "
                        sect.transData.append((TransactionSummary)(label: agreementText, value: "", error: false, errorText: "", specialRow: 1))

                        sect.transData.append((TransactionSummary)(label: "   *Agreement Type", value: trans.agreements[index].agreementType, error: false, errorText: "", specialRow: 3))
                        if trans.agreements[index].effectiveDate == "" {
                            sect.transData.append((TransactionSummary)(label: "   *Effective Date", value: "", error: true, errorText: "Effective Date cant be empty", specialRow: 3, errorType: 6, errorRowIndex: errRowIndex++, companyIndex: transCount, agreementIndex: index))
                            errorSect.transData.append((TransactionSummary)(label: "   *Effective Date", value: "", error: true, errorText: agreementText + "Effective Date cant be empty", specialRow: 3, errorType: 6, errorRowIndex: errRowIndex++, companyIndex: transCount, agreementIndex: index))
                        } else {
                            sect.transData.append((TransactionSummary)(label: "   *Effective Date", value: trans.agreements[index].effectiveDate, error: false, errorText: "", specialRow: 3))
                        }
                        if trans.agreements[index].expirationDate == "" {
                            sect.transData.append((TransactionSummary)(label: "   *Expiration Date", value: "", error: true, errorText: "Expiration Date cant be empty", specialRow: 3, errorType: 6, errorRowIndex: errRowIndex++, companyIndex: transCount, agreementIndex: index))
                            errorSect.transData.append((TransactionSummary)(label: "   *Expiration Date", value: "", error: true, errorText: agreementText + "Expiration Date cant be empty", specialRow: 3, errorType: 6, errorRowIndex: errRowIndex++, companyIndex: transCount, agreementIndex: index))
                        } else {
                            sect.transData.append((TransactionSummary)(label: "   *Expiration Date", value: trans.agreements[index].expirationDate, error: false, errorText: "", specialRow: 3))
                        }
                        if trans.agreements[index].agreementTerms == "" {
                            sect.transData.append((TransactionSummary)(label: "   *Agreement Terms", value: "", error: true, errorText: "Agreement Terms cant be empty", specialRow: 3, errorType: 6, errorRowIndex: errRowIndex++, companyIndex: transCount, agreementIndex: index))
                            errorSect.transData.append((TransactionSummary)(label: "   *Agreement Terms", value: "", error: true, errorText: agreementText + "Agreement Terms cant be empty", specialRow: 3, errorType: 6, errorRowIndex: errRowIndex++, companyIndex: transCount, agreementIndex: index))
                        } else {
                            sect.transData.append((TransactionSummary)(label: "   *Agreement Terms", value: trans.agreements[index].agreementTerms, error: false, errorText: "", specialRow: 3))
                        }
                        if trans.agreements[index].legalReviewBy == "" {
                            sect.transData.append((TransactionSummary)(label:  "   *Legal Review By", value: "", error: true, errorText: "Legal Review by cant be empty", specialRow: 3, errorType: 6, errorRowIndex: errRowIndex++, companyIndex: transCount, agreementIndex: index))
                            errorSect.transData.append((TransactionSummary)(label:  "   *Legal Review By", value: "", error: true, errorText: agreementText + "Legal Review by cant be empty", specialRow: 3, errorType: 6, errorRowIndex: errRowIndex++, companyIndex: transCount, agreementIndex: index))
                        } else {
                            sect.transData.append((TransactionSummary)(label: "   *Legal Review By", value: trans.agreements[index].legalReviewBy, error: false, errorText: "", specialRow: 3))
                        }
                        if trans.agreements[index].exclusivityApprovedBy == "" {
                            sect.transData.append((TransactionSummary)(label: "   **Exclusivity Approved By", value: "", error: true, errorText: "Exclusivity approved by cant be empty", specialRow: 3, errorType: 6, errorRowIndex: errRowIndex++, companyIndex: transCount, agreementIndex: index))
                            errorSect.transData.append((TransactionSummary)(label: "   **Exclusivity Approved By", value: "", error: true, errorText: agreementText + "Exclusivity approved by cant be empty", specialRow: 3, errorType: 6, errorRowIndex: errRowIndex++, companyIndex: transCount, agreementIndex: index))
                        } else {
                            sect.transData.append((TransactionSummary)(label: "   **Exclusivity Approved By", value: trans.agreements[index].exclusivityApprovedBy, error: false, errorText: "", specialRow: 3))
                        }
                       
                    }
                    sect.transData.append((TransactionSummary)(label: "", value: "", error: false, errorText: "", specialRow: 1))

                } else {
                    sect.transData.append((TransactionSummary)(label: "", value: "", error: false, errorText: "", specialRow: 1))
                }
                transCount++
                
                
            }
            
            
            
        }
        self.sections.append(sect)
  
        
        //M&A goes here (business selection)
        sect = TableData()
        if (ct.transactionDetail.product == "M&A") {
            if ct.businessSelection.isDifferentCurrencies == "" {
                sect.transData.append((TransactionSummary)(label: "*Buyer/Seller different currencies", value: "", error: true, errorText: "Buyer / Seller Question cannot be empty", specialRow: 1, errorType: 15, errorRowIndex: errRowIndex++))
                errorSect.transData.append((TransactionSummary)(label: "*Buyer/Seller different currencies", value: "", error: true, errorText: "Buyer / Seller Question cannot be empty", specialRow: 1, errorType: 15, errorRowIndex: errRowIndex++))
            } else {
                sect.transData.append((TransactionSummary)(label: "*Buyer/Seller different currencies", value: ct.businessSelection.isDifferentCurrencies, error: false, errorText: "", specialRow: 1))
            }
            if ct.businessSelection.isUKCompanyInvolved == "" {
                sect.transData.append((TransactionSummary)(label: "*UK Public Company involved", value: "", error: true, errorText: "UK Public Company involvement cannot be empty", specialRow: 1, errorType: 15, errorRowIndex: errRowIndex++))
                errorSect.transData.append((TransactionSummary)(label: "*UK Public Company involved", value: "", error: true, errorText: "UK Public Company involvement cannot be empty", specialRow: 1, errorType: 15, errorRowIndex: errRowIndex++))
            } else {
                sect.transData.append((TransactionSummary)(label: "*UK Public Company involved", value: ct.businessSelection.isUKCompanyInvolved, error: false, errorText: "", specialRow: 1))
            }
            if ct.businessSelection.isFriendlyOrHostile == "" {
                sect.transData.append((TransactionSummary)(label: "*Friendly or Hostile Deal", value: "", error: true, errorText: "Friendly/Hostile Deal cannot be empty", specialRow: 1, errorType: 15, errorRowIndex: errRowIndex++))
                errorSect.transData.append((TransactionSummary)(label: "*Friendly or Hostile Deal", value: "", error: true, errorText: "Friendly/Hostile Deal cannot be empty", specialRow: 1, errorType: 15, errorRowIndex: errRowIndex++))
            } else {
                sect.transData.append((TransactionSummary)(label: "*Friendly or Hostile Deal", value: ct.businessSelection.isFriendlyOrHostile, error: false, errorText: "", specialRow: 1))
            }
            if ct.businessSelection.isDownwardRatingsLikely == "" {
                sect.transData.append((TransactionSummary)(label: "*Likely Downward Ratings Change", value: "", error: true, errorText: "Downward Ratings change cannot be empty", specialRow: 1, errorType: 15, errorRowIndex: errRowIndex++))
                errorSect.transData.append((TransactionSummary)(label: "*Likely Downward Ratings Change", value: "", error: true, errorText: "Downward Ratings change cannot be empty", specialRow: 1, errorType: 15, errorRowIndex: errRowIndex++))
            } else {
                sect.transData.append((TransactionSummary)(label: "*Likely Downward Ratings Change", value: ct.businessSelection.isDownwardRatingsLikely, error: false, errorText: "", specialRow: 1))
            }
            if ct.businessSelection.isGovernmentAgency == "" {
                sect.transData.append((TransactionSummary)(label: "*Client a Govt Agency", value: "", error: true, errorText: "Govt Agency cannot be empty", specialRow: 1, errorType: 15, errorRowIndex: errRowIndex++))
                errorSect.transData.append((TransactionSummary)(label: "*Client a Govt Agency", value: "", error: true, errorText: "Govt Agency cannot be empty", specialRow: 1, errorType: 15, errorRowIndex: errRowIndex++))
            } else {
                sect.transData.append((TransactionSummary)(label: "*Client a Govt Agency", value: ct.businessSelection.isGovernmentAgency, error: false, errorText: "", specialRow: 1))
            }
            
            
            if self.viewStateManager.getBusinessType(ct) == "Buy" || self.viewStateManager.getBusinessType(ct) == "Sell" || self.viewStateManager.getBusinessType(ct) == "Either" {
                
                if ct.businessSelection.isConsolidatedBankingOpportunity == "" {
                    sect.transData.append((TransactionSummary)(label: "*Benefit consolidated opportunities", value: "", error: true, errorText: "Must select a Benefit consolidated opportunity", specialRow: 1, errorType: 16, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "*Benefit consolidated opportunities", value: "", error: true, errorText: "Must select a Benefit consolidated opportunity", specialRow: 1, errorType: 16, errorRowIndex: errRowIndex++))
                } else {
                    sect.transData.append((TransactionSummary)(label: "*Benefit consolidated opportunities", value: ct.businessSelection.isConsolidatedBankingOpportunity, error: false, errorText: "", specialRow: 1))
                }
                if ct.businessSelection.consolidatedBankingOpportunityDescription == "" && ct.businessSelection.isConsolidatedBankingOpportunity == "Yes"{
                    sect.transData.append((TransactionSummary)(label: "*Benefit opportunity description", value: "", error: true, errorText: "Opportunity Description cant be empty", specialRow: 1, errorType: 7, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "*Benefit opportunity description", value: "", error: true, errorText: "Opportunity Description cant be empty", specialRow: 1, errorType: 7, errorRowIndex: errRowIndex++))
                } else {
                    sect.transData.append((TransactionSummary)(label: "*Benefit opportunity description", value: ct.businessSelection.consolidatedBankingOpportunityDescription, error: false, errorText: "", specialRow: 1))
                }
                if ct.businessSelection.isInvestmentOpportunity == "" {
                    sect.transData.append((TransactionSummary)(label: "*Short/Medium term options benefit", value: "", error: true, errorText: "Must select if short medium term benefit", specialRow: 1, errorType: 16, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "*Short/Medium term options benefit", value: "", error: true, errorText: "Must select if short medium term benefit", specialRow: 1, errorType: 16, errorRowIndex: errRowIndex++))
                } else {
                    sect.transData.append((TransactionSummary)(label: "*Short/Medium term options benefit", value: ct.businessSelection.isInvestmentOpportunity, error: false, errorText: "", specialRow: 1))
                }
                
                if ct.businessSelection.investmentOpportunityDescription == "" && ct.businessSelection.isInvestmentOpportunity == "Yes"{
                    sect.transData.append((TransactionSummary)(label: "*Short/Medium opportunity description", value: "", error: true, errorText: "Investment opportunity desc cant be empty", specialRow: 1, errorType: 8, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "*Short/Medium opportunity description", value: "", error: true, errorText: "Investment opportunity desc cant be empty", specialRow: 1, errorType: 8, errorRowIndex: errRowIndex++))
                } else {
                    sect.transData.append((TransactionSummary)(label: "*Short/Medium opportunity description", value: ct.businessSelection.investmentOpportunityDescription, error: false, errorText: "", specialRow: 1))
                }
               
                if ct.businessSelection.isServicesOpportunity == "" {
                    sect.transData.append((TransactionSummary)(label: "*Transfer agent services", value: "", error: true, errorText: "Must select if transfer agent services", specialRow: 1, errorType: 17, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "*Transfer agent services", value: "", error: true, errorText: "Must select if transfer agent services", specialRow: 1, errorType: 17, errorRowIndex: errRowIndex++))
                } else {
                    sect.transData.append((TransactionSummary)(label: "*Transfer agent services", value: ct.businessSelection.isServicesOpportunity, error: false, errorText: "", specialRow: 1))
                }
                if ct.businessSelection.servicesOpportunityDescription == "" && ct.businessSelection.isServicesOpportunity == "Yes"{
                    sect.transData.append((TransactionSummary)(label: "*Services opportunity description", value: "", error: true, errorText: "Services opportunity desc cant be empty", specialRow: 1, errorType: 9, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "*Services opportunity description", value: "", error: true, errorText: "Services opportunity desc cant be empty", specialRow: 1, errorType: 9, errorRowIndex: errRowIndex++))
                } else {
                    sect.transData.append((TransactionSummary)(label: "*Services opportunity description", value: ct.businessSelection.servicesOpportunityDescription, error: false, errorText: "", specialRow: 1))
                }
                
                if ct.businessSelection.toIncludeCash == "" {
                    sect.transData.append((TransactionSummary)(label: "To include cash", value: "", error: true, errorText: "Must select if include cash", specialRow: 1, errorType: 17, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "To include cash", value: "", error: true, errorText: "Must select if include cash", specialRow: 1, errorType: 17, errorRowIndex: errRowIndex++))
                } else {
                    sect.transData.append((TransactionSummary)(label: "To include cash", value: ct.businessSelection.toIncludeCash, error: false, errorText: "", specialRow: 1))
                }
                
                if ct.businessSelection.toIncludeStock == ""{
                    sect.transData.append((TransactionSummary)(label: "To include stock", value: "", error: true, errorText: "Must select if include stock", specialRow: 1, errorType: 17, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "To include stock", value: "", error: true, errorText: "Must select if include stock", specialRow: 1, errorType: 17, errorRowIndex: errRowIndex++))
                } else {
                    sect.transData.append((TransactionSummary)(label: "To include stock", value: ct.businessSelection.toIncludeStock, error: false, errorText: "", specialRow: 1))
                }
                if ct.businessSelection.toIncludeStock == ""{
                    sect.transData.append((TransactionSummary)(label: "To include other", value: "", error: true, errorText: "Must select if include other", specialRow: 1, errorType: 17, errorRowIndex: errRowIndex++))
                    errorSect.transData.append((TransactionSummary)(label: "To include other", value: "", error: true, errorText: "Must select if include other", specialRow: 1, errorType: 17, errorRowIndex: errRowIndex++))
                } else {
                    sect.transData.append((TransactionSummary)(label: "To include other", value: ct.businessSelection.toIncludeStock, error: false, errorText: "", specialRow: 1))
                }
                if ct.businessSelection.toIncludeOther == "Yes"{
                    if ct.businessSelection.pleaseExplain == "" {
                        sect.transData.append((TransactionSummary)(label: "Other Consideration Description", value: "", error: true, errorText: "Other Consideration description cant be empty", specialRow: 1, errorType: 10, errorRowIndex: errRowIndex++))
                        errorSect.transData.append((TransactionSummary)(label: "Other Consideration Description", value: "", error: true, errorText: "Other Consideration description cant be empty", specialRow: 1, errorType: 10, errorRowIndex: errRowIndex++))
                    } else {
                        sect.transData.append((TransactionSummary)(label: "Other Consideration Description", value: ct.businessSelection.pleaseExplain, error: false, errorText: "", specialRow: 1))
                    }
                }
                
                //buy or sell side
//                if self.viewStateManager.getBusinessType(ct) == "Buy" {
//                    if ct.businessSelection.hasDerivativesExposure == ""{
//                        sect.transData.append((TransactionSummary)(label: "Material Derivatives exposure", value: "", error: true, errorText: "Must select Material Derivatives exposure", specialRow: 1, errorType: 18, errorRowIndex: errRowIndex++))
//                        errorSect.transData.append((TransactionSummary)(label: "Material Derivatives exposure", value: "", error: true, errorText: "Must select Material Derivatives exposure", specialRow: 1, errorType: 18, errorRowIndex: errRowIndex++))
//                    } else {
//                        sect.transData.append((TransactionSummary)(label: "Material Derivatives exposure", value: ct.businessSelection.hasDerivativesExposure, error: false, errorText: "", specialRow: 1))
//                    }
//                    if ct.businessSelection.hasDerivativesExposure == ""{
//                        sect.transData.append((TransactionSummary)(label: "Commodities exposure", value: "", error: true, errorText: "Must select Commodities Derivatives exposure", specialRow: 1, errorType: 18, errorRowIndex: errRowIndex++))
//                        errorSect.transData.append((TransactionSummary)(label: "Commodities exposure", value: "", error: true, errorText: "Must select Commodities Derivatives exposure", specialRow: 1, errorType: 18, errorRowIndex: errRowIndex++))
//                    } else {
//                        sect.transData.append((TransactionSummary)(label: "Commodities exposure", value: ct.businessSelection.hasCommoditiesExposure, error: false, errorText: "", specialRow: 1))
//                    }
//                
//                }else 
                if self.viewStateManager.getBusinessType(ct) == "Sell" ||  self.viewStateManager.currentTransaction.businessSelection.businessSelectionTypeForEither == "Sell" {
//                    if ct.businessSelection.hasWealthManagementOpportunity == "" {
//                        sect.transData.append((TransactionSummary)(label: "Wealth Management Opportunities", value: "", error: true, errorText: "Must select Wealth Management Opportunity", specialRow: 1, errorType: 19, errorRowIndex: errRowIndex++))
//                        errorSect.transData.append((TransactionSummary)(label: "Wealth Management Opportunities", value: "", error: true, errorText: "Must select Wealth Management Opportunity", specialRow: 1, errorType: 19, errorRowIndex: errRowIndex++))
//                    } else {
//                        sect.transData.append((TransactionSummary)(label: "Wealth Management Opportunities", value: ct.businessSelection.hasWealthManagementOpportunity, error: false, errorText: "", specialRow: 1))
//                    }
                    if ct.businessSelection.wealthManagementOpportunity == "" && ct.businessSelection.hasWealthManagementOpportunity == "Yes"{
                        sect.transData.append((TransactionSummary)(label: "Wealth Man. Description", value: "", error: true, errorText: "Wealth Management Desc. cannot be empty", specialRow: 1, errorType: 19, errorRowIndex: errRowIndex++))
                        errorSect.transData.append((TransactionSummary)(label: "Wealth Man. Description", value: "", error: true, errorText: "Wealth Management Desc. cannot be empty", specialRow: 1, errorType: 19, errorRowIndex: errRowIndex++))
                    } else {
                        sect.transData.append((TransactionSummary)(label: "Wealth Man. Description", value: ct.businessSelection.wealthManagementOpportunity, error: false, errorText: "", specialRow: 1))
                    }
                    
                }
                
                
            }
            sect.transData.append((TransactionSummary)(label: "", value: "", error: false, errorText: "", specialRow: 1))
            
            
          
        }
        self.sections.append(sect)
        
        //contacts
        sect = TableData()
        var mdRoleCount = 0
        var crossSellCount = 0
        for trans in ct.transactionContacts {
            sect.transData.append((TransactionSummary)(label: "Name", value: trans.contact.firstName + " " + trans.contact.lastName, error: false, errorText: "", specialRow: 3))
            sect.transData.append((TransactionSummary)(label: "Role", value: trans.role, error: false, errorText: "", specialRow: 3))
            sect.transData.append((TransactionSummary)(label: "Phone", value: trans.contact.phone, error: false, errorText: "", specialRow: 3))
            sect.transData.append((TransactionSummary)(label: "DPT", value: trans.contact.department, error: false, errorText: "", specialRow: 3))
            sect.transData.append((TransactionSummary)(label: "Email", value: trans.contact.email, error: false, errorText: "", specialRow: 3))
            sect.transData.append((TransactionSummary)(label: "", value: "", error: false, errorText: "", specialRow: 1))
            if (trans.role=="Sponsoring MD") {
                mdRoleCount++
            }
            if (trans.contact.crossSellDesignee) {
                crossSellCount++
            }
            
        }
        if (mdRoleCount == 0) {
//            sect.transData.append( (TransactionSummary)(label: "", value: "", error: true, errorText: "At least one Sponsoring MD role is required", specialRow: 1, errorType: 11, errorRowIndex: errRowIndex++))
            errorSect.transData.append( (TransactionSummary)(label: "", value: "", error: true, errorText: "At least one Sponsoring MD role is required", specialRow: 1, errorType: 11, errorRowIndex: errRowIndex++))

        }
       
        
        if (mdRoleCount > 1 ) {
//            sect.transData.append( (TransactionSummary)(label: "", value: "", error: true, errorText: "Duplicate Sponsoring MD role not allowed", specialRow: 1, errorType: 11, errorRowIndex: errRowIndex++))
            errorSect.transData.append( (TransactionSummary)(label: "", value: "", error: true, errorText: "Duplicate Sponsoring MD role not allowed", specialRow: 1, errorType: 11, errorRowIndex: errRowIndex++))
            
        }
       
        
        if (crossSellCount == 0 && viewStateManager.currentTransaction.transactionDetail.product == "M&A") {
//            sect.transData.append((TransactionSummary)(label: "", value: "", error: true, errorText: "At least one Cross Sell Designee is required", specialRow: 1, errorType: 12, errorRowIndex: errRowIndex++))
            errorSect.transData.append((TransactionSummary)(label: "", value: "", error: true, errorText: "At least one Cross Sell Designee is required", specialRow: 1, errorType: 12, errorRowIndex: errRowIndex++))
        }
       
        self.sections.append(sect)
        
        //fill in validations
//        self.sections.append(sect)
        if errRowIndex > 0 {
            errorSect.transData.append((TransactionSummary)(label: "", value: "", error: false, errorText: "", specialRow: 1))
        }
        self.sections[0]  = errorSect

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.initData()
        self.tableView.reloadData()

    }
    

    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.layer.backgroundColor = (appAttributes.colorBackgroundColor).CGColor

        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
  //override func view
    override   func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }
    
    override    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        let segueId = segue.identifier
        self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId!)
        self.debugUtil.printLog("prepareForSegue", msg: "END")
    }

}
extension TransactionSummaryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // self.debugUtil.printLog("numberRowsSection", msg: String(self.viewStateManager.currentTransaction.transactionCompanies.count))
        //self.debugUtil.printLog("numberRowsSection", msg: String(sections[section].transData.count))
        if sections.count == 0 {
            return 0
        } else {
            return sections[section].transData.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
  //  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //}
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if sections.count == 0 || (section==3 && self.sections[3].transData.count == 0) {
        //if section < 5 && self.sections[section].transData.count == 0 {
            return nil
        } else {
            
            let header : UITableViewCell = UITableViewCell()
            header.textLabel!.font = UIFont.boldSystemFontOfSize(20.0)
            header.textLabel!.textColor = UIColor.whiteColor()
            header.textLabel!.text = self.sectionTitles[section]
            header.contentView.backgroundColor = UIColor(CGColor:appAttributes.colorCyan)//UIColor.lightGrayColor()
            return header
        }

    }
    

    // set the custom Prototype table view cell data labels
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //var index = String(indexPath.row)
        
    //    self.debugUtil.printLog("cellForRowAtIndexPath", msg: "BEGIN indexPath.row = " + index)
        if indexPath.section == 0  {
            let companyErrCell: TransactionSummaryCompanyErrorCell = tableView.dequeueReusableCellWithIdentifier("TransactionSummaryCompanyErrorCell", forIndexPath: indexPath) as! TransactionSummaryCompanyErrorCell
            
            
            let cellCompany = self.errorSect.transData[indexPath.row]
            self.debugUtil.printLog("cellForRowAtIndexPath-ERR", msg: "BEGIN  indexPath.row" + String(indexPath.row) + " set:" + String(indexPath.section) + " ERRIndex:" + String(cellCompany.errorRowIndex))
            
            //companyErrCell.transField.text = cellCompany.label
            if (cellCompany.error) {
                companyErrCell.warningImageView.hidden = false
                companyErrCell.warningImageView.tag = cellCompany.errorRowIndex
                companyErrCell.transValue.text = cellCompany.errorText
                companyErrCell.transValue.tag = cellCompany.errorRowIndex
                let tapgesture = UITapGestureRecognizer(target: self, action:Selector ("showErrForlabel:"))
                companyErrCell.transValue.addGestureRecognizer(tapgesture)
                
            } else {
                
                companyErrCell.warningImageView.hidden = true
                companyErrCell.transValue.text = cellCompany.value
                
            }
            companyErrCell.backgroundColor = appAttributes.colorBackgroundColor

             return companyErrCell
        } else {
            let companyCell: TransactionSummaryCompanyCell = tableView.dequeueReusableCellWithIdentifier("TransactionSummaryCompanyCell", forIndexPath: indexPath) as! TransactionSummaryCompanyCell
            
            let cellCompany = sections[indexPath.section].transData[indexPath.row]
            
            self.debugUtil.printLog("cellForRowAtIndexPath", msg: "BEGIN  indexPath.row" + String(indexPath.row) + " set:" + String(indexPath.section) + " ERRIndex:" + String(cellCompany.errorRowIndex))
            
            if cellCompany.specialRow == 1 {
                companyCell.backgroundColor = appAttributes.colorBackgroundColor
            } else if cellCompany.specialRow == 2{
                companyCell.backgroundColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
            } else if cellCompany.specialRow == 3 {
                companyCell.backgroundColor = UIColor(red: 252.0/255.0, green: 252.0/255.0, blue: 250.0/255.0, alpha: 1.0)
            }
            //    companyCell.textLabel!.lineBreakMode = NSLineBreakMode
            
            companyCell.transField.text = cellCompany.label
            companyCell.textLabel!.numberOfLines = 0
            if (cellCompany.error) {
                companyCell.warningImageView.hidden = false
                companyCell.warningImageView.tag = cellCompany.errorRowIndex
                companyCell.transValue.text = cellCompany.errorText
                companyCell.transValue.tag = cellCompany.errorRowIndex
                let tapgesture = UITapGestureRecognizer(target: self, action:Selector ("showErrForlabel:"))
                companyCell.transValue.addGestureRecognizer(tapgesture)
            } else {
                
                companyCell.warningImageView.hidden = true
                companyCell.transValue.text = cellCompany.value
                
            }
            
            
            return companyCell
        }
        
    
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
      //  var index = String(indexPath.row)
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
     return 40
        //return UITableViewAutomaticDimension
    }
    
   
    
    
}
