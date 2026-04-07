---
name: flutter-mobile-design-skill
description: Create distinctive, production-grade Flutter mobile interfaces with exceptional design quality for iOS and Android. Use this skill when the user asks to build mobile apps, screens, or UI components. Enforces mobile ergonomics, high-end kineseology (haptics/motion), extreme typographic hierarchy, and custom theming while avoiding generic Flutter/Material defaults.
---

# Flutter Mobile Design Skill

Use this skill to guide the creation of premium, tactile, and distinct mobile interfaces. Your goal is to escape the generic "Flutter slop" (default Material AppBars, predictable blue/purple palettes, floating action buttons, lifeless listviews) and act as a world-class product designer. 

Do not rely on pre-existing templates. Invent a cohesive, custom visual language tailored perfectly to the app's context, and execute it with absolute precision.

## 1. Aesthetic Independence & Design Thinking

Before writing UI code, invent a BOLD aesthetic direction based on the app's purpose.
- **Determine the mood**: Is it raw and utilitarian? Soft and organic? Hyper-futuristic? Minimal and editorial? 
- **Commit fully**: Once you choose a vibe, apply it consistently across borders, typography, shadows, and spacing. Half-measures create forgettable interfaces.
- **Avoid Defaults**: Never use a generic `Card` with default elevation and grey background. Build custom containers using spacing, subtle surface color shifts, or custom border treatments to separate content.

## 2. Mobile Ergonomics & Layout

Design for human thumbs and real devices, not abstract desktop windows.
- **The Thumb Zone**: Place primary navigation and critical actions at the bottom of the screen. Avoid top-left hamburger menus or critical buttons in the top header. Bottom sheets and floating panels out-perform top-heavy layouts.
- **Generous Touch Targets**: This is strictly enforced. Any tappable element must have a minimum hit area of **66x66 logical pixels** (prefer 72-80px for main actions). If an icon is visually small, use padding inside the `GestureDetector` or `InkWell` to expand the hit area.
- **Edge-to-Edge Canvas**: Content should bleed seamlessly under transparent system status and navigation bars. Only constrain interactive UI elements or readable text with `SafeArea`.
- **Responsive Geometry**: Use `LayoutBuilder` for all structural widget decisions based on available space. **NEVER use `MediaQuery` for layout decisions**, as it causes unnecessary rebuilds and breaks easily on keyboard popups. Limit `MediaQuery` only to reading system padding.

## 3. Kinesiology, Motion & Tactility

Mobile interfaces must feel physical, alive, and responsive to human touch. Static interfaces are unacceptable.
- **Haptic Feedback is Mandatory**: Digital touch must feel physical. 
  - `HapticFeedback.lightImpact()` for rapid selections or scrolling thresholds.
  - `HapticFeedback.mediumImpact()` for standard button presses and toggles.
  - `HapticFeedback.heavyImpact()` for destructive actions, major confirmations, or success states.
- **The "Squish" Effect**: Interactive elements must respond visually *immediately* upon touch. Buttons and cards should scale down slightly on press (e.g., `0.95` or `0.98`) and spring back on release. Never use a button that lacks a pressed state.
- **Choreography**: Elements should not just "appear". Use staggered reveals for lists (e.g., 50-100ms delays between items). Use smooth curves (`Curves.easeOutCubic` for entrances, `Curves.elasticOut` for playful bounces).
- **Transitions**: Treat the app as a spatial environment. Use `Hero` animations or custom page transitions to morph elements seamlessly between screens.

## 4. Typography & Extreme Hierarchy

Typography defines the app's personality and structure.
- **No System Defaults**: Never use the default Roboto or basic sans-serifs without character. Always integrate the `google_fonts` package (or explicitly defined custom fonts) to give the app a distinct voice.
- **Two-Font Rule**: Pair one highly distinctive display/header font with one highly readable, clean body font. 
- **Extreme Contrast**: Build hierarchy through massive leaps in scale and weight, not timid increments. Pair a `32px` weight `800` header with a `14px` weight `400` subtitle. If you squint, the most important element must still be obvious.

## 5. Dark Mode Mastery & Color Architecture

Build a complete, custom `ThemeData` from scratch.
- **No Pure Black**: Never use pure black (`#000000`) for dark mode backgrounds. Use rich, deep grays (e.g., `#121212` to `#1A1A1A`). 
- **Elevation via Lightness, Not Shadows**: In dark mode, do not use drop shadows to indicate depth. Instead, elevate surfaces by making them lighter (`#121212` base -> `#1E1E1E` card -> `#2C2C2C` floating element).
- **Text Contrast**: Use opacity for text hierarchy. Primary text at 87-100% opacity, secondary text at 60%, disabled at 38%.
- **Desaturated Accents**: Bright, saturated brand colors vibrate unpleasantly on dark backgrounds. Automatically desaturate or lighten accent colors by 10-20% when in dark mode to ensure comfortable readability.

## Anti-Patterns: What to Reject

- ❌ **"Lorem Ipsum" & Placeholders**: Never leave generic placeholders. Generate realistic, context-appropriate mock data (names, dates, financial figures) that fits the design.
- ❌ **Default AppBar**: Do not use the default `AppBar` with a solid color and centered text. Build custom sliver headers, floating transparent headers, or typography-driven headers instead.
- ❌ **The "AI Gradient"**: Reject predictable purple-to-pink or blue-to-purple linear gradients. 
- ❌ **Instant Snapping**: Reject any state change (like a tab switch or selection) that snaps instantly without a crossfade, size transition, or movement.

Remember: The Flutter framework imposes no style—only generic defaults. Your job as an AI is to override every default intentionally, creating a high-end interface that feels expensive, thoughtful, and entirely unique to the user's prompt.