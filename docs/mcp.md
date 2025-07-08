# BakeFlow ERP - MCP (Model Context Protocol) Usage Guide

## Overview

This documentation provides guidelines for LLM agents working on BakeFlow ERP to effectively use Model Context Protocol (MCP) servers for accessing up-to-date documentation and external resources. MCP servers provide current information beyond the LLM's training cutoff and enable integration with external libraries and frameworks.

## Available MCP Servers

### Context7 Documentation Server
**Repository**: Context7 MCP Server  
**Primary Use**: Access current documentation for Flutter, Firebase, and related libraries

#### Key Capabilities
- Up-to-date library documentation access
- Topic-focused documentation retrieval
- Support for specific library versions
- Integration with current development practices
- Focused content within token limits

## When to Use MCP

### High Priority Use Cases
```yaml
Flutter/Dart Development:
  - New Flutter features beyond training cutoff
  - Widget-specific implementation patterns
  - State management with latest Riverpod versions
  - Material Design 3 component updates
  - Platform-specific integrations (web, mobile)

Firebase Integration:
  - Latest Firebase SDK documentation
  - New Firebase service features
  - Authentication flow updates
  - Firestore query optimization
  - Security rule patterns

External Packages:
  - Package-specific implementation guides
  - Breaking changes in package updates
  - Integration patterns with Flutter
  - Performance optimization techniques
  - Migration guides for package updates
```

### Medium Priority Use Cases
```yaml
Development Tools:
  - GitHub Actions workflow patterns
  - FVM (Flutter Version Management) updates
  - Testing framework updates
  - CI/CD pipeline optimizations

Design and UI:
  - Material Design 3 guidelines
  - Accessibility best practices
  - Responsive design patterns
  - Animation and transition guides

Business Logic:
  - Industry-specific patterns (ERP, bakery management)
  - Multi-tenant architecture patterns
  - Data modeling best practices
  - Security implementation guides
```

### Low Priority Use Cases
```yaml
General Programming:
  - Basic Dart language features
  - Common programming patterns
  - Standard library usage
  - General software architecture principles

Note: Use MCP for specific, current, or complex implementations
rather than basic programming concepts already well-known.
```

## Context7 MCP Usage Patterns

### Library Resolution
```dart
// Step 1: Resolve library name to Context7 ID
mcp__context7__resolve_library_id(libraryName="flutter")
mcp__context7__resolve_library_id(libraryName="firebase")
mcp__context7__resolve_library_id(libraryName="riverpod")
mcp__context7__resolve_library_id(libraryName="go_router")
```

### Flutter-Specific Documentation Access
```dart
// Flutter Widget Documentation
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/flutter/flutter",
    topic="widgets/material",
    tokens=8000
)

// State Management with Riverpod
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/rrousselGit/riverpod",
    topic="providers/state_notifier",
    tokens=6000
)

// Navigation with GoRouter
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/flutter/packages/go_router",
    topic="declarative_routing",
    tokens=5000
)

// Material Design 3 Components
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/flutter/flutter",
    topic="material3/components",
    tokens=7000
)
```

### Firebase-Specific Documentation Access
```dart
// Firebase Authentication
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/firebase/firebase-dart",
    topic="auth/email_password",
    tokens=6000
)

// Cloud Firestore
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/firebase/firebase-dart",
    topic="firestore/security_rules",
    tokens=8000
)

// Firebase Hosting
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/firebase/firebase-dart",
    topic="hosting/deployment",
    tokens=5000
)

// Firebase Storage
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/firebase/firebase-dart",
    topic="storage/file_upload",
    tokens=6000
)
```

### Package-Specific Documentation Access
```dart
// Google Fonts Integration
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/google/fonts",
    topic="flutter_integration",
    tokens=4000
)

// UUID Generation
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/Daegalus/dart-uuid",
    topic="usage_examples",
    tokens=3000
)

// Image Picker
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/flutter/plugins/image_picker",
    topic="web_implementation",
    tokens=5000
)

// Internationalization
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/flutter/flutter",
    topic="internationalization/intl",
    tokens=6000
)
```

## MCP Usage Best Practices

