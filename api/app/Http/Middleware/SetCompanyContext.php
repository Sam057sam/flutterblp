<?php

namespace App\Http\Middleware;

use App\Support\CompanyContext;
use Closure;
use Illuminate\Http\Request;

class SetCompanyContext
{
    public function handle(Request $request, Closure $next)
    {
        $user = $request->user();
        if ($user) {
            $headerCompanyId = $request->header('X-Company-Id');
            if ($headerCompanyId) {
                $user->current_company_id = (int) $headerCompanyId;
            }

            if (!$user->current_company_id) {
                $user->current_company_id = $user->companies()->value('companies.id');
            }

            if (!$user->current_company_id) {
                return response()->json(['message' => 'Company context required.'], 403);
            }

            app(CompanyContext::class)->setCompanyId($user->current_company_id);
        }

        return $next($request);
    }
}
