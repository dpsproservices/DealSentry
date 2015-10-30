//
//  BusinessSelectionViewController.swift
//

import UIKit

class BusinessSelectionViewController: UIViewController {
    
    var debugUtil = DebugUtility(thisClassName: "BusinessSelectionViewController", enabled: false)
    let sharedDataModel = SharedDataModel.sharedInstance
    let appAttributes = AppAttributes()
    var pageViewController: UIPageViewController!
    var detailViewController: DetailViewController!

    
    //var currentPageIndex = 0
    
    var currentPageNumber = 1 // 1 based not zero based
    
    var numberOfPages = 4
    var firstPageNumber = 1
    var lastPageNumber = 4

 
    
    var businessSelectionPageViewController: UIPageViewController!
    var businessSelectionPage1ViewController: BusinessSelectionPageViewController!
    var businessSelectionPage2ViewController: BusinessSelectionPageViewController!
    var businessSelectionPage3ViewController: BusinessSelectionPageViewController!
    var businessSelectionPage4ViewController: BusinessSelectionPageViewController!
    var businessSelectionPage5ViewController: BusinessSelectionPageViewController!
    
    var pageViewsArray = [BusinessSelectionPageViewController]()
    var currentPage: BusinessSelectionPageViewController!
    var lastPage: BusinessSelectionPageViewController!
    var _finishedLoad = false
    
    override func viewWillAppear(animated: Bool) {
    
        self.setLastPage()
        self.setupPageControl()
    }
    override func viewDidLoad() {
        self.debugUtil.printLog("viewDidLoad", msg: "BEGIN")
        
        super.viewDidLoad()
        self.initPageViewControllers()
        // Create the page view controller.
        self.createPageViewController()
        
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
    
        self.businessSelectionPage1ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("BusinessSelectionPage1ViewController") as! BusinessSelectionPage1ViewController
        
        self.businessSelectionPage1ViewController.businessSelectionViewController = self;

        
        self.businessSelectionPage2ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("BusinessSelectionPage2ViewController") as! BusinessSelectionPage2ViewController
        
        self.businessSelectionPage2ViewController.businessSelectionViewController = self;
        
        
        self.businessSelectionPage3ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("BusinessSelectionPage3ViewController") as! BusinessSelectionPage3ViewController
        
        self.businessSelectionPage3ViewController.businessSelectionViewController = self;
        
        
        self.businessSelectionPage4ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("BusinessSelectionPage4ViewController") as! BusinessSelectionPage4ViewController
    
        self.businessSelectionPage4ViewController.businessSelectionViewController = self;
        
        
        self.businessSelectionPage5ViewController = self.storyboard!.instantiateViewControllerWithIdentifier("BusinessSelectionPage5ViewController") as! BusinessSelectionPage5ViewController
        
        self.businessSelectionPage5ViewController.businessSelectionViewController = self;
    }
   
    
    /// this method will set the last page of business selection
    /// - Buy: last page will be buy and total number of pages will be 4
    /// - Sell: last page will be sell and total number of pages will be 4
    /// - N/A: only first page will be shown
    /// - Either: User can choose between Buy/Sell in the last page
    func setLastPage(){
 
        
        // buy side / sell side M&A
        switch sharedDataModel.getBusinessType(self.sharedDataModel.currentTransaction) {
        case "Buy":
            // default show page 4 as last page rather than page 5
            //self.contentPageRestorationIds[3] = "BusinessSelectionPage4ViewController"
            self.pageViewsArray = [
                self.businessSelectionPage1ViewController,
                self.businessSelectionPage2ViewController,
                self.businessSelectionPage3ViewController,
                self.businessSelectionPage4ViewController
            ]
            self.lastPageNumber = 4
            self.numberOfPages = 4
            self.lastPage = self.businessSelectionPage4ViewController
            self.pageViewsArray[3] = self.businessSelectionPage4ViewController
        case "Sell":
            // show page 5 as last page rather than page 4
            //self.contentPageRestorationIds[3] = "BusinessSelectionPage5ViewController"
            self.pageViewsArray = [
                self.businessSelectionPage1ViewController,
                self.businessSelectionPage2ViewController,
                self.businessSelectionPage3ViewController,
                self.businessSelectionPage5ViewController
            ]
            self.lastPageNumber = 4
            self.numberOfPages = 4
            self.lastPage = self.businessSelectionPage5ViewController
            self.pageViewsArray[3] = self.businessSelectionPage5ViewController
        case "N/A":
            // show page 1 as last page
            //self.contentPageRestorationIds[3] = "BusinessSelectionPage5ViewController"
            self.pageViewsArray = [
                self.businessSelectionPage1ViewController,
  
            ]
            self.lastPageNumber = 1
            self.numberOfPages = 1
            self.lastPage = self.businessSelectionPage1ViewController
        case "Either":
            // show page 3 as last page
            //self.contentPageRestorationIds[3] = "BusinessSelectionPage5ViewController"
            self.pageViewsArray = [
                self.businessSelectionPage1ViewController,
                self.businessSelectionPage2ViewController,
                self.businessSelectionPage3ViewController,
                self.businessSelectionPage4ViewController
            ]
            self.lastPageNumber = 4
            self.numberOfPages = 4
            self.lastPage = self.businessSelectionPage4ViewController
            self.pageViewsArray[3] = self.businessSelectionPage4ViewController
        default:
                break
        }
    }
    
