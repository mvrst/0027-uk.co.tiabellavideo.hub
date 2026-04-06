import 'package:flutter/foundation.dart';

/// Stable ValueKeys from docs/action_map.yaml & docs/test_matrix.yaml
abstract final class Tk {
  static const screenS01 = ValueKey<String>('TK_SCREEN_S01');
  static const screenS02 = ValueKey<String>('TK_SCREEN_S02');
  static const screenS03 = ValueKey<String>('TK_SCREEN_S03');
  static const screenS04 = ValueKey<String>('TK_SCREEN_S04');
  static const screenS05 = ValueKey<String>('TK_SCREEN_S05');
  static const screenS05b = ValueKey<String>('TK_SCREEN_S05B');
  static const screenS05c = ValueKey<String>('TK_SCREEN_S05C');
  static const screenS05d = ValueKey<String>('TK_SCREEN_S05D');
  static const screenS06 = ValueKey<String>('TK_SCREEN_S06');
  static const screenS07 = ValueKey<String>('TK_SCREEN_S07');
  static const screenS08 = ValueKey<String>('TK_SCREEN_S08');
  static const screenS09 = ValueKey<String>('TK_SCREEN_S09');
  static const screenS10 = ValueKey<String>('TK_SCREEN_S10');
  static const screenS11 = ValueKey<String>('TK_SCREEN_S11');
  static const screenS12 = ValueKey<String>('TK_SCREEN_S12');
  static const screenS13 = ValueKey<String>('TK_SCREEN_S13');
  static const screenS14 = ValueKey<String>('TK_SCREEN_S14');

  static const s01Continue = ValueKey<String>('TK_S01_CONTINUE');
  static const s01FooterWebsite = ValueKey<String>('TK_S01_FOOTER_WEBSITE');
  static const s02Skip = ValueKey<String>('TK_S02_SKIP');
  static const s02Next = ValueKey<String>('TK_S02_NEXT');
  static const s03Back = ValueKey<String>('TK_S03_BACK');
  static const s03GetStarted = ValueKey<String>('TK_S03_GET_STARTED');

  static const s04QuickServices = ValueKey<String>('TK_S04_QUICK_SERVICES');
  static const s04QuickPortfolio = ValueKey<String>('TK_S04_QUICK_PORTFOLIO');
  static const s04QuickQuote = ValueKey<String>('TK_S04_QUICK_QUOTE');
  static const s04QuickWorkflow = ValueKey<String>('TK_S04_QUICK_WORKFLOW');
  static const s04QuickStatus = ValueKey<String>('TK_S04_QUICK_STATUS');
  static const s04QuickContact = ValueKey<String>('TK_S04_QUICK_CONTACT');
  static const s04CardVideo = ValueKey<String>('TK_S04_CARD_VIDEO');
  static const s04CardPost = ValueKey<String>('TK_S04_CARD_POST');

  static const tabHome = ValueKey<String>('TK_TAB_HOME');
  static const tabPortfolio = ValueKey<String>('TK_TAB_PORTFOLIO');
  static const tabQuote = ValueKey<String>('TK_TAB_QUOTE');
  static const tabStatus = ValueKey<String>('TK_TAB_STATUS');
  static const tabMore = ValueKey<String>('TK_TAB_MORE');

  static const s05Filter = ValueKey<String>('TK_S05_FILTER_ICON');
  static const s05ChipAll = ValueKey<String>('TK_S05_CHIP_ALL');
  static const s05ChipProduction = ValueKey<String>('TK_S05_CHIP_PRODUCTION');
  static const s05ChipPost = ValueKey<String>('TK_S05_CHIP_POST');
  static const s05ChipCorporate = ValueKey<String>('TK_S05_CHIP_CORPORATE');

