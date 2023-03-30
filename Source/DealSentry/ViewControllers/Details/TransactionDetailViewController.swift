//
//  TransactionDetailViewController.swift
//

import UIKit

class TransactionDetailViewController: UIViewController {
    
    var debugUtil = DebugUtility(thisClassName: "TransactionDetailViewController", enabled: false)
    let viewStateManager = ViewStateManager.sharedInstance
    
    var pageViewController: UIPageViewController!
    var detailViewController: DetailViewController!
    let appAttributes = AppAttributes()

    var currentPageNumber = 1 // 1 based not zero based
    var numberOfPages = 6
    var firstPageNumber = 1
    var lastPageNumber = 6
    var currentTransaction : TransactionData!
    
    var transactionDetailPageViewController: UIPageViewController!
    var transactionDetailPage1ViewController: TransactionDetailPageViewController!
    var transactionDetailPage2ViewController: TransactionDetailPageViewController!
    var transactionDetailPage3ViewController: TransactionDetailPageViewController!
    var transactionDetailPage4ViewController: TransactionDetailPageViewController!
    var transactionDetailPage5ViewController: TransactionDetailPageViewController!
    var transactionDetailPage6ViewController: TransactionDetailPageViewController!
    
    var pageViewsArray = [TransactionDetailPageViewController]()
    var currentPage: TransactionDetailPageViewController!
    var lastPage: TransactionDetailPageViewController!
    var _finishedLoad = false
    
    
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        self.initPageViewsArray()
        
        // Create the page view controller.
        self.createPageViewController()
        self.setupPageControl()
        self.pageViewController.view.frame = self.view.frame
        
        //create new Transaction
        currentTransaction  = self.viewStateManager.currentTransaction
        
        //setup detail controller for menu item changes
        self.debugUtil.printLog("viewDidLoad", msg: "END")
    }
    
    override func didReceiveMemoryWarning() {
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "BEGIN")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.debugUtil.printLog("didReceiveMemoryWarning", msg: "END")
    }

    
    /// instantiate all the paged view controllers
    private func initPageViewControllers() {
        
        self.transactionDetailPage1ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TransactionDetailPage1ViewController") as! TransactionDetailPage1ViewController
        
        self.transactionDetailPage1ViewController.transactionDetailViewController = self;
        
        
        self.transactionDetailPage2ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TransactionDetailPage2ViewController") as! TransactionDetailPage2ViewController
        
        self.transactionDetailPage2ViewController.transactionDetailViewController = self;
        
        
        self.transactionDetailPage3ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TransactionDetailPage3ViewController") as! TransactionDetailPage3ViewController
        
        self.transactionDetailPage3ViewController.transactionDetailViewController = self;
        
        
        self.transactionDetailPage4ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TransactionDetailPage4ViewController") as! TransactionDetailPage4ViewController
        
        self.transactionDetailPage4ViewController.transactionDetailViewController = self;
        
        
        self.transactionDetailPage5ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TransactionDetailPage5ViewController") as! TransactionDetailPage5ViewController
        
        self.transactionDetailPage5ViewController.transactionDetailViewController = self;
        
        self.transactionDetailPage6ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TransactionDetailPage6ViewController") as! TransactionDetailPage6ViewController
        
        self.transactionDetailPage6ViewController.transactionDetailViewController = self;

    }
    
    // populate the page view array the pageviewcontroller will use
    private func initPageViewsArray() {
        
        self.initPageViewControllers()
        
        self.pageViewsArray = [
            self.transactionDetailPage1ViewController,
            self.transactionDetailPage2ViewController,
            self.transactionDetailPage3ViewController,
            self.transactionDetailPage4ViewController,
            self.transactionDetailPage5ViewController,
            self.transactionDetailPage6ViewController
            
        ] //page 5 is only shown if certain conditions from page 1 are true
    }
    
    
    private func createPageViewController() {
        
        self.transactionDetailPageViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TransactionDetailPageViewController") as! UIPageViewController
        self.transactionDetailPageViewController.dataSource = self
        
        
        self.transactionDetailPageViewController.setViewControllers([self.transactionDetailPage1ViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        //
        self.pageViewController = transactionDetailPageViewController
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        self.pageViewController!.didMoveToParentViewController(self)
        
        if self.viewStateManager.currentTransaction.transactionDetail.dealStatus == "Terminated" {
            self.numberOfPages = 6
        } else {
            self.numberOfPages = 5
        }
        
        self.pageViewController.view.backgroundColor = appAttributes.colorBackgroundColor

        
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor(CGColor: appAttributes.colorBlue)
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.blackColor()//clearColor()
        appearance.numberOfPages = 5
        appearance.hidden = false
        //appearance.numberOfPages = self.numberOfPages
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
    
    
}

extension TransactionDetailViewController: UIPageViewControllerDataSource {
    
    // mark - UIPageViewControllerDataSource
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.numberOfPages
    }
    // MARK: - Page Indicator
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.currentPageNumber - 1  //self.currentPageIndex
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        self.debugUtil.printLog("viewControllerBeforeViewController", msg: "BEGIN")
        self.debugUtil.printLog("viewControllerBeforeViewController", msg:"Did Finish " + String(stringInterpolationSegment: self._finishedLoad))
        let currentViewController = viewController as! TransactionDetailPageViewController
        
       // var returnController: TransactionDetailPageViewController
        switch currentViewController {
            
        case is TransactionDetailPage1ViewController :
            return nil
        case is TransactionDetailPage2ViewController :
            return self.pageViewsArray[0]
        case is TransactionDetailPage3ViewController :
            return self.pageViewsArray[1]
        case is TransactionDetailPage4ViewController :
            return self.pageViewsArray[2]
        case is TransactionDetailPage5ViewController :
            return self.pageViewsArray[3]
        case is TransactionDetailPage6ViewController :
            return self.pageViewsArray[4]

        default :
            return currentViewController
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        self.debugUtil.printLog("viewControllerAfterViewController", msg: "BEGIN")
        self.debugUtil.printLog("viewControllerAfterViewController", msg:"Did Finish " + String(stringInterpolationSegment: self._finishedLoad))
        let currentViewController = viewController as! TransactionDetailPageViewController
        
       // var returnController: TransactionDetailPageViewController
        switch currentViewController {
            
        case is TransactionDetailPage1ViewController :

            return self.pageViewsArray[1]
        case is TransactionDetailPage2ViewController :
            return  self.pageViewsArray[2]
        case is TransactionDetailPage3ViewController :
            return self.pageViewsArray[3]
        case is TransactionDetailPage4ViewController :
            return self.pageViewsArray[4]
        case is TransactionDetailPage5ViewController :
            if (self.viewStateManager.currentTransaction.transactionDetail.dealStatus == "Terminated" ){//@TODO: dealStatusChangedBackwards == true
                return self.pageViewsArray[5]
            }else{
                return nil
            }
        case is TransactionDetailPage6ViewController :
            return nil
        default :
            return currentViewController
            
        }
    }
}

extension TransactionDetailViewController: UIPageViewControllerDelegate {
    
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