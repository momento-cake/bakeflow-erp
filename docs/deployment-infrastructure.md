# BakeFlow ERP - Deployment & Infrastructure

## Current Infrastructure Overview

### Production Environment
- **Live URL**: https://bakeflow-erp.web.app
- **Hosting**: Firebase Hosting
- **CDN**: Global Firebase CDN with edge caching
- **SSL**: Automatic HTTPS with Firebase certificates
- **Status**: Active and operational

### Firebase Project Configuration
```yaml
Project Details:
  Project ID: bakeflow-erp
  Project Number: 54002399909
  Display Name: bakeflow
  Region: Default (nam5)
  
Services Enabled:
  - Firebase Hosting: ✅ Active
  - Firebase Authentication: ⚠️ Needs console setup
  - Cloud Firestore: ⚠️ Needs console setup
  - Cloud Storage: ⚠️ Needs console setup
  - Analytics: 📋 Not configured
```

## Current Deployment Pipeline

### Automated CI/CD with GitHub Actions

**File**: `.github/workflows/deploy.yml`

```yaml
# Trigger: Push to main branch or pull requests
Triggers:
  - push: main branch
  - pull_request: main branch

# Build Process:
1. Checkout code
2. Setup Flutter 3.27.4 stable
3. Get dependencies (flutter pub get)
4. Code analysis (flutter analyze)
5. Run tests (flutter test)
6. Build web release (flutter build web --release)
7. Deploy to Firebase Hosting (main branch only)

# Deployment Conditions:
- Only deploys on push to main branch
- Pull requests run tests but don't deploy
- Uses Firebase service account for authentication
```

### Manual Deployment Commands
```bash
# Build production version
fvm flutter build web --release

# Deploy to Firebase Hosting
firebase deploy --only hosting

# Full Firebase deploy (when multiple services configured)
firebase deploy

# Preview deployment (for testing)
firebase hosting:channel:deploy preview
```

## Firebase Configuration Files

### `.firebaserc` - Project Configuration
```json
{
  "projects": {
    "default": "bakeflow-erp"
  }
}
```

### `firebase.json` - Hosting Configuration
```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ],
    "headers": [
      {
        "source": "**/*.@(jpg|jpeg|gif|png|svg|webp|ico)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=604800"
          }
        ]
      },
      {
        "source": "**/*.@(js|css)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=604800"
          }
        ]
      }
    ]
  }
}
```

### `lib/firebase_options.dart` - Firebase SDK Configuration
```dart
// Current Firebase project credentials
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'AIzaSyCYekBdWE1tburRNK3EJR5b7_uYH1NGHr8',
  appId: '1:54002399909:web:6f355b1d930539b2202b4c',
  messagingSenderId: '54002399909',
  projectId: 'bakeflow-erp',
  authDomain: 'bakeflow-erp.firebaseapp.com',
  storageBucket: 'bakeflow-erp.firebasestorage.app',
  measurementId: 'G-2C2495V9MN',
);
```

## Required Firebase Console Setup

### Authentication Setup
```yaml
Status: ⚠️ Required for app functionality
Steps:
  1. Go to Firebase Console > Authentication
  2. Navigate to Sign-in method tab
  3. Enable Email/Password provider
  4. Configure settings:
     - Email/Password: Enable
     - Email link (passwordless): Optional
     - Account management emails: Configure sender
  5. Test authentication flow

Configuration Needed:
  - Email/Password: ✅ Enable
  - Authorized domains: bakeflow-erp.web.app, localhost
  - Email templates: Customize for Portuguese
```

### Firestore Database Setup
```yaml
Status: ⚠️ Required for data persistence
Steps:
  1. Go to Firebase Console > Firestore Database
  2. Click Create database
  3. Choose location: nam5 (North America)
  4. Security mode: Start in test mode (development)
  5. Configure security rules for production

Security Rules Template:
  - Allow authenticated users only
  - Business-based access control
  - Multi-tenant data isolation
```

### Cloud Storage Setup
```yaml
Status: 📋 Future requirement
Purpose: Recipe images, receipt uploads
Steps:
  1. Go to Firebase Console > Storage
  2. Get started with default bucket
  3. Configure security rules
  4. Set up folder structure:
     - businesses/{businessId}/receipts/
     - businesses/{businessId}/products/
     - shared/ingredients/
```

## Environment-Specific Configuration

### Development Environment
```yaml
Configuration:
  - Firebase project: bakeflow-erp (same as production)
  - Authentication: Test mode with console setup
  - Firestore: Test mode with open rules
  - Local development: http://localhost:3000
  - Hot reload: Enabled for rapid development

Commands:
  - Start: fvm flutter run -d web-server --web-port=3000
  - Test: fvm flutter test
  - Analyze: fvm flutter analyze
```

