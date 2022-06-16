import 'package:flutter_test/flutter_test.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:myfeed/app/api/api_info.dart';
import 'package:myfeed/app/interfaces/repository/posts_repository_interface.dart';
import 'package:myfeed/app/models/comment_model.dart';
import 'package:myfeed/app/models/post_model.dart';
import 'package:myfeed/app/repositories/posts_repository.dart';
import 'package:myfeed/app/services/hasura_service.dart';

void main() {
  test('getPosts', () async {
    IPostsRepository postsRepository = PostsRepository(
      hasuraService: HasuraService(
        hasuraConnect: HasuraConnect(hasuraBaseURL),
      ),
    );

    List<PostModel> posts = await postsRepository.getAllPosts();

    expect(posts, isNotEmpty);
  });

  test('getComments', () async {
    IPostsRepository postsRepository = PostsRepository(
      hasuraService: HasuraService(
        hasuraConnect: HasuraConnect(hasuraBaseURL),
      ),
    );

    List<CommentModel> comments = await postsRepository.getCommentsFromPost(postId: '1');

    expect(comments, isNotEmpty);
  });

}
