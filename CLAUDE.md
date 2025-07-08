# Momento Cake ERP - Project Documentation

## Project Overview

**Name**: BakeFlow ERP
**Tagline**: Gestão inteligente para confeitarias (Smart management for bakeries)
**Initial Client**: Momento Cake (Brazilian bakery)
**Technology Stack**: Flutter Web (Firebase backend)
**Primary Goal**: Recipe costing, pricing optimization, and inventory management

## Visual Identity

### Color Scheme
- **Primary**: #8B4513 (Saddle Brown) - Represents chocolate and warmth
- **Secondary**: #FFF8DC (Cornsilk) - Light, clean bakery feeling
- **Accent**: #FF6B6B (Soft Red) - For CTAs and important elements
- **Success**: #4ECDC4 (Turquoise) - For positive feedback
- **Warning**: #FFD93D (Honey Yellow) - For alerts
- **Neutral Gray**: #6C757D - For secondary text
- **Background**: #FAFAFA - Light gray for main background

### Typography
- **Headers**: Playfair Display (elegant, readable)
- **Body**: Inter (clean, modern, excellent readability)
- **Numbers/Prices**: Roboto Mono (clear distinction for financial data)

### UI Principles
- Mobile-first responsive design
- Card-based layouts for product displays
- Floating Action Buttons (FAB) for primary actions
- Bottom navigation for mobile
- Side navigation for desktop/tablet
- Minimal depth shadows (Material Design 3)
- Rounded corners (8px for cards, 16px for buttons)

## Git Workflow
- Make sure to create small and concise commits with proper messaging
- Create a proper CI/CD to deploy on Firebase with GitHub workflows

## Architecture Overview

### Frontend (Flutter Web)
```
lib/
├── main.dart
├── app/
│   ├── routes/
│   ├── themes/
│   └── constants/
├── core/
│   ├── models/
│   ├── services/
│   ├── utils/
│   └── extensions/
├── features/
│   ├── auth/
│   ├── dashboard/
│   ├── products/
│   ├── recipes/
│   ├── ingredients/
│   ├── suppliers/
│   ├── purchases/
│   ├── pricing/
│   ├── reports/
│   └── settings/
└── shared/
    ├── widgets/
    └── layouts/
```

### Flutter
- Use riverpod for state management
- Use MVVM for feature internal structure, every view should have its viewmodel
- Use FVM for flutter version management

### Firebase Structure
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

## Core Features

### Phase 1: Foundation (MVP)
1. **Authentication & Multi-tenancy**
   - Email/password login
   - Business registration
   - User roles (Owner, Manager, Employee)

2. **Ingredient Management**
   - CRUD operations
   - Unit conversions (kg↔g, L↔mL)
   - Supplier linking
   - Current pricing tracking

3. **Recipe Builder**
   - Ingredient quantities
   - Preparation steps
   - Yield calculation
   - Cost auto-calculation
   - Recipe versioning

4. **Product Catalog**
   - Link to recipes
   - Categories (matching current menus)
   - Size variations
   - Custom pricing rules
   - Photo gallery

5. **Purchase Registry**
   - Receipt photo upload (OCR future feature)
   - Manual entry form
   - Ingredient price updates
   - Supplier tracking

6. **Pricing Calculator**
   - Cost breakdown visualization
   - Margin calculator
   - Suggested pricing
   - Competitor price tracking

### Phase 2: Operations
1. **Order Management**
   - Customer orders
   - Production planning
   - Delivery scheduling

2. **Inventory Tracking**
   - Stock levels
   - Expiration alerts
   - Reorder points

3. **Financial Reports**
   - Profit/loss statements
   - Best/worst performers
   - Seasonal trends

### Phase 3: Growth
1. **Multi-location support**
2. **Desktop app (Flutter Desktop)**
3. **API for integrations**
4. **Advanced analytics**

## Data Models

### Business
```dart
class Business {
  String id;
  String name;
  String cnpj;
  String address;
  String phone;
  Map<String, dynamic> settings;
  DateTime createdAt;
}
```

### Ingredient
```dart
class Ingredient {
  String id;
  String businessId;
  String name;
  String unit; // 'kg', 'g', 'L', 'mL', 'unit'
  double currentPrice;
  String supplierId;
  DateTime lastUpdated;
  double minStock;
  double currentStock;
}
```

### Recipe
```dart
class Recipe {
  String id;
  String businessId;
  String name;
  List<RecipeIngredient> ingredients;
  List<String> steps;
  double yield; // quantidade produzida
  String yieldUnit;
  double preparationTime; // minutos
  double totalCost; // calculado
  DateTime createdAt;
  int version;
}

class RecipeIngredient {
  String ingredientId;
  double quantity;
  String unit;
}
```

