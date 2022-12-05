// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
//
// import 'flex_scaffold.dart';
//
// /// GoRouter implementation of InheritedWidget.
// ///
// /// Used for to find the current FlexScaffold in the widget tree. This is useful
// /// when reading FlexScaffold properties and using it methods from anywhere
// /// in your app.
// class InheritedFlexScaffold extends InheritedNotifier<FlexScaffold> {
//   /// Default constructor for the inherited go router.
//   const InheritedFlexScaffold({
//     required super.child,
//     required this.flexScaffold,
//     super.key,
//   }) : super(notifier: flexScaffold);
//
//   /// The [FlexScaffold] that is made available to the widget tree.
//   final FlexScaffold flexScaffold;
//
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties
//       .add(DiagnosticsProperty<FlexScaffold>('flexScaffold', flexScaffold));
//   }
// }
