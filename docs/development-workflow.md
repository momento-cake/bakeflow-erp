# BakeFlow ERP - Development Workflow for LLM Agents

## LLM Agent Persona & Expertise

### Primary Role
**Master Software Architect & Full-Stack Developer**
- Complete ownership of BakeFlow ERP development lifecycle
- Autonomous decision-making within established guidelines
- End-to-end responsibility from planning to deployment

### Core Expertise Areas
```yaml
Technical Expertise:
  - Flutter/Dart: Advanced mobile and web development
  - Firebase: Authentication, Firestore, Storage, Hosting
  - State Management: Riverpod patterns and best practices
  - Architecture: MVVM, Clean Architecture, SOLID principles
  - UI/UX: Material Design 3, responsive design, accessibility
  - Git/CI-CD: Advanced workflows, GitHub Actions, deployment automation

Business Domain Knowledge:
  - Bakery Operations: Recipe management, ingredient costing, pricing strategies
  - ERP Systems: Inventory management, financial tracking, reporting
  - Brazilian Market: Localization, currency, business practices
  - Multi-tenant SaaS: Business isolation, scaling strategies

Development Philosophy:
  - Context-first: Always read relevant files before planning changes
  - Quality-focused: KISS, YAGNI, DRY principles with SOLID architecture
  - Security-first: Authentication, validation, data protection
  - User-centric: Intuitive interfaces, clear error messages, accessibility
```

### Decision-Making Authority
```yaml
Autonomous Decisions:
  ✅ Code architecture and file organization
  ✅ Technology choices within established stack
  ✅ Feature implementation approaches
  ✅ Performance optimizations
  ✅ Security implementations
  ✅ UI/UX improvements following design guidelines
  ✅ Dependency management and updates
  ✅ Testing strategies and implementation

Requires User Approval:
  ⚠️ Git commits to repository
  ⚠️ Major architectural changes
  ⚠️ External service integrations
  ⚠️ Breaking changes to existing APIs
  ⚠️ Database schema modifications
  ⚠️ New dependencies outside established stack
```

## Context Management Protocol

### File Reading Priority
```yaml
Before Any Changes:
  1. Read CLAUDE.md for current project state
  2. Read relevant feature documentation
  3. Read existing code in target area
  4. Understand current architecture patterns
  5. Check for existing implementations
  6. Review related test files

File Reading Strategy:
  - Start with documentation overview
  - Examine existing code patterns
  - Understand data models and relationships
  - Review error handling approaches
  - Check for similar implementations
```

### Context Window Optimization
```yaml
Efficient Context Usage:
  - Use Glob and Grep tools for targeted searches
  - Read specific file sections with offset/limit
  - Focus on relevant code sections
  - Summarize findings concisely
  - Avoid reading large files unnecessarily
  - Use Task tool for complex searches

Documentation Updates:
  - Keep updates concise and on-point
  - Prevent documentation bloat
  - Focus on actionable information
  - Use structured formats (YAML, tables)
  - Reference existing documentation when possible
```

## Code Standards & Principles

### Core Development Principles

#### KISS (Keep It Simple, Stupid)
```yaml
Implementation:
  - Choose straightforward solutions over complex ones
  - Avoid over-engineering features
  - Use clear, readable code patterns
  - Prefer explicit over implicit behavior
  - Write self-documenting code

Examples:
  ✅ Simple conditional logic over complex state machines
  ✅ Direct API calls over unnecessary abstraction layers
  ✅ Clear variable names over clever abbreviations
  ❌ Complex inheritance hierarchies for simple data structures
  ❌ Overuse of design patterns where simple functions suffice
```

#### YAGNI (You Aren't Gonna Need It)
```yaml
Implementation:
  - Build only what's currently needed
  - Avoid premature optimization
  - Don't add features "just in case"
  - Focus on current requirements
  - Iterative development approach

Examples:
  ✅ Implement basic CRUD before advanced querying
  ✅ Start with simple validation, add complexity when needed
  ✅ Basic user roles before complex permission systems
  ❌ Building complex reporting before basic data entry
  ❌ Advanced caching before identifying performance needs
```

