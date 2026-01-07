<?php

use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\CustomerController;
use App\Http\Controllers\Api\V1\DashboardController;
use App\Http\Controllers\Api\V1\MediaController;
use App\Http\Controllers\Api\V1\PlaceholderController;
use App\Http\Controllers\Api\V1\ProductController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {
    Route::post('auth/login', [AuthController::class, 'login']);

    Route::middleware(['auth:sanctum', 'company.context'])->group(function () {
        Route::post('auth/logout', [AuthController::class, 'logout']);
        Route::get('me', [AuthController::class, 'me']);
        Route::post('auth/change-password', [AuthController::class, 'changePassword']);

        Route::get('dashboard/kpis', [DashboardController::class, 'kpis']);

        Route::apiResource('customers', CustomerController::class);
        Route::apiResource('products', ProductController::class);

        Route::post('media/upload', [MediaController::class, 'upload']);

        Route::get('analytics', PlaceholderController::class)->defaults('module', 'analytics');

        Route::get('sales/quotes', PlaceholderController::class)->defaults('module', 'sales.quotes');
        Route::get('sales/orders', PlaceholderController::class)->defaults('module', 'sales.orders');
        Route::get('sales/invoices', PlaceholderController::class)->defaults('module', 'sales.invoices');
        Route::get('sales/payments', PlaceholderController::class)->defaults('module', 'sales.payments');
        Route::get('sales/returns', PlaceholderController::class)->defaults('module', 'sales.returns');

        Route::get('purchasing/suppliers', PlaceholderController::class)->defaults('module', 'purchasing.suppliers');
        Route::get('purchasing/orders', PlaceholderController::class)->defaults('module', 'purchasing.orders');
        Route::get('purchasing/grn', PlaceholderController::class)->defaults('module', 'purchasing.grn');
        Route::get('purchasing/bills', PlaceholderController::class)->defaults('module', 'purchasing.bills');
        Route::get('purchasing/expenses', PlaceholderController::class)->defaults('module', 'purchasing.expenses');
        Route::get('purchasing/expense-categories', PlaceholderController::class)
            ->defaults('module', 'purchasing.expense-categories');

        Route::get('inventory/import', PlaceholderController::class)->defaults('module', 'inventory.import');
        Route::get('inventory/categories', PlaceholderController::class)->defaults('module', 'inventory.categories');
        Route::get('inventory/sub-categories', PlaceholderController::class)->defaults('module', 'inventory.sub-categories');
        Route::get('inventory/brands', PlaceholderController::class)->defaults('module', 'inventory.brands');
        Route::get('inventory/units', PlaceholderController::class)->defaults('module', 'inventory.units');
        Route::get('inventory/attributes', PlaceholderController::class)->defaults('module', 'inventory.attributes');
        Route::get('inventory/warehouses', PlaceholderController::class)->defaults('module', 'inventory.warehouses');
        Route::get('inventory/balances', PlaceholderController::class)->defaults('module', 'inventory.balances');
        Route::get('inventory/movements', PlaceholderController::class)->defaults('module', 'inventory.movements');
        Route::get('inventory/adjustments', PlaceholderController::class)->defaults('module', 'inventory.adjustments');
        Route::get('inventory/reorder', PlaceholderController::class)->defaults('module', 'inventory.reorder');

        Route::get('finance/ledger', PlaceholderController::class)->defaults('module', 'finance.ledger');
        Route::get('finance/accounts', PlaceholderController::class)->defaults('module', 'finance.accounts');
        Route::get('finance/taxes', PlaceholderController::class)->defaults('module', 'finance.taxes');

        Route::get('operations/shipments', PlaceholderController::class)->defaults('module', 'operations.shipments');
        Route::get('operations/files', PlaceholderController::class)->defaults('module', 'operations.files');
        Route::get('operations/backups', PlaceholderController::class)->defaults('module', 'operations.backups');
        Route::get('operations/company', PlaceholderController::class)->defaults('module', 'operations.company');
        Route::get('operations/exports', PlaceholderController::class)->defaults('module', 'operations.exports');

        Route::get('admin/users', PlaceholderController::class)->defaults('module', 'admin.users');
        Route::get('admin/roles', PlaceholderController::class)->defaults('module', 'admin.roles');
    });
});
