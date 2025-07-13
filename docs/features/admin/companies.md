# Description

Bakeflow is designed for bakery companies in Brazil, those companies can be formal companies with
proper company complience or solo entreprenuers just starting the business.

## Goal

Admin users must be able to manage companies within the platform with the following aspects:

1. Screen to list all companies within the platform, with the option to delete a company
2. Screen to add a new company
3. Screen to edit a company

### Company Details

1. Company information with potential complience with Brazil documentation, for legal companies or
solo entrepreneurs without a legal company yet.
2. Companies should allow multi user support with the supported roles that will only have access
within company area, they should never have context outside of their companies.
3. Company user access should be scoped for company specific features.

### Admin Features

#### Companies listing

- There should be a new card visible only by app admins or viewers that allows access to listing all
companies within the app.
- This screen must be similar feature and design wise as the admin_users_screen.dart but specific
to companies
- If user is admin it should be able to delete the company from the list
- If user is admin it should be able to view and click on the button to navigate to the add user
screen
- It should have search and items per page features like the users feature

### Adding New Company

- This feature should only be accesible for admin role users
- The field forms you can defined yourself but keep it simple, we don't want long filling forms
- Add proper basic field validation when necessary
- This screen must be similar feature and design wise as the create_user_screen.dart but specific
to company.
- Should also have confirmation popups and when a company is created and this view popped the list
should be reloaded.

### Edit/View company details

- If user role is admin it can be able to edit the fields from the company.
- If user role is viewer it can only view information from the company and not edit it.
- Make sure to use the same fields as defined on `Adding New Company` section.
- This screen must have an tab or a different element to switch between the details page and company
users page.
- Use a popup to confirm the save operation was completed

### Company Users List

- From the company details page it should have an tab or other element to access company users
- The initial view must be the company users, it should show a list based on admin_users_screen.dart
but only for users within a company.
- If admin user role then it can have access to delete the company users, don't apply for regular
viewer role. IMPORTANT: When deleting the user should also be deleted from firebase_auth, you might
have to use a different firebase app like when adding a new user to prevent breaking current session
- If admin user role then can see and click on the button to add a new company user.

### Company User Add

- This feature should only be accesible for admin role users
- This screen must be similar feature and design wise as the create_user_screen.dart but specific
to company.
- Fields must be the same as create user but the available roles should be all we currently support
- Should also have confirmation popups and when a company is created and this view popped the list
should be reloaded.
- IMPORTANT: When creating the user it should be within the company only. It doesn't need to be
displayed on admin_users feature.

### Company User View/Edit

- If user role is admin it can be able to edit the fields from the company user.
- If user role is viewer it can only view information from the company user and not edit it.
- It must contain an option to reset the password that user firebase auth functions
- If admin user role then it can have access to delete the company users, don't apply for regular
viewer role. IMPORTANT: When deleting the user should also be deleted from firebase_auth, you might
have to use a different firebase app like when adding a new user to prevent breaking current session
- Use a popup to confirm the save operation was completed

## IMPORTANT

The company details and company users management will also be used for regular users that have access
to the company. Company managers and admins should be able to edit details of a company and manage
users, but you will not work on this now, we are only planning the admin access but keep in mind
that most of the logic and components and elements or even screen will be used later so try to
adjust the code to be reusable, maybe it doesn't need to be within the admin context folder structure
but app admin users must have access to those features for companies.

## Notes

- Follow same market proof design principles like the ones you used for the dashboard reworks on the UI.
- This list users feature will probable be reused on other places such as company specific users listing and cruding by company managers but some CRUD features must be admin only like managing other admins
- Review firestore security rules so that admin users can work on the users collections
- You are starting to work on similar screens, always prefer creating reusable widgets that can
be shared between similar screens.

## Guinediles

- IMPORTANT! Review all base guidelines prior to pushing changes
- Adjust roadmap with the features that needs to be worked on
- Never rewrite my prompts

--------------------------------------------------------------------------------

## Review Notes 1 - 10/07/25 15:39

