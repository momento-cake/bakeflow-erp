# Feature Documentation: Ingredient Management System

## Feature Overview

### Feature ID
`ingredient-management`

### Feature Name
Ingredient Management System

### Priority Level
**High Priority** - Phase 1 MVP Feature

### Feature Status
```yaml
Status: 🚧 In Development
Phase: Implementation
Started: 2025-07-08
Target Completion: 2025-07-15
Dependencies: Authentication (completed)
Blockers: None
```

### Business Context
The Ingredient Management System allows bakery owners to manage their inventory of ingredients, track pricing from suppliers, and maintain accurate cost calculations for recipes. This feature is critical for the recipe costing functionality and pricing calculator.

### User Stories
```yaml
As a bakery owner, I want to:
  - Add new ingredients to my inventory
  - Update ingredient prices when I make purchases
  - Track which suppliers I buy from
  - Set reorder points for ingredients
  - View ingredient cost history
  - Convert between different units (kg/g, L/mL)

As a baker, I want to:
  - Search for ingredients quickly
  - View current ingredient prices
  - See ingredient availability
  - Update ingredient quantities after use

As a manager, I want to:
  - Generate ingredient cost reports
  - Track ingredient usage patterns
  - Monitor supplier performance
  - Set up automatic reorder alerts
```

## Technical Specification

### Data Models

#### Ingredient Model
```dart
class Ingredient {
  final String id;
  final String businessId;
  final String name;
  final String description;
  final IngredientUnit unit;
  final double currentPrice;
  final String supplierId;
  final DateTime lastUpdated;
  final double minStock;
  final double currentStock;
  final IngredientCategory category;
  final List<String> allergens;
  final bool isActive;
  final DateTime createdAt;
  final String createdBy;

  const Ingredient({
    required this.id,
    required this.businessId,
    required this.name,
    required this.description,
    required this.unit,
    required this.currentPrice,
    required this.supplierId,
    required this.lastUpdated,
    required this.minStock,
    required this.currentStock,
    required this.category,
    required this.allergens,
    required this.isActive,
    required this.createdAt,
    required this.createdBy,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      businessId: json['businessId'],
      name: json['name'],
      description: json['description'] ?? '',
      unit: IngredientUnit.fromString(json['unit']),
      currentPrice: json['currentPrice']?.toDouble() ?? 0.0,
      supplierId: json['supplierId'] ?? '',
      lastUpdated: DateTime.parse(json['lastUpdated']),
      minStock: json['minStock']?.toDouble() ?? 0.0,
      currentStock: json['currentStock']?.toDouble() ?? 0.0,
      category: IngredientCategory.fromString(json['category']),
      allergens: List<String>.from(json['allergens'] ?? []),
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      createdBy: json['createdBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'businessId': businessId,
      'name': name,
      'description': description,
      'unit': unit.toString(),
      'currentPrice': currentPrice,
      'supplierId': supplierId,
      'lastUpdated': lastUpdated.toIso8601String(),
      'minStock': minStock,
      'currentStock': currentStock,
      'category': category.toString(),
      'allergens': allergens,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
    };
  }
}

enum IngredientUnit {
  kilogram, gram, liter, milliliter, unit, pound, ounce, cup, tablespoon, teaspoon;

  static IngredientUnit fromString(String value) {
    return IngredientUnit.values.firstWhere(
      (unit) => unit.toString().split('.').last == value,
      orElse: () => IngredientUnit.kilogram,
    );
  }
}

enum IngredientCategory {
  flour, sugar, dairy, eggs, fats, leavening, flavoring, nuts, fruits, chocolate, spices, preservatives, other;

  static IngredientCategory fromString(String value) {
    return IngredientCategory.values.firstWhere(
      (category) => category.toString().split('.').last == value,
      orElse: () => IngredientCategory.other,
    );
  }
}
```

#### Supplier Model
```dart
class Supplier {
  final String id;
  final String businessId;
  final String name;
  final String contactPerson;
  final String phone;
  final String email;
  final String address;
  final double rating;
  final List<String> categories;
  final bool isActive;
  final DateTime createdAt;

  const Supplier({
    required this.id,
    required this.businessId,
    required this.name,
    required this.contactPerson,
    required this.phone,
    required this.email,
    required this.address,
    required this.rating,
    required this.categories,
    required this.isActive,
    required this.createdAt,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'],
      businessId: json['businessId'],
      name: json['name'],
      contactPerson: json['contactPerson'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      rating: json['rating']?.toDouble() ?? 0.0,
      categories: List<String>.from(json['categories'] ?? []),
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'businessId': businessId,
      'name': name,
      'contactPerson': contactPerson,
      'phone': phone,
      'email': email,
      'address': address,
      'rating': rating,
      'categories': categories,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
```

