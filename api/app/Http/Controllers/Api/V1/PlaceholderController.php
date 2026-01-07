<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class PlaceholderController extends Controller
{
    public function __invoke(Request $request)
    {
        $module = $request->route('module');

        return response()->json([
            'message' => 'Module endpoint placeholder.',
            'module' => $module,
        ]);
    }
}