### Context Window Management
```yaml
Token Allocation Strategy:
  - Small topics (basic usage): 3000-4000 tokens
  - Medium topics (implementation patterns): 5000-6000 tokens
  - Large topics (comprehensive guides): 7000-8000 tokens
  - Complex topics (architecture patterns): 8000+ tokens

Optimization Techniques:
  - Request specific subtopics rather than entire documentation
  - Use focused queries for particular use cases
  - Combine related small topics in single requests
  - Cache frequently accessed information mentally
```

### Query Optimization
```yaml
Effective Topic Patterns:
  ✅ "widgets/material/button"      # Specific component
  ✅ "state_management/providers"   # Focused concept
  ✅ "authentication/email_auth"    # Specific implementation
  ✅ "deployment/firebase_hosting"  # Targeted process

Ineffective Topic Patterns:
  ❌ "flutter"                      # Too broad
  ❌ "documentation"                # Non-specific
  ❌ "everything"                   # Unfocused
  ❌ "general_info"                 # Vague request
```

### Information Prioritization
```yaml
Priority 1 - Critical Implementation:
  - Breaking changes in dependencies
  - Security vulnerability fixes
  - Performance optimization techniques
  - New feature implementations

Priority 2 - Enhancement:
  - Best practice updates
  - Code quality improvements
  - User experience enhancements
  - Development workflow optimizations

Priority 3 - Reference:
  - API reference lookups
  - Configuration options
  - Migration guides
  - Troubleshooting resources
```

## BakeFlow ERP-Specific MCP Usage

### Authentication Implementation
```dart
// When implementing Firebase Auth in Flutter
mcp__context7__resolve_library_id(libraryName="firebase_auth")

mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/firebase/firebase_auth",
    topic="flutter_web_integration",
    tokens=7000
)

// Follow up with error handling patterns
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/firebase/firebase_auth",
    topic="error_handling_best_practices",
    tokens=5000
)
```

### State Management Implementation
```dart
// For Riverpod state management in BakeFlow
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/rrousselGit/riverpod",
    topic="flutter_riverpod/providers",
    tokens=6000
)

// Specific to authentication state
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/rrousselGit/riverpod",
    topic="authentication_state_management",
    tokens=5000
)
```

### Database Integration
```dart
// Firestore integration for BakeFlow ERP
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/firebase/cloud_firestore",
    topic="flutter_web_crud_operations",
    tokens=8000
)

// Multi-tenant data structure
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/firebase/cloud_firestore",
    topic="multi_tenant_architecture",
    tokens=7000
)
```

### UI/UX Implementation
```dart
// Material Design 3 for bakery ERP
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/flutter/flutter",
    topic="material3/theming_system",
    tokens=6000
)

// Responsive design for mobile-first
mcp__context7__get_library_docs(
    context7CompatibleLibraryID="/flutter/flutter",
    topic="responsive_design/layout_builder",
    tokens=5000
)
```

## MCP Integration Workflow

### Pre-Implementation Research
```yaml
Step 1: Identify Knowledge Gaps
  - Check if implementation is beyond training cutoff
  - Identify specific library versions needed
  - Determine complexity of integration
  - Assess current documentation needs

Step 2: Plan MCP Queries
  - List specific topics needed
  - Prioritize critical vs nice-to-have information
  - Estimate token requirements
  - Plan query sequence

Step 3: Execute MCP Queries
  - Start with library resolution
  - Fetch focused documentation
  - Verify current best practices
  - Collect implementation examples

Step 4: Implement with Context
  - Apply documentation to specific use case
  - Adapt examples for BakeFlow ERP context
  - Follow established project patterns
  - Validate against project requirements
```

### Development Process Integration
```yaml
During Feature Development:
  1. Read existing project code first
  2. Identify external library requirements
  3. Use MCP for current documentation
  4. Implement following project patterns
  5. Test with current library versions
  6. Document any library-specific patterns

During Debugging:
  1. Identify library-specific issues
  2. Use MCP for troubleshooting guides
  3. Check for known issues/fixes
  4. Verify implementation against current docs
  5. Apply fixes following best practices

During Updates:
  1. Check for breaking changes
  2. Use MCP for migration guides
  3. Plan update strategy
  4. Test compatibility thoroughly
  5. Update project documentation
```