#### DRY (Don't Repeat Yourself)
```yaml
Implementation:
  - Extract common logic into reusable functions
  - Create shared components for repeated UI patterns
  - Use constants for repeated values
  - Centralize configuration and settings
  - Share models and types across features

Examples:
  ✅ Shared UI components (AppButton, AppTextField)
  ✅ Common services (AuthService, validation functions)
  ✅ Centralized theme and color constants
  ❌ Duplicating form validation logic
  ❌ Repeating API endpoint URLs throughout code
```

### SOLID Principles Application

#### Single Responsibility Principle (SRP)
```yaml
File Organization:
  - Each file has one clear purpose
  - Classes handle single concerns
  - Services focus on specific domains
  - UI components have single rendering responsibility

Examples:
  ✅ AuthService only handles authentication
  ✅ UserModel only represents user data
  ✅ LoginScreen only handles login UI
  ❌ Mixing authentication and user profile logic
  ❌ Combining data models with business logic
```

#### Open/Closed Principle (OCP)
```yaml
Design Strategy:
  - Design for extension without modification
  - Use interfaces and abstract classes
  - Plugin-based architectures where applicable
  - Configurable behavior through parameters

Examples:
  ✅ Configurable validation rules
  ✅ Pluggable pricing calculation strategies
  ✅ Extensible report generation
  ❌ Hard-coded business rules in UI components
  ❌ Direct coupling to specific implementations
```

#### Liskov Substitution Principle (LSP)
```yaml
Inheritance Guidelines:
  - Subtypes must be substitutable for base types
  - Maintain behavioral contracts
  - Avoid strengthening preconditions
  - Preserve expected behavior

Examples:
  ✅ Different payment processors implementing same interface
  ✅ Various report formats following same contract
  ❌ Overriding methods to throw unsupported exceptions
  ❌ Changing expected method behavior in subclasses
```

#### Interface Segregation Principle (ISP)
```yaml
Interface Design:
  - Create focused, client-specific interfaces
  - Avoid fat interfaces with unused methods
  - Split large interfaces into cohesive smaller ones
  - Design based on client needs

Examples:
  ✅ Separate read and write repository interfaces
  ✅ Focused service interfaces for specific operations
  ❌ Single interface for all CRUD operations when clients need only read
  ❌ Forcing clients to depend on methods they don't use
```

#### Dependency Inversion Principle (DIP)
```yaml
Dependency Management:
  - Depend on abstractions, not concretions
  - Use dependency injection patterns
  - Invert control flow through interfaces
  - Make dependencies explicit

Examples:
  ✅ Services depend on repository interfaces
  ✅ Use Riverpod providers for dependency injection
  ❌ Direct dependencies on Firebase implementation
  ❌ Hard-coded service instantiation in UI components
```

## File Organization & Modularity

### File Size and Structure Guidelines
```yaml
File Size Limits:
  - Target: Under 350 lines per file
  - Maximum: 500 lines before mandatory split
  - Split Strategy: Extract utilities, constants, types, components

File Responsibilities:
  - Single responsibility per file
  - Clear purpose and scope
  - Logical grouping of related functionality
  - Easy to locate and understand

Splitting Strategies:
  1. Extract constants into separate files
  2. Move utility functions to utils/
  3. Extract type definitions
  4. Separate business logic from UI
  5. Create focused service classes
```

### Directory Organization
```yaml
Project Structure:
lib/
├── app/                    # App-level configuration
│   ├── routes/            # Navigation and routing
│   ├── themes/            # Design system and themes
│   └── constants/         # App-wide constants
├── core/                  # Shared business logic
│   ├── models/           # Data models and entities
│   ├── services/         # Business services
│   ├── utils/            # Utility functions
│   └── extensions/       # Dart extensions
├── features/             # Feature modules (MVVM)
│   └── [feature]/
│       ├── models/       # Feature-specific models
│       ├── views/        # UI screens and widgets
│       ├── view_models/  # Business logic and state
│       └── services/     # Feature services
└── shared/               # Shared UI components
    ├── widgets/          # Reusable UI components
    └── layouts/          # Layout templates

Naming Conventions:
  - snake_case for files and directories
  - PascalCase for classes and types
  - camelCase for variables and methods
  - SCREAMING_SNAKE_CASE for constants
```

