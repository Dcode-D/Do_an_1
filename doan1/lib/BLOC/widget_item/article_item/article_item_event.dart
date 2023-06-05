part of 'article_item_bloc.dart';

@immutable
abstract class ArticleItemEvent {}

class GetArticleItemData extends ArticleItemEvent{
  Article? article;
  GetArticleItemData({required this.article});
}

