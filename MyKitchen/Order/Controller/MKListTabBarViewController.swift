//
//  MKListTabBarViewController.swift
//  MyKitchen
//
//  Created by wochu on 15/12/17.
//  Copyright © 2015年 @Wochu. All rights reserved.
//

import UIKit

let TagOffset : NSInteger = 1000

protocol MKListTabBarControllerDelegate
{
    func mk_tabBarController(tabBarController : MKListTabBarViewController , shouldSelectedViewController : UIViewController, index : NSInteger) ->Bool
    func mk_tabBarController(tabBarController : MKListTabBarViewController, didSelecteViewController : UIViewController, index : NSInteger)
    func reloadTabButtons()
}

class MKListTabBarViewController: MKBaseViewController {
    
    var _viewListControllers : Array<UIViewController> = []
    var viewListControllers : Array<UIViewController>  {
        get{
            return _viewListControllers
        }
        set(newViewListControllers){
            btnCount = newViewListControllers.count
            
            let oldSelecteViewController : UIViewController? = self.selectedViewController
            for viewController : UIViewController in _viewListControllers
            {
                viewController.willMoveToParentViewController(nil)
                viewController.removeFromParentViewController()
            }
            
            _viewListControllers = newViewListControllers
            
            if  oldSelecteViewController == nil{
                return
            }
            
            let newIndex : NSInteger = _viewListControllers.indexOf(oldSelecteViewController!)!
            
            if newIndex != NSNotFound{
                self.selectedIndex = newIndex
            }
            else if newIndex < _viewListControllers.count{
                self.selectedIndex = newIndex
            }else{
                self.selectedIndex = 0
            }
            
            for viewController : UIViewController in _viewListControllers
            {
                self.addChildViewController(viewController)
                viewController.didMoveToParentViewController(self)
            }
            
            if self.isViewLoaded(){
                self.reloadTabButtons()
            }
        }
    }
    
