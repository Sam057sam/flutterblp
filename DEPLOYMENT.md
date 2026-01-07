# Hostinger Deployment Guide (Managed Cloud)

## Subdomains
- API: `api.shamsprojects.com`
- Web: `erp.shamsprojects.com`

## Git Setup
- `main` branch: source code
- `deploy-web` branch: Flutter web build artifacts only

## Laravel API Deployment (api.shamsprojects.com)
1) In Hostinger hPanel:
   - Go to **Git** -> **Create Repository**
   - Connect your GitHub repo and select branch `main` (or `deploy-api` if you use a dedicated branch).
2) Set the repository to deploy inside your API directory (e.g., `public_html/api`).
3) Configure environment:
   - Create `.env` on the server (do not commit `.env`)
   - Set DB creds, APP_URL, etc.
4) SSH commands (from repo root):
   ```bash
   composer install --no-dev --optimize-autoloader
   php artisan key:generate
   php artisan migrate --seed
   php artisan storage:link
   php artisan config:cache && php artisan route:cache
   ```
5) If Hostinger expects `public_html` to be web root, add `.htaccess` in `public_html`:
   ```apache
   RewriteEngine On
   RewriteRule ^(.*)$ public/$1 [L]
   ```
6) Cron jobs in hPanel:
   - `* * * * * /usr/bin/php /home/USERNAME/public_html/api/artisan schedule:run >> /dev/null 2>&1`
   - Optional queue worker for shared hosting:
     - `* * * * * /usr/bin/php /home/USERNAME/public_html/api/artisan queue:work --tries=3 --timeout=90 >> /dev/null 2>&1`

## Flutter Web Deployment (erp.shamsprojects.com)
1) GitHub Actions builds web on every push to `main` and publishes to `deploy-web`.
2) In hPanel:
   - Connect Git repo to subdomain `erp.shamsprojects.com`
   - Select branch `deploy-web` so only built web assets are deployed.
3) Ensure SSL is enabled in hPanel for both subdomains.

## Database Setup
- Create a MySQL database in Hostinger.
- Update `.env` with:
  - `DB_CONNECTION=mysql`
  - `DB_HOST`, `DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`

## Notes
- File uploads use `storage/app/public`. Make sure `storage:link` is in place.
- Backups (spatie/laravel-backup) require `zip` and system permissions on the host.
