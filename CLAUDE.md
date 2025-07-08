# BakeFlow ERP - Development Documentation

## Project Overview

**Name**: BakeFlow ERP  
**Tagline**: Gestão inteligente para confeitarias (Smart management for bakeries)  
**Initial Client**: Momento Cake (Brazilian bakery)  
**Technology Stack**: Flutter Web (Firebase backend)  
**Primary Goal**: Recipe costing, pricing optimization, and inventory management

**Live Application**: https://bakeflow-erp.web.app  
**Repository**: https://github.com/momento-cake/bakeflow-erp

## Documentation Structure

For detailed technical information, refer to the specialized documentation:

- **[Project Structure](docs/project-structure.md)**: Architecture, patterns, and code organization
- **[Design Guidelines](docs/design-guidelines.md)**: UI styling, color schemes, typography, and component guidelines
- **[Deployment & Infrastructure](docs/deployment-infrastructure.md)**: CI/CD pipeline, Firebase setup, and deployment workflows
- **[README.md](README.md)**: Setup instructions and project overview
- **[GitHub Issues](https://github.com/momento-cake/bakeflow-erp/issues)**: Bug reports and feature requests

## Development Guidelines

### Technology Stack

- **Frontend**: Flutter Web with Material Design 3
- **State Management**: Riverpod for reactive state management
- **Architecture**: MVVM pattern for features, clean architecture principles
- **Backend**: Firebase (Auth, Firestore, Storage, Hosting)
- **Version Control**: Git with conventional commits
- **CI/CD**: GitHub Actions with automated Firebase deployment

### Design System

The application follows a comprehensive design system with warm, professional aesthetics suitable for bakery businesses. For detailed design specifications, including:

- **Color Palettes**: Primary, secondary, semantic colors with accessibility guidelines
- **Typography**: Font families, scales, and usage guidelines  
- **Component Styles**: Buttons, forms, cards, and layout patterns
- **Responsive Design**: Mobile-first approach with consistent breakpoints
- **Accessibility**: WCAG compliance and inclusive design practices

**Refer to: [Design Guidelines](docs/design-guidelines.md)** for complete styling specifications.

### Development Workflow

#### Git Workflow
- **main**: Production-ready code, automatically deployed
- **feature/***: Feature development branches
- **hotfix/***: Critical production fixes
- Small, focused commits with descriptive messages
- Pull requests for code review before merging

#### Commit Conventions
```
feat: add ingredient management CRUD operations
fix: resolve authentication redirect loop
docs: update project structure documentation
style: apply consistent code formatting
refactor: extract common UI components
test: add unit tests for pricing calculator
```

#### Code Standards
- Follow Flutter/Dart conventions and best practices
- Use meaningful variable and function names in English
- Add Portuguese comments for business logic explanations
- Implement proper error handling with user-friendly messages
- Write unit tests for business logic and widget tests for UI

### Feature Development Pattern

Each feature should follow the MVVM structure:

```
features/[feature_name]/
├── models/           # Data models specific to the feature
├── views/            # UI screens and widgets
├── view_models/      # Business logic and state management
└── services/         # Feature-specific services
```

### Firebase Configuration

#### Database Structure
```
firestore/
├── businesses/{businessId}/
│   ├── info (business details)
│   ├── users/{userId}
│   ├── products/{productId}
│   ├── recipes/{recipeId}
│   ├── ingredients/{ingredientId}
│   ├── suppliers/{supplierId}
│   ├── purchases/{purchaseId}
│   ├── pricingHistory/{recordId}
│   └── reports/{reportId}
└── sharedIngredients/ (common ingredients database)
```

#### Security Rules Template
```javascript
// Firestore Rules
match /businesses/{businessId} {
  allow read, write: if request.auth != null && 
    request.auth.uid in resource.data.authorizedUsers;
    
  match /{document=**} {
    allow read, write: if request.auth != null && 
      request.auth.uid in get(/databases/$(database)/documents/businesses/$(businessId)).data.authorizedUsers;
  }
}
```

## Core Features Roadmap

### Phase 1: Foundation (MVP) ✅
1. **Authentication & Multi-tenancy** ✅
   - Email/password login with Firebase Auth
   - Route guards and session management
   - Portuguese error messages

2. **Ingredient Management** 🚧
   - CRUD operations with validation
   - Unit conversions (kg↔g, L↔mL)
   - Supplier linking and price tracking

3. **Recipe Builder** 📋
   - Ingredient quantities and steps
   - Yield calculation and cost auto-calculation
   - Recipe versioning and modification history

4. **Product Catalog** 📋
   - Link to recipes with size variations
   - Categories matching current menus
   - Photo gallery and pricing rules

5. **Purchase Registry** 📋
   - Manual entry forms with receipt tracking
   - Automatic ingredient price updates
   - Supplier management integration

6. **Pricing Calculator** 📋
   - Cost breakdown visualization
   - Margin calculator with business rules
   - Suggested pricing based on market analysis

### Phase 2: Operations 📋
- Order Management (customer orders, production planning)
- Inventory Tracking (stock levels, expiration alerts)
- Financial Reports (profit/loss, performance analysis)

### Phase 3: Growth 📋
- Multi-location support
- Desktop app (Flutter Desktop)
- API for third-party integrations
- Advanced analytics and insights

## Business Logic Rules

### Pricing Guidelines
- **Minimum Margin**: 100% (2x ingredient cost)
- **Suggested Margin**: 150-200% depending on category
- **Premium Products**: 200-300% margin
- **Seasonal Adjustment**: +20-50% for holiday items

### Inventory Management
- **Perishables**: Alert 2 days before expiration
- **Reorder Point**: When stock < 2x weekly average usage
- **Waste Tracking**: Log expired/damaged items for cost analysis

### Recipe Scaling
- **Linear Scaling**: Most ingredients scale proportionally
- **Non-linear Items**: Yeast, salt, baking powder (use lookup tables)
- **Yield Variance**: ±5% acceptable variance in production

## Commands Reference

### Development
```bash
# Start development server
fvm flutter run -d web-server --web-port=3000

# Run tests
fvm flutter test

# Code analysis
fvm flutter analyze

# Build for production
fvm flutter build web --release
```

### Deployment & Infrastructure

The project uses Firebase Hosting with GitHub Actions for automated CI/CD. For comprehensive deployment information including:

- **CI/CD Pipeline**: Automated testing and deployment workflow
- **Firebase Configuration**: Service setup and security rules
- **Environment Management**: Development and production configurations
- **Troubleshooting**: Common issues and solutions
- **Monitoring**: Performance and analytics setup

**Refer to: [Deployment & Infrastructure](docs/deployment-infrastructure.md)** for complete deployment specifications.

### Quick Commands
```bash
# Development
fvm flutter run -d web-server --web-port=3000
fvm flutter test
fvm flutter analyze

# Build and deploy
fvm flutter build web --release
firebase deploy --only hosting

# Automated deployment: push to main branch
git push origin main
```

## Testing Strategy

### Test Coverage
- **Unit Tests**: Business logic, calculations, utility functions
- **Widget Tests**: UI components and user interactions
- **Integration Tests**: Firebase integration and complete workflows
- **Manual Testing**: Cross-browser compatibility and user experience

### Testing Commands
```bash
# Run all tests
fvm flutter test

# Run tests with coverage
fvm flutter test --coverage

# Run specific test file
fvm flutter test test/features/auth/auth_service_test.dart
```

## Performance & Monitoring

The application implements web performance optimizations and monitoring strategies. For detailed information on:

- **Build Optimization**: Bundle size management and asset optimization
- **Performance Monitoring**: Core Web Vitals and Firebase metrics  
- **Error Tracking**: Crashlytics and debugging strategies
- **Analytics Setup**: User behavior and business metrics

**Refer to: [Deployment & Infrastructure](docs/deployment-infrastructure.md)** for complete performance and monitoring specifications.

## Next Development Steps

1. **Enable Firebase Services**: Authentication and Firestore in Firebase Console
2. **Implement Ingredient Management**: CRUD operations with form validation
3. **Build Recipe System**: Ingredient linking and cost calculation
4. **Create Product Catalog**: Menu-based categorization and pricing
5. **Add Purchase Tracking**: Receipt management and price updates
6. **Develop Pricing Tools**: Margin calculation and optimization

## Support and Resources

- **Flutter Documentation**: https://docs.flutter.dev/
- **Firebase Documentation**: https://firebase.google.com/docs
- **Riverpod Documentation**: https://riverpod.dev/
- **Material Design 3**: https://m3.material.io/

## Guidelines for AI Development

- You are the master architect for this project and will handle everything on all ends
- Use git for proper project setup and maintain clean commit history
- Use the Firebase CLI to configure everything needed on Firebase
- Test everything you create and verify results before committing
- You have full access to Firebase and GitHub to completely create and deploy this project
- Only use the account momentocake@gmail.com for Firebase operations
- Work within the company GitHub organization: https://github.com/momento-cake
- Follow the established patterns and maintain consistency with the existing codebase
- Prioritize user experience with intuitive, mobile-first design
- Implement proper error handling and user feedback
- Document significant changes and architectural decisions