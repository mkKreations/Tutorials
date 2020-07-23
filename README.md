# MountainSearch


## Screenshots

### Home Screen

[![Home-Screen.png](https://i.postimg.cc/4xB84VN1/Home-Screen.png)](https://postimg.cc/Mnf0dcBc)

### Detail Screen

[![Detail-Screen.png](https://i.postimg.cc/kMbhN2fn/Detail-Screen.png)](https://postimg.cc/rzqJMFBb)

### Home Screen with Queued Cells

[![Home-Screen-Queued-Cells.png](https://i.postimg.cc/3xKSHn7R/Home-Screen-Queued-Cells.png)](https://postimg.cc/2VKFQd1R)

### Queued Screen

[![Queued-Screen.png](https://i.postimg.cc/DZtpkhyk/Queued-Screen.png)](https://postimg.cc/FdVV32LD)

### Queued Screen with Selected Cells

[![Queued-Screen-Selected.png](https://i.postimg.cc/mkCXTntc/Queued-Screen-Selected.png)](https://postimg.cc/wRxcV05H)

### Queued Screen with Deleted Cells

[![Queued-Screen-Deleted.png](https://i.postimg.cc/DZWpM0hP/Queued-Screen-Deleted.png)](https://postimg.cc/N9cxyg5K)

### Home Screen with Deleted Cells

[![Home-Screen-Deleted.png](https://i.postimg.cc/8PdK3x29/Home-Screen-Deleted.png)](https://postimg.cc/ykdy3pYy)


## Description

This is a simple iOS that allows a user to search through a number of famous Mountains and learn basic
details about them. The basis of this app is a collectionView with a UISearchController. This version of
the app beautifully, and seamlessly, animates when as a user searches. The sledgehammer approach of reloadData()
has been replaced instead with only reloading the necessary indexPaths to produce a much more lively feeling. 
This app splits responsibility in order to manage the collectionView and search controller properly by having 
types that act specifically as the dataSource/delegate/flowLayout and so on. This app is built entirely 
on UIKit and is designed to run on devices running iOS11 and up.


## Features

- Manages indexPaths to create seamless search animation as user types
- Uses custom classes to manage all aspects of UICollectionView
- Utilizes UISearchController to manage results of UICollectionView
- Loads raw data from CSV


## Disclaimer

Some issues identified:

- IndexPaths are reset when returning from detail screen


## Feedback

Any and all feedback is welcome - including pull requests.
