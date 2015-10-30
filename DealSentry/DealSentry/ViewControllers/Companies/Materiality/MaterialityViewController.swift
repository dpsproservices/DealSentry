//
// MaterialityViewController.swift
//

import UIKit

class MaterialityViewController: UIViewController {
    
    var debugUtil = DebugUtility(thisClassName: "MaterialityViewController", enabled: false)
    let sharedDataModel = SharedDataModel.sharedInstance
    let appAttributes = AppAttributes()
    var pageViewController: UIPageViewController!
    var detailViewController: DetailViewController!
    var selectedCount = 0
    
    var embeddedCompaniesViewController: CompaniesQuestionsViewController!
   
    
    var currentPageNumber = 1 // one based not zero based
    var numberOfPages = 2
    var firstPageNumber = 1
    var lastPageNumber = 2
    
    var materialityPageViewController: UIPageViewController!
    var materialityPage1ViewController: MaterialityPageViewController!
    var materialityPage2ViewController: MaterialityPageViewController!
    var materialityPage0ViewController: MaterialityPageViewController!

    
    var pageViewsArray = [MaterialityPageViewController]()
    var currentPage: MaterialityPageViewController!
    var lastPage: MaterialityPageViewController!
    var _finishedLoad = false
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            
            self.configureView()
        }
    }
    
    
    func configureView() {
        
        self.debugUtil.printLog("configureView", msg: "BEGIN")
        
        // Update the user interface for the detail item.

        
        //setLeftSplitViewButton()
        
        
        self.debugUtil.printLog("configureView", msg: "END")
    }
    
    
    override func viewDidAppear(animated: Bool) {
    //    self.debugUtil.printLog("viewDidAppear", msg: "BEGIN")
        
     }
    
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        self.initPageViewsArray()
        
        // Create the page view controller.
        self.createPageViewController()
        self.setupPageControl()
        self.pageViewController.view.frame = self.view.frame
        self.pageViewController.view.backgroundColor = appAttributes.colorBackgroundColor
        
    
        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
    override func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }
    
    
    // instantiate all the paged view controllers
    private func initPageViewControllers() {
        
        
        self.materialityPage1ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MaterialityPage1ViewController") as! MaterialityPage1ViewController
        self.materialityPage1ViewController.materialityViewController = self;
        
        
        self.materialityPage2ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MaterialityPage2ViewController") as! MaterialityPage2ViewController
        self.materialityPage2ViewController.materialityViewController = self;
        
        self.materialityPage0ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MaterialityPage0ViewController") as! MaterialityPage0ViewController
        self.materialityPage0ViewController.materialityViewController = self;
        
    }
    
    // populate the page view array the pageviewcontroller will use
    private func initPageViewsArray() {
        
        self.initPageViewControllers()
        self.pageViewsArray = [
            self.materialityPage1ViewController,
            self.materialityPage2ViewController,
            self.materialityPage0ViewController
        ]
    }
    
    
    private func createPageViewController() {
        
        self.materialityPageViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MaterialityPageViewController") as! UIPageViewController
        self.materialityPageViewController.dataSource = self
        
        self.materialityPageViewController.setViewControllers([self.materialityPage1ViewController] , direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        //
        self.pageViewController = materialityPageViewController
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        self.pageViewController!.didMoveToParentViewController(self)
        
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor(CGColor: appAttributes.colorBlue)
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.blackColor()//clearColor()
        if(self.sharedDataModel.currentTransaction.transactionCompanies.count == 0)
        {
            appearance.numberOfPages = 0//self.numberOfPages
        }
        else
        {
            appearance.numberOfPages = 2//self.numberOfPages
        }
        appearance.hidden = false
    }
    
    func getPageViewController(pageNumber: Int) -> UIViewController {
        self.debugUtil.printLog("getPageViewController", msg: "BEGIN pageNumber = " + String(self.currentPageNumber))
        
        self.debugUtil.printLog("getPageViewController", msg: "END")
        return self.pageViewsArray[pageNumber - 1] // array is zero indexed
    }
    
    func getNextPageViewController() -> UIViewController {
        self.debugUtil.printLog("getNextPageViewController", msg: "BEGIN")
        self.debugUtil.printLog("getNextPageViewController", msg: "currentPageNumber = " + String(self.currentPageNumber))
        
        let nextPageNumber = self.currentPageNumber++
        
        self.debugUtil.printLog("getNextPageViewController", msg: "next pageNumber = " + String(nextPageNumber))
        self.debugUtil.printLog("getNextPageViewController", msg: "END")
        return self.pageViewsArray[nextPageNumber - 1] // array is zero indexed
    }
    
    func getPreviousPageViewController() -> UIViewController {
        self.debugUtil.printLog("getPreviousPageViewController", msg: "BEGIN")
        self.debugUtil.printLog("getPreviousPageViewController", msg: "currentPageNumber = " + String(currentPageNumber))
        
        let previousPageNumber = self.currentPageNumber--
        
        self.debugUtil.printLog("getPreviousPageViewController", msg: "previousPageNumber = " + String(previousPageNumber))
        self.debugUtil.printLog("getPreviousPageViewController", msg: "END")
        return self.pageViewsArray[previousPageNumber - 1] // array is zero indexed
    }
    
    //whichWay is an indicator of either forward or backwards.  -1 = backwards, 1 = forwards
    func goToPage(pageNum:Int, whichWay:Int) {
        currentPageNumber  = pageNum
        self.pageViewController.dataSource = nil
        self.pageViewController.dataSource = self
        
        var _direction:UIPageViewControllerNavigationDirection
        if (whichWay<0) {
            _direction = UIPageViewControllerNavigationDirection.Reverse
        } else {
            _direction = UIPageViewControllerNavigationDirection.Forward
        }
        self.pageViewController.setViewControllers(
            [self.getPageViewController(pageNum)],
            direction: _direction,
            animated: false,
            completion: nil
        )
        
    }
    
    
    // user taps Companies button to go back to companies list
    func goToCompanies() {
    //    self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.PrimaryOverlay
//        self.splitViewController!.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
//        self.splitViewController?.navigationController!.popViewControllerAnimated(true)
       // goToPage(1, whichWay:-1)
        //var transListVC = self.splitViewController?.childViewControllers[0] as! TransactionListViewController
        //transListVC.performSegueWithIdentifier("showCompanies", sender: self)
    }
    
    // user taps Agreements button to go to Agreements view
    func goToAgreements() {
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        self.debugUtil.printLog("prepareForSegue", msg: "BEGIN")
        
        //var indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
        self.debugUtil.printLog("prepareForSegue", msg: " selectedStatus = " + self.sharedDataModel.selectedCategory)
        
        if let segueId = segue.identifier {
            
            switch segueId {
                
            case "showCompanies" :
                self.debugUtil.printLog("prepareForSegue", msg: "segueId = showCompanies template")
                //     self.embeddedCompaniesViewController = segue.destinationViewController as! CompaniesQuestionsViewController
                //    self.embeddedCompaniesViewController.detailViewController = self.detailViewController
                
            default:
                self.debugUtil.printLog("prepareForSegue", msg: "segueId = " + segueId)
                break
            }
        }
        
        self.debugUtil.printLog("prepareForSegue", msg: "END")
    }
}
extension MaterialityViewController: UIPageViewControllerDataSource {
    
