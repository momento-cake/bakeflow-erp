# BakeFlow ERP - Design Guidelines

## Overview

BakeFlow ERP follows a warm, professional design system that reflects the artisanal nature of bakery businesses while maintaining modern usability standards. The design emphasizes clarity, accessibility, and mobile-first responsive design principles.

## Brand Identity

### Visual Philosophy
- **Warmth**: Reflecting the cozy, artisanal nature of bakeries
- **Professionalism**: Clean, organized interface for business operations
- **Accessibility**: Clear contrast and readable typography for all users
- **Simplicity**: Intuitive navigation and minimal cognitive load

### Brand Personality
- **Artisanal**: Handcrafted quality with attention to detail
- **Reliable**: Trustworthy and consistent business tool
- **Friendly**: Approachable and easy to use
- **Intelligent**: Smart automation and helpful insights

## Color System

### Primary Palette

#### Primary Color - Saddle Brown
```css
--primary-color: #8B4513
--primary-rgb: rgb(139, 69, 19)
--primary-hsl: hsl(25, 76%, 31%)
```
- **Usage**: Headers, primary buttons, brand elements, navigation highlights
- **Represents**: Chocolate, warmth, earthiness, craftsmanship
- **Accessibility**: WCAG AA compliant when used with white text

#### Secondary Color - Cornsilk
```css
--secondary-color: #FFF8DC
--secondary-rgb: rgb(255, 248, 220)
--secondary-hsl: hsl(48, 100%, 93%)
```
- **Usage**: Light backgrounds, subtle highlights, card backgrounds
- **Represents**: Flour, cleanliness, bakery environment
- **Accessibility**: Use with dark text for optimal contrast

#### Accent Color - Soft Red
```css
--accent-color: #FF6B6B
--accent-rgb: rgb(255, 107, 107)
--accent-hsl: hsl(0, 100%, 71%)
```
- **Usage**: CTAs, important notifications, interactive elements
- **Represents**: Energy, urgency, attention-grabbing elements
- **Accessibility**: WCAG AA compliant with white text

### Semantic Colors

#### Success - Turquoise
```css
--success-color: #4ECDC4
--success-rgb: rgb(78, 205, 196)
--success-hsl: hsl(176, 57%, 55%)
```
- **Usage**: Success messages, positive feedback, completion states
- **Context**: Order completion, successful saves, positive metrics

#### Warning - Honey Yellow
```css
--warning-color: #FFD93D
--warning-rgb: rgb(255, 217, 61)
--warning-hsl: hsl(48, 100%, 62%)
```
- **Usage**: Warnings, caution states, important notices
- **Context**: Low inventory, expiring ingredients, attention needed

#### Error - Coral Red
```css
--error-color: #E74C3C
--error-rgb: rgb(231, 76, 60)
--error-hsl: hsl(6, 78%, 57%)
```
- **Usage**: Error messages, validation failures, critical issues
- **Context**: Form errors, failed operations, critical alerts

### Neutral Palette

#### Neutral Gray
```css
--neutral-gray: #6C757D
--neutral-gray-rgb: rgb(108, 117, 125)
--neutral-gray-hsl: hsl(210, 7%, 46%)
```
- **Usage**: Secondary text, borders, disabled states
- **Context**: Descriptions, placeholders, subtle elements

#### Background
```css
--background-color: #FAFAFA
--background-rgb: rgb(250, 250, 250)
--background-hsl: hsl(0, 0%, 98%)
```
- **Usage**: Main background, page background, subtle separation
- **Context**: App background, card containers, section backgrounds

#### Surface White
```css
--surface-white: #FFFFFF
--surface-white-rgb: rgb(255, 255, 255)
--surface-white-hsl: hsl(0, 0%, 100%)
```
- **Usage**: Card backgrounds, input fields, elevated surfaces
- **Context**: Form backgrounds, modal overlays, content cards

### Color Usage Guidelines

#### Contrast Requirements
- **Primary text on background**: Minimum 4.5:1 contrast ratio
- **Large text (18pt+)**: Minimum 3:1 contrast ratio
- **Interactive elements**: Minimum 3:1 contrast ratio for borders and states

#### Color Combinations
```css
/* Approved combinations for accessibility */
.primary-on-white { color: #8B4513; background: #FFFFFF; } /* 7.1:1 */
.white-on-primary { color: #FFFFFF; background: #8B4513; } /* 7.1:1 */
.accent-on-white { color: #FF6B6B; background: #FFFFFF; } /* 3.8:1 */
.gray-on-white { color: #6C757D; background: #FFFFFF; } /* 5.4:1 */
```

## Typography System

### Font Families

