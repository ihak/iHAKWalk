//
//  WalkSlider.swift
//  ihakwalk
//
//  Created by Hassan Ahmed on 19/03/2019.
//  Copyright © 2019 Hassan Ahmed. All rights reserved.
//

import UIKit

/**
 *  A protocol that provides scrollview related updates
 *  to the interested views.
 */
protocol SliderDelegate {
    func didContentOffsetChange(contentOffset: Double)
}

/**
 *  A view that takes WalkView and WalkBGView and layout
 *  the slider accordingly.
 */
class WalkSlider: UIView {
    private lazy var pageControl = UIPageControl(frame: .zero)
    private lazy var scrollView = UIScrollView(frame: .zero)
    private lazy var skipButton = UIButton(type: .custom)
    private lazy var containerView = UIView()
    private lazy var backgroundContainerView = UIView()
    
    private var skipButtonTopConstraint: NSLayoutConstraint?
    
    private var backgroundView: WalkBGView?
    private var milestones = [UIView]()

    private var skipButtonAction: ((_ button: UIButton) -> Void)?
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    var totalPages: Int {
        return Int(scrollView.contentSize.width/scrollView.bounds.width)
    }
    
    var pageWidth: Double {
        return Double(scrollView.bounds.width)
    }

    init(backgroundView: WalkBGView? = nil, milestones: [UIView]) {
        self.milestones.append(contentsOf: milestones)
        self.backgroundView = backgroundView
        
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        setup()
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        if backgroundView?.type == .paralax {
            configureParalax()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *  Perform paralax related configurations if background view is present.
     */
    private func configureParalax() {
        if let backgroundView = self.backgroundView {
            backgroundView.contentSize = Double(self.scrollView.contentSize.width)
            backgroundView.paralaxDelta = 0.2
        }
    }
    
    /**
     *  Performs basic setup of the view.
     */
    private func setup() {
        // if background view is present add it
        if let backgroundView = self.backgroundView {
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(backgroundView)
            
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        
        // Add scrollview to superview
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        let topConstraint = scrollView.topAnchor.constraint(equalTo: self.topAnchor)
        topConstraint.priority = .init(rawValue: 999.0)
        topConstraint.isActive = true
        
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        let trailingConstraint = scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        trailingConstraint.priority = .init(rawValue: 999.0)
        trailingConstraint.isActive = true
        
        
        // configure scrollview
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self

        // add container view to scrollview
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        let contentLayoutGuide = scrollView.contentLayoutGuide
        containerView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor).isActive = true
//        containerView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor).isActive = true
//        containerView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor).isActive = true
        
        // Add views to container view
        addMileStones(views: milestones, to: containerView)
    }
    
    /**
     *  Adds WalkViews to the containerView which is added on the
     *  scrollview.
     */
    private func addMileStones(views: [UIView], to container:UIView) {
        var previousView: UIView!
        for (index, view) in views.enumerated() {
            var walkView = view
            var bgView: WalkBGView?
            
            // If its a WalkBGView obtain corresponding WalkView instance
            // and add it to the container.
            if let bg = view as? WalkBGView {
                bgView = bg
                if let walk = bg.walkView {
                    walkView = walk
                }
            }
            
            walkView.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(walkView)
            walkView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
            walkView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
            walkView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
            
            if previousView != nil {
                walkView.leadingAnchor.constraint(equalTo: previousView.trailingAnchor).isActive = true
            }
            else {
                walkView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
            }
            
            if index == (views.count - 1) {
                walkView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
            }
            
            // Add the background view
            if let bgView = bgView {
                bgView.translatesAutoresizingMaskIntoConstraints = false
                container.insertSubview(bgView, belowSubview: walkView)
                bgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                bgView.leadingAnchor.constraint(equalTo: walkView.leadingAnchor).isActive = true
                bgView.trailingAnchor.constraint(equalTo: walkView.trailingAnchor).isActive = true
            }
            previousView = walkView
        }
    }
    
    /**
     *  Adds skip button to the stackview.
     */
    func addSkipButton() {
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.backgroundColor = .clear
        
        skipButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        skipButton.titleLabel?.adjustsFontForContentSizeCategory = true

        skipButton.addTarget(self, action: #selector(skipButtonTapped(sender:)), for: .touchUpInside)
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        // Adding the button on scrollView so that it stays
        // on the screen while scrolling.
        scrollView.addSubview(skipButton)
        NSLayoutConstraint.activate([
            // Centering the button wrt to scrollview's frame in the horizontal axis.
            skipButton.centerXAnchor.constraint(equalTo: scrollView.frameLayoutGuide.centerXAnchor),
            // Attaching the bottom anchor of containerView to the button with proper spacing.
            skipButton.topAnchor.constraint(greaterThanOrEqualTo: containerView.bottomAnchor, constant: 20.0),
            // Attaching the bottom anchor of the button with slider's layout margin's bottom anchor
            // so that directionalLayoutMargins apply.
            skipButton.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])
        
        // Setting the content-hugging priority to high so that the
        // button is not expanded vertically.
        skipButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        // If pageControl is already added
        // remove and add it again to adjust
        // the constraints.
        if let _ = pageControl.superview {
            pageControl.removeFromSuperview()
            addPageControl()
        }
    }
    
    /**
     *  Adds page control to the stackview.
     */
    func addPageControl() {
        pageControl.numberOfPages = milestones.count
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(pageControl)
        
        pageControl.centerXAnchor.constraint(equalTo: scrollView.frameLayoutGuide.centerXAnchor).isActive = true
        
        if let _ = skipButton.superview {
            pageControl.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: 0.0).isActive = true
        }
        else {
            pageControl.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        }
    }

    /**
     *  Shows page control.
     */
    func showPageControl() {
        self.pageControl.isHidden = false
    }
    
    /**
     *  Hides page control.
     */
    func hidePageControl() {
        self.pageControl.isHidden = true
    }
    
    /**
     *  Performs custom configurations on page control
     */
    func configurePageControl(_ block: (_ pageControl: UIPageControl) -> Void) {
        block(pageControl)
    }
    
    /**
     *  Performs custom configurations on skip button.
     */
    func configureSkipButton(_ block: (_ button: UIButton) -> Void) {
        block(skipButton)
    }
    
    func skipButtonAction(_ block: @escaping (_ button: UIButton) -> Void) {
        skipButtonAction = block
    }
    
    @objc func skipButtonTapped(sender: UIButton) {
        skipButtonAction?(skipButton)
    }
}

extension WalkSlider: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        guard scrollView.bounds.width > 0 else {
            print("Error: Scrollview width is <= zero.")
            return
        }
        currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        // if background view is present and supports paralax
        // inform the view about offset changes (to allow paralax)
        if backgroundView?.type == .paralax {
            backgroundView?.contentOffset = Double(scrollView.contentOffset.x)
        }
        
        // inform individual views about the offset change
        for (index, milestone) in milestones.enumerated() {
            if let bg = milestone as? WalkBGView {
                let offset = Double(scrollView.contentOffset.x) - (pageWidth * Double(index))
                
                bg.didContentOffsetChange(contentOffset: offset)
            }
        }
    }
}
