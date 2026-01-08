import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompanyProfile {
  CompanyProfile({
    required this.id,
    required this.displayName,
    required this.legalName,
    required this.primaryEmail,
    this.entityCode = '',
    this.reportingCurrency = '',
    this.contactPhone = '',
    this.streetAddress = '',
    this.city = '',
    this.state = '',
    this.postalCode = '',
    this.country = 'United Arab Emirates',
    this.tagline = '',
    this.logoFile = '',
    this.faviconFile = '',
    this.gstVatNumber = '',
    this.taxRegistration = '',
    this.panTaxId = '',
    this.cinCompanyId = '',
    this.msmeUdyam = '',
    this.complianceNotes = '',
    this.timezone = 'Asia/Dubai',
    this.locale = 'en-AE',
    this.industry = '',
    this.financialYearStart = '',
    this.financialYearEnd = '',
    this.documentPrefix = '',
    this.website = '',
    this.supportEmail = '',
    this.accountName = '',
    this.accountNumber = '',
    this.bank = '',
    this.branch = '',
    this.ifscCode = '',
    this.documentWatermarkFile = '',
    this.authorisedSignatureFile = '',
    this.termsAndConditions = '',
  });

  final String id;
  final String displayName;
  final String legalName;
  final String primaryEmail;
  final String entityCode;
  final String reportingCurrency;
  final String contactPhone;
  final String streetAddress;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String tagline;
  final String logoFile;
  final String faviconFile;
  final String gstVatNumber;
  final String taxRegistration;
  final String panTaxId;
  final String cinCompanyId;
  final String msmeUdyam;
  final String complianceNotes;
  final String timezone;
  final String locale;
  final String industry;
  final String financialYearStart;
  final String financialYearEnd;
  final String documentPrefix;
  final String website;
  final String supportEmail;
  final String accountName;
  final String accountNumber;
  final String bank;
  final String branch;
  final String ifscCode;
  final String documentWatermarkFile;
  final String authorisedSignatureFile;
  final String termsAndConditions;

  CompanyProfile copyWith({
    String? displayName,
    String? legalName,
    String? primaryEmail,
    String? entityCode,
    String? reportingCurrency,
    String? contactPhone,
    String? streetAddress,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    String? tagline,
    String? logoFile,
    String? faviconFile,
    String? gstVatNumber,
    String? taxRegistration,
    String? panTaxId,
    String? cinCompanyId,
    String? msmeUdyam,
    String? complianceNotes,
    String? timezone,
    String? locale,
    String? industry,
    String? financialYearStart,
    String? financialYearEnd,
    String? documentPrefix,
    String? website,
    String? supportEmail,
    String? accountName,
    String? accountNumber,
    String? bank,
    String? branch,
    String? ifscCode,
    String? documentWatermarkFile,
    String? authorisedSignatureFile,
    String? termsAndConditions,
  }) {
    return CompanyProfile(
      id: id,
      displayName: displayName ?? this.displayName,
      legalName: legalName ?? this.legalName,
      primaryEmail: primaryEmail ?? this.primaryEmail,
      entityCode: entityCode ?? this.entityCode,
      reportingCurrency: reportingCurrency ?? this.reportingCurrency,
      contactPhone: contactPhone ?? this.contactPhone,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      tagline: tagline ?? this.tagline,
      logoFile: logoFile ?? this.logoFile,
      faviconFile: faviconFile ?? this.faviconFile,
      gstVatNumber: gstVatNumber ?? this.gstVatNumber,
      taxRegistration: taxRegistration ?? this.taxRegistration,
      panTaxId: panTaxId ?? this.panTaxId,
      cinCompanyId: cinCompanyId ?? this.cinCompanyId,
      msmeUdyam: msmeUdyam ?? this.msmeUdyam,
      complianceNotes: complianceNotes ?? this.complianceNotes,
      timezone: timezone ?? this.timezone,
      locale: locale ?? this.locale,
      industry: industry ?? this.industry,
      financialYearStart: financialYearStart ?? this.financialYearStart,
      financialYearEnd: financialYearEnd ?? this.financialYearEnd,
      documentPrefix: documentPrefix ?? this.documentPrefix,
      website: website ?? this.website,
      supportEmail: supportEmail ?? this.supportEmail,
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      bank: bank ?? this.bank,
      branch: branch ?? this.branch,
      ifscCode: ifscCode ?? this.ifscCode,
      documentWatermarkFile: documentWatermarkFile ?? this.documentWatermarkFile,
      authorisedSignatureFile: authorisedSignatureFile ?? this.authorisedSignatureFile,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'display_name': displayName,
      'legal_name': legalName,
      'primary_email': primaryEmail,
      'entity_code': entityCode,
      'reporting_currency': reportingCurrency,
      'contact_phone': contactPhone,
      'street_address': streetAddress,
      'city': city,
      'state_region': state,
      'postal_code': postalCode,
      'country': country,
      'tagline': tagline,
      'gst_vat_number': gstVatNumber,
      'tax_registration': taxRegistration,
      'pan_tax_id': panTaxId,
      'cin_company_id': cinCompanyId,
      'msme_udyam': msmeUdyam,
      'compliance_notes': complianceNotes,
      'timezone': timezone,
      'locale': locale,
      'industry': industry,
      'financial_year_start': financialYearStart,
      'financial_year_end': financialYearEnd,
      'document_prefix': documentPrefix,
      'website': website,
      'support_email': supportEmail,
      'account_name': accountName,
      'account_number': accountNumber,
      'bank': bank,
      'branch': branch,
      'ifsc_code': ifscCode,
      'terms_conditions': termsAndConditions,
    };
  }

  static CompanyProfile fromJson(Map<String, dynamic> json) {
    return CompanyProfile(
      id: json['id'].toString(),
      displayName: (json['display_name'] ?? json['name'] ?? '').toString(),
      legalName: (json['legal_name'] ?? json['display_name'] ?? '').toString(),
      primaryEmail: (json['primary_email'] ?? json['email'] ?? '').toString(),
      entityCode: (json['entity_code'] ?? '').toString(),
      reportingCurrency: (json['reporting_currency'] ?? json['currency'] ?? '').toString(),
      contactPhone: (json['contact_phone'] ?? '').toString(),
      streetAddress: (json['street_address'] ?? '').toString(),
      city: (json['city'] ?? '').toString(),
      state: (json['state_region'] ?? '').toString(),
      postalCode: (json['postal_code'] ?? '').toString(),
      country: (json['country'] ?? 'United Arab Emirates').toString(),
      tagline: (json['tagline'] ?? '').toString(),
      logoFile: (json['logo_file'] ?? '').toString(),
      faviconFile: (json['favicon_file'] ?? '').toString(),
      gstVatNumber: (json['gst_vat_number'] ?? '').toString(),
      taxRegistration: (json['tax_registration'] ?? '').toString(),
      panTaxId: (json['pan_tax_id'] ?? '').toString(),
      cinCompanyId: (json['cin_company_id'] ?? '').toString(),
      msmeUdyam: (json['msme_udyam'] ?? '').toString(),
      complianceNotes: (json['compliance_notes'] ?? '').toString(),
      timezone: (json['timezone'] ?? 'Asia/Dubai').toString(),
      locale: (json['locale'] ?? 'en-AE').toString(),
      industry: (json['industry'] ?? '').toString(),
      financialYearStart: (json['financial_year_start'] ?? '').toString(),
      financialYearEnd: (json['financial_year_end'] ?? '').toString(),
      documentPrefix: (json['document_prefix'] ?? '').toString(),
      website: (json['website'] ?? '').toString(),
      supportEmail: (json['support_email'] ?? '').toString(),
      accountName: (json['account_name'] ?? '').toString(),
      accountNumber: (json['account_number'] ?? '').toString(),
      bank: (json['bank'] ?? '').toString(),
      branch: (json['branch'] ?? '').toString(),
      ifscCode: (json['ifsc_code'] ?? '').toString(),
      documentWatermarkFile: (json['document_watermark_file'] ?? '').toString(),
      authorisedSignatureFile: (json['authorised_signature_file'] ?? '').toString(),
      termsAndConditions: (json['terms_conditions'] ?? '').toString(),
    );
  }
}

