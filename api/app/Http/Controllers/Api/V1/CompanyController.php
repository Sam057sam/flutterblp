<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Company;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class CompanyController extends Controller
{
    public function index(Request $request)
    {
        return response()->json([
            'data' => $request->user()->companies()->orderBy('name')->get(),
        ]);
    }

    public function store(Request $request)
    {
        $data = $this->validateCompany($request);
        $data['slug'] = $data['slug'] ?? Str::slug($data['display_name'] ?? $data['name'] ?? 'company');
        $data['name'] = $data['name'] ?? $data['display_name'] ?? $data['legal_name'] ?? 'Company';

        $company = Company::create($data);
        $request->user()->companies()->syncWithoutDetaching([$company->id => ['is_primary' => false]]);

        return response()->json(['data' => $company], 201);
    }

    public function show(Request $request, Company $company)
    {
        $this->authorizeCompany($request, $company);

        return response()->json(['data' => $company]);
    }

    public function update(Request $request, Company $company)
    {
        $this->authorizeCompany($request, $company);

        $data = $this->validateCompany($request, false);
        $company->update($data);

        return response()->json(['data' => $company->fresh()]);
    }

    public function upload(Request $request, Company $company)
    {
        $this->authorizeCompany($request, $company);

        $data = $request->validate([
            'type' => ['required', 'string'],
            'file' => ['required', 'file', 'max:10240'],
        ]);

        $typeMap = [
            'logo' => 'logo_file',
            'favicon' => 'favicon_file',
            'document_watermark' => 'document_watermark_file',
            'authorised_signature' => 'authorised_signature_file',
        ];

        $field = $typeMap[$data['type']] ?? null;
        if (!$field) {
            return response()->json(['message' => 'Invalid upload type.'], 422);
        }

        $path = $data['file']->store('company-assets', 'public');
        $company->update([$field => $path]);

        return response()->json([
            'data' => $company->fresh(),
            'url' => Storage::disk('public')->url($path),
        ]);
    }

    private function authorizeCompany(Request $request, Company $company): void
    {
        $exists = $request->user()->companies()->where('companies.id', $company->id)->exists();
        if (!$exists) {
            abort(403, 'Unauthorized company access.');
        }
    }

    private function validateCompany(Request $request, bool $required = true): array
    {
        $rule = $required ? 'required' : 'nullable';

        return $request->validate([
            'name' => [$rule, 'string', 'max:255'],
            'slug' => ['nullable', 'string', 'max:255'],
            'email' => ['nullable', 'email'],
            'phone' => ['nullable', 'string', 'max:50'],
            'address' => ['nullable', 'string', 'max:255'],
            'currency' => ['nullable', 'string', 'max:10'],
            'timezone' => ['nullable', 'string', 'max:64'],
            'entity_code' => ['nullable', 'string', 'max:100'],
            'display_name' => [$rule, 'string', 'max:255'],
            'legal_name' => [$rule, 'string', 'max:255'],
            'reporting_currency' => ['nullable', 'string', 'max:10'],
            'primary_email' => [$rule, 'email'],
            'contact_phone' => ['nullable', 'string', 'max:50'],
            'street_address' => ['nullable', 'string', 'max:255'],
            'city' => ['nullable', 'string', 'max:100'],
            'state_region' => ['nullable', 'string', 'max:100'],
            'postal_code' => ['nullable', 'string', 'max:20'],
            'country' => ['nullable', 'string', 'max:100'],
            'tagline' => ['nullable', 'string', 'max:255'],
            'gst_vat_number' => ['nullable', 'string', 'max:100'],
            'tax_registration' => ['nullable', 'string', 'max:100'],
            'pan_tax_id' => ['nullable', 'string', 'max:100'],
            'cin_company_id' => ['nullable', 'string', 'max:100'],
            'msme_udyam' => ['nullable', 'string', 'max:100'],
            'compliance_notes' => ['nullable', 'string'],
            'locale' => ['nullable', 'string', 'max:20'],
            'industry' => ['nullable', 'string', 'max:100'],
            'financial_year_start' => ['nullable', 'string', 'max:50'],
            'financial_year_end' => ['nullable', 'string', 'max:50'],
            'document_prefix' => ['nullable', 'string', 'max:50'],
            'website' => ['nullable', 'string', 'max:255'],
            'support_email' => ['nullable', 'email'],
            'account_name' => ['nullable', 'string', 'max:255'],
            'account_number' => ['nullable', 'string', 'max:100'],
            'bank' => ['nullable', 'string', 'max:100'],
            'branch' => ['nullable', 'string', 'max:100'],
            'ifsc_code' => ['nullable', 'string', 'max:50'],
            'terms_conditions' => ['nullable', 'string'],
        ]);
    }
}
