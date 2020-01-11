// Copyright 2016 Google Inc. Use of this source code is governed by an
// MIT-style license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:source_span/source_span.dart';

/// A node in an abstract syntax tree.
abstract class AstNode {
  /// The source span associated with the node.
  ///
  /// This indicates where in the source Sass or SCSS stylesheet the node was
  /// defined.
  FileSpan get span;

  /// Returns an [AstNode] that doesn't have any data and whose span is
  /// generated by [callback].
  ///
  /// Anumber of APIs take [AstNode]s instead of spans because computing spans
  /// eagerly can be expensive. This allows arbitrary spans to be passed to
  /// those callbacks while sitll being lazily computed.
  factory AstNode.fake(FileSpan Function() callback) = _FakeAstNode;

  AstNode();
}

/// An [AstNode] that just exposes a single span generated by a callback.
class _FakeAstNode implements AstNode {
  FileSpan get span => _callback();

  /// The callback to use to generate [span].
  final FileSpan Function() _callback;

  _FakeAstNode(this._callback);
}