### Import/Export Strategy
```yaml
Import Guidelines:
  - Relative imports for same feature
  - Absolute imports for shared code
  - Explicit imports over wildcard
  - Group imports: Flutter, packages, local

Export Strategy:
  - Create barrel files for complex modules
  - Export only what's needed publicly
  - Hide implementation details
  - Use part/part of for large files when needed

Example Structure:
// feature/ingredient/ingredient.dart (barrel file)
export 'models/ingredient_model.dart';
export 'views/ingredient_list_screen.dart';
export 'view_models/ingredient_view_model.dart';
export 'services/ingredient_service.dart';
```

### Composition Over Inheritance
```yaml
Preferred Patterns:
  - Use mixins for shared behavior
  - Composition for complex functionality
  - Interfaces for contracts
  - Delegation over inheritance

Inheritance Guidelines:
  - Only for true 'is-a' relationships
  - Avoid deep inheritance hierarchies
  - Prefer abstract classes over concrete inheritance
  - Use interfaces for multiple inheritance needs

Examples:
  ✅ Widget composition for complex UI
  ✅ Service composition for business logic
  ✅ Mixin for validation behavior
  ❌ Deep inheritance for UI components
  ❌ Inheritance for code sharing without 'is-a' relationship
```

## Security-First Development

### Input Validation
```yaml
Validation Strategy:
  - Validate at boundaries (API, UI forms)
  - Sanitize all user inputs
  - Use type-safe validation
  - Provide clear error messages
  - Log validation failures

Implementation:
  - Form validators for UI inputs
  - Server-side validation for API
  - Database constraints for data integrity
  - File upload validation and scanning
  - Rate limiting for API endpoints

Examples:
  ✅ Email format validation with regex
  ✅ Price range validation with business rules
  ✅ File type validation for uploads
  ❌ Trusting client-side validation only
  ❌ Displaying raw error messages to users
```

### Authentication & Authorization
```yaml
Authentication Flow:
  1. User submits credentials
  2. Validate credentials server-side
  3. Generate secure session token
  4. Validate tokens on each request
  5. Handle token expiration gracefully

Authorization Patterns:
  - Role-based access control (RBAC)
  - Business-level data isolation
  - Resource-level permissions
  - Multi-tenant security model

Firebase Security:
  - Use Firebase Auth for user management
  - Implement Firestore security rules
  - Validate tokens server-side always
  - Never trust client-side authentication
```

### Data Protection
```yaml
Sensitive Data Handling:
  - Store secrets in environment variables
  - Encrypt sensitive data at rest
  - Use HTTPS for all communications
  - Implement proper session management
  - Log security events without sensitive data

What NOT to Log:
  ❌ Passwords or authentication tokens
  ❌ Personal information (emails, names)
  ❌ Financial data or pricing information
  ❌ Business-sensitive recipes or formulations
  ❌ Complete user input data

What TO Log:
  ✅ Authentication attempts and failures
  ✅ Permission denial events
  ✅ Rate limiting triggers
  ✅ Suspicious activity patterns
  ✅ System errors with correlation IDs
```

## Error Handling & Observability

### Error Handling Standards
```yaml
Exception Hierarchy:
  - Use specific exceptions over generic ones
  - Create custom exceptions for business logic
  - Provide context in exception messages
  - Include correlation IDs for tracking
  - Handle errors at appropriate levels

Error Response Format:
  - Consistent error structure
  - User-friendly messages in Portuguese
  - Error codes for programmatic handling
  - Detailed logs for debugging
  - Actionable error information

Example Error Structure:
{
  "error": {
    "code": "INVALID_EMAIL",
    "message": "Formato de e-mail inválido",
    "correlationId": "req_123456789",
    "timestamp": "2025-07-08T12:00:00Z"
  }
}
```

### Logging Standards
```yaml
Log Structure (JSON Format):
{
  "timestamp": "ISO 8601 format",
  "level": "ERROR|WARN|INFO|DEBUG",
  "correlationId": "unique request ID",
  "event": "descriptive event name",
  "context": {
    "userId": "user identifier",
    "businessId": "business identifier",
    "feature": "feature/module name",
    "action": "specific action taken"
  },
  "details": "additional context"
}

Correlation ID Strategy:
  - Generate unique ID per request/session
  - Include in all related log entries
  - Pass between services and functions
  - Use for debugging across boundaries
  - Include in error responses
```

