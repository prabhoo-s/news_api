// Mocks generated by Mockito 5.0.0 from annotations
// in news_api/test/headlines_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:news_api/Data/Models/sources_list.dart' as _i3;
import 'package:news_api/Data/Models/top_headlines_list.dart' as _i4;
import 'package:news_api/Data/Repositories/api_provider.dart' as _i2;
import 'package:news_api/Domain/Repositories/api_repository.dart' as _i5;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeAPIProvider extends _i1.Fake implements _i2.APIProvider {}

class _FakeSourcesList extends _i1.Fake implements _i3.SourcesList {}

class _FakeTopHeadlinesList extends _i1.Fake implements _i4.TopHeadlinesList {}

/// A class which mocks [APIRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAPIRepository extends _i1.Mock implements _i5.APIRepository {
  MockAPIRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.APIProvider get apiProvider =>
      (super.noSuchMethod(Invocation.getter(#apiProvider),
          returnValue: _FakeAPIProvider()) as _i2.APIProvider);
  @override
  _i6.Future<_i3.SourcesList> fetchSources() =>
      (super.noSuchMethod(Invocation.method(#fetchSources, []),
              returnValue: Future.value(_FakeSourcesList()))
          as _i6.Future<_i3.SourcesList>);
  @override
  _i6.Future<_i4.TopHeadlinesList> fetchTopHeadlines() =>
      (super.noSuchMethod(Invocation.method(#fetchTopHeadlines, []),
              returnValue: Future.value(_FakeTopHeadlinesList()))
          as _i6.Future<_i4.TopHeadlinesList>);
  @override
  _i6.Future<_i4.TopHeadlinesList> search(String? searchString) =>
      (super.noSuchMethod(Invocation.method(#search, [searchString]),
              returnValue: Future.value(_FakeTopHeadlinesList()))
          as _i6.Future<_i4.TopHeadlinesList>);
}