On Companies List

- There is an error when loading companies, firestore missing or insuficcient permissions

On add company

- Adjust copy on "Empresa Formal" to "Empresa Formal / MEI"
- Adjust copy on "Pessoa física ou MEI" to "Pessoa física"
- Remove cancel button, the back button does the job
- Error when trying to add the company "Erro ao criar empresa: Exception: Failed to create business: [cloud_firestore/invalid-argument] Function setDoc() called with invalid data. Unsupported field value: a custom $36SoloEntrepreneurImpl object (found in field type in document businesses/RTmqlABcvzeOS4QwMKka"
- When hitting enter the Criar Empresa button should be triggered

--------------------------------------------------------------------------------

## Review Notes 2 - 10/07/25 16:24

There is this error when trying to compile lib/core/models/business_model.dart:56:38: Error: The argument type 'Map<String, dynamic>' can't be assigned to the parameter type 'String'.

- 'Map' is from 'dart:core'.
      return BusinessType.fromString(json);

--------------------------------------------------------------------------------

## Review Notes 3 - 10/07/25 16:41

You still need to implement the following based on the initial request

- Edit/View company details
- Company Users List
- Company User Add
- Company User View/Edit

--------------------------------------------------------------------------------

## Review Notes 4 - 10/07/25 17:19

On company details page

- The icon on the edit button isn't visible because it has the same color as the button bg
- After saving an edit the snackbar on the bottom has a blue background that doesn't match the current
app color schema, replace it.
- On the users tab, the add user button icon isn't visible because it has the same color as the button bg
- On the users tab, the add first user button icon isn't visible because it has the same color as the button bg
- Both details and users tab aren't mobile responsive, the layout is breaking for the Editar button
 and Deletar button and the same for Adicionar Usuário button. Apply layout variations to support
 mobile view as well without horizontally overflowing the screen
- The itens per page dropdown on the users tab must have a smaller version for mobile without the
 "por página" text
- The state form is breaking on mobile visualization, create a mobile variation so it does't overflow

--------------------------------------------------------------------------------

## Review Notes 5 - 10/07/25 17:43

On company details page

- Move the Editar, Excluir and Adicionar Usuário actions into a sub tree dot menu within the screen
 only on mobile. The options should change depending on the current selected tab

--------------------------------------------------------------------------------

## Review Notes 6 - 10/07/25 17:47

On add comapny user page

- When a new company user is created it is invalidating the current user auth session from firebase
 auth. You must follow the same logic for creating a new firebase app used on admin_user_serivce.dart
- As we will not be sending the email with the credentials to access, remove the option to automatically
 set the password, enforcing manually password definition that needs to be reset on the first login.

--------------------------------------------------------------------------------

## Review Notes 7 - 10/07/25 18:04

On add company user there is an issue while saving the user, it is being created on firebase auth
 but not on firestore

 "Erro ao criar usuário: Exception: Failed to create company user: [cloud_firestore/invalid-argument] Function setDoc() called with invalid data. Unsupported field value: a custom $36CompanyAdminImpl object (found in field role in document businesses/xeB0knIKxIsEAE7f9SOS/users/VQUE6Xzng

--------------------------------------------------------------------------------

## Review Notes 8 - 10/07/25 18:07

On add company user there is an issue while saving the user, it is showing a snackbar instead of
 the same modal from the create_user_screen.dart and it isn't also properly dismissing the add screen
 back into the list/details screen.

--------------------------------------------------------------------------------

## Review Notes 9 - 10/07/25 18:28

- When deleting an user it should delete from firestore and also firebase auth
- After creating the user I'm getting the error there is noting to pop from go_router, you've fixed
 this issue on create_user_screen.dart. It must be something with go_router that is widespreaded on
 our app, review on the internet for the best solutions for this

--------------------------------------------------------------------------------

## Review Notes 10 - 10/07/25 18:28

