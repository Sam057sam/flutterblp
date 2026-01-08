import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/glass_surface.dart';
import '../../shared/widgets/page_header.dart';
import 'company_state.dart';

class CompanyPage extends ConsumerStatefulWidget {
  const CompanyPage({super.key});

  @override
  ConsumerState<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends ConsumerState<CompanyPage> {
  final _formKey = GlobalKey<FormState>();
  Timer? _autoSaveTimer;
  String _saveStatus = 'All changes saved';
  String? _activeCompanyId;

  final Map<String, TextEditingController> _controllers = {};
  late final TextEditingController _baseUrlController;
  late final TextEditingController _tokenController;

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _baseUrlController.dispose();
    _tokenController.dispose();
    _autoSaveTimer?.cancel();
    super.dispose();
  }

  void _syncControllers(CompanyProfile company, CompanyState state) {
    if (_activeCompanyId == company.id) return;
    _activeCompanyId = company.id;

    _baseUrlController = TextEditingController(text: state.baseUrl);
    _tokenController = TextEditingController(text: state.token);

    void setField(String key, String value) {
      _controllers[key]?.dispose();
      _controllers[key] = TextEditingController(text: value);
    }

    setField('entityCode', company.entityCode);
    setField('displayName', company.displayName);
    setField('legalName', company.legalName);
    setField('reportingCurrency', company.reportingCurrency);
    setField('primaryEmail', company.primaryEmail);
    setField('contactPhone', company.contactPhone);
    setField('streetAddress', company.streetAddress);
    setField('city', company.city);
    setField('state', company.state);
    setField('postalCode', company.postalCode);
    setField('tagline', company.tagline);
    setField('gstVatNumber', company.gstVatNumber);
    setField('taxRegistration', company.taxRegistration);
    setField('panTaxId', company.panTaxId);
    setField('cinCompanyId', company.cinCompanyId);
    setField('msmeUdyam', company.msmeUdyam);
    setField('complianceNotes', company.complianceNotes);
    setField('industry', company.industry);
    setField('financialYearStart', company.financialYearStart);
    setField('financialYearEnd', company.financialYearEnd);
    setField('documentPrefix', company.documentPrefix);
    setField('website', company.website);
    setField('supportEmail', company.supportEmail);
    setField('accountName', company.accountName);
    setField('accountNumber', company.accountNumber);
    setField('bank', company.bank);
    setField('branch', company.branch);
    setField('ifscCode', company.ifscCode);
    setField('termsAndConditions', company.termsAndConditions);
  }

  void _scheduleAutosave() {
    setState(() => _saveStatus = 'Saving...');
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer(const Duration(milliseconds: 900), () {
      if (mounted) {
        setState(() => _saveStatus = 'All changes saved');
      }
    });
  }

  void _updateCompany(CompanyProfile updated) {
    ref.read(companyProvider.notifier).updateActive(updated);
    _scheduleAutosave();
  }

