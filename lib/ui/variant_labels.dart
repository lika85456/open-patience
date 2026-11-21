import '../core/game_catalog.dart';
import '../core/game_registry.dart';
import '../l10n/app_strings.dart';

/// A human-readable full title for a variant id (headers, records, resume rows).
///
/// [strings] defaults to null so the pure-English call sites in tests keep
/// working; the UI passes `S(context)` to get the localized label.
String variantTitle(String id, [AppStrings? strings]) {
  switch (id) {
    case GameRegistry.klondikeDraw1:
      return strings?.klondikeDraw1 ?? 'Klondike (Draw 1)';
    case GameRegistry.klondikeDraw3:
      return strings?.klondikeDraw3 ?? 'Klondike (Draw 3)';
    case GameRegistry.freecell:
      return 'FreeCell';
    case GameRegistry.freecellCells2:
      return strings?.freecellTwoCells ?? 'FreeCell (2 cells)';
    case GameRegistry.freecellCells6:
      return strings?.freecellSixCells ?? 'FreeCell (6 cells)';
    default:
      return id;
  }
}

/// The display name of a game (title screen and options header).
String gameTitle(String gameId, [AppStrings? strings]) {
  switch (gameId) {
    case GameCatalog.klondike:
      return strings?.klondike ?? 'Klondike';
    case GameCatalog.freecell:
      return 'FreeCell';
    default:
      return gameId;
  }
}

/// A short label for a variant row on a game's options page.
String variantShortLabel(String id, [AppStrings? strings]) {
  switch (id) {
    case GameRegistry.klondikeDraw1:
      return strings?.drawOne ?? 'Draw 1';
    case GameRegistry.klondikeDraw3:
      return strings?.drawThree ?? 'Draw 3';
    case GameRegistry.freecell:
      return strings?.classicFourCells ?? 'Classic · 4 cells';
    case GameRegistry.freecellCells2:
      return strings?.twoCellsHard ?? '2 cells · hard';
    case GameRegistry.freecellCells6:
      return strings?.sixCellsRelaxed ?? '6 cells · relaxed';
    default:
      return id;
  }
}

/// A one-line descriptor under a variant's short label.
String variantDescriptor(String id, [AppStrings? strings]) {
  switch (id) {
    case GameRegistry.klondikeDraw1:
      return strings?.turnOneCard ?? 'Turn one card at a time';
    case GameRegistry.klondikeDraw3:
      return strings?.turnThreeCards ?? 'Turn three at a time';
    case GameRegistry.freecell:
      return strings?.standardFreecell ?? 'Standard FreeCell';
    case GameRegistry.freecellCells2:
      return strings?.fewerCellsTighter ?? 'Fewer cells, tighter play';
    case GameRegistry.freecellCells6:
      return strings?.extraRoomEasier ?? 'Extra room, easier';
    default:
      return '';
  }
}
