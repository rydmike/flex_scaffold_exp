import 'package:flutter/widgets.dart';

/// A widget laying out multiple pages with only one active page being built
/// at a time and on stage. Off stage pages' animations are stopped.
class PageSwitchingView extends StatefulWidget {
  const PageSwitchingView({
    super.key,
    required this.currentPageIndex,
    required this.pageCount,
    required this.pageBuilder,
  })  : assert(pageCount > 0, 'PageCount must be greater than 0');

  final int currentPageIndex;
  final int pageCount;
  final IndexedWidgetBuilder pageBuilder;

  @override
  State<PageSwitchingView> createState() => _PageSwitchingViewState();
}

class _PageSwitchingViewState extends State<PageSwitchingView> {
  final List<bool> shouldBuildPage = <bool>[];
  final List<FocusScopeNode> pageFocusNodes = <FocusScopeNode>[];

  // When focus nodes are no longer needed, we need to dispose of them, but we
  // can't be sure that nothing else is listening to them until this widget is
  // disposed of, so when they are no longer needed, we move them to this list,
  // and dispose of them when we dispose of this widget.
  final List<FocusScopeNode> discardedNodes = <FocusScopeNode>[];

  @override
  void initState() {
    super.initState();
    shouldBuildPage.addAll(List<bool>.filled(widget.pageCount, false));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _focusActivePage();
  }

  @override
  void didUpdateWidget(PageSwitchingView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only partially invalidate the page cache to avoid breaking the current
    // behavior. We assume that the only possible change is either:
    // - new pages are appended to the tab list, or
    // - some trailing pages are removed.
    // If the above assumption is not true, some pages may lose their state.
    final int lengthDiff = widget.pageCount - shouldBuildPage.length;
    if (lengthDiff > 0) {
      shouldBuildPage.addAll(List<bool>.filled(lengthDiff, false));
    } else if (lengthDiff < 0) {
      shouldBuildPage.removeRange(widget.pageCount, shouldBuildPage.length);
    }
    _focusActivePage();
  }

  // Will focus the active tab if the FocusScope above it has focus already. If
  // not, then it will just mark it as the preferred focus for that scope.
  void _focusActivePage() {
    if (pageFocusNodes.length != widget.pageCount) {
      if (pageFocusNodes.length > widget.pageCount) {
        discardedNodes.addAll(pageFocusNodes.sublist(widget.pageCount));
        pageFocusNodes.removeRange(widget.pageCount, pageFocusNodes.length);
      } else {
        pageFocusNodes.addAll(
          List<FocusScopeNode>.generate(
            widget.pageCount - pageFocusNodes.length,
            (int index) => FocusScopeNode(
                debugLabel: 'Page ${index + pageFocusNodes.length}'),
          ),
        );
      }
    }
    FocusScope.of(context)
        .setFirstFocus(pageFocusNodes[widget.currentPageIndex]);
  }

  @override
  void dispose() {
    for (final FocusScopeNode focusScopeNode in pageFocusNodes) {
      focusScopeNode.dispose();
    }
    for (final FocusScopeNode focusScopeNode in discardedNodes) {
      focusScopeNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: List<Widget>.generate(widget.pageCount, (int index) {
        final bool active = index == widget.currentPageIndex;
        shouldBuildPage[index] = active || shouldBuildPage[index];

        return HeroMode(
          enabled: active,
          child: Offstage(
            offstage: !active,
            child: TickerMode(
              enabled: active,
              child: FocusScope(
                node: pageFocusNodes[index],
                child: Builder(builder: (BuildContext context) {
                  return shouldBuildPage[index]
                      ? widget.pageBuilder(context, index)
                      : Container();
                }),
              ),
            ),
          ),
        );
      }),
    );
  }
}
