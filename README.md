# LaskNews

This project is a **LaskNews Application** built using **Xcode 16**, targeting **iOS 18.0** and written in **Swift 6.0**. The app allows users to read the latest news, bookmark articles, and read bookmarked articles offline. It leverages **Combine** for reactive programming and **SwiftData** for managing offline data.

## Features

- **Fetch News**: Get the latest news from various sources.
- **Bookmark Articles**: Save articles for later reading.
- **Offline Reading**: Access bookmarked articles even when offline.
- **Swift 6.0**: Modern Swift codebase taking advantage of new features.
- **Combine**: Use reactive programming to handle asynchronous data streams.
- **SwiftData**: Efficient management of offline storage for news articles.

Before diving into the implementation, check out the **UI/UX design** for this project created on **Figma**. The design is a blueprint for the application's visual layout and user experience flow. The Figma file includes mockups for all major screens, including the **News List**, **Bookmarks**, and **Article Details** views.

- Figma Design Link: [News App Design](https://www.figma.com/design/HzTB83DKT6cjM0ZFIBAcdr/Lask-Mobile-News-App-UI-Kit-(Community)?node-id=112-1982&node-type=canvas&t=elaIY4dMZdYLCbev-0)

## Technologies

- **Xcode 16**
- **iOS 18.0 SDK**
- **Swift 6.0**
- **Combine Framework**
- **SwiftData**

## Key Components
**Combine**
Used to fetch and update news articles from APIs asynchronously.
Handles reactive data streams, providing automatic UI updates.
**SwiftData**
Manages offline data storage for bookmarked news articles.
Ensures persistence and availability of articles even when the device is offline.
**Usage**
Fetching News
When the app loads, it fetches the latest news using a Combine-powered service.
**Bookmarking**
Users can tap the "Bookmark" button on any article to save it for later.
**Offline Reading**
Bookmarked articles can be read offline, with the app using SwiftData to ensure data persistence.

## NEWSAPI.ORG
Register with newsapi.org - [Link](https://newsapi.org/) and get your key.
Add in Constant file.

## Contributing
Feel free to open issues or submit pull requests if you find any bugs or have suggestions for improvement.

## License
This project is licensed under the MIT License - see the LICENSE file for details.




