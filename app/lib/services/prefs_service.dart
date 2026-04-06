import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Honest local persistence only (no backend).
class PrefsService {
  PrefsService._(this._p);
  final SharedPreferences _p;

  static const _kNotif = 'pref_notifications';
  static const _kEmailUp = 'pref_email_updates';
  static const _kQuote = 'pref_quote_draft';
  static const _kContactName = 'pref_contact_name';
  static const _kContactEmail = 'pref_contact_email';
  static const _kContactMsg = 'pref_contact_message';

  static Future<PrefsService> create() async {
    final p = await SharedPreferences.getInstance();
    return PrefsService._(p);
  }

  bool get notifications => _p.getBool(_kNotif) ?? true;

  Future<bool> setNotifications(bool v) => _p.setBool(_kNotif, v);

  bool get emailUpdates => _p.getBool(_kEmailUp) ?? false;

  Future<bool> setEmailUpdates(bool v) => _p.setBool(_kEmailUp, v);

  Map<String, dynamic>? get quoteDraft {
    final s = _p.getString(_kQuote);
    if (s == null) return null;
    return jsonDecode(s) as Map<String, dynamic>;
  }

  Future<bool> saveQuoteDraft(Map<String, dynamic> m) =>
      _p.setString(_kQuote, jsonEncode(m));

  String? get contactName => _p.getString(_kContactName);
  String? get contactEmail => _p.getString(_kContactEmail);
  String? get contactMessage => _p.getString(_kContactMsg);

  Future<bool> saveContactDraft({String? name, String? email, String? message}) async {
    var ok = true;
    if (name != null) ok = (await _p.setString(_kContactName, name)) && ok;
    if (email != null) ok = (await _p.setString(_kContactEmail, email)) && ok;
    if (message != null) ok = (await _p.setString(_kContactMsg, message)) && ok;
    return ok;
  }

  Future<bool> clearSession() async {
    var ok = true;
    ok = (await _p.remove(_kQuote)) && ok;
    ok = (await _p.remove(_kContactName)) && ok;
    ok = (await _p.remove(_kContactEmail)) && ok;
    ok = (await _p.remove(_kContactMsg)) && ok;
    ok = (await _p.remove(_kNotif)) && ok;
    ok = (await _p.remove(_kEmailUp)) && ok;
    return ok;
  }
}
