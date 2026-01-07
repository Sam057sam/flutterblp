# Shams ERP Monorepo

Production-ready SaaS ERP scaffold with:
- Laravel 12 (API-first) in `/api`
- Flutter (Android/Web/Windows) in `/app`

## Monorepo Structure
- `/api` Laravel 12 API
- `/app` Flutter client
- `/postman` Postman collection
- `DEPLOYMENT.md` Hostinger deployment steps

## Local Development

### API (Laravel)
1) Copy env and set DB values:
   - `copy api/.env.example api/.env`
   - Update `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`
2) Install deps:
   - `cd api`
   - `composer install --ignore-platform-req=ext-pcntl`
3) Run migrations + seed roles/admin:
   - `php artisan migrate --seed`
4) Storage link:
   - `php artisan storage:link`
5) Serve API:
   - `php artisan serve`

### Flutter App
1) Install deps:
   - `cd app`
   - `flutter pub get`
   - Note: Windows may require Developer Mode for symlink support.
2) Run (desktop/web/mobile):
   - `flutter run -d windows`
   - `flutter run -d chrome`
   - `flutter run -d android`

## Phase 1 Endpoints (Working)
- `POST /api/v1/auth/login`
- `POST /api/v1/auth/logout`
- `GET  /api/v1/me`
- `GET  /api/v1/dashboard/kpis`
- `CRUD /api/v1/customers`
- `CRUD /api/v1/products`
- `POST /api/v1/media/upload`

## Sample curl commands
```bash
# Login
curl -X POST https://api.shamsprojects.com/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@example.com","password":"password"}'

# Me (replace TOKEN)
curl https://api.shamsprojects.com/api/v1/me \
  -H "Authorization: Bearer TOKEN"

# List customers
curl https://api.shamsprojects.com/api/v1/customers \
  -H "Authorization: Bearer TOKEN"

# Create customer
curl -X POST https://api.shamsprojects.com/api/v1/customers \
  -H "Authorization: Bearer TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name":"ACME Trading","email":"sales@acme.com"}'
```

## Default Admin Seed
- Email: `admin@example.com`
- Password: `password` (force change later)

## Notes
- Multi-tenant baseline uses `companies` + `company_user` pivot.
- Use `X-Company-Id` header to switch company context.
