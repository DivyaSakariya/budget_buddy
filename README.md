<p align="center">
  <img src="https://github.com/DivyaSakariya/budget_buddy/blob/master/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png?raw=true" alt="BudgetBuddy Logo" />
</p>


<h1 align="center">BudgetBuddy Expense Tracker</h1>
<h2 align="center">Master your money, master your life</h2>

<p align="center">
  <strong>Effortlessly track your daily expenses with a simple and intuitive Flutter app</strong>
</p>

## Overview

BudgetBuddy is a feature-rich expense management Flutter application designed to provide users with complete control over their finances. The app offers a user-friendly interface and a robust set of features for efficiently tracking expenses, setting and achieving savings goals, and gaining insights into spending patterns.

## Key Features

### Expense Tracking

- **Effortless Recording**: Record daily expenses with ease, providing a seamless experience for users to log transactions on the go.
  
- **Comprehensive Details**: Categorize transactions, add notes, and attach receipts for comprehensive record-keeping.

### Savings Goals

- **Goal Planning**: Plan for the future by setting savings goals. Users can define their objectives and track their progress over time.

- **Visual Progress**: Monitor savings goal progress with visual indicators and celebrate financial milestones.

### Interactive Charts

- **Visual Insights**: Gain insights into your financial health with interactive charts. Analyze spending patterns through visually appealing visualizations, helping users understand their financial habits.

- **Customization**: Users can customize charts to focus on specific time periods or expense categories.

### Categories

- **Organized Transactions**: Organize transactions by categorizing them into predefined or custom categories. The app provides a structured approach to financial management.

- **Category Insights**: Users can analyze spending patterns based on categories, helping them make informed decisions.

### Heatmap Calendar

- **Visualize Activities**: The Heatmap Calendar allows users to visualize spending activities on a color-coded calendar.

- **Identify Patterns**: Users can identify peak spending days and optimize their budget based on historical data.

### Animations

- **Smooth Transitions**: The app incorporates smooth animations for a delightful user experience.

- **Interactive Elements**: Animated buttons, transitions, and visual feedback enhance user engagement.

### PDF Summary

- **Export PDF Reports**: Users can generate and export PDF summaries of their financial data.

- **Customizable Reports**: Choose specific date ranges or categories for detailed and customizable PDF reports.

### PDF Summary

 - Personalize your avatar with random customization options.



## Technologies Used