    var _selectedViewController : UIViewController?
    var selectedViewController : UIViewController?{
        get{
            return _selectedViewController
        }
        set(newSelectedViewController){
            self.selectedViewController(newSelectedViewController!)
        }
    }
    var _selectedIndex : NSInteger = 0
    var selectedIndex : NSInteger{
        get{
            return _selectedIndex
        }
        set(newSelectedIndex)
        {
            _selectedIndex = newSelectedIndex
        }
    }
    var selectedColor : UIColor?
    var delegate : MKListTabBarControllerDelegate?

    
    private var tabButtonsContainerView : UIView?
    private var contentContainerView : UIView?
    private var indicatorView : UIView?
    private var btnCount : NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.selectedColor == nil{
            self.selectedColor = RGB(239, G: 103, B: 38, alpha: 1.0)
        }
        self.edgesForExtendedLayout = UIRectEdge.None
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight , UIViewAutoresizing.FlexibleWidth]
        var rect : CGRect = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.tabBarHeight)
        tabButtonsContainerView = UIView(frame: rect)
        tabButtonsContainerView?.backgroundColor = UIColor.whiteColor()
        tabButtonsContainerView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(tabButtonsContainerView!)
        
        
        rect.origin.y = self.tabBarHeight
        rect.size.height = self.view.bounds.size.height - self.tabBarHeight
        contentContainerView = UIView(frame: rect)
        contentContainerView?.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        self.view .addSubview(contentContainerView!)
        
        indicatorView = UIView(frame: CGRectMake(0.0, tabButtonsContainerView!.frame.size.width - 2.0 ,floor(CGFloat(rect.size.width) / CGFloat(btnCount)) , 2.0))
        indicatorView?.layer.cornerRadius = 5.0
        indicatorView?.backgroundColor = self.selectedColor
        self.view.addSubview(indicatorView!)
        
        let splitLine : UIView = UIView(frame:  CGRectMake(0.0, CGRectGetMaxY(tabButtonsContainerView!.frame),self.view.frame.width, 1.0))
        splitLine.alpha = 0.2
        splitLine.backgroundColor = UIColor.grayColor()
        self.view.addSubview(splitLine)
        
        self.reloadTabButtons()
    }
    
    func viewWillLayOutSubViews()
    {
        super.viewWillLayoutSubviews()
        self.layoutTabButtons()
    }
    
    override func shouldAutorotate() -> Bool {
        
        for viewController : UIViewController in self.viewListControllers
        {
            if viewController.shouldAutorotate() != true
            {
                return false
            }
        }
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        if self.isViewLoaded() &&  self.view.window == nil
        {
            self.view = nil
            tabButtonsContainerView = nil
            contentContainerView = nil
            indicatorView = nil
        }
    }
    
    func reloadTabButtons()
    {
        self.removeTabButtons()
        self.addTabButtons()
     
        let lastIndex : NSInteger = _selectedIndex
        _selectedIndex = NSNotFound
        self.selectedIndex = lastIndex
    }
    
    func addTabButtons()
    {
        var index : NSInteger = 0
        for viewController : UIViewController in self.viewListControllers
        {
            let button : UIButton = UIButton(type: UIButtonType.Custom)
            button.tag = TagOffset + index
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.titleLabel?.shadowOffset = CGSizeMake(0.0, 1.0)
            
            let offset : UIOffset = viewController.tabBarItem.titlePositionAdjustment
            button.titleEdgeInsets = UIEdgeInsetsMake( offset.vertical,offset.horizontal, 0, 0)
            button.imageEdgeInsets = viewController.tabBarItem.imageInsets
            button.setTitle(viewController.tabBarItem.title, forState: UIControlState.Normal)
            button.setImage(viewController.tabBarItem.image, forState: UIControlState.Normal)
            button.addTarget(self, action: "tabButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            self.deselectTabButton(button)
            tabButtonsContainerView?.addSubview(button)
            ++index
        }
        self.layoutTabButtons()
    }
    
    func layoutTabButtons(){
        var index : NSInteger = 0
        let count : NSInteger = self.viewListControllers.count
        
        var rect : CGRect  = CGRectMake(0, 0, (CGFloat)(self.view.bounds.size.width) / (CGFloat)(count),self.tabBarHeight )
        indicatorView?.hidden = true
        
        let buttons : [UIButton]? = (tabButtonsContainerView?.subviews) as? [UIButton]
        
        if  buttons == nil{
            return
        }
        
        for  button : UIButton in buttons!{
            if index == count - 1{
                rect.size.width = self.view.bounds.size.width - rect.origin.x
            }
            button.frame = rect
            rect.origin.x += rect.size.width
            if index == self.selectedIndex{
                self.centerIndicatorOnButton(button)
            }
            ++index
        }
    }
    
    func removeTabButtons()
    {
        while tabButtonsContainerView?.subviews.count > 0
        {
            tabButtonsContainerView?.subviews.last?.removeFromSuperview()
        }
    }
    
    func tabButtonPressed(sender : UIButton)
    {
        self.selectedIndex(sender.tag-TagOffset, animated: true)
    }
    
    func selectTabButton(button : UIButton)
    {
        button.setTitleColor(self.selectedColor, forState: UIControlState.Normal)
    }
    
    func deselectTabButton(button : UIButton)
    {
        button .setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
    
    func selectedViewController(viewCtr : UIViewController)
    {
        self.selecteViewController(viewCtr, animated: false)
    }
    
    func selecteViewController(viewCtr : UIViewController,animated : Bool)
    {
        let index : NSInteger = self.viewListControllers.indexOf(viewCtr)!
        
        if index != NSNotFound
        {
            self.selectedIndex(index, animated: animated)
        }
    }
    
    func viewListControllers(viewControllers : Array<UIViewController>)
    {
        btnCount = viewControllers.count
        
        let oldSelecteViewController : UIViewController = _selectedViewController!
        for viewController : UIViewController in self.viewListControllers
        {
            viewController.willMoveToParentViewController(nil)
            viewController.removeFromParentViewController()
        }
        
        self.viewListControllers = viewControllers
        
        let newIndex : NSInteger = self.viewListControllers.indexOf(oldSelecteViewController)!
        if newIndex != NSNotFound{
            self.selectedIndex = newIndex
        }
        else if newIndex < self.viewListControllers.count{
            self.selectedIndex = newIndex
        }else{
            self.selectedIndex = 0
        }
        
        for viewController : UIViewController in self.viewListControllers
        {
            self.addChildViewController(viewController)
            viewController.didMoveToParentViewController(self)
        }
        
        if self.isViewLoaded(){
            self.reloadTabButtons()
        }
    }
    
    func selectedIndex(index : NSInteger, animated : Bool)
    {
        let toViewContro : UIViewController = self.viewListControllers[index]
        
        if self.delegate?.mk_tabBarController(self, shouldSelectedViewController: toViewContro, index: index) == nil{
            return;
        }
        
        if self.isViewLoaded() == false{
            _selectedIndex = index
        }
        else if(_selectedIndex != index)
        {
            var fromViewCtr : UIViewController?
            var toViewCtr : UIViewController?
            
            if _selectedIndex != index{
                let fromButton = tabButtonsContainerView?.viewWithTag(TagOffset + _selectedIndex) as? UIButton
                if fromButton == nil{
                    return
                }
                self.deselectTabButton(fromButton!)
                fromViewCtr = self.selectedViewController
            }
            
            let oldSelectedIndex = _selectedIndex
            
            _selectedIndex = index
            
            var toButton : UIButton?
            
            if _selectedIndex != NSNotFound
            {
                toButton = tabButtonsContainerView?.viewWithTag(TagOffset + _selectedIndex) as? UIButton
                self.selectTabButton(toButton!)
                toViewCtr = self.selectedViewController
            }
            
            if toViewCtr == nil{
                fromViewCtr?.view.removeFromSuperview()
            }
            else if (fromViewCtr == nil){
                toViewCtr!.view.frame = (contentContainerView?.bounds)!
                contentContainerView?.addSubview((toViewCtr?.view)!)
                
                self.delegate?.mk_tabBarController(self, didSelecteViewController: toViewCtr!, index: index)
            }
            else if (animated){
                var rect : CGRect  = (contentContainerView?.bounds)!
                if oldSelectedIndex < index{
                    rect.origin.x = rect.size.width
                }
                else{
                    rect.origin.x = -rect.size.width
                }
                
                toViewCtr?.view.frame = rect
                tabButtonsContainerView?.userInteractionEnabled = false
                
                self.transitionFromViewController(fromViewCtr!, toViewController: toViewCtr!, duration: 0.3, options: [UIViewAnimationOptions.LayoutSubviews,UIViewAnimationOptions.CurveEaseOut], animations: { (Void) -> Void in
                    var rect : CGRect = (fromViewCtr?.view.frame)!
                    if oldSelectedIndex < index{
                        rect.origin.x = -rect.size.width
                    }
                    else{
                        rect.origin.x = rect.size.width
                    }
                    fromViewCtr?.view.frame = rect
                    toViewCtr?.view.frame = (self.contentContainerView?.bounds)!
                    self.centerIndicatorOnButton(toButton!)
                    
                    }, completion: { (Void) -> Void in
                        self.tabButtonsContainerView?.userInteractionEnabled = true
                        self.delegate?.mk_tabBarController(self, didSelecteViewController: toViewCtr!, index: index)
                })
            }
            else{
                fromViewCtr?.view.removeFromSuperview()
                
                toViewCtr?.view.frame = (contentContainerView?.bounds)!
                contentContainerView?.addSubview((toViewCtr?.view)!)
                self.centerIndicatorOnButton(toButton!)
                self.delegate?.mk_tabBarController(self, didSelecteViewController: toViewCtr!, index: index)
            }
        }
        
    }
    
    func centerIndicatorOnButton(button : UIButton)
    {
        var rect : CGRect = (indicatorView?.frame)!
        rect.origin.x = button.center.x - (CGFloat)((indicatorView?.frame.size.width)!)/2.0
        rect.origin.y = self.tabBarHeight - (indicatorView?.frame.size.height)!
        indicatorView?.frame = rect
        indicatorView?.hidden = false
    }
    
    var tabBarHeight : CGFloat
    {
        return 44.0
    }
}