#### Display & Headers - Playfair Display
```css
font-family: 'Playfair Display', serif;
```
- **Usage**: Page titles, section headers, brand elements
- **Characteristics**: Elegant, readable, sophisticated
- **Weights**: 400 (Regular), 600 (SemiBold), 700 (Bold)
- **Fallback**: Georgia, 'Times New Roman', serif

#### Body Text - Inter
```css
font-family: 'Inter', sans-serif;
```
- **Usage**: Body text, navigation, UI elements, descriptions
- **Characteristics**: Clean, modern, excellent readability
- **Weights**: 400 (Regular), 500 (Medium), 600 (SemiBold)
- **Fallback**: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif

#### Numbers & Data - Roboto Mono
```css
font-family: 'Roboto Mono', monospace;
```
- **Usage**: Prices, quantities, measurements, financial data
- **Characteristics**: Monospaced, clear distinction, consistent width
- **Weights**: 400 (Regular), 500 (Medium)
- **Fallback**: 'SF Mono', Monaco, 'Cascadia Code', monospace

### Typography Scale

#### Display Typography
```css
/* Display Large - Page Titles */
.display-large {
  font-family: 'Playfair Display', serif;
  font-size: 32px;
  font-weight: 700;
  line-height: 1.2;
  letter-spacing: -0.5px;
  color: var(--primary-color);
}

/* Display Medium - Section Headers */
.display-medium {
  font-family: 'Playfair Display', serif;
  font-size: 28px;
  font-weight: 600;
  line-height: 1.3;
  letter-spacing: -0.25px;
}

/* Display Small - Subsection Headers */
.display-small {
  font-family: 'Playfair Display', serif;
  font-size: 24px;
  font-weight: 600;
  line-height: 1.3;
  letter-spacing: 0px;
}
```

#### Headline Typography
```css
/* Headline Large - Card Titles */
.headline-large {
  font-family: 'Inter', sans-serif;
  font-size: 20px;
  font-weight: 600;
  line-height: 1.4;
  letter-spacing: 0px;
}

/* Headline Medium - Component Headers */
.headline-medium {
  font-family: 'Inter', sans-serif;
  font-size: 18px;
  font-weight: 500;
  line-height: 1.4;
  letter-spacing: 0.1px;
}

/* Headline Small - List Headers */
.headline-small {
  font-family: 'Inter', sans-serif;
  font-size: 16px;
  font-weight: 500;
  line-height: 1.4;
  letter-spacing: 0.1px;
}
```

#### Body Typography
```css
/* Body Large - Main Content */
.body-large {
  font-family: 'Inter', sans-serif;
  font-size: 16px;
  font-weight: 400;
  line-height: 1.5;
  letter-spacing: 0.15px;
}

/* Body Medium - Secondary Content */
.body-medium {
  font-family: 'Inter', sans-serif;
  font-size: 14px;
  font-weight: 400;
  line-height: 1.5;
  letter-spacing: 0.25px;
}

/* Body Small - Captions, Labels */
.body-small {
  font-family: 'Inter', sans-serif;
  font-size: 12px;
  font-weight: 400;
  line-height: 1.4;
  letter-spacing: 0.4px;
}
```

#### Data Typography
```css
/* Price Display */
.price-large {
  font-family: 'Roboto Mono', monospace;
  font-size: 24px;
  font-weight: 500;
  line-height: 1.2;
  letter-spacing: 0px;
}

/* Quantity/Measurement */
.data-medium {
  font-family: 'Roboto Mono', monospace;
  font-size: 16px;
  font-weight: 400;
  line-height: 1.3;
  letter-spacing: 0.1px;
}

/* Small Numbers */
.data-small {
  font-family: 'Roboto Mono', monospace;
  font-size: 14px;
  font-weight: 400;
  line-height: 1.3;
  letter-spacing: 0.2px;
}
```

## Spacing System

### Spacing Scale
```css
/* Base spacing unit: 4px */
--spacing-xs: 4px;    /* 0.25rem */
--spacing-sm: 8px;    /* 0.5rem */
--spacing-md: 16px;   /* 1rem */
--spacing-lg: 24px;   /* 1.5rem */
--spacing-xl: 32px;   /* 2rem */
--spacing-2xl: 48px;  /* 3rem */
--spacing-3xl: 64px;  /* 4rem */
```

### Padding Guidelines
```css
/* Component padding */
--padding-sm: 8px;    /* Small components, compact spacing */
--padding-md: 16px;   /* Standard components, comfortable spacing */
--padding-lg: 24px;   /* Large components, generous spacing */

/* Page padding */
--page-padding-mobile: 16px;
--page-padding-tablet: 24px;
--page-padding-desktop: 32px;
```

