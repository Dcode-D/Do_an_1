part of 'article_bloc.dart';

@immutable
abstract class ArticleEvent {}

class GetArticleData extends ArticleEvent {}


class GetArticleByQuery extends ArticleEvent {
  final String query;

  GetArticleByQuery(this.query);
}