class CompanyState {
  CompanyState({
    required this.companies,
    required this.activeCompanyId,
    required this.baseUrl,
    required this.token,
    required this.isSyncing,
    this.lastError,
  });

  final List<CompanyProfile> companies;
  final String activeCompanyId;
  final String baseUrl;
  final String token;
  final bool isSyncing;
  final String? lastError;

  CompanyProfile get activeCompany =>
      companies.firstWhere((company) => company.id == activeCompanyId);

  CompanyState copyWith({
    List<CompanyProfile>? companies,
    String? activeCompanyId,
    String? baseUrl,
    String? token,
    bool? isSyncing,
    String? lastError,
  }) {
    return CompanyState(
      companies: companies ?? this.companies,
      activeCompanyId: activeCompanyId ?? this.activeCompanyId,
      baseUrl: baseUrl ?? this.baseUrl,
      token: token ?? this.token,
      isSyncing: isSyncing ?? this.isSyncing,
      lastError: lastError,
    );
  }
}

class CompanyNotifier extends Notifier<CompanyState> {
  @override
  CompanyState build() {
    final initial = CompanyProfile(
      id: 'default',
      displayName: 'Shams Projects',
      legalName: 'Shams Projects LLC',
      primaryEmail: 'admin@shamsprojects.com',
      reportingCurrency: 'AED',
    );

    return CompanyState(
      companies: [initial],
      activeCompanyId: initial.id,
      baseUrl: 'https://www.shamsprojects.com/api/public',
      token: '',
      isSyncing: false,
    );
  }