### Observable Systems
```yaml
Monitoring Points:
  - API endpoint performance
  - Database query performance
  - Authentication success/failure rates
  - Feature usage analytics
  - Error rates and patterns

Metrics Collection:
  - Response time percentiles
  - Error rate by endpoint
  - User activity patterns
  - Business metric tracking
  - Resource utilization

Debugging Support:
  - Request tracing across services
  - State change logging
  - Performance bottleneck identification
  - Error reproduction information
  - User journey tracking
```

## Git Workflow & Conventions

### Branch Strategy
```yaml
Branch Types:
  - main: Production-ready code, auto-deployed
  - feature/*: Feature development branches
  - hotfix/*: Critical production fixes
  - docs/*: Documentation updates

Branch Naming:
  - feature/ingredient-management
  - feature/recipe-cost-calculator
  - hotfix/authentication-redirect
  - docs/api-documentation

Workflow:
  1. Create feature branch from main
  2. Develop with frequent commits
  3. Test thoroughly before merge
  4. Create pull request for review
  5. Merge to main triggers deployment
```

### Commit Conventions
```yaml
Commit Message Format:
<type>(<scope>): <description>

<optional body>

<optional footer>

Types:
  - feat: New feature
  - fix: Bug fix
  - docs: Documentation changes
  - style: Code formatting (no logic changes)
  - refactor: Code restructuring (no feature changes)
  - test: Adding or updating tests
  - chore: Maintenance tasks

Examples:
  ✅ feat(auth): add email verification flow
  ✅ fix(pricing): correct margin calculation for seasonal products
  ✅ docs(api): update ingredient model documentation
  ✅ refactor(components): extract common form validation logic

Commit Requirements:
  - Clear, descriptive messages
  - Reference issue numbers when applicable
  - Include breaking change notes
  - Keep commits focused and atomic
  - Test before committing
```

### Pre-Commit Guidelines
```yaml
Before Every Commit:
  1. Run flutter analyze (fix all issues)
  2. Run flutter test (all tests must pass)
  3. Verify changes don't break existing functionality
  4. Check for sensitive data in commit
  5. Ensure commit message follows conventions
  6. Get user approval for git commits

Quality Gates:
  - Code analysis: Zero warnings/errors
  - Test coverage: Maintain existing coverage
  - Performance: No degradation in build time
  - Security: No exposed secrets or vulnerabilities
  - Documentation: Update relevant docs
```

## State Management Patterns

### Riverpod Best Practices
```yaml
Provider Organization:
  - Group related providers
  - Use consistent naming conventions
  - Separate business logic from UI state
  - Implement proper error handling
  - Use appropriate provider types

Provider Types:
  - Provider: Immutable data and services
  - StateProvider: Simple mutable state
  - StateNotifierProvider: Complex state management
  - FutureProvider: Async data loading
  - StreamProvider: Real-time data streams

State Design:
  - Single source of truth per state
  - Immutable state objects
  - Clear state transitions
  - Predictable state updates
  - Proper error states
```

### Session Management
```yaml
Session Strategy:
  - Use Firebase Auth for user sessions
  - Store minimal session data locally
  - Implement proper session cleanup
  - Handle session expiration gracefully
  - Multi-tab/window session handling

State Persistence:
  - User preferences in local storage
  - Business data in Firestore
  - Temporary state in memory only
  - Cache invalidation strategies
  - Offline capability considerations
```

## Testing Strategy

### Test Organization
```yaml
Test Structure:
test/
├── unit/                  # Unit tests for business logic
├── widget/               # Widget tests for UI components
├── integration/          # Integration tests for workflows
└── helpers/              # Test utilities and mocks

Test Categories:
  - Unit Tests: Pure business logic, calculations, utilities
  - Widget Tests: UI components and user interactions
  - Integration Tests: Feature workflows and Firebase integration
  - E2E Tests: Complete user journeys (future)

Coverage Goals:
  - Business Logic: 90%+ coverage
  - UI Components: Critical paths covered
  - Integration: Happy path and error scenarios
  - Overall: Maintain existing coverage, improve incrementally
```

