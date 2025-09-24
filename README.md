# 📱 iOS Test - CI&T: List & Detail Screens

[![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=for-the-badge&logo=swift)](https://developer.apple.com/swift/)  [![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey?style=for-the-badge&logo=apple)](https://developer.apple.com/ios/)  [![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)  [![Build](https://img.shields.io/badge/Build-Passing-brightgreen?style=for-the-badge&logo=github)](https://github.com/)  

This project was developed as part of the **Mobile Developer Test** for **CI&T (EMEA)**.  
The goal was to build a simple mobile application with two screens: **List** and **Detail**,  
demonstrating architectural patterns, best practices, and testing.  

The focus of this challenge was not on design fidelity but on:  
- Clean architecture and separation of concerns.  
- Proper state management and error handling.  
- Writing unit and UI/integration tests.  

---

## 📸 Screenshots

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/282c2246-0f83-4ccf-971e-e741469f77bf" width="200"/><br>
      <b>List Screen</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/8016d825-eca6-449a-bb2a-048b41f49338" width="200"/><br>
      <b>Detail Screen</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/c9466149-2032-480a-a01f-c2b6dfd9dfab" width="200"/><br>
      <b>Detail Screen navigation</b>
    </td>
  </tr>
</table>

---



## 📋 Table of Contents

- [😁 Message to Reviewers](#-message-to-reviewers)  
- [📖 About the Project](#-about-the-project)  
- [🛠️ Technologies & Tools](#️-technologies--tools)  
- [🏛️ Architecture Overview](#️-architecture-overview)  
- [🚀 How to Run](#-how-to-run)  
- [💡 Improvements with More Time](#-improvements-with-more-time)  
- [✉️ Contact](#️-contact)  
---

## 😁 Message to Reviewers

Hello CI&T team! 👋  

It was a pleasure to participate in this challenge and apply my knowledge to the development of this test.  
My main focus was on building a project that balances **code organization, maintainability, and proper testing**.  
I hope the result reflects my dedication and attention to detail.  

Thank you for the opportunity, and feel free to reach out for any feedback or questions!  

---

## 📖 About the Project

The application contains **two main screens**:  

- **List Screen**  
  - Displays a list of items fetched from the TMDB API.  
  - Shows basic information for each item (poster, title, release year, genre).  
  - Includes loading and error states with retry option.  
  - Supports pull-to-refresh functionality.  

- **Detail Screen**  
  - Displays more detailed information about the selected item.  
  - Includes navigation back to the list.  

This project was implemented with **Clean Architecture principles** to ensure code organization, maintainability, and testability.  

---

## 🛠️ Technologies & Tools

- **Swift** – main development language.  
- **UIKit** for building UI.  
- **ViewCode** – UI implemented in code for flexibility.  
- **MVVM (Clean Architecture inspired)** – separation of concerns, easier testing.  
- **RxSwift** – reactive programming for async data flow.  
- **XCTest** – for unit and UI testing.  

---  

## 🏛️ Architecture Overview

```plaintext
MovieListDetailApp/
├── Source/
│   ├── Animation/           # TableView Animation
│   ├── Model/               # Data Model
│   ├── View/                # Main folder for Views and ViewControllers
│   │   ├── Views/           # Reusable UI components and layouts
│   │   └── ViewController/  # Logic and control of main screens
│   ├── ViewModel/           # Data handling and business logic (MVVM)
│   ├── Utils/               # Constants and helpers (images, colors, strings, formatters)
│   └── Service/             # API consumption service
├── Resources/               # Assets and configurations
├── Pods/                    # External dependencies
├── MovieListDetailAppTests/     # Unit tests (e.g., testing ViewModels, Services)
└── MovieListDetailAppUITests/   # UI & integration tests (user flows, navigation)
```

## 🚀 How to Run

### Requirements:
- **Xcode 15** installed on macOS.  
- **CocoaPods** dependency manager.  

### Steps:
1. Clone this repository:
   ```bash
   git clone https://github.com/luchoa54/MovieListDetailApp.git
2. Navigate to the project folder and install dependencies:
   ```bash
   cd MovieListDetailApp
   pod install

3. Open the workspace in Xcode:
   ```bash
   open MovieListDetailApp.xcworkspace
4. ⚠️ IMPORTANT: Configure your API key

> ⚠️ Notice: This is a public repository, so the API key has been **removed** for security reasons.  
> In the private ZIP file sent by email, the API key is included to allow faster testing of the app.

Go to the file:
```swift
Source/Utils/APIConstants.swift
   ```
   and replace ```YOUR_API_KEY``` with your personal API key from The Movie DB.

Example:

```swift
static var authorization: String {
  return "Bearer YOUR_API_KEY" // Replace YOUR_API_KEY with your personal TMDB token
}
```
5. Select a simulator in Xcode and run the project with Cmd + R.

## 💡 Improvements with More Time

If given more time, I would:

- Improve the UI with nicer layouts and simple animations.
- Handle errors better with visual messages.
- Add unit tests for more parts of the app.
- Make the app work offline using cached data.
- Organize the code even more clearly in separate folders for easy maintenance.
- Improve accessibility for visually impaired users and provide localization support for multiple languages.
- Add a search bar to filter movies in the list screen.

## ✉️ Contact

Feel free to get in touch:

- **E-mail**: lucianou54@gmail.com  
- [LinkedIn](https://www.linkedin.com/in/luciano-uchoa/)