    private func createPageViewController() {
        
        self.businessSelectionPageViewController = self.storyboard!.instantiateViewControllerWithIdentifier("BusinessSelectionPageViewController") as! UIPageViewController
        self.businessSelectionPageViewController.dataSource = self
        
        self.businessSelectionPageViewController.setViewControllers([self.businessSelectionPage1ViewController] , direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        self.pageViewController = businessSelectionPageViewController
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        self.pageViewController!.didMoveToParentViewController(self)
        self.pageViewController.view.backgroundColor = appAttributes.colorBackgroundColor
  
    
        
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor(CGColor: appAttributes.colorBlue)
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.blackColor()//clearColor()
        
        appearance.numberOfPages = self.numberOfPages
        if numberOfPages == 1 {
            appearance.hidden = true
        } else {
            appearance.hidden = false
        }
    }
    
    func getPageViewController(pageNumber: Int) -> UIViewController {
        self.debugUtil.printLog("getPageViewController", msg: "BEGIN pageNumber = " + String(self.currentPageNumber))
        
        self.debugUtil.printLog("getPageViewController", msg: "END")
        return self.pageViewsArray[pageNumber - 1] // array is zero indexed
    }
  /*
    func getNextPageViewController() -> UIViewController {
        self.debugUtil.printLog("getNextPageViewController", msg: "BEGIN")
        self.debugUtil.printLog("getNextPageViewController", msg: "currentPageNumber = " + String(self.currentPageNumber))
        
        var nextPageNumber = self.currentPageNumber++
        
        self.debugUtil.printLog("getNextPageViewController", msg: "next pageNumber = " + String(nextPageNumber))
        self.debugUtil.printLog("getNextPageViewController", msg: "END")
        return self.pageViewsArray[nextPageNumber - 1] // array is zero indexed
    }
    
    func getPreviousPageViewController() -> UIViewController {
        self.debugUtil.printLog("getPreviousPageViewController", msg: "BEGIN")
        self.debugUtil.printLog("getPreviousPageViewController", msg: "currentPageNumber = " + String(currentPageNumber))
        
        var previousPageNumber = self.currentPageNumber--

        self.debugUtil.printLog("getPreviousPageViewController", msg: "previousPageNumber = " + String(previousPageNumber))
        self.debugUtil.printLog("getPreviousPageViewController", msg: "END")
        return self.pageViewsArray[previousPageNumber - 1] // array is zero indexed
    }
*/
    // mark - Public Methods
    
    
    // triggered manaually by button action
    func goToPreviousContentViewController() {
        
    //    if self.currentPageIndex >= 1 {
  /*
            // Get index of current view controller
            var currentViewController = self.pageViewController.viewControllers[0] as! UIViewController
            var vcRestorationID = currentViewController.restorationIdentifier
            
            self.currentPageIndex -= 1
            
            var previousViewController = self.getViewControllerAtIndex(self.currentPageIndex) as UIViewController
            
            
            var viewControllersArray = [previousViewController]
            
            self.pageViewController.setViewControllers(
                viewControllersArray,
                direction: UIPageViewControllerNavigationDirection.Reverse,
                animated: true,
                completion: nil
            )
            
      //  }*/
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
    
    func goToPreviousPage() {
  
    }

    func goToNextPage() {
     
    }
    
    
}

extension BusinessSelectionViewController: UIPageViewControllerDataSource {
    
    // mark - UIPageViewControllerDataSource
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        if self.numberOfPages == 1 {
            return 0
        }else {
            return self.numberOfPages
        }
       
    }
    // MARK: - Page Indicator
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        debugUtil.printLog("presentationIndex", msg: String(a.pageNumber))
        return self.currentPageNumber - 1  //self.currentPageIndex
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        //self.debugUtil.printLog("viewControllerBeforeViewController", msg: "BEGIN")
        //self.debugUtil.printLog("viewControllerBeforeViewController", msg:"Did Finish " + String(stringInterpolationSegment: self._finishedLoad))
        let currentViewController = viewController as! BusinessSelectionPageViewController
        
      //  var returnController: BusinessSelectionPageViewController
        switch currentViewController {

            case is BusinessSelectionPage1ViewController :
                currentPageNumber = 1
                return nil
            case is BusinessSelectionPage2ViewController :
                currentPageNumber = 2
                return self.pageViewsArray[0]
            case is BusinessSelectionPage3ViewController :
                currentPageNumber = 3
                return self.pageViewsArray[1]
            case is BusinessSelectionPage4ViewController :
                currentPageNumber = 4
               return self.pageViewsArray[2]
            case is BusinessSelectionPage5ViewController :
                currentPageNumber = 4
                return self.pageViewsArray[2]
            default :
                return currentViewController
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        //self.debugUtil.printLog("viewControllerAfterViewController", msg: "BEGIN")
       // self.debugUtil.printLog("viewControllerAfterViewController", msg:"Did Finish " + String(stringInterpolationSegment: self._finishedLoad))
        let currentViewController = viewController as! BusinessSelectionPageViewController
        
       // var returnController: BusinessSelectionPageViewController
        switch currentViewController {
            
            case is BusinessSelectionPage1ViewController :
                currentPageNumber = 1
                if numberOfPages == 1 {
                    return nil
                } else {
                    return self.pageViewsArray[1]
                }
            case is BusinessSelectionPage2ViewController :
                currentPageNumber = 2
                return  self.pageViewsArray[2]
            case is BusinessSelectionPage3ViewController :
                currentPageNumber = 3
                if numberOfPages == 3 {
                    return nil
                } else {
                    return self.pageViewsArray[3]
                }
            case is BusinessSelectionPage4ViewController :
                currentPageNumber = 4
                return nil
            case is BusinessSelectionPage5ViewController :
                currentPageNumber = 4
                return nil
            default :
                return currentViewController
            
        }
    }
}

extension BusinessSelectionViewController: UIPageViewControllerDelegate {
    
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