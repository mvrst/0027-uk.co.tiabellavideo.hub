import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_state.dart';
import '../core/test_keys.dart';
import '../models/quote_selection.dart';
import '../router/route_paths.dart';
import '../widgets/bottom_pill_tabs.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';

class S07QuoteToolPage extends StatefulWidget {
  const S07QuoteToolPage({
    super.key,
    required this.initialType,
    required this.initialDuration,
  });

  final ProjectTypeKind initialType;
  final DurationKind initialDuration;

  @override
  State<S07QuoteToolPage> createState() => _S07QuoteToolPageState();
}

class _S07QuoteToolPageState extends State<S07QuoteToolPage> {
  late ProjectTypeKind _type;
  late DurationKind _dur;
  bool _colour = true;
  bool _motion = false;
  bool _voice = false;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    final d = AppScope.prefs.quoteDraft;
    if (d != null) {
      _type = ProjectTypeKindX.fromQuery(d['project_type'] as String?);
      _dur = DurationKindX.fromQuery(d['duration'] as String?);
      _colour = d['addon_colour'] as bool? ?? true;
      _motion = d['addon_motion'] as bool? ?? false;
      _voice = d['addon_voice'] as bool? ?? false;
    } else {
      _type = widget.initialType;
      _dur = widget.initialDuration;
    }
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    try {
      final ok = await AppScope.prefs.saveQuoteDraft({
        'project_type': _type.apiName,
        'duration': _dur.apiName,
        'addon_colour': _colour,
        'addon_motion': _motion,
        'addon_voice': _voice,
      });
      if (!mounted) return;
      if (!ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save your quote request on this device.')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Quote request saved on this device only — not sent to our servers.'),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save your quote request on this device.')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    return Scaffold(
      key: Tk.screenS07,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HubStatusBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quote Request',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                IconButton(
                  key: Tk.s07Close,
                  icon: const Icon(Icons.close, color: HubColors.muted),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(RoutePaths.dashboard);
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const Text('Project Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _typeCard('Video Production', ProjectTypeKind.videoProduction, Tk.s07TypeVideo)),
                    const SizedBox(width: 8),
                    Expanded(child: _typeCard('Post Production', ProjectTypeKind.postProduction, Tk.s07TypePost)),
                    const SizedBox(width: 8),
                    Expanded(child: _typeCard('Photography', ProjectTypeKind.photography, Tk.s07TypePhoto)),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Project Duration', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _durCard('1 Day', DurationKind.oneDay, Tk.s07Dur1)),
                    const SizedBox(width: 8),
                    Expanded(child: _durCard('2–3 Days', DurationKind.twoToThreeDays, Tk.s07Dur23)),
                    const SizedBox(width: 8),
                    Expanded(child: _durCard('1 Week+', DurationKind.oneWeekPlus, Tk.s07DurWk)),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Add-On Services', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 10),
                _addon('Colour Grading', _colour, Tk.s07AddonColour, (v) => setState(() => _colour = v)),
                const SizedBox(height: 8),
                _addon('Motion Graphics', _motion, Tk.s07AddonMotion, (v) => setState(() => _motion = v)),
                const SizedBox(height: 8),
                _addon('Voiceover & Audio', _voice, Tk.s07AddonVoice, (v) => setState(() => _voice = v)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: HubColors.charcoal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'We typically respond within one business day. This is general information only; '
                    'no server submission occurs in this build.',
                    style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    key: Tk.s07Submit,
                    style: ElevatedButton.styleFrom(backgroundColor: HubColors.accentRed),
                    onPressed: _submitting ? null : _submit,
                    child: _submitting
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('Submit Quote Request'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomPillTabs(currentIndex: BottomPillTabs.indexForPath(loc)),
    );
  }

  Widget _typeCard(String label, ProjectTypeKind v, Key key) {
    final sel = _type == v;
    return Material(
      color: sel ? HubColors.charcoal : HubColors.pageBg,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        key: key,
        onTap: () => setState(() => _type = v),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: HubColors.border),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: sel ? Colors.white : HubColors.charcoal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _durCard(String label, DurationKind v, Key key) {
    final sel = _dur == v;
    return Material(
      color: sel ? HubColors.charcoal : HubColors.pageBg,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        key: key,
        onTap: () => setState(() => _dur = v),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: HubColors.border),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: sel ? Colors.white : HubColors.charcoal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _addon(String label, bool on, Key key, ValueChanged<bool> onChanged) {
    return Material(
      color: HubColors.pageBg,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        key: key,
        onTap: () => onChanged(!on),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: HubColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              Icon(on ? Icons.check_box : Icons.check_box_outline_blank, color: HubColors.charcoal),
            ],
          ),
        ),
      ),
    );
  }
}
