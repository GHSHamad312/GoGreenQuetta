# 🚌 Green Bus App

<div align="center">

  ![Flutter](https://img.shields.io/badge/Made%20with-Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
  ![Firebase](https://img.shields.io/badge/Backend-Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
  ![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
  ![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)

  <p align="center">
    <b>A smart, eco-friendly mobile application for efficient public transportation planning.</b>
    <br />
    <a href="#-screenshots">View Screenshots</a>
    ·
    <a href="https://github.com/ghshamad/green-bus-app/issues">Report Bug</a>
  </p>
</div>

---

## 📖 Table of Contents
- [📍 Overview](#-overview)
- [✨ Key Features](#-key-features)
- [🔧 Tech Stack](#-tech-stack)
- [📸 Screenshots](#-screenshots)
- [🚀 Getting Started](#-getting-started)
- [🤝 Contributing](#-contributing)

---

## 🌟 Overview

**Green Bus App** is designed to modernize the daily commute. By integrating real-time location services with a robust backend, the app solves common public transport hurdles such as uncertainty in bus timings, crowded stops, and cash-only transactions.

It combines **user convenience**, a **clean UI**, and **powerful backend integrations** to deliver a seamless commuting experience.

---

## ✨ Key Features

| Feature | Description |
| :--- | :--- |
| 🗺️ **Live Map & Routes** | Real-time tracking of bus locations and detailed route visualization. |
| 📍 **Smart Stop Detection** | Automatically detects and suggests the nearest bus stops to your location. |
| 💳 **Digital Wallet** | Secure ticket purchasing with a complete transaction history log. |
| 📶 **Live Capacity** | Real-time updates on bus crowding levels before you board. |
| 🔐 **Secure Auth** | Robust user authentication and profile management via Firebase. |
| ⚙️ **Customizable** | Full control over app settings, themes, and notifications. |

---

## 🔧 Tech Stack

This project leverages a modern mobile development stack for performance and scalability.

| Technology | Badge | Purpose |
| :--- | :--- | :--- |
| **Flutter** | ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white) | Cross-platform UI Framework |
| **Dart** | ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white) | Primary Programming Language |
| **Firebase Auth** | ![Firebase Auth](https://img.shields.io/badge/Firebase_Auth-FFCA28?style=flat&logo=firebase&logoColor=black) | User Authentication |
| **Cloud Firestore** | ![Firestore](https://img.shields.io/badge/Cloud_Firestore-FFCA28?style=flat&logo=firebase&logoColor=black) | Real-time NoSQL Database |
| **Flutter Maps** | ![Maps](https://img.shields.io/badge/Flutter_Maps-47B17C?style=flat&logo=google-maps&logoColor=white) | Mapping & Geolocation |
| **Provider** | ![Provider](https://img.shields.io/badge/State_Management-Provider-blue?style=flat) | Application State Management |

---

## 📸 Screenshots

<div align="center">
  
  <h3>📱 User Interface</h3>

  | **Dashboard & Navigation** | **Authentication** |
  |:---:|:---:|
  | <img src="assets/screenshots/dashboard.jpeg" width="250" alt="Home Screen"/> <br/> *Home Dashboard* | <img src="assets/screenshots/login.jpeg" width="250" alt="Login Screen"/> <br/> *Secure Login* |
  
  | **Registration** | **Map Visualization** |
  |:---:|:---:|
  | <img src="assets/screenshots/registration.jpeg" width="250" alt="Sign Up"/> <br/> *New User Registration* | <img src="assets/screenshots/bus routes.jpeg" width="250" alt="Bus Map"/> <br/> *Route Planning* |

  | **Route Details** | **Nearest Stop** |
  |:---:|:---:|
  | <img src="assets/screenshots/route inside.jpeg" width="250" alt="Route Inside"/> <br/> *Detailed Route View* | <img src="assets/screenshots/nearest.jpeg" width="250" alt="Nearest Stop"/> <br/> *Proximity Detection* |

  | **Transactions** | **summary** |
  |:---:|:---:|
  | <img src="assets/screenshots/buy ticket.jpeg" width="250" alt="Buy Ticket"/> <br/> *Purchase Ticket* | <img src="assets/screenshots/ticket summary.jpeg" width="250" alt="Ticket Summary"/> <br/> *Transaction Log* |

</div>

<details>
<summary>⚙️ <b>Click to view Settings & Profile Screens</b></summary>
<br>
<div align="center">
  <table>
    <tr>
      <td><img src="assets/screenshots/settings.jpeg" width="200" alt="Settings"/></td>
      <td><img src="assets/screenshots/about app.jpeg" width="200" alt="About"/></td>
      <td><img src="assets/screenshots/help and support.jpeg" width="200" alt="Help"/></td>
      <td><img src="assets/screenshots/theme.jpeg" width="200" alt="Theme"/></td>
    </tr>
  </table>
</div>
</details>


## 🚀 Getting Started

Follow these steps to set up the project locally.

### 📦 Prerequisites

* [Flutter SDK](https://flutter.dev/docs/get-started/install)
* [Git](https://git-scm.com/downloads)
* Active Firebase Project (for `google-services.json`)

### 🛠 Installation

1.  **Clone the repository**
    ```bash
    git clone [https://github.com/ghshamad/green-bus-app.git](https://github.com/ghshamad/green-bus-app.git)
    cd green-bus-app
    ```

2.  **Install dependencies**
    ```bash
    flutter pub get
    ```

3.  **Firebase Configuration**
    * Download `google-services.json` from your Firebase Console.
    * Place it in `android/app/`.

4.  **Run the App**
    ```bash
    flutter run
    ```

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1.  Fork the project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

---

<div align="center">
  
  **Made with ❤️ by [Hamad Ali Shah](https://github.com/ghshamad)**
  
</div>