  static const s05bBack = ValueKey<String>('TK_S05B_BACK');
  static const s05bFilter = ValueKey<String>('TK_S05B_FILTER');
  static const s05cBack = ValueKey<String>('TK_S05C_BACK');
  static const s05cFilter = ValueKey<String>('TK_S05C_FILTER');
  static const s05dBack = ValueKey<String>('TK_S05D_BACK');
  static const s05dFilter = ValueKey<String>('TK_S05D_FILTER');

  static const s06Back = ValueKey<String>('TK_S06_BACK');
  static const s06Share = ValueKey<String>('TK_S06_SHARE');
  static const s06CarouselPrev = ValueKey<String>('TK_S06_CAROUSEL_PREV');
  static const s06CarouselNext = ValueKey<String>('TK_S06_CAROUSEL_NEXT');
  static const s06RequestQuote = ValueKey<String>('TK_S06_REQUEST_QUOTE');

  static const s07Close = ValueKey<String>('TK_S07_CLOSE');
  static const s07TypeVideo = ValueKey<String>('TK_S07_TYPE_VIDEO');
  static const s07TypePost = ValueKey<String>('TK_S07_TYPE_POST');
  static const s07TypePhoto = ValueKey<String>('TK_S07_TYPE_PHOTO');
  static const s07Dur1 = ValueKey<String>('TK_S07_DUR_1');
  static const s07Dur23 = ValueKey<String>('TK_S07_DUR_23');
  static const s07DurWk = ValueKey<String>('TK_S07_DUR_WK');
  static const s07AddonColour = ValueKey<String>('TK_S07_ADDON_COLOUR');
  static const s07AddonMotion = ValueKey<String>('TK_S07_ADDON_MOTION');
  static const s07AddonVoice = ValueKey<String>('TK_S07_ADDON_VOICE');
  static const s07Submit = ValueKey<String>('TK_S07_SUBMIT');

  static const s08Back = ValueKey<String>('TK_S08_BACK');
  static const s08GetQuote = ValueKey<String>('TK_S08_GET_QUOTE');

  static const s10QuickCall = ValueKey<String>('TK_S10_QUICK_CALL');
  static const s10QuickEmail = ValueKey<String>('TK_S10_QUICK_EMAIL');
  static const s10QuickWeb = ValueKey<String>('TK_S10_QUICK_WEBSITE');
  static const s10DetailPhone = ValueKey<String>('TK_S10_DETAIL_PHONE');
  static const s10DetailEmail = ValueKey<String>('TK_S10_DETAIL_EMAIL');
  static const s10DetailWebsite = ValueKey<String>('TK_S10_DETAIL_WEBSITE');
  static const s10FieldName = ValueKey<String>('TK_S10_FIELD_NAME');
  static const s10FieldEmail = ValueKey<String>('TK_S10_FIELD_EMAIL');
  static const s10FieldMessage = ValueKey<String>('TK_S10_FIELD_MESSAGE');
  static const s10Send = ValueKey<String>('TK_S10_SEND');

  static const s11Maps = ValueKey<String>('TK_S11_MAPS');
  static const s11Email = ValueKey<String>('TK_S11_EMAIL');
  static const s11Web = ValueKey<String>('TK_S11_WEBSITE');

  static const s12Refresh = ValueKey<String>('TK_S12_REFRESH');

  static const s13Notif = ValueKey<String>('TK_S13_NOTIF_TOGGLE');
  static const s13EmailUpdates = ValueKey<String>('TK_S13_EMAIL_UPDATES_TOGGLE');
  static const s13Privacy = ValueKey<String>('TK_S13_PRIVACY_POLICY');
  static const s13Legal = ValueKey<String>('TK_S13_LEGAL');
  /// Reachability for S11 — not in action_map.yaml; required for full nav graph.
  static const s13About = ValueKey<String>('TK_S13_ABOUT_US');
  static const s13SignOut = ValueKey<String>('TK_S13_SIGN_OUT');

  static const s14Back = ValueKey<String>('TK_S14_BACK');
}