### Architecture Design

#### File Structure
```
lib/features/ingredients/
├── models/
│   ├── ingredient_model.dart
│   ├── supplier_model.dart
│   └── ingredient_category_model.dart
├── services/
│   ├── ingredient_service.dart
│   ├── supplier_service.dart
│   └── ingredient_validation_service.dart
├── repositories/
│   ├── ingredient_repository.dart
│   └── supplier_repository.dart
├── providers/
│   ├── ingredient_providers.dart
│   ├── supplier_providers.dart
│   └── ingredient_form_providers.dart
├── views/
│   ├── ingredient_list_screen.dart
│   ├── ingredient_detail_screen.dart
│   ├── ingredient_form_screen.dart
│   └── supplier_selection_screen.dart
├── widgets/
│   ├── ingredient_card.dart
│   ├── ingredient_form_fields.dart
│   ├── unit_converter_widget.dart
│   └── stock_level_indicator.dart
└── utils/
    ├── ingredient_validators.dart
    ├── unit_converter.dart
    └── ingredient_search_filter.dart
```

#### Firestore Structure
```
firestore/
└── businesses/{businessId}/
    ├── ingredients/{ingredientId}
    │   ├── id: string
    │   ├── name: string
    │   ├── description: string
    │   ├── unit: string
    │   ├── currentPrice: number
    │   ├── supplierId: string
    │   ├── lastUpdated: timestamp
    │   ├── minStock: number
    │   ├── currentStock: number
    │   ├── category: string
    │   ├── allergens: array<string>
    │   ├── isActive: boolean
    │   ├── createdAt: timestamp
    │   └── createdBy: string
    └── suppliers/{supplierId}
        ├── id: string
        ├── name: string
        ├── contactPerson: string
        ├── phone: string
        ├── email: string
        ├── address: string
        ├── rating: number
        ├── categories: array<string>
        ├── isActive: boolean
        └── createdAt: timestamp
```

### Implementation Plan

#### Phase 1: Core CRUD Operations (Priority: High)
```yaml
Tasks:
  1. Create data models (Ingredient, Supplier)
  2. Implement Firestore repositories
  3. Create basic service layer
  4. Build ingredient list view
  5. Implement add/edit ingredient form
  6. Add basic validation

Files to Create:
  - lib/features/ingredients/models/ingredient_model.dart
  - lib/features/ingredients/models/supplier_model.dart
  - lib/features/ingredients/repositories/ingredient_repository.dart
  - lib/features/ingredients/services/ingredient_service.dart
  - lib/features/ingredients/providers/ingredient_providers.dart
  - lib/features/ingredients/views/ingredient_list_screen.dart
  - lib/features/ingredients/views/ingredient_form_screen.dart

Dependencies:
  - Authentication system (completed)
  - Firestore configuration (needs setup)
  - Business context provider

Acceptance Criteria:
  - Users can view list of ingredients
  - Users can add new ingredients
  - Users can edit existing ingredients
  - Users can delete ingredients
  - All operations are validated
  - Data persists in Firestore
```

#### Phase 2: Advanced Features (Priority: Medium)
```yaml
Tasks:
  1. Implement supplier management
  2. Add unit conversion system
  3. Create search and filtering
  4. Add stock level indicators
  5. Implement reorder alerts

Files to Create:
  - lib/features/ingredients/services/supplier_service.dart
  - lib/features/ingredients/utils/unit_converter.dart
  - lib/features/ingredients/widgets/stock_level_indicator.dart
  - lib/features/ingredients/views/supplier_selection_screen.dart
  - lib/features/ingredients/utils/ingredient_search_filter.dart

Dependencies:
  - Phase 1 completion
  - Notification system (future)

Acceptance Criteria:
  - Users can manage suppliers
  - Unit conversions work correctly
  - Search/filter functionality works
  - Stock levels are visually indicated
  - Low stock alerts are triggered
```

