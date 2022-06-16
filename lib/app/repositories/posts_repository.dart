import 'package:flutter/cupertino.dart';
import 'package:myfeed/app/api/api_info.dart';
import 'package:myfeed/app/exceptions/exceptions.dart';
import 'package:myfeed/app/interfaces/repository/posts_repository_interface.dart';
import 'package:myfeed/app/interfaces/services/hasura_service_interface.dart';
import 'package:myfeed/app/models/post_model.dart';
import 'package:myfeed/app/models/comment_model.dart';

class PostsRepository extends ChangeNotifier implements IPostsRepository {
  final IHasuraService hasuraService;

  PostsRepository({required this.hasuraService});

  @override
  Future<List<PostModel>> getAllPosts({
    int? offset,
    int? limit,
  }) async {
    Map<String, dynamic> responseMap = await hasuraService.query(query: postsQuery(offset: offset, limit: limit));

    if (responseMap.containsKey('errors')) {
      throw TryAgainLaterException();
    }

    List<PostModel> posts = [];
    for (Map<String, dynamic> map in responseMap['data']['posts']) {
      posts.add(PostModel.fromMap(map));
    }

    return posts;
  }

  @override
  Future<List<CommentModel>> getCommentsFromPost({required String postId, int? offset, int? limit}) async {
    Map<String, dynamic> responseMap = await hasuraService.query(query: commentsFromPostQuery(postId: postId, offset: offset, limit: limit));

    if (responseMap.containsKey('errors')) {
      throw TryAgainLaterException();
    }

    List<CommentModel> comments = [];
    for (Map<String, dynamic> map in responseMap['data']['comments']) {
      comments.add(CommentModel.fromMap(map));
    }

    return comments;
  }

  @override
  Future<void> createComment({required CommentModel commentModel}) async {
    Map<String, dynamic> responseMap = await hasuraService.mutation(query: createCommentQuery(commentModel: commentModel));

    if (responseMap.containsKey('errors')) {
      throw TryAgainLaterException();
    }
  }

  @override
  Future<void> updateComment({required CommentModel commentModel}) async {
    Map<String, dynamic> responseMap = await hasuraService.mutation(query: updateCommentQuery(commentModel: commentModel));

    if (responseMap.containsKey('errors')) {
      throw TryAgainLaterException();
    }
  }

  @override
  Future<void> deleteComment({required CommentModel commentModel}) async {
    Map<String, dynamic> responseMap = await hasuraService.mutation(query: deleteCommentQuery(commentId: commentModel.commentId));

    if (responseMap.containsKey('errors')) {
      throw TryAgainLaterException();
    }
  }
}