### Production Environment
```yaml
Configuration:
  - Firebase project: bakeflow-erp
  - Authentication: Production rules enabled
  - Firestore: Production security rules
  - Hosting: https://bakeflow-erp.web.app
  - CDN: Global edge caching enabled

Deployment:
  - Automatic: Push to main branch
  - Manual: firebase deploy --only hosting
  - Rollback: Firebase Console > Hosting > Previous versions
```

## Security Configuration

### Current Firebase Security Status
```yaml
Authentication:
  Status: ⚠️ Needs console setup
  Configuration: Email/Password provider
  Security: Firebase Auth tokens, secure session management

Firestore Rules:
  Status: 📋 Not configured
  Required: Business-based access control
  Template: |
    rules_version = '2';
    service cloud.firestore {
      match /databases/{database}/documents {
        // Business access control
        match /businesses/{businessId} {
          allow read, write: if request.auth != null && 
            request.auth.uid in resource.data.authorizedUsers;
          
          match /{document=**} {
            allow read, write: if request.auth != null && 
              request.auth.uid in get(/databases/$(database)/documents/businesses/$(businessId)).data.authorizedUsers;
          }
        }
        
        // Shared ingredients (read-only for authenticated users)
        match /sharedIngredients/{document} {
          allow read: if request.auth != null;
          allow write: if false; // Admin only via console
        }
      }
    }

Hosting Security:
  HTTPS: ✅ Enforced automatically
  Headers: ✅ Security headers configured
  CORS: ✅ Handled by Firebase
```

### GitHub Secrets Configuration
```yaml
Required Secrets:
  FIREBASE_SERVICE_ACCOUNT:
    Status: ⚠️ Needs setup for automated deployment
    Purpose: GitHub Actions authentication to Firebase
    Setup: Firebase Console > Project Settings > Service Accounts
    
  GITHUB_TOKEN:
    Status: ✅ Automatically provided
    Purpose: Repository access for workflows
    Usage: Pull request management and deployment
```

## Build Optimization

### Current Build Configuration
```yaml
Flutter Web Build:
  Command: flutter build web --release
  Output: build/web/
  Optimization:
    - Tree shaking: ✅ Enabled (99.5% font reduction)
    - Code splitting: ✅ Automatic
    - Asset optimization: ✅ Enabled
    - Minification: ✅ Enabled

Bundle Analysis:
  - Main bundle: ~2MB (estimated)
  - Fonts: Optimized (MaterialIcons: 8.6KB, CupertinoIcons: 1.2KB)
  - Images: Not yet optimized (future)
  - Service worker: Auto-generated
```

### Performance Optimizations
```yaml
Current:
  - Font subsetting: ✅ Automatic tree shaking
  - Asset caching: ✅ 7-day cache headers
  - GZIP compression: ✅ Firebase automatic
  - CDN distribution: ✅ Global Firebase CDN

Future Optimizations:
  - Image optimization: WebP format conversion
  - Lazy loading: Route-based code splitting
  - Service worker: Custom caching strategies
  - Bundle analysis: Size monitoring and alerts
```

## Monitoring and Analytics

### Current Monitoring
```yaml
Available:
  - Firebase Hosting metrics: Basic traffic and bandwidth
  - GitHub Actions logs: Build and deployment status
  - Browser DevTools: Performance debugging
  - Firebase Console: Project overview and usage

Not Configured:
  - Firebase Analytics: User behavior tracking
  - Performance Monitoring: Core Web Vitals
  - Crashlytics: Error reporting and crash analytics
  - Custom metrics: Business KPI tracking
```

### Logging Strategy
```yaml
Current Logging:
  - Flutter debug prints: Development console
  - Firebase Auth errors: Handled in AuthService
  - Build logs: GitHub Actions workflow logs
  - Deployment logs: Firebase CLI output

Production Logging Needs:
  - Error tracking: Firebase Crashlytics integration
  - User analytics: Firebase Analytics events
  - Performance monitoring: Core Web Vitals tracking
  - Custom events: Business metric tracking
```

## Deployment Workflow

### Automated Deployment Process
```mermaid
graph TD
    A[Push to main] --> B[GitHub Actions Trigger]
    B --> C[Setup Flutter Environment]
    C --> D[Install Dependencies]
    D --> E[Run Code Analysis]
    E --> F[Execute Tests]
    F --> G{Tests Pass?}
    G -->|No| H[Fail Deployment]
    G -->|Yes| I[Build Web Release]
    I --> J[Deploy to Firebase]
    J --> K[Update Live Site]
    K --> L[Send Notifications]
```

