#  Ride Sharing Application (Flutter)

A **modern Uber/Ola-style ride booking & trip management app** built using **Flutter**.  
This project simulates a **real-time ride booking flow** including booking, live driver tracking, trip status updates, fare calculation, and analytics dashboard.

---

##  Features

### Ride Booking
- Pickup & Drop location search (Geocoding)
- Google Maps integration
- Route polyline between pickup and drop
- Distance calculation using Haversine formula
- Ride type selection (Mini, Sedan, Auto, Bike)

### Live Ride Experience
- Driver assignment simulation
- Real-time driver movement on map
- ETA countdown
- Trip status flow:
  - Requested
  - Driver Assigned
  - Ride Started
  - Completed
- Driver snaps to drop location on completion

### Fare Calculation
- Base fare per ride type
- Per-km fare calculation
- Live fare updates during ride
- Distance-based final fare

### Dashboard
- Total trips completed
- Total amount spent
- Recent trips list
- Trips by ride type (chart)

### Architecture
- Provider state management
- Clean separation of UI, Providers, Services
- Hive local storage
- Simulation services for ride & driver lifecycle

---

## Screens Implemented

- Dashboard Screen
- Booking Screen (Map-first UI)
- Ride Status Screen (Live tracking)
- Trips History Screen

---

## Tech Stack

| Technology | Usage |
|-----------|-------|
| Flutter | Cross-platform UI |
| Provider | State management |
| Google Maps | Map & markers |
| Geocoding | Address → Coordinates |
| Hive | Local storage |
| fl_chart | Analytics charts |

---

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  provider: ^6.1.2
  google_maps_flutter: ^2.6.0
  geocoding: ^2.1.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  fl_chart: ^0.66.2
  uuid: ^4.3.3
