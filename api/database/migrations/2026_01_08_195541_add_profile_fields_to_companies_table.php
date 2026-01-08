<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('companies', function (Blueprint $table) {
            $table->string('entity_code')->nullable()->after('id');
            $table->string('display_name')->nullable()->after('name');
            $table->string('legal_name')->nullable()->after('display_name');
            $table->string('reporting_currency', 10)->nullable()->after('currency');
            $table->string('primary_email')->nullable()->after('email');
            $table->string('contact_phone')->nullable()->after('phone');
            $table->string('street_address')->nullable()->after('address');
            $table->string('city')->nullable();
            $table->string('state_region')->nullable();
            $table->string('postal_code')->nullable();
            $table->string('country')->nullable();
            $table->string('tagline')->nullable();

            $table->string('logo_file')->nullable();
            $table->string('favicon_file')->nullable();

            $table->string('gst_vat_number')->nullable();
            $table->string('tax_registration')->nullable();
            $table->string('pan_tax_id')->nullable();
            $table->string('cin_company_id')->nullable();
            $table->string('msme_udyam')->nullable();
            $table->text('compliance_notes')->nullable();

            $table->string('timezone')->nullable()->after('timezone');
            $table->string('locale')->nullable();
            $table->string('industry')->nullable();
            $table->string('financial_year_start')->nullable();
            $table->string('financial_year_end')->nullable();
            $table->string('document_prefix')->nullable();
            $table->string('website')->nullable();
            $table->string('support_email')->nullable();

            $table->string('account_name')->nullable();
            $table->string('account_number')->nullable();
            $table->string('bank')->nullable();
            $table->string('branch')->nullable();
            $table->string('ifsc_code')->nullable();

            $table->string('document_watermark_file')->nullable();
            $table->string('authorised_signature_file')->nullable();
            $table->text('terms_conditions')->nullable();
        });

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('companies', function (Blueprint $table) {
            $table->string('entity_code')->nullable()->after('id');
            $table->string('display_name')->nullable()->after('name');
            $table->string('legal_name')->nullable()->after('display_name');
            $table->string('reporting_currency', 10)->nullable()->after('currency');
            $table->string('primary_email')->nullable()->after('email');
            $table->string('contact_phone')->nullable()->after('phone');
            $table->string('street_address')->nullable()->after('address');
            $table->string('city')->nullable();
            $table->string('state_region')->nullable();
            $table->string('postal_code')->nullable();
            $table->string('country')->nullable();
            $table->string('tagline')->nullable();

            $table->string('logo_file')->nullable();
            $table->string('favicon_file')->nullable();

            $table->string('gst_vat_number')->nullable();
            $table->string('tax_registration')->nullable();
            $table->string('pan_tax_id')->nullable();
            $table->string('cin_company_id')->nullable();
            $table->string('msme_udyam')->nullable();
            $table->text('compliance_notes')->nullable();

            $table->string('timezone')->nullable()->after('timezone');
            $table->string('locale')->nullable();
            $table->string('industry')->nullable();
            $table->string('financial_year_start')->nullable();
            $table->string('financial_year_end')->nullable();
            $table->string('document_prefix')->nullable();
            $table->string('website')->nullable();
            $table->string('support_email')->nullable();

            $table->string('account_name')->nullable();
            $table->string('account_number')->nullable();
            $table->string('bank')->nullable();
            $table->string('branch')->nullable();
            $table->string('ifsc_code')->nullable();

            $table->string('document_watermark_file')->nullable();
            $table->string('authorised_signature_file')->nullable();
            $table->text('terms_conditions')->nullable();
        });

    }
};
