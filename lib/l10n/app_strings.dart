import 'package:flutter/material.dart';

/// Every user-visible string in the app, in English and Czech.
///
/// The app follows the device locale. Anything other than Czech falls back to
/// English. Keeping the copy in one place (instead of scattered `Text` literals)
/// means a new language only needs one more set of getters here.
class AppStrings {
  const AppStrings(this.locale);

  final Locale locale;

  /// True when the device locale is Czech.
  bool get isCzech => locale.languageCode == 'cs';

  /// Looks up the strings registered by [AppStringsDelegate] on [MaterialApp].
  static AppStrings of(BuildContext context) =>
      Localizations.of<AppStrings>(context, AppStrings) ??
      const AppStrings(Locale('en'));

  // Main menu.
  String get games => isCzech ? 'Hry' : 'Games';
  String get continuePlaying => isCzech ? 'Pokračovat v hře' : 'Continue playing';
  String get resume => isCzech ? 'Pokračovat' : 'Resume';
  String get debugModeEnabled =>
      isCzech ? 'Ladící režim zapnut' : 'Debug mode enabled';

  // Game options.
  String get play => isCzech ? 'Hrát' : 'Play';
  String get records => isCzech ? 'Rekordy' : 'Records';
  String get testWin => isCzech ? 'Test výhry' : 'Test win';

  // In-game menu and top bar.
  String get restartDeal => isCzech ? 'Restartovat hru' : 'Restart Deal';
  String get newDeal => isCzech ? 'Nová hra' : 'New Deal';
  String get exitToMenu => isCzech ? 'Zpět do nabídky' : 'Exit to menu';
  String get soundOn => isCzech ? 'Zvuk: Zapnutý' : 'Sound: On';
  String get soundOff => isCzech ? 'Zvuk: Vypnutý' : 'Sound: Off';
  String get back => isCzech ? 'Zpět' : 'Back';
  String get menu => isCzech ? 'Nabídka' : 'Menu';
  String get solve => isCzech ? 'Vyřešit' : 'Solve';
  String get undo => isCzech ? 'Vrátit tah' : 'Undo';
  String get redo => isCzech ? 'Opakovat tah' : 'Redo';

  // Win and records.
  String get youWin => isCzech ? 'Vyhráli jste!' : 'You Win!';
  String get youWonIn => isCzech ? 'Vyhráli jste za' : 'You won in';
  String get totalWins => isCzech ? 'Celkem výher' : 'Total wins';
  String get bestWin => isCzech ? 'Nejlepší výhra' : 'Best win';
  String get emptyLeaderboard => isCzech
      ? 'Vyhrajte hru a založte si žebříček.'
      : 'Win a game to start your leaderboard.';
  String get newBadge => isCzech ? 'NOVÉ' : 'NEW';
  String rankBest(int rank) =>
      isCzech ? '#$rank NEJLEPŠÍ' : '#$rank BEST';
  String bestWinMoves(int count) =>
      '${moves(count)} · ${isCzech ? 'nejlepší' : 'best'}';

  // Variant names and descriptions.
  // Proper names stay the same in Czech.
  String get klondike => 'Klondike';
  String get freecell => 'FreeCell';
  String get klondikeDraw1 => isCzech ? 'Klondike (1 karta)' : 'Klondike (Draw 1)';
  String get klondikeDraw3 => isCzech ? 'Klondike (3 karty)' : 'Klondike (Draw 3)';
  String get freecellTwoCells =>
      isCzech ? 'FreeCell (2 sloty)' : 'FreeCell (2 cells)';
  String get freecellSixCells =>
      isCzech ? 'FreeCell (6 slotů)' : 'FreeCell (6 cells)';
  String get drawOne => isCzech ? '1 karta' : 'Draw 1';
  String get drawThree => isCzech ? '3 karty' : 'Draw 3';
  String get classicFourCells =>
      isCzech ? 'Klasické · 4 sloty' : 'Classic · 4 cells';
  String get twoCellsHard => isCzech ? '2 sloty · těžké' : '2 cells · hard';
  String get sixCellsRelaxed =>
      isCzech ? '6 slotů · snadné' : '6 cells · relaxed';
  String get turnOneCard =>
      isCzech ? 'Otočit jednu kartu najednou' : 'Turn one card at a time';
  String get turnThreeCards =>
      isCzech ? 'Otočit tři karty najednou' : 'Turn three at a time';
  String get standardFreecell =>
      isCzech ? 'Klasický FreeCell' : 'Standard FreeCell';
  String get fewerCellsTighter =>
      isCzech ? 'Méně slotů, těžší hra' : 'Fewer cells, tighter play';
  String get extraRoomEasier =>
      isCzech ? 'Více místa, snadněji' : 'Extra room, easier';
  String get today => isCzech ? 'Dnes' : 'Today';

  /// Month abbreviations for leaderboard dates.
  List<String> get monthAbbreviations => isCzech
      ? const <String>[
          'Led',
          'Úno',
          'Bře',
          'Dub',
          'Kvě',
          'Čvn',
          'Čvc',
          'Srp',
          'Zář',
          'Říj',
          'Lis',
          'Pro',
        ]
      : const <String>[
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];

  /// `Today` for the current calendar day, otherwise a short localized date.
  String formatWinDate(DateTime timestamp) {
    final DateTime now = DateTime.now();
    final bool isToday =
        timestamp.year == now.year &&
        timestamp.month == now.month &&
        timestamp.day == now.day;
    if (isToday) {
      return today;
    }
    final String month = monthAbbreviations[timestamp.month - 1];
    return isCzech ? '${timestamp.day}. $month' : '$month ${timestamp.day}';
  }

  /// Localized move count, including Czech plural rules (1 tah / 2 tahy / 5 tahů).
  String moves(int count) {
    if (!isCzech) {
      return count == 1 ? '1 move' : '$count moves';
    }
    final int lastTwo = count % 100;
    final int last = count % 10;
    // 1, 21, 31... but not 11 → "tah".
    if (last == 1 && lastTwo != 11) {
      return '$count tah';
    }
    // 2-4, 22-24... but not 12-14 → "tahy".
    if (last >= 2 && last <= 4 && (lastTwo < 12 || lastTwo > 14)) {
      return '$count tahy';
    }
    return '$count tahů';
  }
}

/// Short alias used at call sites: `S(context).games`.
AppStrings S(BuildContext context) => AppStrings.of(context);

/// Registers [AppStrings] with Flutter's [Localizations] widget.
class AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const AppStringsDelegate();

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode == 'en' || locale.languageCode == 'cs';

  @override
  Future<AppStrings> load(Locale locale) async => AppStrings(locale);

  @override
  bool shouldReload(AppStringsDelegate old) => false;
}