  void _openNewCompanyDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => const _NewCompanyDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(companyProvider);
    final company = state.activeCompany;
    _syncControllers(company, state);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(
              title: 'Company Profile',
              breadcrumbs: 'Operations / Company',
              trailing: Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: _openNewCompanyDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('New Company'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await ref.read(companyProvider.notifier).saveActive();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Company saved.')),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save Changes'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GlassSurface(
              borderRadius: 18,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.business, color: Color(0xFF2563EB)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: state.activeCompanyId,
                          decoration: const InputDecoration(labelText: 'Active company'),
                          items: [
                            for (final item in state.companies)
                              DropdownMenuItem(
                                value: item.id,
                                child: Text(item.displayName),
                              ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              ref.read(companyProvider.notifier).selectCompany(value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      _SaveStatusChip(status: _saveStatus),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _baseUrlController,
                          decoration: const InputDecoration(labelText: 'API Base URL'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _tokenController,
                          decoration: const InputDecoration(labelText: 'API Token'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: state.isSyncing
                            ? null
                            : () async {
                                ref.read(companyProvider.notifier).updateConnection(
                                      baseUrl: _baseUrlController.text.trim(),
                                      token: _tokenController.text.trim(),
                                    );
                                await ref.read(companyProvider.notifier).loadFromApi();
                              },
                        icon: const Icon(Icons.sync),
                        label: const Text('Sync from API'),
                      ),
                    ],
                  ),
                  if (state.lastError != null) ...[
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.lastError!,
                        style: const TextStyle(color: Color(0xFFEF4444)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
            _Section(
              title: 'Identity',
              subtitle: 'Branding & legal profile',
              child: _TwoColumn(
                children: [
                  _field(
                    controller: _controllers['entityCode']!,
                    label: 'Entity code',
                    onChanged: (value) => _updateCompany(company.copyWith(entityCode: value)),
                  ),
                  _field(
                    controller: _controllers['displayName']!,
                    label: 'Display name',
                    validator: _required,
                    onChanged: (value) => _updateCompany(company.copyWith(displayName: value)),
                  ),
                  _field(
                    controller: _controllers['legalName']!,
                    label: 'Legal name',
                    validator: _required,
                    onChanged: (value) => _updateCompany(company.copyWith(legalName: value)),
                  ),
                  _field(
                    controller: _controllers['reportingCurrency']!,
                    label: 'Reporting currency',
                    validator: _required,
                    onChanged: (value) => _updateCompany(company.copyWith(reportingCurrency: value)),
                  ),
                  _field(
                    controller: _controllers['primaryEmail']!,
                    label: 'Primary email',
                    validator: _email,
                    onChanged: (value) => _updateCompany(company.copyWith(primaryEmail: value)),
                  ),
                  _field(
                    controller: _controllers['contactPhone']!,
                    label: 'Contact phone',
                    onChanged: (value) => _updateCompany(company.copyWith(contactPhone: value)),
                  ),
                  _field(
                    controller: _controllers['streetAddress']!,
                    label: 'Street address',
                    onChanged: (value) => _updateCompany(company.copyWith(streetAddress: value)),
                  ),
                  _field(
                    controller: _controllers['city']!,
                    label: 'City',
                    onChanged: (value) => _updateCompany(company.copyWith(city: value)),
                  ),
                  _field(
                    controller: _controllers['state']!,
                    label: 'State / Region',
                    onChanged: (value) => _updateCompany(company.copyWith(state: value)),
                  ),
                  _field(
                    controller: _controllers['postalCode']!,
                    label: 'Postal code',
                    onChanged: (value) => _updateCompany(company.copyWith(postalCode: value)),
                  ),
                  DropdownButtonFormField<String>(
                    value: company.country,
                    decoration: const InputDecoration(labelText: 'Country'),
                    items: const [
                      DropdownMenuItem(value: 'United Arab Emirates', child: Text('United Arab Emirates')),
                      DropdownMenuItem(value: 'India', child: Text('India')),
                      DropdownMenuItem(value: 'Saudi Arabia', child: Text('Saudi Arabia')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        _updateCompany(company.copyWith(country: value));
                      }
                    },
                  ),
                  _field(
                    controller: _controllers['tagline']!,
                    label: 'Tagline',
                    onChanged: (value) => _updateCompany(company.copyWith(tagline: value)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _Section(
              title: 'Branding',
              subtitle: 'Visual identity',
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _UploadCard(
                    title: 'Logo',
                    helper: 'SVG / PNG 512x512',
                    fileName: company.logoFile,
                    type: 'logo',
                    onUploadComplete: (value) => _updateCompany(company.copyWith(logoFile: value)),
                  ),
                  _UploadCard(
                    title: 'Favicon',
                    helper: 'PNG 64x64',
                    fileName: company.faviconFile,
                    type: 'favicon',
                    onUploadComplete: (value) => _updateCompany(company.copyWith(faviconFile: value)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _Section(
              title: 'Compliance',
              subtitle: 'Registrations & filings',
              child: _TwoColumn(
                children: [
                  _field(
                    controller: _controllers['gstVatNumber']!,
                    label: 'GST / VAT number',
                    onChanged: (value) => _updateCompany(company.copyWith(gstVatNumber: value)),
                  ),
                  _field(
                    controller: _controllers['taxRegistration']!,
                    label: 'Tax registration',
                    onChanged: (value) => _updateCompany(company.copyWith(taxRegistration: value)),
                  ),
                  _field(
                    controller: _controllers['panTaxId']!,
                    label: 'PAN / Tax ID',
                    onChanged: (value) => _updateCompany(company.copyWith(panTaxId: value)),
                  ),
                  _field(
                    controller: _controllers['cinCompanyId']!,
                    label: 'CIN / Company ID',
                    onChanged: (value) => _updateCompany(company.copyWith(cinCompanyId: value)),
                  ),
                  _field(
                    controller: _controllers['msmeUdyam']!,
                    label: 'MSME / Udyam',
                    onChanged: (value) => _updateCompany(company.copyWith(msmeUdyam: value)),
                  ),
                  TextFormField(
                    controller: _controllers['complianceNotes'],
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Compliance notes'),
                    onChanged: (value) => _updateCompany(company.copyWith(complianceNotes: value)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _Section(
              title: 'Workspace defaults',
              subtitle: 'Account metadata',
              child: _TwoColumn(
                children: [
                  DropdownButtonFormField<String>(
                    value: company.timezone,
                    decoration: const InputDecoration(labelText: 'Timezone'),
                    items: const [
                      DropdownMenuItem(value: 'Asia/Dubai', child: Text('Asia/Dubai')),
                      DropdownMenuItem(value: 'Asia/Kolkata', child: Text('Asia/Kolkata')),
                      DropdownMenuItem(value: 'UTC', child: Text('UTC')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        _updateCompany(company.copyWith(timezone: value));
                      }
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: company.locale,
                    decoration: const InputDecoration(labelText: 'Locale'),
                    items: const [
                      DropdownMenuItem(value: 'en-AE', child: Text('en-AE')),
                      DropdownMenuItem(value: 'en-IN', child: Text('en-IN')),
                      DropdownMenuItem(value: 'en-US', child: Text('en-US')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        _updateCompany(company.copyWith(locale: value));
                      }
                    },
                  ),
                  _field(
                    controller: _controllers['industry']!,
                    label: 'Industry',
                    onChanged: (value) => _updateCompany(company.copyWith(industry: value)),
                  ),
                  _field(
                    controller: _controllers['financialYearStart']!,
                    label: 'Financial year start',
                    onChanged: (value) => _updateCompany(company.copyWith(financialYearStart: value)),
                  ),
                  _field(
                    controller: _controllers['financialYearEnd']!,
                    label: 'Financial year end',
                    onChanged: (value) => _updateCompany(company.copyWith(financialYearEnd: value)),
                  ),
                  _field(
                    controller: _controllers['documentPrefix']!,
                    label: 'Document prefix',
                    onChanged: (value) => _updateCompany(company.copyWith(documentPrefix: value)),
                  ),
                  _field(
                    controller: _controllers['website']!,
                    label: 'Website',
                    onChanged: (value) => _updateCompany(company.copyWith(website: value)),
                  ),
                  _field(
                    controller: _controllers['supportEmail']!,
                    label: 'Support email',
                    validator: _emailOptional,
                    onChanged: (value) => _updateCompany(company.copyWith(supportEmail: value)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _Section(
              title: 'Finance',
              subtitle: 'Bank details & terms',
              child: _TwoColumn(
                children: [
                  _field(
                    controller: _controllers['accountName']!,
                    label: 'Account name',
                    onChanged: (value) => _updateCompany(company.copyWith(accountName: value)),
                  ),
                  _field(
                    controller: _controllers['accountNumber']!,
                    label: 'Account number',
                    onChanged: (value) => _updateCompany(company.copyWith(accountNumber: value)),
                  ),
                  _field(
                    controller: _controllers['bank']!,
                    label: 'Bank',
                    onChanged: (value) => _updateCompany(company.copyWith(bank: value)),
                  ),
                  _field(
                    controller: _controllers['branch']!,
                    label: 'Branch',
                    onChanged: (value) => _updateCompany(company.copyWith(branch: value)),
                  ),
                  _field(
                    controller: _controllers['ifscCode']!,
                    label: 'IFSC code',
                    onChanged: (value) => _updateCompany(company.copyWith(ifscCode: value)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _Section(
              title: 'Documents',
              subtitle: 'Watermark, signature & terms',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _UploadCard(
                        title: 'Document watermark',
                        helper: 'PNG / PDF 1024px wide',
                        fileName: company.documentWatermarkFile,
                        type: 'document_watermark',
                        onUploadComplete: (value) =>
                            _updateCompany(company.copyWith(documentWatermarkFile: value)),
                      ),
                      _UploadCard(
                        title: 'Authorised signatory signature',
                        helper: 'PNG transparent',
                        fileName: company.authorisedSignatureFile,
                        type: 'authorised_signature',
                        onUploadComplete: (value) =>
                            _updateCompany(company.copyWith(authorisedSignatureFile: value)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _controllers['termsAndConditions'],
                    maxLines: 6,
                    decoration: const InputDecoration(labelText: 'Terms & conditions'),
                    onChanged: (value) => _updateCompany(company.copyWith(termsAndConditions: value)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            GlassCard(
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Remember to keep your legal profile and tax IDs up to date for compliance audits.',
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Mark profile as reviewed'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

String? _required(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Required';
  }
  return null;
}

String? _email(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Required';
  }
  final isValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim());
  return isValid ? null : 'Invalid email';
}

String? _emailOptional(String? value) {
  if (value == null || value.trim().isEmpty) return null;
  final isValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim());
  return isValid ? null : 'Invalid email';
}

TextFormField _field({
  required TextEditingController controller,
  required String label,
  FormFieldValidator<String>? validator,
  ValueChanged<String>? onChanged,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: label),
    validator: validator,
    onChanged: onChanged,
  );
}

class _SaveStatusChip extends StatelessWidget {
  const _SaveStatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final isSaving = status.toLowerCase().contains('saving');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSaving
            ? const Color(0xFFF59E0B).withOpacity(0.15)
            : const Color(0xFF10B981).withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            isSaving ? Icons.sync : Icons.check_circle,
            size: 16,
            color: isSaving ? const Color(0xFFF59E0B) : const Color(0xFF10B981),
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: isSaving ? const Color(0xFFF59E0B) : const Color(0xFF10B981),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.subtitle, required this.child});

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _TwoColumn extends StatelessWidget {
  const _TwoColumn({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 780;
        if (isNarrow) {
          return Column(
            children: [
              for (final child in children) ...[
                child,
                const SizedBox(height: 12),
              ],
            ],
          );
        }
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final child in children)
              SizedBox(width: (constraints.maxWidth - 16) / 2, child: child),
          ],
        );
      },
    );
  }
}

class _UploadCard extends ConsumerWidget {
  const _UploadCard({
    required this.title,
    required this.helper,
    required this.fileName,
    required this.type,
    required this.onUploadComplete,
  });

  final String title;
  final String helper;
  final String fileName;
  final String type;
  final ValueChanged<String> onUploadComplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasFile = fileName.trim().isNotEmpty;
    return GlassSurface(
      borderRadius: 18,
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(helper, style: const TextStyle(color: Color(0xFF64748B))),
            const SizedBox(height: 10),
            if (hasFile)
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      fileName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              )
            else
              const Text('No file selected', style: TextStyle(color: Color(0xFF94A3B8))),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles();
                if (result == null || result.files.isEmpty) return;
                final file = result.files.single;
                if (file.path == null) return;
                final url = await ref
                    .read(companyProvider.notifier)
                    .uploadFile(type: type, filePath: file.path!);
                if (url != null) {
                  onUploadComplete(file.name);
                }
              },
              icon: const Icon(Icons.upload_file),
              label: Text(hasFile ? 'Replace file' : 'Upload'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewCompanyDialog extends ConsumerStatefulWidget {
  const _NewCompanyDialog();

  @override
  ConsumerState<_NewCompanyDialog> createState() => _NewCompanyDialogState();
}

class _NewCompanyDialogState extends ConsumerState<_NewCompanyDialog> {
  final _formKey = GlobalKey<FormState>();
  final _displayController = TextEditingController();
  final _legalController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _displayController.dispose();
    _legalController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(companyProvider);

    return AlertDialog(
      title: const Text('Add new company'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _displayController,
              decoration: const InputDecoration(labelText: 'Display name'),
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _legalController,
              decoration: const InputDecoration(labelText: 'Legal name'),
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Primary email'),
              validator: _email,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              final profile = CompanyProfile(
                id: UniqueKey().toString(),
                displayName: _displayController.text.trim(),
                legalName: _legalController.text.trim(),
                primaryEmail: _emailController.text.trim(),
                reportingCurrency: 'AED',
              );

              if (state.token.isNotEmpty) {
                await ref.read(companyProvider.notifier).createCompany(profile);
              } else {
                ref.read(companyProvider.notifier).addCompany(
                      displayName: profile.displayName,
                      legalName: profile.legalName,
                      primaryEmail: profile.primaryEmail,
                    );
              }

              if (mounted) Navigator.of(context).pop();
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
