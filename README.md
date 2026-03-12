<div align="center">

<br/>

```
 ██████╗ ██╗████████╗    ███████╗ ██████╗ ██╗      ██╗      ██████╗ ██╗    ██╗
██╔════╝ ██║╚══██╔══╝    ██╔════╝██╔═══██╗██║      ██║     ██╔═══██╗██║    ██║
██║  ███╗██║   ██║       █████╗  ██║   ██║██║      ██║     ██║   ██║██║ █╗ ██║
██║   ██║██║   ██║       ██╔══╝  ██║   ██║██║      ██║     ██║   ██║██║███╗██║
╚██████╔╝██║   ██║       ██║     ╚██████╔╝███████╗ ███████╗╚██████╔╝╚███╔███╔╝
 ╚═════╝ ╚═╝   ╚═╝       ╚═╝      ╚═════╝ ╚══════╝ ╚══════╝ ╚═════╝  ╚══╝╚══╝
```

<br/>

**Browse GitHub profiles. Discover followers. Save your favourites.**

<br/>

![Swift](https://img.shields.io/badge/Swift-5.9-F05138?style=for-the-badge&logo=swift&logoColor=white)
![UIKit](https://img.shields.io/badge/UIKit-Programmatic-2396F3?style=for-the-badge&logo=apple&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-16%2B-000000?style=for-the-badge&logo=apple&logoColor=white)
![GitHub API](https://img.shields.io/badge/GitHub%20API-Public-181717?style=for-the-badge&logo=github&logoColor=white)
![No Storyboard](https://img.shields.io/badge/No%20Storyboard-100%25%20Code-brightgreen?style=for-the-badge)

</div>

---

## 📱 Overview

**Git Follow** is an iOS application that lets you explore the GitHub social graph — search any GitHub username, browse their followers, dive into profiles, and save your favourite users for quick access later. Built with a focus on **clean architecture**, **real-world iOS engineering practices**, and a **fully programmatic UI** (zero storyboards).

---

## 🖼️ Screenshots

<div align="center">

| Search | Followers | User Detail |
|:------:|:---------:|:-----------:|
| <img src="https://github.com/user-attachments/assets/d0fbb943-a34b-4292-9c00-cbed11358f96" width="220"/> | <img src="https://github.com/user-attachments/assets/04f64113-7f29-4a43-87c9-9d479f2e5cc5" width="220"/> | <img src="https://github.com/user-attachments/assets/021c6ba8-d55c-469a-b738-6eb2b53a7097" width="220"/> |

| Favourites | Error View | WebView |
|:----------:|:-----------:|:-------:|
| <img src="https://github.com/user-attachments/assets/d421d0d2-6c39-472a-bce5-b13264a27b54" width="220"/> | <img src="https://github.com/user-attachments/assets/408d3f7e-261c-440f-b5b3-56f4f21a54c9" width="220"/> | <img src="https://github.com/user-attachments/assets/3109b49f-8a9e-42c3-b82a-77a0317db399" width="220"/> |

</div>

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🔍 **User Search** | Search any GitHub username instantly via the public GitHub REST API |
| 👥 **Followers List** | Paginated list of all followers for any given user |
| 👤 **User Detail** | Rich profile view with avatar, bio, repos, following & followers count |
| 🌐 **Profile WebView** | Open the full GitHub profile in-app via a native `WKWebView` |
| ⭐ **Favourites** | Save users to a persistent favourites list backed by `UserDefaults` |
| 📦 **Caching** | Avatar images cached in memory with `NSCache` to reduce network calls |
| 📄 **Pagination** | Infinite scroll — followers load in batches as you scroll |

---

## 🏗️ Core Engineering Concepts

> This project was built to demonstrate real-world iOS development patterns, not just feature delivery.

```
┌─────────────────────────────────────────────────────┐
│                  Engineering Focus                    │
├──────────────────────┬──────────────────────────────-┤
│  🌐 Networking        │  URLSession + async/await     │
│  📄 Pagination        │  Page-based infinite scroll   │
│  🗄️  Caching          │  NSCache for avatar images    │
│  💾 Local Storage     │  UserDefaults persistence     │
│  🧹 Clean Code        │  SOLID, DRY, SRP principles   │
│  ♻️  Reusability       │  Custom reusable UI components│
│  🌍 WebView           │  In-app WKWebView browser     │
│  ⚠️  Error Handling    │  Custom GFError enum alerts   │
│  📐 Programmatic UI   │  100% code, zero storyboards  │
└──────────────────────┴───────────────────────────────┘
```

### 🌐 Networking Layer
Built on top of `URLSession` using Swift Concurrency (`async/await`). A dedicated `NetworkManager` singleton handles all API calls with clean error propagation via custom `GFError` enums.

### 📄 Pagination
Followers are fetched in pages of 100. The collection view detects when the user nears the bottom and automatically fetches the next page — seamless, no manual "Load More" button.

### 🗄️ Image Caching
A shared `NSCache` instance stores downloaded avatar images keyed by URL string. Repeated visits to the same user never trigger a redundant network request.

### 💾 Persistent Favourites
The favourites list is encoded as JSON and written to `UserDefaults`, surviving app restarts. An ergonomic `PersistenceManager` abstracts all read/write logic away from view controllers.

### ♻️ Reusable Components
Custom `UIView` subclasses (`GFButton`, `GFLabel`, `GFAvatarImageView`, `GFEmptyStateView`) keep every screen consistent and reduce code duplication to near zero.

### ⚠️ Error Handling
A custom `GFError` enum conforms to `Error` and covers all failure cases — invalid username, invalid URL, server errors, and decoding failures. Every error maps to a user-friendly message surfaced via a reusable `GFAlertVC`, so users always know what went wrong without the app ever crashing silently.

---

## 🚀 Getting Started

### Requirements
- Xcode 15+
- iOS 16.0+
- No third-party dependencies — 100% native Apple frameworks

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/GitFollow.git

# Open in Xcode
cd GitFollow
open GitFollow.xcodeproj
```

> ⚡ **No CocoaPods, no SPM packages, no setup required.** Hit Run and go.

---

## 🔌 API Reference

This app uses the **GitHub REST API v3** — no authentication required for the endpoints used.

| Endpoint | Usage |
|----------|-------|
| `GET /users/{username}` | Fetch user profile details |
| `GET /users/{username}/followers?page={n}&per_page=100` | Fetch paginated followers |

> Rate limit: **60 requests/hour** unauthenticated. Add a personal access token to the `NetworkManager` headers to increase this to 5,000/hour.

---

## 📐 Architecture

The project follows **MVC** — the standard UIKit pattern — with a clear separation of concerns:

- **Models** are plain Swift structs conforming to `Codable`
- **Views** are custom `UIView`/`UIViewController` subclasses built entirely in code
- **Controllers** delegate business logic to the `NetworkManager` and `PersistenceManager` singletons

---

## 🧠 What I Learned

- Building complex, multi-screen UIKit apps **without a single storyboard**
- Implementing a robust **networking layer** with proper error handling
- Using `NSCache` effectively for **performant image loading**
- Designing a **reusable component library** that scales across screens
- Making data **persistent** across app sessions cleanly and safely
- Managing **pagination state** without blocking the UI thread

---

<div align="center">

**Built with 🖤 in Swift**

*No storyboards were harmed in the making of this app.*

</div>