## Error Handling and Troubleshooting

### MCP Query Failures
```yaml
Common Issues:
  - Library name not found in Context7
  - Topic too broad or unfocused
  - Token limit exceeded
  - Network connectivity issues

Solutions:
  - Verify library name spelling and format
  - Use more specific topic queries
  - Reduce token allocation for large topics
  - Retry queries after brief delay
  - Fall back to general programming knowledge
```

### Documentation Quality Assessment
```yaml
Evaluation Criteria:
  - Recency: Is documentation current?
  - Relevance: Does it apply to our use case?
  - Completeness: Are examples comprehensive?
  - Accuracy: Do examples work as expected?
  - Compatibility: Works with our tech stack?

Quality Indicators:
  ✅ Recent publication dates
  ✅ Version-specific information
  ✅ Working code examples
  ✅ Error handling patterns
  ✅ Performance considerations

Red Flags:
  ❌ Outdated version references
  ❌ Deprecated API usage
  ❌ Incomplete examples
  ❌ Missing error handling
  ❌ No performance guidance
```

## Security Considerations

### MCP Data Handling
```yaml
Security Guidelines:
  - Never include sensitive project data in MCP queries
  - Don't expose API keys or credentials in topic searches
  - Avoid querying for business-specific implementations
  - Use generic examples and adapt internally
  - Sanitize any code examples before implementation

Safe Query Patterns:
  ✅ "firebase_auth_implementation_patterns"
  ✅ "flutter_form_validation_techniques"
  ✅ "riverpod_state_management_examples"

Unsafe Query Patterns:
  ❌ "bakeflow_erp_specific_configuration"
  ❌ "momentocake_firebase_setup"
  ❌ "custom_business_logic_implementation"
```

### Information Validation
```yaml
Validation Process:
  1. Verify information against multiple sources
  2. Test examples in isolated environment
  3. Check for security implications
  4. Validate against project requirements
  5. Adapt to project-specific needs

Security Checklist:
  - Are authentication patterns secure?
  - Do examples follow security best practices?
  - Are there any known vulnerabilities?
  - Is input validation properly implemented?
  - Are error messages information-safe?
```

## Integration with Development Workflow

### Context Management
```yaml
MCP Usage in Development Workflow:
  1. Context Reading: Read project files first
  2. Gap Identification: Identify knowledge gaps
  3. MCP Research: Query for current information
  4. Implementation: Apply with project patterns
  5. Testing: Verify with current library versions
  6. Documentation: Update project docs if needed

Context Window Optimization:
  - Use MCP for specific unknowns only
  - Prioritize critical implementation details
  - Cache mental models of library patterns
  - Focus on project-specific applications
```

### Documentation Updates
```yaml
When to Update Project Documentation:
  - New library integration patterns discovered
  - Breaking changes in dependencies
  - Security best practices updates
  - Performance optimization techniques
  - Development workflow improvements

Documentation Targets:
  - Update relevant .md files with new patterns
  - Add library-specific examples to guidelines
  - Include version-specific considerations
  - Document known issues and solutions
  - Reference MCP-discovered resources
```

## Performance and Efficiency

### Query Optimization
```yaml
Efficient MCP Usage:
  - Batch related queries when possible
  - Use specific topic strings for focused results
  - Adjust token limits based on content needs
  - Cache frequently accessed patterns mentally
  - Avoid redundant queries for same information

Performance Metrics:
  - Query response time
  - Information relevance score
  - Implementation success rate
  - Token usage efficiency
  - Problem resolution speed
```

### Best Practices Summary
```yaml
Do's:
  ✅ Use MCP for current, specific information
  ✅ Query focused topics with appropriate tokens
  ✅ Validate information against project needs
  ✅ Integrate with existing development workflow
  ✅ Document significant findings for future reference

Don'ts:
  ❌ Use MCP for basic programming concepts
  ❌ Query overly broad topics
  ❌ Include sensitive project information
  ❌ Blindly implement without adaptation
  ❌ Skip validation of MCP-provided information
```

This MCP usage guide ensures efficient, secure, and effective use of Model Context Protocol servers while maintaining focus on BakeFlow ERP development needs and following established project patterns.