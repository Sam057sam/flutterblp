<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Company extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'slug',
        'email',
        'phone',
        'address',
        'currency',
        'timezone',
        'logo_path',
        'is_active',
        'entity_code',
        'display_name',
        'legal_name',
        'reporting_currency',
        'primary_email',
        'contact_phone',
        'street_address',
        'city',
        'state_region',
        'postal_code',
        'country',
        'tagline',
        'logo_file',
        'favicon_file',
        'gst_vat_number',
        'tax_registration',
        'pan_tax_id',
        'cin_company_id',
        'msme_udyam',
        'compliance_notes',
        'locale',
        'industry',
        'financial_year_start',
        'financial_year_end',
        'document_prefix',
        'website',
        'support_email',
        'account_name',
        'account_number',
        'bank',
        'branch',
        'ifsc_code',
        'document_watermark_file',
        'authorised_signature_file',
        'terms_conditions',
    ]

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function users(): BelongsToMany
    {
        return $this->belongsToMany(User::class)->withTimestamps();
    }
}