### Product
```dart
class Product {
  String id;
  String businessId;
  String name;
  String category; // 'bolos', 'doces', 'doces_finos', etc.
  String recipeId;
  List<ProductVariation> variations;
  List<String> images;
  bool active;
  bool seasonal;
  String seasonalPeriod; // 'natal', 'pascoa'
}

class ProductVariation {
  String size; // 'P', 'M', 'G', '1kg', '2kg'
  double recipeMultiplier; // quanto da receita usa
  double basePrice;
  double suggestedPrice;
  double currentPrice;
}
```

### Purchase
```dart
class Purchase {
  String id;
  String businessId;
  String supplierId;
  DateTime purchaseDate;
  List<PurchaseItem> items;
  double totalAmount;
  String receiptUrl; // Firebase Storage
  String notes;
}

class PurchaseItem {
  String ingredientId;
  double quantity;
  String unit;
  double unitPrice;
  double totalPrice;
}
```

## Security Rules

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

## Development Phases

### Setup Phase
1. Initialize Flutter project with web support
2. Configure Firebase project
3. Set up authentication
4. Create base routing structure
5. Implement theme system

### MVP Development Order
1. Authentication flow
2. Business registration/setup
3. Ingredient CRUD
4. Recipe builder
5. Product catalog
6. Purchase entry
7. Basic pricing calculator
8. Simple dashboard

## Testing Strategy
- Unit tests for calculations
- Widget tests for critical UI
- Integration tests for Firebase
- Manual testing checklist for each feature

## Deployment
- Firebase Hosting for web app
- GitHub Actions for CI/CD
- Environment variables for Firebase config
- Staging and production environments

## Business Logic Rules

### Pricing Rules
1. **Minimum Margin**: 100% (2x ingredient cost)
2. **Suggested Margin**: 150-200% depending on category
3. **Premium Products**: 200-300% margin
4. **Seasonal Adjustment**: +20-50% for holiday items

### Inventory Rules
1. **Perishables**: Alert 2 days before expiration
2. **Reorder Point**: When stock < 2x weekly average usage
3. **Waste Tracking**: Log expired/damaged items

### Recipe Scaling
1. **Linear Scaling**: Most ingredients scale proportionally
2. **Non-linear Items**: Yeast, salt, baking powder (lookup tables)
3. **Yield Variance**: ±5% acceptable

## UI/UX Guidelines

### Mobile Navigation
- Bottom nav: Dashboard, Products, Orders, More
- FAB for quick actions (add product, new order)
- Swipe gestures for common actions

### Forms
- Step-by-step wizards for complex entries
- Auto-save drafts
- Inline validation
- Smart defaults based on history

### Data Display
- Cards for products/recipes
- Tables for financial data (responsive)
- Charts for trends (Chart.js or FL Chart)
- Color coding for margins (red/yellow/green)

## Integration Points
- WhatsApp Business API (future)
- Payment gateways (future)
- Accounting software (future)
- Delivery apps (future)

## Performance Targets
- Initial load: <3 seconds
- Page transitions: <200ms
- Search results: <500ms
- Offline capability for critical features

## Localization
- Portuguese (Brazil) as primary
- Currency: BRL (R$)
- Date format: DD/MM/YYYY
- Decimal separator: comma (,)
- Thousand separator: period (.)

## Error Handling
- User-friendly error messages in Portuguese
- Automatic error reporting to Firebase Crashlytics
- Offline queue for failed operations
- Retry mechanisms for network requests

## Commands to Run
```bash
# Development
flutter run -d chrome --web-port=3000

# Build
flutter build web --release

# Deploy
firebase deploy --only hosting

# Tests
flutter test

# Analyze
flutter analyze
```

## Environment Setup
Create `.env` file:
```
FIREBASE_API_KEY=
FIREBASE_AUTH_DOMAIN=
FIREBASE_PROJECT_ID=
FIREBASE_STORAGE_BUCKET=
FIREBASE_MESSAGING_SENDER_ID=
FIREBASE_APP_ID=
```

## Next Steps
1. Create Flutter project structure
2. Set up Firebase project
3. Implement authentication
4. Build ingredient management
5. Create recipe builder
6. Develop pricing calculator

## Guidelines
- You are the master architect for this project and will handle everything on all ends, you will use git for proper project setup, you will use the firebase cli in order to configure everything that needs to be configured on firebase
- You will test everything you create and check results
- You will have full access to firebase and github to completely create and deploy this project
- You have full access to firebase cli on terminal, use terminal freely to execute commands, only use the account momentocake@gmail.com, the firebase project needs to be setup
- You have full access to GH cli but you should only work within the company https://github.com/momento-cake GH page, a new repo needs to be created