- When deleting an user it should delete from firestore and also firebase auth
- Remove _showSuccessDialog from both create_user_screen.dart and create_company_user_screen.dart
 instead use a snackbar with a success green color but prior to displaying the snackbar, pop
 from the screen to the previous one

--------------------------------------------------------------------------------

## Review Notes 11 - 10/07/25 18:55

- Auto pop on success isn't working on both create_user_screen.dart and create_company_user_screen.dart for some reason, only manual back button taps

--------------------------------------------------------------------------------

## Review Notes 12 - 10/07/25 19:01

- Now I'm getting the error message, there is nothing to pop. This is potentially happening because
a snackbar is being shown, try a different pop strategy so that the screen is pop and snackbar is
shown normally

--------------------------------------------------------------------------------

## Review Notes 13 - 10/07/25 19:07

- Now it is popping into a blank page

--------------------------------------------------------------------------------

## AI Content

# Companies Management Feature

## Overview

**BakeFlow ERP** companies management enables multi-tenant bakery business administration with proper Brazilian compliance support. This feature supports both formal companies (with CNPJ) and solo entrepreneurs starting their business.

## Business Requirements

### Target Users

- **Formal Companies**: Established bakeries with proper Brazilian legal documentation
- **Solo Entrepreneurs**: Individual bakers without formal company registration yet
- **Multi-location Bakeries**: Companies with multiple physical locations

### Core Objectives

1. **Multi-tenant Architecture**: Complete data isolation between companies
2. **Brazilian Compliance**: Support for CNPJ, business registration, and tax requirements
3. **Role-based Access**: Proper user management within company boundaries
4. **Scalable Structure**: Support for growth from sole proprietor to multi-location enterprise

## Technical Architecture

### Data Models

#### Business Entity

```dart
class Business {
  String id;
  String name;
  String? cnpj; // Optional for solo entrepreneurs
  String? fantasyName; // Nome fantasia
  String address;
  String city;
  String state;
  String zipCode;
  String phone;
  String? email;
  BusinessType type; // FORMAL_COMPANY, SOLO_ENTREPRENEUR
  BusinessStatus status; // ACTIVE, INACTIVE, SUSPENDED
  Map<String, dynamic> settings;
  List<String> authorizedUsers;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy; // Admin user ID
}

enum BusinessType { FORMAL_COMPANY, SOLO_ENTREPRENEUR }
enum BusinessStatus { ACTIVE, INACTIVE, SUSPENDED }
```

#### Company User Model

```dart
class CompanyUser {
  String id;
  String businessId;
  String email;
  String name;
  String phone;
  UserRole role; // COMPANY_ADMIN, COMPANY_MANAGER, COMPANY_EMPLOYEE
  bool isActive;
  DateTime createdAt;
  DateTime lastLogin;
  String createdBy;
}

enum UserRole { 
  ADMIN, // Platform admin
  VIEWER, // Platform viewer
  COMPANY_ADMIN, // Company administrator
  COMPANY_MANAGER, // Company manager
  COMPANY_EMPLOYEE // Company employee
}
```

### Firebase Structure

```
firestore/
├── businesses/{businessId}/
│   ├── info/ (business details)
│   ├── users/{userId}/ (company-specific users)
│   ├── products/{productId}/
│   ├── recipes/{recipeId}/
│   ├── ingredients/{ingredientId}/
│   ├── suppliers/{supplierId}/
│   ├── purchases/{purchaseId}/
│   └── reports/{reportId}/
└── platformUsers/{userId}/ (admin/viewer users)
```

## Feature Specifications

### 1. Companies Listing Screen

**Path**: `/admin/companies`
**Access**: Admin, Viewer roles

#### Features

- **Grid/List View**: Card-based layout following Material Design 3 principles
- **Search Functionality**: Real-time search by company name, CNPJ, or city
- **Pagination**: 10, 25, 50 items per page options
- **Filters**: By business type, status, creation date
- **Actions**:
  - View company details (Admin/Viewer)
  - Edit company (Admin only)
  - Delete company (Admin only - with confirmation)
  - Add new company (Admin only)