#### Phase 3: Integration & Analytics (Priority: Low)
```yaml
Tasks:
  1. Integration with recipe system
  2. Cost history tracking
  3. Usage analytics
  4. Supplier performance metrics
  5. Inventory reports

Files to Create:
  - lib/features/ingredients/services/ingredient_analytics_service.dart
  - lib/features/ingredients/views/ingredient_reports_screen.dart
  - lib/features/ingredients/models/ingredient_cost_history_model.dart

Dependencies:
  - Phase 2 completion
  - Recipe system (future)
  - Reporting system (future)

Acceptance Criteria:
  - Recipe integration works
  - Cost history is tracked
  - Analytics are generated
  - Reports are available
```

### UI/UX Design

#### Design Requirements
```yaml
Visual Design:
  - Follow Material Design 3 principles
  - Use BakeFlow color scheme (primary: #8B4513)
  - Implement responsive design for mobile-first
  - Use appropriate typography hierarchy
  - Include accessibility features

Component Design:
  - Ingredient cards with key information
  - Form fields with validation feedback
  - Search bar with filtering options
  - Stock level indicators with color coding
  - Floating action button for adding ingredients

Navigation:
  - Bottom navigation integration
  - Breadcrumb navigation for deep screens
  - Back button functionality
  - Search functionality in app bar
```

#### User Interface Mockups
```yaml
Ingredient List Screen:
  - App bar with search and filter icons
  - List of ingredient cards
  - Each card shows: name, current price, stock level, supplier
  - Color-coded stock level indicators
  - Floating action button to add ingredient
  - Pull-to-refresh functionality

Ingredient Detail Screen:
  - App bar with edit and delete actions
  - Ingredient image placeholder
  - Detailed information display
  - Stock level chart
  - Price history graph
  - Supplier information
  - Usage statistics

Ingredient Form Screen:
  - Form fields for all ingredient properties
  - Unit selector dropdown
  - Supplier selection
  - Category selection
  - Allergen selection (multi-select)
  - Save and cancel buttons
  - Form validation feedback
```

### Business Logic

#### Validation Rules
```dart
class IngredientValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome do ingrediente é obrigatório';
    }
    if (value.length < 2) {
      return 'Nome deve ter pelo menos 2 caracteres';
    }
    if (value.length > 100) {
      return 'Nome deve ter no máximo 100 caracteres';
    }
    return null;
  }

  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preço é obrigatório';
    }
    final price = double.tryParse(value.replaceAll(',', '.'));
    if (price == null) {
      return 'Preço deve ser um número válido';
    }
    if (price < 0) {
      return 'Preço deve ser positivo';
    }
    if (price > 999999.99) {
      return 'Preço muito alto';
    }
    return null;
  }

  static String? validateStock(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Stock is optional
    }
    final stock = double.tryParse(value.replaceAll(',', '.'));
    if (stock == null) {
      return 'Quantidade deve ser um número válido';
    }
    if (stock < 0) {
      return 'Quantidade deve ser positiva';
    }
    return null;
  }

  static String? validateMinStock(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Min stock is optional
    }
    final minStock = double.tryParse(value.replaceAll(',', '.'));
    if (minStock == null) {
      return 'Estoque mínimo deve ser um número válido';
    }
    if (minStock < 0) {
      return 'Estoque mínimo deve ser positivo';
    }
    return null;
  }
}
```

#### Business Rules
```yaml
Stock Management:
  - Low stock alert when current stock <= min stock
  - Critical stock alert when current stock <= min stock * 0.5
  - Out of stock when current stock = 0
  - Reorder suggestion when stock is low

Price Management:
  - Track price history for cost analysis
  - Alert when price changes > 20% from previous
  - Calculate average price over time periods
  - Support different currencies (future)

Supplier Management:
  - Rate suppliers based on delivery and quality
  - Track supplier performance metrics
  - Suggest best suppliers for reorders
  - Manage supplier contact information

Unit Conversion:
  - Convert between metric and imperial units
  - Support recipe scaling calculations
  - Validate unit compatibility
  - Maintain precision in conversions
```

### Security Implementation

#### Data Security
```yaml
Access Control:
  - Users can only access their business ingredients
  - Role-based permissions for ingredient management
  - Audit trail for ingredient changes
  - Data encryption at rest and in transit

Input Validation:
  - Sanitize all user inputs
  - Validate file uploads (images)
  - Check for SQL injection attempts
  - Implement rate limiting

Business Logic Security:
  - Validate business ownership on all operations
  - Check user permissions before modifications
  - Log all sensitive operations
  - Implement data backup and recovery
```