### Margin Guidelines
```css
/* Component margins */
--margin-component-sm: 8px;   /* Between related elements */
--margin-component-md: 16px;  /* Between sections */
--margin-component-lg: 24px;  /* Between major sections */

/* Content margins */
--margin-content: 16px;       /* Standard content spacing */
--margin-section: 32px;       /* Between page sections */
```

## Border Radius System

### Radius Scale
```css
--radius-xs: 2px;    /* Subtle rounding */
--radius-sm: 4px;    /* Small elements */
--radius-md: 8px;    /* Cards, containers */
--radius-lg: 16px;   /* Buttons, prominent elements */
--radius-xl: 24px;   /* Large containers */
--radius-full: 50%;  /* Circular elements */
```

### Component-Specific Radius
```css
/* Cards and containers */
.card { border-radius: var(--radius-md); }

/* Buttons */
.button { border-radius: var(--radius-lg); }

/* Input fields */
.input { border-radius: var(--radius-sm); }

/* Images */
.avatar { border-radius: var(--radius-full); }
.thumbnail { border-radius: var(--radius-md); }
```

## Shadow System

### Elevation Levels
```css
/* Subtle elevation - Cards */
--shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);

/* Standard elevation - Buttons, dropdowns */
--shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);

/* High elevation - Modals, tooltips */
--shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);

/* Maximum elevation - Overlays */
--shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.15);
```

### Component Shadows
```css
.card-shadow { box-shadow: var(--shadow-sm); }
.button-shadow { box-shadow: var(--shadow-md); }
.modal-shadow { box-shadow: var(--shadow-lg); }
.overlay-shadow { box-shadow: var(--shadow-xl); }
```

## Component Guidelines

### Buttons

#### Primary Button
```css
.btn-primary {
  background-color: var(--primary-color);
  color: white;
  border: none;
  border-radius: var(--radius-lg);
  padding: 12px 24px;
  font-family: 'Inter', sans-serif;
  font-size: 16px;
  font-weight: 600;
  box-shadow: var(--shadow-md);
  transition: all 0.2s ease;
}

.btn-primary:hover {
  background-color: #7A3E11;
  box-shadow: var(--shadow-lg);
  transform: translateY(-1px);
}
```

#### Secondary Button
```css
.btn-secondary {
  background-color: var(--secondary-color);
  color: var(--primary-color);
  border: 1px solid var(--primary-color);
  border-radius: var(--radius-lg);
  padding: 12px 24px;
  font-family: 'Inter', sans-serif;
  font-size: 16px;
  font-weight: 600;
}
```

#### Icon Button
```css
.btn-icon {
  width: 48px;
  height: 48px;
  border-radius: var(--radius-full);
  background-color: var(--primary-color);
  color: white;
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: var(--shadow-md);
}
```

### Form Elements

#### Text Input
```css
.text-input {
  width: 100%;
  padding: 12px 16px;
  border: 1px solid rgba(108, 117, 125, 0.3);
  border-radius: var(--radius-sm);
  background-color: white;
  font-family: 'Inter', sans-serif;
  font-size: 16px;
  line-height: 1.5;
  transition: border-color 0.2s ease;
}

.text-input:focus {
  outline: none;
  border-color: var(--primary-color);
  border-width: 2px;
  box-shadow: 0 0 0 3px rgba(139, 69, 19, 0.1);
}
```

#### Label
```css
.form-label {
  font-family: 'Inter', sans-serif;
  font-size: 14px;
  font-weight: 500;
  color: var(--neutral-gray);
  margin-bottom: 8px;
  display: block;
}
```

### Cards

#### Standard Card
```css
.card {
  background-color: white;
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
  padding: var(--padding-md);
  border: 1px solid rgba(108, 117, 125, 0.1);
  transition: box-shadow 0.2s ease;
}

.card:hover {
  box-shadow: var(--shadow-md);
}
```

#### Feature Card
```css
.feature-card {
  background-color: white;
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
  padding: var(--padding-lg);
  text-align: center;
  border: 1px solid rgba(108, 117, 125, 0.1);
  cursor: pointer;
  transition: all 0.2s ease;
}

.feature-card:hover {
  box-shadow: var(--shadow-lg);
  transform: translateY(-2px);
  border-color: var(--primary-color);
}
```

## Layout Guidelines

### Container System
```css
/* Page container */
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 var(--page-padding-mobile);
}

@media (min-width: 768px) {
  .container {
    padding: 0 var(--page-padding-tablet);
  }
}

@media (min-width: 1024px) {
  .container {
    padding: 0 var(--page-padding-desktop);
  }
}
```

