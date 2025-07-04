# 🏟️ Sports App – iOS Project Using Swift

An iOS sports app developed in Swift, leveraging the [AllSportsAPI](https://allsportsapi.com/) to provide users with real-time and historical sports data. This app includes an elegant UI, favorite leagues storage using CoreData, and navigational flows for league, event, and team details.

---

## 📱 Features

### 🔹 Main Screen (Tab Bar Controller)
- **Tab 1 – Sports**  
  - Displays a list of sports from the SportsDB API using a `UICollectionView`
  - Each row shows two sports with spacing, including sport name and thumbnail
  - Tapping a sport navigates to its leagues

- **Tab 2 – Favorite Leagues**
  - Shows user-saved leagues using CoreData
  - UI mirrors the Leagues screen
  - If offline, alerts the user instead of navigating

---

### 📋 Leagues ViewController
- A `UITableViewController` titled **Leagues**
- Each row includes:
  - Circular league badge
  - League name
- Tapping a row opens the League Details

---

### 📊 LeagueDetails ViewController
- Add league to favorites via button in top-right
- Divided into 3 main sections:
  1. **Upcoming Events** – Horizontal collection of event name, date, time, and team images
  2. **Latest Events** – Vertical collection with teams, scores, date, time, and images
  3. **Teams** – Horizontal scrolling collection of team logos; tap navigates to team details

---

### 🧾 TeamDetails ViewController
- Shows detailed information about a team
- UI is customizable but must remain elegant and consistent

---

## 🧪 Technical Stack
- **Language:** Swift
- **Networking:** [Alamofire](https://github.com/Alamofire/Alamofire)
- **Data Persistence:** CoreData
- **Design Patterns:** MVP
- **Testing:** XCTest
- 
---

## 📸 Screenshots

> Add screenshots or screen recordings here for visual documentation.

---

