import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_state.dart';
import '../core/constants.dart';
import '../core/test_keys.dart';
import '../router/route_paths.dart';
import '../services/hub_launcher.dart';
import '../widgets/bottom_pill_tabs.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';
import '../widgets/launch_feedback.dart';

final _emailOk = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

class S10ContactPage extends StatefulWidget {
  const S10ContactPage({super.key});

  @override
  State<S10ContactPage> createState() => _S10ContactPageState();
}

class _S10ContactPageState extends State<S10ContactPage> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _message;
  bool _attemptedSubmit = false;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    final p = AppScope.prefs;
    _name = TextEditingController(text: p.contactName ?? '');
    _email = TextEditingController(text: p.contactEmail ?? '');
    _message = TextEditingController(text: p.contactMessage ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _attemptedSubmit = true);
    if (!(_form.currentState?.validate() ?? false)) return;

    setState(() => _submitting = true);
    try {
      final ok = await AppScope.prefs.saveContactDraft(
        name: _name.text.trim(),
        email: _email.text.trim(),
        message: _message.text.trim(),
      );
      if (!mounted) return;
      if (!ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save your message on this device.')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message saved on this device only — not sent to our servers.'),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save your message on this device.')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    return Scaffold(
      key: Tk.screenS10,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HubStatusBar(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Contact Us', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            ),
          ),
          Expanded(
            child: Form(
              key: _form,
              autovalidateMode: _attemptedSubmit ? AutovalidateMode.always : AutovalidateMode.disabled,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _quick(
                          key: Tk.s10QuickCall,
                          icon: Icons.call,
                          label: 'Call',
                          onLaunch: HubLauncher.dialPhone,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _quick(
                          key: Tk.s10QuickEmail,
                          icon: Icons.mail,
                          label: 'Email',
                          onLaunch: HubLauncher.sendEmail,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _quick(
                          key: Tk.s10QuickWeb,
                          icon: Icons.language,
                          label: 'Website',
                          onLaunch: () => HubLauncher.openHttp(kWebsiteUrl),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: HubColors.charcoal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _detailRow(
                          Icons.phone,
                          kPhoneDisplay,
                          Tk.s10DetailPhone,
                          onLaunch: HubLauncher.dialPhone,
                        ),
                        const Divider(color: Colors.white24),
                        _detailRow(
                          Icons.email,
                          kEmail,
                          Tk.s10DetailEmail,
                          onLaunch: HubLauncher.sendEmail,
                        ),
                        const Divider(color: Colors.white24),
                        _detailRow(
                          Icons.language,
                          kWebsiteHostDisplay,
                          Tk.s10DetailWebsite,
                          onLaunch: () => HubLauncher.openHttp(kWebsiteUrl),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Send a Message', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: Tk.s10FieldName,
                    controller: _name,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Your full name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final t = v?.trim() ?? '';
                      if (t.isEmpty) return 'Required';
                      if (t.length > 120) return 'Max 120 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: Tk.s10FieldEmail,
                    controller: _email,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'your@email.com',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      final t = v?.trim() ?? '';
                      if (t.isEmpty) return 'Required';
                      if (!_emailOk.hasMatch(t)) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: Tk.s10FieldMessage,
                    controller: _message,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      hintText: 'Describe your project or enquiry...',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final t = v?.trim() ?? '';
                      if (t.isEmpty) return 'Required';
                      if (t.length > 4000) return 'Max 4000 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      key: Tk.s10Send,
                      onPressed: _submitting ? null : _submit,
                      child: _submitting
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Send Message'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomPillTabs(currentIndex: BottomPillTabs.indexForPath(loc)),
    );
  }

  Widget _quick({
    required Key key,
    required IconData icon,
    required String label,
    required Future<bool> Function() onLaunch,
  }) {
    return Material(
      color: HubColors.pageBg,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        key: key,
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.runExternal(onLaunch),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: HubColors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 22, color: HubColors.charcoal),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String text, Key key, {required Future<bool> Function() onLaunch}) {
    return ListTile(
      key: key,
      leading: Icon(icon, color: Colors.white70),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: () => context.runExternal(onLaunch),
    );
  }
}
