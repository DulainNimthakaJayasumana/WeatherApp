
# WeatherApp

This is a SwiftUI Weather App that uses the OpenWeather API to fetch current weather data based on the user's location.

## Features
- Current weather conditions (temperature, humidity, wind speed, etc.)
- Dynamic theming with a fixed dark theme
- Location services for fetching user’s coordinates
- A simple and clean user interface

## Setup
1. Clone the repository.
2. Open `WeatherApp.xcodeproj` in Xcode.
3. In `Managers/WeatherManager.swift`, replace `YOUR_API_KEY` with your valid OpenWeather API key.
4. Ensure that your Info.plist contains the key `NSLocationWhenInUseUsageDescription` with an appropriate description.
5. Build and run the project.

## File Structure
- **Components/WeatherRow.swift**: Reusable component to display a weather condition row.
- **Managers/LocationManager.swift**: Manages user location.
- **Managers/WeatherManager.swift**: Fetches weather data from the OpenWeather API.
- **Preview Content/ModelData.swift** & **weatherData.json**: Provides sample data for SwiftUI previews.
- **Views/**: Contains the main UI files.
- **WeatherAppApp.swift**: App entry point.
