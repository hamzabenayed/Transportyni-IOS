# 🚆 Public Transport App (iOS - Swift)

## 📌 Project Overview
Developed an intuitive iOS mobile application aimed at enhancing the public transport experience by providing real-time station locations, route planning, and essential travel information. The app empowers users to navigate public transit efficiently with features such as multimodal trip planning, real-time GPS tracking, and fare management.

## ✨ Key Features
- **📍 Interactive Map Interface** – View public transport stations in real-time on a dynamic map.
- **🗺️ Smart Route Planning** – Calculates the shortest and most efficient routes based on user preferences.
- **📡 Real-Time GPS Navigation** – Live tracking to guide users to their destinations.
- **🚍 Multi-Modal Transport Support** – Plan trips combining buses, metro, tram, and other public transport.
- **💰 Fare & Schedule Management** – Access up-to-date ticket prices, schedules, and transport availability.
- **⭐ User Feedback & Ratings** – Enables users to review and rate transport services.
- **🔒 Secure Data Handling** – Implements security measures for protecting user and transport data.

## 🛠️ Technologies Used
- **Frontend:** Swift (UIKit / SwiftUI), MapKit, CoreLocation, Combine
- **APIs & Services:** Google Maps API, GPS Tracking, RESTful APIs (Node.js Backend)
- **Development Tools:** Xcode, CocoaPods, GitHub
- **Software Design & Modeling:** Unified Modeling Language (UML)

## 🚀 Installation & Setup
### Prerequisites
Ensure you have the following installed:
- **Xcode** (Latest version recommended)
- **CocoaPods** (For managing dependencies)
- **Swift 5+**

### Steps to Run the Project
1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/your-ios-repo.git
   cd your-ios-repo
   ```
2. **Install dependencies**
   ```bash
   pod install
   ```
3. **Open the project in Xcode**
   ```bash
   open PublicTransportApp.xcworkspace
   ```
4. **Configure API Keys**
   - Obtain a Google Maps API key and add it to `Info.plist`
   ```xml
   <key>GMSApiKey</key>
   <string>YOUR_GOOGLE_MAPS_API_KEY</string>
   ```
5. **Run the project**
   - Select a simulator or connected device
   - Click `Run` ▶️ in Xcode

## 🏗️ Architecture
- **MVVM Pattern** – Ensures better code organization and scalability.
- **Combine Framework** – Handles asynchronous operations efficiently.
- **Dependency Injection** – Improves modularity and testability.

## 🔑 API Integration
The app interacts with a **Node.js** backend to fetch transport schedules, fare details, and live tracking data. The endpoints include:
- `/api/routes` – Fetch available transport routes.
- `/api/stations` – Get real-time station locations.
- `/api/fares` – Retrieve ticket prices and payment options.

## 🤝 Contributing
Contributions are welcome! If you’d like to improve the project, follow these steps:
1. Fork the repository.
2. Create a new branch (`feature-branch-name`).
3. Make your changes and commit them.
4. Push to your fork and submit a Pull Request.

## 📝 License
This project is licensed under the **MIT License**.

---

💡 *Have any questions or suggestions? Feel free to reach out!*
