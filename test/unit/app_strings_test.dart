import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_patience/l10n/app_strings.dart';
import 'package:open_patience/ui/theme/game_palette.dart';
import 'package:open_patience/ui/variant_labels.dart';

void main() {
  const AppStrings cs = AppStrings(Locale('cs'));
  const AppStrings en = AppStrings(Locale('en'));

  group('AppStrings', () {
    test('Czech UI copy', () {
      expect(cs.games, 'Hry');
      expect(cs.continuePlaying, 'Pokračovat v hře');
      expect(cs.resume, 'Pokračovat');
      expect(cs.play, 'Hrát');
      expect(cs.records, 'Rekordy');
      expect(cs.restartDeal, 'Restartovat hru');
      expect(cs.newDeal, 'Nová hra');
      expect(cs.exitToMenu, 'Zpět do nabídky');
      expect(cs.soundOn, 'Zvuk: Zapnutý');
      expect(cs.soundOff, 'Zvuk: Vypnutý');
      expect(cs.youWin, 'Vyhráli jste!');
      expect(cs.totalWins, 'Celkem výher');
      expect(cs.emptyLeaderboard, 'Vyhrajte hru a založte si žebříček.');
      expect(cs.rankBest(2), '#2 NEJLEPŠÍ');
      expect(cs.bestWinMoves(7), '7 tahů · nejlepší');
    });

    test('unsupported locales fall back to English', () {
      expect(const AppStrings(Locale('de')).games, 'Games');
      expect(en.games, 'Games');
      expect(en.youWin, 'You Win!');
      expect(en.rankBest(1), '#1 BEST');
    });

    test('Czech move plurals', () {
      expect(cs.moves(0), '0 tahů');
      expect(cs.moves(1), '1 tah');
      expect(cs.moves(2), '2 tahy');
      expect(cs.moves(4), '4 tahy');
      expect(cs.moves(5), '5 tahů');
      expect(cs.moves(11), '11 tahů');
      expect(cs.moves(12), '12 tahů');
      expect(cs.moves(21), '21 tah');
      expect(cs.moves(22), '22 tahy');
      expect(en.moves(1), '1 move');
      expect(en.moves(2), '2 moves');
    });

    test('formatMoves uses the supplied locale', () {
      expect(formatMoves(3), '3 moves');
      expect(formatMoves(3, cs), '3 tahy');
    });

    test('variant labels and descriptors are localized', () {
      expect(variantTitle('klondike-draw1', cs), 'Klondike (1 karta)');
      expect(variantTitle('freecell-cells6', cs), 'FreeCell (6 slotů)');
      expect(variantShortLabel('klondike-draw3', cs), '3 karty');
      expect(variantDescriptor('freecell', cs), 'Klasický FreeCell');
      expect(gameTitle('klondike', cs), 'Klondike');
    });

    test('leaderboard dates use Czech month names', () {
      final DateTime oldDate = DateTime(2020, 8, 20);
      expect(cs.formatWinDate(oldDate), '20. Srp');
      expect(en.formatWinDate(oldDate), 'Aug 20');
      // A win from today is relative in both languages.
      final DateTime now = DateTime.now();
      expect(cs.formatWinDate(now), 'Dnes');
      expect(en.formatWinDate(now), 'Today');
    });
  });

  testWidgets('AppStringsDelegate resolves the device locale', (
    WidgetTester tester,
  ) async {
    Future<void> pumpWith(Locale locale) => tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppStringsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[Locale('en'), Locale('cs')],
        locale: locale,
        home: Builder(
          builder: (BuildContext context) => Text(S(context).games),
        ),
      ),
    );

    await pumpWith(const Locale('cs'));
    await tester.pumpAndSettle();
    expect(find.text('Hry'), findsOneWidget);

    await pumpWith(const Locale('en'));
    await tester.pumpAndSettle();
    expect(find.text('Games'), findsOneWidget);
  });
}
