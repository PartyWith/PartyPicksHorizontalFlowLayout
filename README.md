# PartyPicksHorizontalFlowLayout
![language](https://img.shields.io/badge/Language-%20Swift%20-orange.svg)
![CI Status](https://img.shields.io/badge/build-passing-brightgreen.svg)
[![Version](https://img.shields.io/cocoapods/v/PartyPicksHorizontalFlowLayout.svg?style=flat)](http://cocoapods.org/pods/PartyPicksHorizontalFlowLayout)
[![License](https://img.shields.io/cocoapods/l/PartyPicksHorizontalFlowLayout.svg?style=flat)](http://cocoapods.org/pods/PartyPicksHorizontalFlowLayout)
[![Platform](https://img.shields.io/cocoapods/p/PartyPicksHorizontalFlowLayout.svg?style=flat)](http://cocoapods.org/pods/PartyPicksHorizontalFlowLayout)

UICollectionViewFlowLayout used in PartyWith iOS App's Party Picks section (edit mode)

<img src="http://felipe.ricieri.me/pods/pphfl2.png" alt="Example">


## Installation

`PartyPicksHorizontalFlowLayout` is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```swift
pod "PartyPicksHorizontalFlowLayout"
```

And then run:

`$ pod install`


#### Manual Installation

To manually install `PartyPicksHorizontalFlowLayout`, simply add `PartyPicksHorizontalFlowLayout` files to your project.


## Example

To run the example project, clone the repo. No Cocoapods setup needed, the files are embeded.


## Getting Start

**Via Storyboard**

You can easily set your `UICollectionView`'s Flow Layout in your storyboard:

<img src="http://felipe.ricieri.me/pods/pphfl_sbs.png" alt="Storyboard settings">

In your `UIViewController`, you'll **need** to implement the `delegate` property:

```swift
if  let flowLayout = collection.collectionViewLayout as? PartyPicksHorizontalFlowLayout {
    // Your app will crash if you don't implement this property
    flowLayout.delegate = <#delegate here#>
}
```

**Via Code**

You can also set it in your `UIViewController`:

```swift
let flowLayout = PartyPicksHorizontalFlowLayout(delegate: self) // Delegate is required
self.collectionView.collectionViewLayout = flowLayout
```

Additionally you can configure some extra properties:

```swift
let flowLayout = PartyPicksHorizontalFlowLayout(lines: 4, delegate: self) // Delegate is required
self.collectionView.collectionViewLayout = flowLayout

flowLayout.cellSpacing = 5
flowLayout.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
```

If you chose to implement `PartyPicksHorizontalFlowLayout` via storyboard, you can custom these properties using the conditional cast operator:

```swift
if  let flowLayout = collection.collectionViewLayout as? PartyPicksHorizontalFlowLayout {
    // Customize your flow layout
    flowLayout.numberOfLines = 4
    flowLayout.cellSpacing = 5
    flowLayout.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
}
```


## Delegate

In order to work properly, `PartyPicksHorizontalFlowLayout` requires a `PartyPicksHorizontalFlowLayoutDelegate`. You'll find these methods in this protocol:

```swift
public protocol PartyPicksHorizontalFlowLayoutDelegate {
    
    /**
     * Tells the flow layout which should be the width for a given cell.
     */
    func collectionView(_ collectionView: UICollectionView, widthForCellAt indexPath: IndexPath, withHeight height: CGFloat) -> CGFloat
    
    /**
     * Tells the delegate when flow layout is all set.
     */
    func didPreparedFlowLayout()
}
```

Please look into the example project for more details about the implementation.


## Maintance

Pull Requests are welcome 🙂. Let us know your thoughts!

- 🍎 Download the App in App Store: https://itunes.apple.com/us/app/id562560874?mt=8
- 🤖 Download the App in Google Play: https://play.google.com/store/apps/details?id=com.pwal
- 🐦 Follow us in Twitter: https://twitter.com/partywithapp
- 👤 Like our page in Facebook: https://www.facebook.com/PartyWith
- 📬 Got feedback? Send us a message to: info@partywith.co


## License

MIT License

Copyright (c) 2017 PartyWith B.V.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
