//
//  MyViewController.swift
//  PageBasedApp
//
//  Created by Gaurav on 22/09/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

import UIKit

class MyViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    let arrTitle = ["Page 1","Page 2","Page 3"]
    let arrPhotos = ["image1.png","image2.png","image3.png"]
    
    var pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource=self
        self.delegate=self
        
        self.setViewControllers([getViewCtrl(index: 0)] as [UIViewController], direction: .forward, animated: true, completion: nil)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY-50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.pageIndicatorTintColor=UIColor.white
        pageControl.currentPageIndicatorTintColor=UIColor.black
        pageControl.backgroundColor=UIColor.clear
        pageControl.numberOfPages=arrTitle.count
        pageControl.currentPage=0
        
        self.view.addSubview(pageControl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getViewCtrl(index:Int) -> PageContentViewController {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
        vc.strTitle = arrTitle[index]
        vc.strPhotoName = arrPhotos[index]
        vc.pageIndex = index
        
        return vc
    }
    
     func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let pgVC = viewController as! PageContentViewController
        
        var pgIndex = pgVC.pageIndex
        
        if pgIndex == NSNotFound || pgIndex == 0 {
            return nil
        }
        
        pgIndex = pgIndex!-1
        
        return getViewCtrl(index: pgIndex!)
    }
    
     func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        let pgVC = viewController as! PageContentViewController
        
        var pgIndex = pgVC.pageIndex
        
        if pgIndex == NSNotFound {
            return nil
        }
        
        pgIndex = pgIndex! + 1
        
        if pgIndex == arrPhotos.count {
            return nil
        }

        
        return getViewCtrl(index: pgIndex!)

    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let vc = pageViewController.viewControllers?[0] as! PageContentViewController
        self.pageControl.currentPage = vc.pageIndex!
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