#### Firestore Security Rules
```javascript
// Firestore Security Rules for Ingredients
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /businesses/{businessId}/ingredients/{ingredientId} {
      allow read, write: if request.auth != null && 
        request.auth.uid in get(/databases/$(database)/documents/businesses/$(businessId)).data.authorizedUsers;
        
      allow create: if request.auth != null && 
        request.auth.uid in get(/databases/$(database)/documents/businesses/$(businessId)).data.authorizedUsers &&
        validateIngredientData(request.resource.data);
        
      allow update: if request.auth != null && 
        request.auth.uid in get(/databases/$(database)/documents/businesses/$(businessId)).data.authorizedUsers &&
        validateIngredientData(request.resource.data);
        
      allow delete: if request.auth != null && 
        request.auth.uid in get(/databases/$(database)/documents/businesses/$(businessId)).data.authorizedUsers;
    }
    
    match /businesses/{businessId}/suppliers/{supplierId} {
      allow read, write: if request.auth != null && 
        request.auth.uid in get(/databases/$(database)/documents/businesses/$(businessId)).data.authorizedUsers;
    }
  }
}

function validateIngredientData(data) {
  return data.keys().hasAll(['name', 'businessId', 'unit', 'currentPrice', 'createdAt']) &&
         data.name is string &&
         data.name.size() > 0 &&
         data.businessId is string &&
         data.currentPrice is number &&
         data.currentPrice >= 0;
}
```

### Testing Strategy

#### Unit Tests
```yaml
Test Files:
  - test/features/ingredients/models/ingredient_model_test.dart
  - test/features/ingredients/services/ingredient_service_test.dart
  - test/features/ingredients/repositories/ingredient_repository_test.dart
  - test/features/ingredients/utils/ingredient_validators_test.dart
  - test/features/ingredients/utils/unit_converter_test.dart

Test Coverage:
  - Model serialization/deserialization
  - Service business logic
  - Repository operations
  - Validation functions
  - Unit conversion calculations
  - Error handling scenarios

Mock Strategy:
  - Mock Firestore operations
  - Mock authentication state
  - Mock business context
  - Use fake data for testing
  - Test edge cases and error conditions
```

#### Widget Tests
```yaml
Test Files:
  - test/features/ingredients/views/ingredient_list_screen_test.dart
  - test/features/ingredients/views/ingredient_form_screen_test.dart
  - test/features/ingredients/widgets/ingredient_card_test.dart
  - test/features/ingredients/widgets/stock_level_indicator_test.dart

Test Coverage:
  - Screen rendering and layout
  - User interaction handling
  - Form validation feedback
  - Navigation between screens
  - State management integration
  - Error state handling
```

#### Integration Tests
```yaml
Test Files:
  - test/features/ingredients/integration/ingredient_flow_test.dart
  - test/features/ingredients/integration/supplier_integration_test.dart

Test Coverage:
  - Complete ingredient CRUD flow
  - Supplier selection and management
  - Search and filtering functionality
  - Navigation between screens
  - Data persistence verification
  - Error recovery scenarios
```

### Performance Considerations

#### Optimization Strategies
```yaml
Data Loading:
  - Implement pagination for ingredient lists
  - Use Firestore queries with limits
  - Cache frequently accessed data
  - Optimize image loading and resizing
  - Implement search result caching

UI Performance:
  - Use ListView.builder for efficient scrolling
  - Implement pull-to-refresh functionality
  - Add loading states and skeleton screens
  - Optimize widget rebuilds with keys
  - Use const constructors where possible

Network Performance:
  - Batch Firestore operations when possible
  - Use offline persistence for critical data
  - Implement retry mechanisms for failed requests
  - Optimize payload sizes
  - Use compression for large data transfers
```

#### Monitoring and Analytics
```yaml
Performance Metrics:
  - Screen load times
  - API response times
  - Search query performance
  - User interaction latency
  - Error rates and types

Business Metrics:
  - Ingredient usage patterns
  - Most expensive ingredients
  - Supplier performance ratings
  - Stock turnover rates
  - Cost trend analysis
```

### Error Handling

