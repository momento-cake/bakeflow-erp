# BakeFlow ERP - Project Structure

## Overview

BakeFlow ERP is a Flutter web application designed for intelligent bakery management. The project follows a clean architecture pattern with MVVM structure for features, using Riverpod for state management and Firebase as the backend.

## Directory Structure

```
bakeflow-erp/
├── lib/                          # Main application source code
│   ├── main.dart                 # Application entry point
│   ├── app/                      # App-level configuration
│   │   ├── routes/               # Navigation and routing
│   │   │   └── app_router.dart   # GoRouter configuration with auth guards
│   │   ├── themes/               # Visual design system
│   │   │   └── app_theme.dart    # Material 3 theme with brand colors
│   │   └── constants/            # App-wide constants
│   ├── core/                     # Core business logic and shared services
│   │   ├── models/               # Data models and entities
│   │   │   └── user_model.dart   # User authentication model
│   │   ├── services/             # Business services and APIs
│   │   │   └── auth_service.dart # Firebase authentication service
│   │   ├── utils/                # Utility functions and helpers
│   │   └── extensions/           # Dart extensions
│   ├── features/                 # Feature-based modules (MVVM pattern)
│   │   ├── auth/                 # Authentication feature
│   │   │   └── login_screen.dart # Login UI with form validation
│   │   ├── dashboard/            # Main dashboard
│   │   │   └── dashboard_screen.dart # Dashboard with feature cards
│   │   ├── products/             # Product catalog management
│   │   ├── recipes/              # Recipe builder and management
│   │   ├── ingredients/          # Ingredient CRUD operations
│   │   ├── suppliers/            # Supplier management
│   │   ├── purchases/            # Purchase registry and receipts
│   │   ├── pricing/              # Pricing calculator and margins
│   │   ├── reports/              # Financial and operational reports
│   │   └── settings/             # App settings and preferences
│   └── shared/                   # Shared UI components and layouts
│       ├── widgets/              # Reusable UI components
│       │   ├── app_button.dart   # Styled button component
│       │   └── app_text_field.dart # Styled input field component
│       └── layouts/              # Layout templates
├── web/                          # Web-specific assets
│   ├── index.html                # Main HTML template
│   ├── manifest.json             # PWA manifest
│   └── icons/                    # App icons and favicons
├── test/                         # Test files
│   └── widget_test.dart          # Widget and unit tests
├── docs/                         # Project documentation
│   ├── features/                 # Feature-specific documentation
│   │   ├── README.md            # Feature documentation guidelines
│   │   └── ingredient-management.md # Example feature documentation
│   └── project-structure.md     # This file
├── menus/                        # Business reference materials
│   ├── details.md                # Menu descriptions
│   └── *.pdf                     # Current bakery menu files
├── .github/                      # GitHub configuration
│   └── workflows/                # CI/CD workflows
│       └── deploy.yml            # Firebase deployment pipeline
├── firebase.json                 # Firebase project configuration
├── .firebaserc                   # Firebase project aliases
├── pubspec.yaml                  # Flutter dependencies and metadata
├── CLAUDE.md                     # Development documentation and guidelines
└── README.md                     # Project overview and setup instructions
```

## Architecture Patterns

### MVVM Pattern for Features

Each feature follows the Model-View-ViewModel pattern:

```
features/[feature_name]/
├── models/                       # Feature-specific data models
├── views/                        # UI screens and widgets
├── view_models/                  # Business logic and state management
└── services/                     # Feature-specific services
```

### State Management with Riverpod

- **Providers**: Global state and dependency injection
- **StateNotifiers**: Complex state management
- **FutureProviders**: Async data loading
- **StreamProviders**: Real-time data streams

### Firebase Integration

```
Firebase Services:
├── Authentication              # User management and security
├── Firestore                  # NoSQL database for app data
├── Storage                    # File uploads and media storage
└── Hosting                    # Web app deployment
```

## Code Organization Principles

### 1. Feature-First Structure
- Each major feature has its own directory
- Self-contained modules with clear boundaries
- Minimal cross-feature dependencies

### 2. Layered Architecture
- **Presentation Layer**: UI components and screens
- **Business Layer**: Services and view models
- **Data Layer**: Models and repositories
- **Core Layer**: Shared utilities and configurations

### 3. Dependency Flow
```
UI Layer → Business Layer → Data Layer
    ↓           ↓              ↓
Widgets → ViewModels → Services → Models
```

## Naming Conventions