- [Flutter](https://flutter.dev/): Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
  
- [Provider Package](https://pub.dev/packages/provider): State management for efficient communication between different components of the app.

- [SQFlite Database](https://pub.dev/packages/sqflite): Local database storage for persistent data management.

- [Fl_chart Package](https://pub.dev/packages/fl_chart): A Flutter charting library for visually appealing and customizable charts.

- [Shared Preferences](https://pub.dev/packages/shared_preferences): Light storage for user preferences.

- [HTTP Package](https://pub.dev/packages/http): Facilitates communication with external APIs.

- [Logger](https://pub.dev/packages/logger): A powerful logging package for detailed debugging and error tracking.

- [PDF Package](https://pub.dev/packages/pdf) and [Printing Package](https://pub.dev/packages/printing): Integration for generating and exporting PDF reports.

- Other Dependencies: 
- [`animated_bottom_navigation_bar`](https://pub.dev/packages/animated_bottom_navigation_bar): A customizable animated bottom navigation bar for Flutter.
  - [`percent_indicator`](https://pub.dev/packages/percent_indicator): Circular percent indicators for visualizing progress.
  - [`url_launcher`](https://pub.dev/packages/url_launcher): A Flutter plugin for launching URLs in the mobile platform.
  - [`google_fonts`](https://pub.dev/packages/google_fonts): A package to include Google Fonts in your Flutter app.
  - [`page_transition`](https://pub.dev/packages/page_transition): Beautiful page transition animations for Flutter apps.
  - [`simple_animations`](https://pub.dev/packages/simple_animations): Create custom animations using the AnimationController.
  - [`intl`](https://pub.dev/packages/intl): Provides internationalization and localization support.
  - [`fluentui_system_icons`](https://pub.dev/packages/fluentui_system_icons): Icons from the Fluent System.
  - [`loading_btn`](https://pub.dev/packages/loading_btn): A Flutter package for creating loading buttons.
  - [`animated_text_kit`](https://pub.dev/packages/animated_text_kit): A collection of Flutter widgets for animated text.
  - [`flutter_heatmap_calendar`](https://pub.dev/packages/flutter_heatmap_calendar): A Flutter package to display a heatmap calendar.
  - [`syncfusion_flutter_charts`](https://pub.dev/packages/syncfusion_flutter_charts): Data visualization library for Flutter with various chart types.
  - [`path_provider`](https://pub.dev/packages/path_provider): Provides a platform-agnostic way to find commonly used locations on the filesystem.
  - [`introduction_screen`](https://pub.dev/packages/introduction_screen): A Flutter package to build customizable introduction screens.
  - [`flutter_slidable`](https://pub.dev/packages/flutter_slidable): A Flutter package that provides a slideable widget.
  - [`awesome_dialog`](https://pub.dev/packages/awesome_dialog): A Flutter package for a customizable and flexible dialog.
  - [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons): A package for updating Flutter launcher icons.
  - [`path`](https://pub.dev/packages/path): A package for giving local path to DataBase.
  - [`gap`](https://pub.dev/packages/gap): Flutter widgets for easily adding gaps inside Flex widgets such as Columns and Rows or scrolling views.
  - [`printing`](https://pub.dev/packages/printing): A plugin that allows Flutter apps to generate and print documents to android or ios compatible printers.

## Directory Structure
 
📦 budget_buddy                                                                                                                                         
 ┣ 📂 lib                                                                                                                                                        
 ┃ ┣ 📂 controller                                                                                                                                                
 ┃ ┃ ┣ 📜 api_controller.dart                                                                                                                                        
 ┃ ┃ ┣ 📜 category_controller.dart                                                                                                                                
 ┃ ┃ ┣ 📜 heatmap_controller.dart                                                                                                                                
 ┃ ┃ ┣ 📜 login_controller.dart                                                                                                                               
 ┃ ┃ ┣ 📜 pageindex_controller.dart                                                                                                                                
 ┃ ┃ ┣ 📜 savings_controller.dart                                                                                                                                
 ┃ ┃ ┣ 📜 transaction_controller.dart                                                                                                                                
 ┃ ┃ ┗ 📜 user_controller.dart                                                                                                                                       
 ┃ ┣ 📂 helper                                                                                                                                                       
 ┃ ┃ ┣ 📜 api_helper.dart                                                                                                                                            
 ┃ ┃ ┗ 📜 db_helper.dart                                                                                                                                       
 ┃ ┣ 📂 modal                                                                                                                                                        
 ┃ ┃ ┣ 📜 category_modal.dart                                                                                                                                
 ┃ ┃ ┣ 📜 chart_modal.dart                                                                                                                                
 ┃ ┃ ┣ 📜 saving_goal_modal.dart                                                                                                                                
 ┃ ┃ ┣ 📜 saving_modal.dart                                                                                                                                
 ┃ ┃ ┣ 📜 transaction_modal.dart                                                                                                                                
 ┃ ┃ ┗ 📜 user_modal.dart                                                                                                                                
 ┃ ┣ 📂 utility                                                                                                                                                   
 ┃ ┃ ┣ 📂 animation                                                                                                                                            
 ┃ ┃ ┃ ┣ 📜 fade_animation_controller.dart                                                                                                                                
 ┃ ┃ ┃ ┗ 📜 loop_controller.dart                                                                                                                                
 ┃ ┃ ┗ 📜 avtar_list.dart    
 ┃ ┃ ┗ 📜 colors.dart    
 ┃ ┣ 📂 views                                                                                                                                
 ┃ ┃ ┣ 📂 component                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 saving_goal_tile.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 saving_tile.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 setting_tile.dart                                                                                                                                
 ┃ ┃ ┃ ┗ 📜 tran_tile.dart                                                                                                                                
 ┃ ┃ ┣ 📂 screens                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 add_transaction.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 history_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 home_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 intro_screen_1.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 intro_screen_2.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 intro_screen_3.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 login_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 monthly_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 recent_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 saving_goal_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 saving_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 signup_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 splash_screen.dart                                                                                                                       
 ┃ ┣ 📜 main.dart                                                                                                                                
 ┗ 📜 .gitignore                                                                                                                                


The app follows the MVC (Model-View-Controller) pattern:

- **lib/controller:** Contains all the controller classes responsible for managing app logic.
- **lib/helper:** Includes helper classes such as API helpers and database helpers.
- **lib/modal:** Holds modal classes defining the structure of data objects.
- **lib/utility/animation:** Houses animation-related utility classes.
- **lib/views/component:** Custom widgets and components used across the app.
- **lib/views/screens:** Individual screens of the app.
- **lib/main.dart:** The entry point of the application.
- **lib/splash_screen.dart:** SplashScreen, the initial screen displayed when the app launches.

## Asset Files

- **assets/images:** Directory for storing image assets.

## Screen Reviews

### Home Screen

- The home screen provides a quick overview of recent transactions and savings goals.

### Analytics Screen

- The analytics screen displays interactive charts, allowing users to analyze their spending patterns.

### Saving Goals Screen

- Users can set and track their savings goals, ensuring better financial planning.

### Transactions Screen

- The transactions screen lists all logged expenses, providing details such as date, category, and amount.

### Profile Screen

- The profile screen allows users to view and edit their account information.

## Animation Enhancements

- The app incorporates subtle animations for a more engaging user experience.

## Custom Widgets

- Various custom widgets, such as `SavingTile`, `SettingTile`, and `TransactionTile`, enhance the UI.

## Utils

- Utility classes, including `FadeAnimation` and `LoopAnimation`, are utilized for animation effects.

## Directory Structure

- The app maintains a clear and organized directory structure, following best practices.

## Screenshots

<img src="https://github.com/user-attachments/assets/5356d08b-f798-437e-8995-f3174e25ccee" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/c0edc8f0-e606-40c4-ba7f-1e33a219bcb0" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/390f9e59-d470-44e9-87f1-e9fc202fdd8d" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/f24e0087-06ed-4411-888c-cc718119e4e2" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/aba928eb-1e0d-481b-8b48-ae1b194cce9e" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/13be6fe7-f21f-4202-9d3b-2644655ef7ee" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/03d782b1-4904-401e-8153-320e8ae4b966" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/0a4af6cc-0faa-4506-a2c7-ff76247e8bd3" alt="Image" width="200">
<img src="https://github.com/user-attachments/assets/f7cb908b-ebc2-491b-9bc4-8b827ec1fba9" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/0915f657-8a35-4ea3-989c-200518529783" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/baa3826d-8690-4988-9cec-aa677c355ea0" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/a1e07426-439f-44c1-8302-c97438056482" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/d228d095-47c8-44fe-be02-3131f667a265" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/61501466-2be8-410a-a7f0-4971f38b25d1" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/502c227e-35f2-4671-95ab-8d7ef71679f9" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/d8e0b1a4-a5b2-438d-a167-13aafdfcb914" alt="Image" width="200">  
<img src="https://github.com/user-attachments/assets/c0762040-20d6-4d0f-8300-a8ed6b62b958" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/fb216f70-fd9a-4f5d-875d-381da24b4119" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/0e949d1f-1b55-457d-8235-c7e6366ea021" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/61cd74e4-7132-413a-81d2-7fceebc2d09a" alt="Image" width="200"> 
<img src="https://github.com/user-attachments/assets/34975f44-f8e6-4164-bc32-d2eeb6faab3d" alt="Image" width="200"> 


## Getting Started

1. **Clone the repository:**
    ```bash
    git clone https://github.com/DivyaSakariya/budget_buddy.git
    cd budget_buddy
    ```

2. **Install dependencies:**
    ```bash
    flutter pub get
    ```

3. **Run the app:**
    ```bash
    flutter run
    ```

## Avatar Customization

Explore BudgetBuddy's avatar customization feature to add a personal touch to your user profile.

## Logger Integration

BudgetBuddy employs the Logger package for detailed debugging and error tracking. View logs in the console or customize logging as needed.

```dart
// Example Usage
import 'package:logger/logger.dart';

final Logger logger = Logger();

void main() {
  logger.d('Debug message');
  logger.i('Information message');
  logger.e('Error message');
}
```

## AppIcon Integration

A package for updating Flutter launcher icons to BudgetBuddy Icon.

1. Add Package in .yaml file
```dart
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_launcher_icons: any

flutter_icons:
  image_path: "assets/images/MainIcon.png"
  android: true
  ios: true
```
2. Run the package in terminal
```dart
flutter pub get
flutter pub run flutter_launcher_icons:main
```

## Contributing

Contributions are welcome! Feel free to open issues, suggest improvements, or submit pull requests following our guidelines.

## License

BudgetBuddy is licensed under the MIT License. Refer to the [GT](LICENSE) file for details.

## Acknowledgments

We extend our gratitude to the Flutter community, contributors, and third-party libraries that contribute to the success of BudgetBuddy.
