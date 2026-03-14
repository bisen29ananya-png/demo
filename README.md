# Demo

This Flutter project is scaffolded to demonstrate:

- Clean Architecture with **BLoC** (feature: `movies`)
- **Multi-flavor** app (dev/uat/prod)
- Multiple themes via a small **design system** (variant + light/dark)
- **Localization** via ARB + Flutter gen-l10n
- **Paginated** API calls with shimmer loading and cached network images
- Navigation via **auto_route** with **tabbed navigation** and **deep links**

The demo uses the free **TVMaze** API:

- Paginated list: `GET https://api.tvmaze.com/shows?page=<n>`
- Details: `GET https://api.tvmaze.com/shows/<id>`

## Structure

Key folders:

- `lib/core/` — cross-cutting concerns (DI, env, routing, design system, theme/locale cubits)
- `lib/features/` — feature modules
	- `movies/` — clean architecture (data/domain/presentation)
	- `shell/` — tab scaffold (auto_route)
	- `favorites/` — simple in-memory favorites
	- `settings/` — theme + language switches
- `lib/l10n/` — ARB files
- `lib/generated/l10n/` — generated localization output

## Run

### Dev flavor (default)

- Entry: `lib/main_dev.dart` (also `lib/main.dart` points to dev)

### UAT / Prod

- Entry: `lib/main_uat.dart`, `lib/main_prod.dart`

On Android, product flavors are defined in `android/app/build.gradle.kts`.

## Deep links

Examples (paths depend on platform deep-link integration, but auto_route routes are configured for these URLs):

- Movies list: `/movies`
- Movie details: `/movies/1`
- Favorites: `/favorites`
- Settings: `/settings`

## Notes

- Favorites are stored in-memory for simplicity (evaluation purpose).
- Design system tokens live under `lib/core/design_system/`.
- Localizations are in `lib/l10n/app_en.arb` and `lib/l10n/app_ar.arb`.
