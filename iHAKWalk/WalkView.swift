//
//  WalkView.swift
//  ihakwalk
//
//  Created by Hassan Ahmed on 15/03/2019.
//  Copyright © 2019 Hassan Ahmed. All rights reserved.
//

import UIKit
/**
 * A view composed of a title, description and image. It is a basic element
 *  of this component. For functionality, customizations or configurations
 *  checkout the methods exposed by this class.
 */

class WalkView: UIView {
    private var title: String?
    private var descriptionText: String?
    private var image: UIImage?
    
    private lazy var stackView = UIStackView()
    
    private var titleLabel: UILabel?
    private var descriptionLabel: UILabel?
    private var imageView: UIImageView?
    private var sequence: [DisplayItem]
    
    typealias Configuration = (_ walkView: WalkView, _ title: UILabel?,_ description: UILabel?,_ image: UIImageView?) -> Void
    typealias TapHandler = ((_ bgView: WalkView) -> Void)
    
    private var tapHandler: TapHandler?
    
    enum DisplayItem {
        case title, description, image
    }
    
    private var defaultConfiguration: Configuration
    private var configuration: Configuration?
    
    init(title:String? = nil,
         descriptionText:String? = nil,
         image:UIImage? = nil,
         sequence: [DisplayItem] = [.title, .description, .image],
         _ configuration: Configuration? = nil) {
        self.title = title
        self.descriptionText = descriptionText
        self.image = image
        self.sequence = sequence
        
        defaultConfiguration = { (self, title, description, image) in
            title?.textColor = .white
            title?.numberOfLines = 2
            title?.font = UIFont.preferredFont(forTextStyle: .title1)
            title?.adjustsFontForContentSizeCategory = true
            
            description?.textColor = .white
            description?.font = UIFont.preferredFont(forTextStyle: .body)
            description?.adjustsFontForContentSizeCategory = true
        }
        
        self.configuration = configuration
        super.init(frame: .zero)
        
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20.0, leading: 20.0, bottom: 20.0, trailing: 20.0)
        setup()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *  Returns the corresponding view of a DisplayItem.
     */
    private func correspondingView(displayItem: DisplayItem) -> UIView? {
        switch displayItem {
        case .title:
            return titleLabel
        case .description:
            return descriptionLabel
        case .image:
            return imageView
        }
    }

    /**
     *  calls default and user provided configuration blocks
     *  to perform default and custom configurations on display items.
     */
    private func configure() {
        defaultConfiguration(self, titleLabel, descriptionLabel, imageView)
        configuration?(self, titleLabel, descriptionLabel, imageView)
    }
    
    /**
     *  Adds custom spacing after a view in stackview.
     *  Call this method in configuration block to make it work.
     */
    func addCustomSpacing(spacing: Double, after view: UIView) {
        self.stackView.setCustomSpacing(CGFloat(spacing), after: view)
    }
    
    /**
     *  This is the main method that carries out the heave work of setting-up
     *  this view. The settings involves initialization of display elements,
     *  adding them to the view and configuring their basic properties
     *  e.g. font, numberOfLines, textAlignment, etc.
     */

    private func setup() {
        // configure title label
        titleLabel = UILabel()
        titleLabel?.numberOfLines = 0
        titleLabel?.text = self.title
        titleLabel?.allowsDefaultTighteningForTruncation = true
        titleLabel?.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel?.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        titleLabel?.textAlignment = .center

        // configure description label
        descriptionLabel = UILabel()
        descriptionLabel?.numberOfLines = 0
        descriptionLabel?.text = self.descriptionText
        descriptionLabel?.textAlignment = .center
        descriptionLabel?.setContentHuggingPriority(.defaultHigh, for: .vertical)
        descriptionLabel?.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)


        // configure imageview
        imageView = UIImageView(image: self.image)
        imageView?.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView?.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageView?.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView?.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageView?.contentMode = .scaleAspectFit
        imageView?.clipsToBounds = true

        stackView.axis = .vertical
        
        // loop through the display items in sequence array and add them
        // to stackview in given sequence
        for item in sequence {
            if let view = correspondingView(displayItem: item) {
                stackView.addArrangedSubview(view)
            }
        }
        
        // Configure stackview
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        // add stackview to superview
        self.addSubview(stackView)
        let margins = self.layoutMarginsGuide
        stackView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: margins.bottomAnchor, constant: 10.0).isActive = true
    }
    
    func configureTap(_ block:TapHandler?) {
        self.tapHandler = block
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(walkViewTapped))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func walkViewTapped() {
        print("View tapped!!!")
        self.tapHandler?(self)
    }
}