#### Error Types and Handling
```dart
class IngredientException implements Exception {
  final String message;
  final String code;
  final String? details;

  IngredientException({
    required this.message,
    required this.code,
    this.details,
  });
}

class IngredientErrorHandler {
  static void handleError(dynamic error, String context) {
    String userMessage;
    String logMessage;
    
    if (error is IngredientException) {
      userMessage = error.message;
      logMessage = '${error.code}: ${error.message} - ${error.details}';
    } else if (error is FirebaseException) {
      userMessage = 'Erro de conexão. Tente novamente.';
      logMessage = 'Firebase error in $context: ${error.message}';
    } else {
      userMessage = 'Erro inesperado. Tente novamente.';
      logMessage = 'Unexpected error in $context: $error';
    }
    
    // Log error with context
    Logger.error(logMessage, context: context);
    
    // Show user-friendly message
    showErrorSnackBar(userMessage);
  }
}
```

#### Error Scenarios
```yaml
Network Errors:
  - Connection timeout
  - No internet connection
  - Server unavailable
  - Rate limiting exceeded

Data Errors:
  - Invalid ingredient data
  - Duplicate ingredient names
  - Missing required fields
  - Data corruption

Business Logic Errors:
  - Insufficient permissions
  - Invalid business context
  - Constraint violations
  - Validation failures

User Experience Errors:
  - Form submission errors
  - Navigation failures
  - State inconsistencies
  - UI component errors
```

### LLM Agent Context

#### Implementation Context
```yaml
Current State:
  - Authentication system is implemented and working
  - Firebase project is configured and deployed
  - Basic project structure is in place
  - Design system is documented and ready

Prerequisites:
  - Firestore database must be enabled in Firebase Console
  - Security rules must be configured
  - Business context provider must be implemented
  - Error handling system should be in place

Next Steps:
  - Create ingredient data models
  - Implement repository layer
  - Build service layer with business logic
  - Create UI screens and widgets
  - Add comprehensive testing
  - Deploy and test in production
```

#### Continuation Points
```yaml
If Implementation Stops:
  - Check last completed file in git commits
  - Review TODO comments in code
  - Verify test coverage and failures
  - Check for any compilation errors
  - Ensure all imports are resolved

Common Issues:
  - Firebase permissions not configured
  - Business context not properly injected
  - State management provider not registered
  - Navigation routes not configured
  - Missing validation messages

Recovery Actions:
  - Review error logs and debug output
  - Check Firebase console for data issues
  - Verify provider registration in main.dart
  - Test authentication state management
  - Validate Firestore security rules
```

#### Code Quality Checklist
```yaml
Before Completion:
  - All files follow project structure conventions
  - Code passes flutter analyze with no warnings
  - All tests pass (flutter test)
  - UI follows design guidelines
  - Error handling is implemented
  - Security rules are properly configured
  - Documentation is updated
  - Performance is optimized

Code Review Items:
  - SOLID principles are followed
  - DRY principle is maintained
  - Error handling is comprehensive
  - User experience is intuitive
  - Security is properly implemented
  - Tests provide adequate coverage
  - Code is properly documented
  - Performance is optimized
```

### Deployment Instructions

#### Pre-deployment Checklist
```yaml
Technical Requirements:
  - Firebase Firestore enabled
  - Security rules deployed
  - Authentication working
  - All tests passing
  - No compilation errors
  - Performance validated

Business Requirements:
  - Feature requirements met
  - User acceptance criteria satisfied
  - Error handling tested
  - Security validated
  - Documentation updated
```

#### Deployment Steps
```yaml
1. Code Review:
   - Verify all files are implemented
   - Check test coverage
   - Validate security implementation
   - Review error handling

2. Testing:
   - Run unit tests: flutter test
   - Run widget tests
   - Perform integration testing
   - Test error scenarios

3. Build and Deploy:
   - Build release: flutter build web --release
   - Deploy to Firebase: firebase deploy
   - Monitor deployment logs
   - Verify functionality in production

4. Post-deployment:
   - Test critical user flows
   - Monitor error logs
   - Verify performance metrics
   - Update documentation
```

#### Rollback Plan
```yaml
If Issues Occur:
  - Use Firebase Console to rollback to previous version
  - Check error logs for specific issues
  - Fix critical bugs with hotfix branch
  - Communicate issues to stakeholders
  - Plan fix and redeployment strategy
```

This feature documentation provides comprehensive context for LLM agents to understand, implement, and deploy the ingredient management system while maintaining code quality and following established patterns.