  void selectCompany(String id) {
    state = state.copyWith(activeCompanyId: id);
  }

  void updateConnection({required String baseUrl, required String token}) {
    state = state.copyWith(baseUrl: baseUrl, token: token, lastError: null);
  }

  void addCompany({
    required String displayName,
    required String legalName,
    required String primaryEmail,
  }) {
    final company = CompanyProfile(
      id: UniqueKey().toString(),
      displayName: displayName,
      legalName: legalName,
      primaryEmail: primaryEmail,
      reportingCurrency: 'AED',
    );

    state = state.copyWith(
      companies: [...state.companies, company],
      activeCompanyId: company.id,
    );
  }

  void updateActive(CompanyProfile updated) {
    final companies = state.companies
        .map((company) => company.id == updated.id ? updated : company)
        .toList();
    state = state.copyWith(companies: companies);
  }

  Future<void> loadFromApi() async {
    if (state.token.isEmpty) return;
    state = state.copyWith(isSyncing: true, lastError: null);

    try {
      final dio = _dio();
      final response = await dio.get('/api/v1/companies');
      final data = (response.data['data'] as List)
          .map((item) => CompanyProfile.fromJson(item))
          .toList();
      if (data.isNotEmpty) {
        state = state.copyWith(
          companies: data,
          activeCompanyId: data.first.id,
        );
      }
    } catch (error) {
      state = state.copyWith(lastError: 'Failed to load companies from API.');
    } finally {
      state = state.copyWith(isSyncing: false);
    }
  }

  Future<void> saveActive() async {
    if (state.token.isEmpty) return;
    state = state.copyWith(isSyncing: true, lastError: null);

    final company = state.activeCompany;
    try {
      final dio = _dio();
      final response = await dio.put('/api/v1/companies/${company.id}',
          data: company.toJson());
      final updated = CompanyProfile.fromJson(response.data['data']);
      updateActive(updated);
    } catch (error) {
      state = state.copyWith(lastError: 'Failed to save company to API.');
    } finally {
      state = state.copyWith(isSyncing: false);
    }
  }


  Future<String?> uploadFile({required String type, required String filePath}) async {
    if (state.token.isEmpty) return null;
    state = state.copyWith(isSyncing: true, lastError: null);

    final company = state.activeCompany;
    try {
      final dio = _dio();
      final form = FormData.fromMap({
        'type': type,
        'file': await MultipartFile.fromFile(filePath),
      });
      final response = await dio.post(
        '/api/v1/companies/${company.id}/upload',
        data: form,
      );
      final updated = CompanyProfile.fromJson(response.data['data']);
      updateActive(updated);
      return response.data['url'] as String?;
    } catch (error) {
      state = state.copyWith(lastError: 'Failed to upload file.');
      return null;
    } finally {
      state = state.copyWith(isSyncing: false);
    }
  }

  Future<void> createCompany(CompanyProfile company) async {
    if (state.token.isEmpty) return;
    state = state.copyWith(isSyncing: true, lastError: null);

    try {
      final dio = _dio();
      final response = await dio.post('/api/v1/companies', data: company.toJson());
      final created = CompanyProfile.fromJson(response.data['data']);
      state = state.copyWith(
        companies: [...state.companies, created],
        activeCompanyId: created.id,
      );
    } catch (error) {
      state = state.copyWith(lastError: 'Failed to create company via API.');
    } finally {
      state = state.copyWith(isSyncing: false);
    }
  }

  Dio _dio() {
    return Dio(
      BaseOptions(baseUrl: state.baseUrl),
    )..options.headers['Authorization'] = 'Bearer ${state.token}';
  }
}

final companyProvider = NotifierProvider<CompanyNotifier, CompanyState>(
  CompanyNotifier.new,
);
