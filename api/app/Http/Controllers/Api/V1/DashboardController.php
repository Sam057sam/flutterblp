<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use App\Models\Product;

class DashboardController extends Controller
{
    public function kpis()
    {
        return response()->json([
            'kpis' => [
                'customers' => Customer::count(),
                'products' => Product::count(),
                'sales' => 0,
                'outstanding_invoices' => 0,
            ],
            'alerts' => [
                ['type' => 'info', 'message' => 'Welcome to Shams ERP.'],
            ],
        ]);
    }
}