### Grid System
```css
/* Responsive grid */
.grid {
  display: grid;
  gap: var(--spacing-md);
}

.grid-2 {
  grid-template-columns: repeat(2, 1fr);
}

.grid-3 {
  grid-template-columns: repeat(3, 1fr);
}

.grid-4 {
  grid-template-columns: repeat(4, 1fr);
}

/* Mobile-first responsive */
@media (max-width: 767px) {
  .grid-2,
  .grid-3,
  .grid-4 {
    grid-template-columns: 1fr;
  }
}

@media (min-width: 768px) and (max-width: 1023px) {
  .grid-3,
  .grid-4 {
    grid-template-columns: repeat(2, 1fr);
  }
}
```

## Responsive Design

### Breakpoints
```css
/* Mobile devices */
@media (max-width: 767px) { /* Mobile styles */ }

/* Tablet devices */
@media (min-width: 768px) and (max-width: 1023px) { /* Tablet styles */ }

/* Desktop devices */
@media (min-width: 1024px) { /* Desktop styles */ }

/* Large desktop */
@media (min-width: 1440px) { /* Large desktop styles */ }
```

### Mobile-First Approach
- Design for mobile first, then enhance for larger screens
- Touch-friendly interface with minimum 44px touch targets
- Readable text without zooming (minimum 16px font size)
- Efficient use of screen real estate
- Thumb-friendly navigation placement

## Accessibility Guidelines

### Color Accessibility
- Maintain minimum 4.5:1 contrast ratio for normal text
- Maintain minimum 3:1 contrast ratio for large text (18pt+)
- Never rely solely on color to convey information
- Provide alternative indicators (icons, patterns, text)

### Typography Accessibility
- Use relative units (rem, em) for scalable text
- Maintain readable line height (1.4-1.6 for body text)
- Ensure sufficient character spacing
- Test with system font size adjustments

### Interactive Element Accessibility
- Minimum 44px touch target size
- Clear focus indicators with high contrast
- Logical tab order for keyboard navigation
- Descriptive alt text for images and icons

## Animation Guidelines

### Micro-Interactions
```css
/* Standard transitions */
.transition-standard {
  transition: all 0.2s ease;
}

/* Hover effects */
.hover-lift:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-lg);
}

/* Button press */
.btn:active {
  transform: translateY(1px);
  box-shadow: var(--shadow-sm);
}
```

### Loading States
```css
/* Skeleton loading */
.skeleton {
  background: linear-gradient(90deg, 
    var(--background-color) 25%, 
    rgba(255,255,255,0.8) 50%, 
    var(--background-color) 75%);
  background-size: 200% 100%;
  animation: loading 1.5s infinite;
}

@keyframes loading {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}
```

## Content Guidelines

### Writing Style
- **Clear and Concise**: Use simple, direct language
- **Consistent Terminology**: Maintain consistent terms throughout
- **Action-Oriented**: Use active voice and clear CTAs
- **Localized**: Portuguese (Brazil) with appropriate cultural context

### Error Messages
- **Helpful**: Explain what went wrong and how to fix it
- **Polite**: Use friendly, non-technical language
- **Actionable**: Provide clear next steps
- **Localized**: Written in Portuguese with appropriate tone

### Success Messages
- **Positive**: Use encouraging language
- **Specific**: Clearly state what was accomplished
- **Brief**: Keep messages concise but informative

## Icon Guidelines

### Icon System
- **Style**: Outlined icons for consistency
- **Size**: 16px, 20px, 24px standard sizes
- **Color**: Use semantic colors (primary, accent, neutral)
- **Context**: Icons should enhance, not replace text labels

### Common Icons
```css
/* Navigation icons */
.icon-home { /* Home/Dashboard */ }
.icon-products { /* Product catalog */ }
.icon-recipe { /* Recipe management */ }
.icon-ingredients { /* Ingredient inventory */ }
.icon-calculator { /* Pricing calculator */ }
.icon-reports { /* Reports and analytics */ }
.icon-settings { /* App settings */ }

/* Action icons */
.icon-add { /* Add new item */ }
.icon-edit { /* Edit existing item */ }
.icon-delete { /* Remove item */ }
.icon-save { /* Save changes */ }
.icon-cancel { /* Cancel action */ }
.icon-search { /* Search function */ }
```

## Implementation Notes

### CSS Custom Properties
All design tokens should be implemented as CSS custom properties for easy theming and maintenance.

### Component Libraries
- Follow Material Design 3 principles
- Ensure consistency with Flutter's Material widgets
- Maintain cross-platform compatibility

### Performance Considerations
- Optimize font loading with font-display: swap
- Use system fonts as fallbacks
- Minimize CSS bundle size
- Implement efficient responsive images

This design system ensures consistency, accessibility, and professional appearance across the BakeFlow ERP application while maintaining the warm, artisanal brand identity appropriate for bakery businesses.