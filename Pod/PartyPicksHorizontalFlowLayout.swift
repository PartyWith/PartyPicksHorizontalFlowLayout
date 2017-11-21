//
//  PartyPicksHorizontalFlowLayout.swift
//  PartyPicksHorizontalFlowLayout
//
//  Created by Felipe Ricieri on 18/11/2017.
//  Copyright © 2017 Ricieri ME. All rights reserved.
//

import UIKit

/**
 *  Use it to get a left-aligned horizontal flow layout behavior
 */
open class PartyPicksHorizontalFlowLayout : UICollectionViewFlowLayout {
    
    /**
     * Delegate is required. Here you will define the dynamic width for cells
     */
    open var delegate : PartyPicksHorizontalFlowLayoutDelegate!
    
    /**
     * Amount of lines you want your collection view to have
     */
    open var numberOfLines : Int = 2
    
    /**
     * Space between cells (default is 5px)
     */
    open var cellSpacing : CGFloat = 5
    
    /**
     * Cells height (default is 45px)
     */
    open var cellHeight : CGFloat = 45
    
    /**
     * Collection View content inset
     */
    open var contentInset : UIEdgeInsets = .zero
    
    /**
     * The content height will be defined automatically by PartyPicksHorizontalFlowLayout class
     */
    public var contentHeight : CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.height - (insets.top + insets.bottom)
    }
    
    /**
     * The content width will be defined automatically by PartyPicksHorizontalFlowLayout class
     */
    fileprivate(set) public var contentWidth : CGFloat = 0
    
    /**
     * Collection View Content Size
     */
    override open var collectionViewContentSize : CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    /**
     * Attributes cache list
     */
    private var cache : [UICollectionViewLayoutAttributes] = []
    
    
    // MARK: - 🤘🦄  Initialization
    
    
    /**
     * Instantiates PartyPicksHorizontalFlowLayout with its delegate.
     */
    public init(lines: Int = 2, delegate: PartyPicksHorizontalFlowLayoutDelegate) {
        super.init()
        self.numberOfLines = lines
        self.delegate = delegate
        self.contentWidth = contentInset.left
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentWidth = contentInset.left
        print("🤘🦄 Warning: 🚨 You instantiated PartyPicksHorizontalFlowLayout via Interface Builder. Don't forget to declare the delegate.")
    }
    
    /**
     * Prepares the layout. Obs.: PartyPicksHorizontalFlowLayout was designed to not accept any supplementary view.
     */
    override open func prepare() {
        
        // Cannot prepare layout without the delegate
        assert(delegate != nil, "🤘🦄 Warning: 🚨 Delegate is nil. Please provide a delegate.")
        
        let lineHeight = contentHeight / CGFloat(numberOfLines)
        var yOffset = [CGFloat]()
        for line in 0 ..< numberOfLines {
            yOffset.append(CGFloat(line) * lineHeight )
        }
        var line = 0
        var xOffset = [CGFloat](repeating: contentInset.left, count: numberOfLines)
        
        for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            //let height = lineHeight - cellSpacing * 2
            let height = cellHeight
            let annotation = delegate.collectionView(collectionView!, widthForCellAt: indexPath, withHeight: height)
            let width = cellSpacing + annotation + cellSpacing
            let frame = CGRect(x: xOffset[line], y: yOffset[line], width: width, height: lineHeight)
            let insetFrame = frame.insetBy(dx: cellSpacing, dy: cellSpacing)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentWidth = max(contentWidth, frame.maxX) + contentInset.left
            
            xOffset[line] = xOffset[line] + width
            
            if  line >= (numberOfLines - 1) {
                line = 0
            }
            else {
                line += 1
            }
        }
        
        // Fire delegate
        delegate?.didPrepareFlowLayout?()
    }
    
    // MARK: - 🤘🦄 Layout
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if  attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    
    // MARK: - 🤘🦄 Reseting
    
    /**
     * Clears the attributes cache list, content height property & invalidates layout.
     */
    func clearCache() {
        invalidateLayout()
        contentWidth = 0
        cache = []
    }
}


// MARK: - 🤘🦄 Delegation


/**
 *  PartyPicksHorizontalFlowLayout's Delegate
 */
@objc public protocol PartyPicksHorizontalFlowLayoutDelegate {
    
    /**
     * Tells the flow layout which should be the width for a given cell.
     */
    func collectionView(_ collectionView: UICollectionView, widthForCellAt indexPath: IndexPath, withHeight height: CGFloat) -> CGFloat
    
    /**
     * Tells the delegate when flow layout is all set.
     */
    @objc optional func didPrepareFlowLayout()
}

