Flutter Booking App
Overview
This project is a feature-rich Flutter app prototype designed for managing event bookings. The app provides user authentication, event listing, an organizer section, and an onboarding experience.

Features
Login & Signup: User authentication using Firebase.
OTP Verification: Secure login and registration with OTP-based verification.
Onboarding Screen: Guides users through the app features on first launch.
Home Page: Displays a list of events available for booking.
Event Details: Provides detailed information about each event with booking options.
Organizer Section: Displays event organizers and their hosted events.
Eevents:in Home,and saved events screen and seell events screen
State Management: Implemented using Cubit to ensure smooth UI interactions.
Architecture
The project follows Clean Architecture, ensuring a modular, scalable, and maintainable codebase.

![Screenshot_20250819_184517](https://github.com/user-attachments/assets/c7289e77-b799-45a1-b7d3-daa0063765cd)
![Screenshot_20250819_184522](https://github.com/user-attachments/assets/9282e5e7-5163-4d73-9592-c6eb6a4a76de)
![Screenshot_20250819_185207](https://github.com/user-attachments/assets/8fce5059-698c-47db-9b1a-bccce4e13285)
![Screenshot_20250819_191454](https://github.com/user-attachments/assets/b4576f9f-7166-4b98-b176-c3b324f16b75)
![Screenshot_20250819_191503](https://github.com/user-attachments/assets/a1fd26f4-665d-4ced-8d8d-4bb63e0da172)
![Screenshot_20250819_194114](https://github.com/user-attachments/assets/5c8f4665-3232-424f-b0d6-54d07d2ff20c)
![Screenshot_20250819_194117](https://github.com/user-attachments/assets/2b470f5d-93a1-4c8c-bc40-6375a33537ed)
![Screenshot_20250819_194453](https://github.com/user-attachments/assets/b2a6db8e-6221-451d-9e36-7bc3c514906f)

Technologies Used
Flutter: Frontend UI framework.
Firebase Authentication: User login and registration.
Cubit (Bloc): State management.
Hive: Local storage for caching events and user data.
Dio: Networking package for API calls.
Clean Architecture: Layered architecture for better scalability.
Future Enhancements
Personalized Event Recommendations: Using AI-based suggestions.

Deployment Steps
Ensure all dependencies are installed:
flutter pub get
flutter run
Build APK for deployment:
flutter build apk