    // mark - UIPageViewControllerDataSource
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    if(self.sharedDataModel.currentTransaction.transactionCompanies.count == 0)
    {
        return 0//self.numberOfPages
    }
    else
    {
        return 2//self.numberOfPages
    }
    }
    // MARK: - Page Indicator
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        if(self.sharedDataModel.currentTransaction.transactionCompanies.count == 0)
    {
        return 0//self.numberOfPages
    }
        else
    {
            return self.currentPageNumber - 1  //self.currentPageIndex
    }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        self.debugUtil.printLog("viewControllerBeforeViewController", msg: "BEGIN")
        //self.debugUtil.printLog("viewControllerBeforeViewController", msg:"Did Finish " + String(stringInterpolationSegment: self._finishedLoad))
        let currentViewController = viewController as! MaterialityPageViewController
        
      //  var returnController: MaterialityPageViewController
        switch currentViewController {
  
        case is MaterialityPage1ViewController :
            currentPageNumber = 1
            return nil//self.pageViewsArray[0]
        case is MaterialityPage2ViewController :
            currentPageNumber = 2
            return self.pageViewsArray[0]

        default :
            return currentViewController
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        //self.debugUtil.printLog("viewControllerAfterViewController", msg: "BEGIN")
        // self.debugUtil.printLog("viewControllerAfterViewController", msg:"Did Finish " + String(stringInterpolationSegment: self._finishedLoad))
        let currentViewController = viewController as! MaterialityPageViewController
        
        //var returnController: MaterialityPageViewController
        switch currentViewController {

        case is MaterialityPage1ViewController :
            currentPageNumber = 1
            return  self.pageViewsArray[1]
        case is MaterialityPage2ViewController :
            currentPageNumber = 2
            return nil//self.pageViewsArray[3]

        default :
            return currentViewController
            
        }
    }
}

extension MaterialityViewController: UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        //self.debugUtil.printLog("didFinishAnimating", msg: "BEGIN")
        if (completed) {
            self.debugUtil.printLog("didFinishAnimating", msg: "currentPageNumber = " + String(self.currentPageNumber))
        } else{
        }
        self.debugUtil.printLog("didFinishAnimating", msg:String(stringInterpolationSegment: self._finishedLoad))
        
        _finishedLoad = completed
        //self.debugUtil.printLog("didFinishAnimating", msg: "END")
    }
}
