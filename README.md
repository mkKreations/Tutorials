# Tutorials


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

Tutorials is an iOS app that displays several collections of Tutorial topics as a library. The user can scroll
through the different sections of Tutorials and select whichever one interests them. A detail screen displays 
the details of a specific Tutorial and provides a list of videos related to that Tutorial. Currently, the videos
are not interactive. However, the user can queue whichever Tutorial topic that are of interest of them and that
list is maintained within another tab. From here, a user can delete any queued Tutorial topics. This app was designed
using UIKit and UICompositonalLayout/DiffableDatasource - features from the iOS 13 SDK. Additionally, this app is designed 
for iOS devices running iOS 13 and up as it uses compositionalLayout and diffableDatasource to manage its collectionViews. 


## Features

- Presents library of Tutorials with collectionView using orthogonal scrolling
- Manages the state of Tutorial items that are queued with animation
- Uses snapshots and diffableDatasource to maintain user-updated state of collectionViews
- Animates all interactions with collectionViews
- Loads raw data from a plist


## Disclaimer

Some issues identified:

- Currently have not found solution to presenting supplementaryView on item within HomeViewController


## Feedback

Any and all feedback is welcome - including pull requests.
