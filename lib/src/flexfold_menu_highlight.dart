import 'package:flutter/material.dart';

import 'flex_scaffold.dart';
import 'flex_scaffold_constants.dart';
import 'flexfold_theme.dart';

/// Makes a ShapeBorder based on the [FlexfoldHighlightType] enum.
///
/// This is a helper class that makes a hover and selected menu item highlight
/// indicator for the [FlexScaffold| menu items.
///
/// You can provide custom margin values, if none are provided then
/// suitable defaults are used that you can get with the [margins]
/// and pass into [FlexScaffold].
///
/// You can also provide custom [ShapeBorder]s and custom margin to
/// [FlexScaffold], you don't have to construct them with this helper class,
/// but if one of the pre-made ones suits your needs, this helper class makes
/// it easier. It can also serve as an example on how to define your own
/// custom menu highlight ShapeBorder.
///
/// If there is some style you would like to add to the ready made
/// ones, please post a suggestion or make a pull request.
class FlexfoldMenuHighlight {
  /// Default constructor for [FlexfoldMenuHighlight].
  FlexfoldMenuHighlight({
    this.highlightType = FlexfoldHighlightType.stadium,
    this.borderColor,
    this.highlightColor,
    this.borderRadius = 8.0,
    this.height = kFlexfoldHighlightHeight,
    this.menuHighlightMarginStart,
    this.menuHighlightMarginEnd,
    this.menuHighlightMarginTop,
    this.menuHighlightMarginBottom,
    this.startBarWidth = 5.0,
    this.endBarWidth = 6.0,
    this.directionality = TextDirection.ltr,
  })  : assert(borderRadius >= 0, 'The border radius must be >= 0.'),
        assert(height >= 0, 'The height must be >= 0.'),
        assert(startBarWidth >= 0, 'The startBarWidth must be >= 0.'),
        assert(endBarWidth >= 0, 'The endBarWidth must be >= 0.') {
    switch (highlightType) {
      case FlexfoldHighlightType.none:
        {
          _start = 0.0;
          _end = 0.0;
          _top = 2.0;
          _bottom = 2.0;
          _highLightColor = Colors.transparent;
        }
        break;
      case FlexfoldHighlightType.row:
        {
          _start = menuHighlightMarginStart ?? 0;
          _end = menuHighlightMarginEnd ?? 0;
          _top = menuHighlightMarginTop ?? 2;
          _bottom = menuHighlightMarginBottom ?? 2;
          _highLightColor = highlightColor ?? Colors.transparent;
        }
        break;
      case FlexfoldHighlightType.box:
        {
          _start = menuHighlightMarginStart ?? 4;
          _end = menuHighlightMarginEnd ?? 4;
          _top = menuHighlightMarginTop ?? 2;
          _bottom = menuHighlightMarginBottom ?? 2;
          _highLightColor = highlightColor ?? Colors.transparent;
        }
        break;
      case FlexfoldHighlightType.stadium:
        {
          _start = menuHighlightMarginStart ?? 3;
          _end = menuHighlightMarginEnd ?? 3;
          _top = menuHighlightMarginTop ?? 2;
          _bottom = menuHighlightMarginBottom ?? 2;
          _highLightColor = highlightColor ?? Colors.transparent;
        }
        break;
      case FlexfoldHighlightType.endStadium:
        {
          _start = menuHighlightMarginStart ?? 0;
          _end = menuHighlightMarginEnd ?? 3;
          _top = menuHighlightMarginTop ?? 2;
          _bottom = menuHighlightMarginBottom ?? 2;
          _highLightColor = highlightColor ?? Colors.transparent;
        }
        break;
      case FlexfoldHighlightType.startBar:
        {
          _start = menuHighlightMarginStart ?? 0;
          _end = menuHighlightMarginEnd ?? 0;
          _top = menuHighlightMarginTop ?? 2;
          _bottom = menuHighlightMarginBottom ?? 2;
          _highLightColor = Colors.transparent;
        }
        break;
      case FlexfoldHighlightType.endBar:
        {
          _start = menuHighlightMarginStart ?? 0;
          _end = menuHighlightMarginEnd ?? 0;
          _top = menuHighlightMarginTop ?? 2;
          _bottom = menuHighlightMarginBottom ?? 2;
          _highLightColor = Colors.transparent;
        }
        break;
    }
  }

  /// The type of Flexfold Shape.
  ///
  /// Default to [FlexfoldHighlightType.stadium].
  final FlexfoldHighlightType highlightType;

  /// Color of the border on the edge for the shape when used.
  ///
  /// If not defined defaults to [Colors.transparent].
  final Color? borderColor;

  /// Color of the background highlight or hover transparency.
  ///
  /// If not defined defaults to [Colors.transparent].
  final Color? highlightColor;

  /// Corner rounding diameter.
  final double borderRadius;

  /// Highlight height
  final double height;

  /// Margin before the menu selection highlight indicator.
  final double? menuHighlightMarginStart;

  /// Margin after the menu selection highlight indicator.
  final double? menuHighlightMarginEnd;

  /// Margin on top of the menu selection highlight indicator.
  final double? menuHighlightMarginTop;

  /// Margin below the menu selection highlight indicator.
  final double? menuHighlightMarginBottom;

  /// Start bar width.
  final double startBarWidth;

  /// End bar width.
  final double endBarWidth;

  /// Directionality for current text direction.
  ///
  /// Only used to resolve the circular side direction for the end stadium style
  /// from BorderRadiusDirectional to normal BorderRadius that is used by
  /// the ShapeBorder RoundedRectangleBorder.
  final TextDirection directionality;

  late double _start;
  late double _end;
  late double _top;
  late double _bottom;
  late Color _highLightColor;

  /// Return the margins to be used with the menu highlight shape.
  ///
  /// Different shape type require different margins. FlexfoldMenuHighlight
  /// creates suitable default margins for the ShapeBorders it creates.
  EdgeInsetsDirectional get margins =>
      EdgeInsetsDirectional.fromSTEB(_start, _top, _end, _bottom);

  /// Return the highlight color. Typically assigned to the [FlexScaffold] theme
  /// property [FlexfoldThemeData.menuHighlightColor]. Some types do not use a
  /// highlight color and will
  /// return [Colors.transparent]. If a highlight color for a selected item
  /// is used for the highlight type, the [highlightColor] color will be
  /// returned.
  Color get highlight => _highLightColor;

  /// Returns the defined shape border.
  ShapeBorder? shape() {
    switch (highlightType) {
      case FlexfoldHighlightType.none:
        return null;
      case FlexfoldHighlightType.row:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(0));
      case FlexfoldHighlightType.box:
        return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius));
      case FlexfoldHighlightType.stadium:
        return const StadiumBorder();
      case FlexfoldHighlightType.endStadium:
        return RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.horizontal(
            end: Radius.circular(height / 2.0),
          ).resolve(directionality),
        );
      case FlexfoldHighlightType.startBar:
        return BorderDirectional(
          start: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: startBarWidth,
          ),
        );
      case FlexfoldHighlightType.endBar:
        return BorderDirectional(
          end: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: endBarWidth,
          ),
        );
    }
  }
}