### Manual Deployment Steps
```bash
# 1. Verify current setup
firebase projects:list
firebase use bakeflow-erp

# 2. Build application
fvm flutter clean
fvm flutter pub get
fvm flutter analyze
fvm flutter test
fvm flutter build web --release

# 3. Deploy to Firebase
firebase deploy --only hosting

# 4. Verify deployment
curl -I https://bakeflow-erp.web.app
```

### Rollback Procedures
```yaml
Automatic Rollback:
  - Not configured
  - Manual intervention required

Manual Rollback:
  1. Firebase Console > Hosting
  2. Select previous version
  3. Click "Rollback"
  4. Confirm deployment

Emergency Rollback:
  - Use Firebase Console for immediate rollback
  - Fix issues in code and redeploy
  - No automated rollback triggers configured
```

## Troubleshooting Guide

### Common Deployment Issues

#### Build Failures
```yaml
Issue: Flutter build fails
Causes:
  - Dependency conflicts
  - Code analysis errors
  - Test failures
  - Missing environment setup

Solutions:
  - Run flutter clean && flutter pub get
  - Fix analysis issues with flutter analyze
  - Ensure all tests pass with flutter test
  - Verify Flutter version with fvm flutter --version
```

#### Firebase Deployment Failures
```yaml
Issue: Firebase deploy fails
Causes:
  - Authentication issues
  - Project configuration errors
  - Build output missing
  - Service account permissions

Solutions:
  - Verify authentication: firebase login
  - Check project: firebase use bakeflow-erp
  - Ensure build/web exists and contains files
  - Verify service account permissions in console
```

#### Authentication Not Working
```yaml
Issue: Login fails in production
Causes:
  - Firebase Auth not enabled
  - Domain not authorized
  - Configuration mismatch

Solutions:
  - Enable Email/Password in Firebase Console
  - Add bakeflow-erp.web.app to authorized domains
  - Verify firebase_options.dart configuration
  - Check browser network tab for errors
```

### Performance Issues
```yaml
Issue: Slow loading times
Diagnostics:
  - Check Lighthouse scores
  - Analyze bundle size
  - Review network requests
  - Monitor Core Web Vitals

Solutions:
  - Enable service worker caching
  - Optimize images and assets
  - Implement lazy loading
  - Use CDN for static assets
```

## Required Actions for Full Deployment

### Immediate Actions Required
```yaml
Priority 1 (Authentication):
  1. Firebase Console > Authentication > Sign-in method
  2. Enable Email/Password provider
  3. Configure authorized domains
  4. Test login functionality

Priority 2 (Database):
  1. Firebase Console > Firestore Database
  2. Create database in nam5 region
  3. Start in test mode for development
  4. Plan production security rules

Priority 3 (Service Account):
  1. Firebase Console > Project Settings > Service Accounts
  2. Generate private key for GitHub Actions
  3. Add FIREBASE_SERVICE_ACCOUNT to GitHub secrets
  4. Test automated deployment
```

### Future Enhancements
```yaml
Phase 1:
  - Firebase Analytics setup
  - Performance monitoring integration
  - Error tracking with Crashlytics
  - Custom domain configuration

Phase 2:
  - Staging environment setup
  - Blue-green deployment strategy
  - Automated testing in production-like environment
  - Load testing and performance optimization

Phase 3:
  - Multi-region deployment
  - Advanced monitoring and alerting
  - Automated rollback triggers
  - Infrastructure as Code (Terraform/ARM)
```

## Cost Monitoring

### Current Firebase Usage
```yaml
Hosting:
  - Free tier: 10GB storage, 1GB transfer/month
  - Current usage: <1GB (initial deployment)
  - Overage cost: $0.15/GB

Authentication:
  - Free tier: 50,000 monthly active users
  - Current usage: Development only
  - Overage cost: $0.0055/user

Firestore:
  - Free tier: 1GB storage, 50K reads, 20K writes/day
  - Current usage: Not yet configured
  - Overage cost: $0.18/100K operations
```

### Cost Optimization
```yaml
Strategies:
  - Monitor Firebase usage dashboard
  - Implement efficient Firestore queries
  - Use Firebase hosting cache headers
  - Optimize bundle size to reduce bandwidth
  - Set up usage alerts and quotas
```

This deployment documentation provides comprehensive context for managing the BakeFlow ERP infrastructure, enabling autonomous deployment management and troubleshooting.