#### UI Components

```dart
// Reusable components
- CompanyCard widget
- CompanySearchBar widget
- CompanyFilters widget
- CompanyActionButtons widget
```

#### Visual Design

- **Colors**: Primary (#8B4513), Secondary (#FFF8DC), Accent (#FF6B6B)
- **Typography**: Headers (Playfair Display), Body (Inter)
- **Cards**: 8px rounded corners, subtle shadows
- **FAB**: Add company action (Admin only)

### 2. Add New Company Screen

**Path**: `/admin/companies/create`
**Access**: Admin role only

#### Form Fields

```dart
// Required Fields
- Company Name (String, required)
- Business Type (enum: FORMAL_COMPANY, SOLO_ENTREPRENEUR)
- Phone (String, formatted: (XX) XXXXX-XXXX)
- Email (String, email validation)
- Address (String, required)
- City (String, required)
- State (String, dropdown with Brazilian states)
- ZIP Code (String, formatted: XXXXX-XXX)

// Optional Fields (shown based on business type)
- CNPJ (String, validation for formal companies)
- Fantasy Name (String, for formal companies)
```

#### Validation Rules

- **CNPJ**: Valid format and check digit validation
- **Phone**: Brazilian phone number format
- **Email**: Valid email format
- **ZIP Code**: Brazilian ZIP code format (XXXXX-XXX)

#### UI Behavior

- **Step-by-step form**: Split into logical sections
- **Auto-save drafts**: Save form data locally
- **Confirmation popup**: Success/error feedback
- **Navigation**: Return to listing after successful creation

### 3. Company Details/Edit Screen

**Path**: `/admin/companies/{id}`
**Access**: Admin (edit), Viewer (read-only)

#### Tab Structure

```dart
// TabBar with two tabs
1. Company Details
2. Company Users
```

#### Company Details Tab

- **Form Fields**: Same as Add New Company
- **Edit Mode**: Admin can modify all fields
- **View Mode**: Viewer sees read-only information
- **Actions**: Save changes (Admin), Cancel, Delete company (Admin)

#### Company Users Tab

- **User List**: Similar to admin users screen
- **Search**: By name, email, role
- **Actions**: Add user, Edit user, Delete user (Admin only)
- **Pagination**: 10, 25, 50 users per page

### 4. Company User Management

#### Add Company User Screen

**Path**: `/admin/companies/{id}/users/create`
**Access**: Admin role only

```dart
// Form Fields
- Name (String, required)
- Email (String, required, unique validation)
- Phone (String, Brazilian format)
- Role (enum: COMPANY_ADMIN, COMPANY_MANAGER, COMPANY_EMPLOYEE)
- Initial Password (String, generated or manual)
```

#### Edit Company User Screen

**Path**: `/admin/companies/{id}/users/{userId}`
**Access**: Admin (edit), Viewer (read-only)

- **All fields**: Same as create user
- **Password Reset**: Generate new password option
- **Status**: Active/Inactive toggle
- **Delete User**: Remove from Firebase Auth and Firestore

## UI/UX Guidelines

### Design System Compliance

- **Color Palette**: Saddle Brown (#8B4513) primary, Cornsilk (#FFF8DC) secondary
- **Typography**: Playfair Display for headers, Inter for body text
- **Spacing**: 8px grid system
- **Elevation**: Subtle shadows for cards (elevation 1-2)
- **Animations**: Smooth transitions (200ms duration)

### Responsive Design

- **Mobile-first**: Bottom navigation, stacked layouts
- **Tablet**: Side navigation, two-column layouts
- **Desktop**: Full sidebar, multi-column layouts

### Accessibility

- **Color Contrast**: WCAG AA compliance
- **Screen Reader**: Proper semantic HTML and ARIA labels
- **Keyboard Navigation**: Full keyboard support
- **Focus Management**: Clear focus indicators

### User Experience Patterns

- **Loading States**: Skeleton screens during data loading
- **Error Handling**: User-friendly error messages in Portuguese
- **Confirmation Dialogs**: For destructive actions
- **Success Feedback**: Toast notifications for successful operations

## Security & Access Control

### Firestore Security Rules

```javascript
// Platform admin access
match /platformUsers/{userId} {
  allow read, write: if request.auth != null && 
    request.auth.uid == userId &&
    resource.data.role in ['ADMIN', 'VIEWER'];
}

// Business collection access
match /businesses/{businessId} {
  allow read, write: if request.auth != null && 
    isPlatformAdmin(request.auth.uid);
  
  // Company-specific user access
  match /users/{userId} {
    allow read, write: if request.auth != null && 
      (isPlatformAdmin(request.auth.uid) || 
       isCompanyAuthorized(request.auth.uid, businessId));
  }
  
  // Company data access
  match /{document=**} {
    allow read, write: if request.auth != null && 
      (isPlatformAdmin(request.auth.uid) || 
       isCompanyAuthorized(request.auth.uid, businessId));
  }
}

// Helper functions
function isPlatformAdmin(userId) {
  return get(/databases/$(database)/documents/platformUsers/$(userId)).data.role == 'ADMIN';
}

function isCompanyAuthorized(userId, businessId) {
  return userId in get(/databases/$(database)/documents/businesses/$(businessId)).data.authorizedUsers;
}
```

### Multi-tenancy Implementation

- **Data Isolation**: Complete separation between companies
- **User Context**: Company users only see their company data
- **Admin Override**: Platform admins can access all companies
- **Permission Matrix**: Role-based access control

## Implementation Architecture

### Flutter Project Structure

```
lib/
├── features/
│   ├── admin/
│   │   ├── companies/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   ├── repositories/
│   │   │   │   └── services/
│   │   │   ├── presentation/
│   │   │   │   ├── screens/
│   │   │   │   ├── widgets/
│   │   │   │   └── providers/
│   │   │   └── domain/
│   │   │       ├── entities/
│   │   │       └── usecases/
│   │   └── users/
│   └── company/ (reusable components)
│       ├── management/
│       ├── users/
│       └── shared/
└── shared/
    ├── widgets/
    │   ├── forms/
    │   ├── lists/
    │   └── cards/
    └── utils/
        ├── validators/
        └── formatters/
```

### State Management (Riverpod)

```dart
// Providers for company management
final companiesProvider = StateNotifierProvider<CompaniesNotifier, CompaniesState>((ref) {
  return CompaniesNotifier(ref.read(companiesRepositoryProvider));
});

final companyUsersProvider = StateNotifierProvider.family<CompanyUsersNotifier, CompanyUsersState, String>((ref, businessId) {
  return CompanyUsersNotifier(ref.read(companyUsersRepositoryProvider), businessId);
});

// Form providers
final createCompanyFormProvider = StateNotifierProvider<CreateCompanyFormNotifier, CreateCompanyFormState>((ref) {
  return CreateCompanyFormNotifier();
});
```

### Reusable Components

- **BaseListScreen**: Generic list screen with search/pagination
- **BaseFormScreen**: Generic form screen with validation
- **BaseCard**: Consistent card design across features
- **BaseDataTable**: Responsive table component
- **ConfirmationDialog**: Standardized confirmation dialogs
- **LoadingStates**: Skeleton screens and loading indicators

## Brazilian Compliance Features

### CNPJ Validation

```dart
class CNPJValidator {
  static bool isValid(String cnpj) {
    // Remove formatting
    cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Check length and calculate check digits
    if (cnpj.length != 14) return false;
    
    // Calculate verification digits
    // Implementation of CNPJ algorithm
    return _validateCheckDigits(cnpj);
  }
  
  static String format(String cnpj) {
    return cnpj.replaceAllMapped(
      RegExp(r'(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})'),
      (match) => '${match[1]}.${match[2]}.${match[3]}/${match[4]}-${match[5]}'
    );
  }
}
```

### Brazilian States Dropdown

```dart
class BrazilianStates {
  static const List<String> states = [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO',
    'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI',
    'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ];
}
```

## Testing Strategy

### Unit Tests

- Model validation and serialization
- Business logic and use cases
- Form validation and formatting
- CNPJ validation algorithm

### Widget Tests

- Form input validation
- Button states and actions
- Navigation flows
- Error handling

### Integration Tests

- Firebase authentication flows
- Firestore CRUD operations
- Multi-user scenarios
- Permission validation

## Performance Considerations

### Data Loading

- **Pagination**: Load companies in chunks
- **Caching**: Cache frequently accessed data
- **Lazy Loading**: Load user details on demand
- **Optimistic Updates**: Update UI immediately, sync later

### Memory Management

- **Dispose Controllers**: Properly dispose form controllers
- **Stream Subscriptions**: Cancel subscriptions on dispose
- **Image Caching**: Cache company logos and avatars
- **State Cleanup**: Clear state when navigating away

## Localization (Portuguese - Brazil)

### Text Resources

```dart
class CompanyStrings {
  static const String companiesTitle = 'Empresas';
  static const String addCompany = 'Adicionar Empresa';
  static const String editCompany = 'Editar Empresa';
  static const String companyName = 'Nome da Empresa';
  static const String fantasyName = 'Nome Fantasia';
  static const String cnpj = 'CNPJ';
  static const String formalCompany = 'Empresa Formal';
  static const String soloEntrepreneur = 'Empreendedor Individual';
  static const String confirmDelete = 'Confirmar Exclusão';
  static const String companyDeletedSuccess = 'Empresa excluída com sucesso';
  static const String companyCreatedSuccess = 'Empresa criada com sucesso';
  static const String companyUpdatedSuccess = 'Empresa atualizada com sucesso';
}
```

### Input Formatting

- **Phone**: (XX) XXXXX-XXXX
- **CNPJ**: XX.XXX.XXX/XXXX-XX
- **ZIP Code**: XXXXX-XXX
- **Currency**: R$ X.XXX,XX

## Migration Strategy

### From Current Architecture

1. **Phase 1**: Create admin company management screens
2. **Phase 2**: Extract reusable components
3. **Phase 3**: Implement company-specific screens
4. **Phase 4**: Migrate existing features to multi-tenant structure

### Data Migration

- **Existing Data**: Migrate current bakery data to company structure
- **User Assignment**: Assign existing users to their respective companies
- **Permission Updates**: Update user roles and permissions
- **Validation**: Ensure data integrity after migration

## Future Enhancements

### Advanced Features

- **Company Analytics**: Usage statistics and performance metrics
- **Bulk Operations**: Mass company creation/updates
- **Export/Import**: Company data export for backup/migration
- **API Integration**: RESTful API for third-party integrations
- **Audit Trail**: Track all changes to company data

### Scalability Improvements

- **Database Optimization**: Indexes and query optimization
- **CDN Integration**: Asset delivery optimization
- **Background Jobs**: Async processing for heavy operations
- **Monitoring**: Performance and error tracking

## Development Guidelines

### Code Standards

- Follow BakeFlow ERP coding conventions
- Use MVVM architecture pattern
- Implement proper error handling
- Add comprehensive documentation
- Write unit and widget tests

### Git Workflow

- Create feature branches for each screen
- Small, focused commits with clear messages
- Code review before merging
- Continuous integration with automated tests

### Quality Assurance

- Manual testing on different screen sizes
- Performance testing with large datasets
- Security testing for permission boundaries
- Accessibility testing for screen readers

---

## Implementation Notes

### Reusability Considerations

- **Shared Components**: Extract common widgets for reuse
- **Business Logic**: Keep business rules in domain layer
- **UI Patterns**: Maintain consistent design patterns
- **State Management**: Use family providers for entity-specific state

### Next Steps

1. Review and update project roadmap
2. Create detailed technical tasks
3. Set up development environment
4. Begin with companies listing screen
5. Implement form validation utilities
6. Add comprehensive test coverage