### Files and Directories
- **snake_case** for file names: `user_model.dart`
- **lowercase** for directory names: `features/auth/`
- **descriptive names** that indicate purpose

### Dart Code
- **PascalCase** for classes: `UserModel`, `AuthService`
- **camelCase** for variables and methods: `currentUser`, `signInWithEmail()`
- **SCREAMING_SNAKE_CASE** for constants: `API_BASE_URL`

### UI Components
- **Prefixed with "App"**: `AppButton`, `AppTextField`
- **Descriptive suffixes**: `LoginScreen`, `DashboardScreen`

## Data Models Structure

### Core Models
```dart
// User authentication and profile
class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  // ... other properties
}

// Business entity
class Business {
  final String id;
  final String name;
  final String cnpj;
  // ... other properties
}
```

### Feature Models
```dart
// Ingredient management
class Ingredient {
  final String id;
  final String businessId;
  final String name;
  final String unit;
  final double currentPrice;
  // ... other properties
}

// Recipe management
class Recipe {
  final String id;
  final String businessId;
  final String name;
  final List<RecipeIngredient> ingredients;
  final double totalCost;
  // ... other properties
}
```

## Service Layer Architecture

### Authentication Service
- Firebase Auth integration
- User session management
- Error handling with Portuguese messages

### Data Services
- Repository pattern for data access
- Firestore integration
- Offline capability planning

### Business Logic Services
- Pricing calculations
- Inventory management
- Recipe cost calculation

## UI Component System

### Design System
- **Theme**: Material 3 with custom brand colors
- **Typography**: Google Fonts (Playfair Display + Inter)
- **Color Palette**: Warm bakery-inspired colors
- **Spacing**: Consistent spacing scale
- **Components**: Reusable, accessible widgets

### Component Categories
- **Atoms**: Basic elements (buttons, inputs, icons)
- **Molecules**: Simple combinations (form fields, cards)
- **Organisms**: Complex components (forms, lists)
- **Templates**: Page layouts and structures

## Development Workflow

### Branch Strategy
- `main`: Production-ready code
- `develop`: Integration branch
- `feature/*`: Feature development
- `hotfix/*`: Critical fixes

### Commit Conventions
- **feat**: New features
- **fix**: Bug fixes
- **docs**: Documentation updates
- **style**: Code formatting
- **refactor**: Code restructuring
- **test**: Test additions/updates

### Testing Strategy
- **Unit Tests**: Business logic and utilities
- **Widget Tests**: UI components
- **Integration Tests**: Feature workflows
- **E2E Tests**: Complete user journeys

## Build and Deployment

### Development Environment
- **FVM**: Flutter version management
- **Hot Reload**: Development efficiency
- **Debug Mode**: Development builds

### Production Deployment
- **GitHub Actions**: Automated CI/CD
- **Firebase Hosting**: Web app hosting
- **Code Analysis**: Automated quality checks
- **Testing**: Automated test execution

## Performance Considerations

### Web Optimization
- **Tree Shaking**: Unused code elimination
- **Code Splitting**: Lazy loading of features
- **Asset Optimization**: Image and font optimization
- **Caching**: Browser and Firebase caching

### Bundle Size Management
- Selective imports
- Lazy loading of features
- Asset optimization
- Dependency auditing

## Security Implementation

### Authentication Security
- Firebase Auth integration
- Route guards for protected content
- Session management
- Secure token handling

### Data Security
- Firestore security rules
- Input validation and sanitization
- XSS protection
- CSRF protection

## Internationalization (i18n)

### Current Implementation
- **Primary Language**: Portuguese (Brazil)
- **Error Messages**: Localized to Portuguese
- **Date/Time**: Brazilian format (DD/MM/YYYY)
- **Currency**: Brazilian Real (R$)

### Future Expansion
- Multi-language support framework
- Locale-specific formatting
- Cultural adaptations

## Monitoring and Analytics

### Performance Monitoring
- Firebase Performance Monitoring
- Core Web Vitals tracking
- Error reporting and logging

### User Analytics
- User behavior tracking
- Feature usage analytics
- Performance metrics

## Documentation Standards

### Code Documentation
- **JSDoc style** comments for complex functions
- **README files** for each major feature
- **Inline comments** for business logic
- **Type annotations** for all public APIs

### API Documentation
- Service interface documentation
- Model schema definitions
- Error code references
- Usage examples

This structure ensures maintainability, scalability, and clear separation of concerns while following Flutter and Firebase best practices.