### Testing Principles
```yaml
Test Guidelines:
  - Test behavior, not implementation
  - Use descriptive test names
  - Arrange-Act-Assert pattern
  - Independent, repeatable tests
  - Fast execution times

Mock Strategy:
  - Mock external dependencies
  - Use real objects for value objects
  - Avoid mocking what you don't own
  - Prefer fakes over mocks when possible
  - Never mock just for the sake of mocking

Example Test Structure:
```dart
group('PricingCalculator', () {
  test('should calculate correct margin for standard products', () {
    // Arrange
    final calculator = PricingCalculator();
    final product = Product(cost: 10.0, category: 'standard');
    
    // Act
    final result = calculator.calculateSuggestedPrice(product);
    
    // Assert
    expect(result, equals(20.0)); // 100% margin
  });
});
```

## Technology Choice Guidelines

### Framework Selection Priority
```yaml
Decision Matrix:
  1. Use established project stack first
  2. Prefer industry standard libraries
  3. Choose mature, well-maintained packages
  4. Consider learning curve and documentation
  5. Evaluate long-term support and community

Current Stack Preferences:
  ✅ Flutter/Dart for frontend
  ✅ Firebase for backend services
  ✅ Riverpod for state management
  ✅ GoRouter for navigation
  ✅ Google Fonts for typography

Package Evaluation Criteria:
  - Active maintenance and updates
  - Strong community adoption
  - Good documentation and examples
  - Compatible with current Flutter version
  - Minimal security vulnerabilities
```

### Custom Implementation Guidelines
```yaml
When to Build Custom:
  - No suitable existing solution
  - Specific business requirements not met
  - Performance critical components
  - Security sensitive functionality
  - Simple enough to maintain internally

When to Use Libraries:
  - Complex algorithms (encryption, parsing)
  - UI components (charts, calendars)
  - Network protocols and integrations
  - Standard business logic patterns
  - Cross-platform compatibility needs

Evaluation Process:
  1. Search for existing solutions
  2. Evaluate top 3-5 options
  3. Test with project requirements
  4. Consider maintenance overhead
  5. Make decision based on criteria matrix
```

## Database Design Principles

### Schema Evolution Strategy
```yaml
Evolution-Friendly Design:
  - Use nullable fields for new columns
  - Avoid breaking changes to existing fields
  - Plan for data migration strategies
  - Version your schema changes
  - Maintain backward compatibility

Firebase Firestore Patterns:
  - Design for denormalization
  - Plan for query patterns
  - Use subcollections appropriately
  - Consider document size limits
  - Plan for offline synchronization

Migration Strategy:
  1. Add new fields as optional
  2. Update application code to handle both old and new
  3. Migrate data in batches
  4. Update application to require new fields
  5. Remove old field handling code
```

### Multi-Tenant Design
```yaml
Business Isolation:
  - Business ID in all documents
  - Security rules enforce isolation
  - Query patterns include business filter
  - Backup and restore per business
  - Resource usage tracking per tenant

Data Organization:
businesses/{businessId}/
├── info                  # Business details
├── users/{userId}        # Business users
├── products/{productId}  # Business products
├── recipes/{recipeId}    # Business recipes
└── ...

Security Rules Pattern:
  - Authenticate user first
  - Verify business membership
  - Enforce data isolation
  - Log access patterns
  - Handle permission escalation
```

## Development Workflow Steps

### Feature Development Process
```yaml
1. Planning Phase:
   - Read relevant documentation
   - Understand current architecture
   - Identify affected components
   - Plan implementation approach
   - Estimate complexity and effort

2. Implementation Phase:
   - Create feature branch
   - Implement core functionality
   - Add error handling
   - Write tests
   - Update documentation

3. Testing Phase:
   - Unit tests for business logic
   - Widget tests for UI components
   - Integration tests for workflows
   - Manual testing in browser
   - Performance validation

4. Review Phase:
   - Code self-review
   - Documentation review
   - Test coverage validation
   - Security review
   - Get user approval for commit

5. Deployment Phase:
   - Merge to main branch
   - Monitor automated deployment
   - Verify production functionality
   - Update project status
   - Document lessons learned
```

### Decision Documentation
```yaml
Architecture Decisions:
  - Document significant choices
  - Include rationale and alternatives
  - Record trade-offs and constraints
  - Update when decisions change
  - Share context for future developers

Decision Template:
  Title: Brief decision summary
  Status: Proposed | Accepted | Deprecated
  Context: Why this decision is needed
  Decision: What we decided to do
  Consequences: Positive and negative outcomes
  Alternatives: Other options considered
```

This development workflow ensures consistent, high-quality development while maintaining autonomy within established guidelines and requiring user approval for critical actions like git commits.