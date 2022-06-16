import 'package:myfeed/app/models/comment_model.dart';

String hasuraBaseURL = 'https://myfeed.hasura.app/v1/graphql';
String adminSecret = 'BuTyaLl6FoxqCt1kTywEIUNyPtMUpgfxUJFdowAsrOttbby1j3SgTvsN281vEp8i';

//String postsEndpoint({int? page, int? limit}) {
//  if (page == null && limit == null) return '$baseURL/posts';
//  return '$baseURL/posts?page=$page&limit=$limit';
//}
//
//String commentsFromPostEndpoint({required String postId, int? page, int? limit}) {
//  if (page == null && limit == null) return '$baseURL/posts/$postId/comments';
//  return '$baseURL/posts/$postId/comments?page=$page&limit=$limit&orderby=createdAt&order=desc';
//}
//
//String createCommentEndpoint({required String postId}) => '$baseURL/posts/$postId/comments';
//String updateCommentEndpoint({required String postId, required String commentId}) => '$baseURL/posts/$postId/comments/$commentId';
//String deleteCommentEndpoint({required String postId, required String commentId}) => '$baseURL/posts/$postId/comments/$commentId';

String postsQuery({int? offset, int? limit}) {
  if (offset == null && limit == null) {
    return '''
      query {
        posts {
        content
        createdAt
        id
        ownerAvatar
        ownerUsername
        }
      }
    ''';
  }
  return '''
      query {
        posts(limit: $limit, offset: $offset) {
        content
        createdAt
        id
        ownerAvatar
        ownerUsername
        }
      }
    ''';
}

String commentsFromPostQuery({required String postId, int? offset, int? limit}) {
  if (offset == null && limit == null) {
    '''
    query {
      comments(order_by: {createdAt: desc}, where: {postId: {_eq: 1}}) {
        username
        postId
        id
        createdAt
        content
        avatar
      }
    }
    ''';
  }
  return '''
    query {
      comments(order_by: {createdAt: asc}, where: {postId: {_eq: $postId}}, limit: $limit, offset: $offset) {
        username
        postId
        id
        createdAt
        content
        avatar
      }
    }
    ''';
}

String createCommentQuery({required CommentModel commentModel}) {
  return
  '''
    mutation {
      insert_comments_one(object: {avatar: "${commentModel.ownerAvatarURL}", content: "${commentModel.content}", createdAt: "${commentModel.createdAt}", postId: ${commentModel.postId}, username: "${commentModel.ownerUsername}"}) {
        id
      }
    }
  ''';
}

String updateCommentQuery({required CommentModel commentModel}){
  return 
  '''
  mutation {
    update_comments(where: {id: {_eq: ${commentModel.commentId}}}, _set: {avatar: "${commentModel.ownerAvatarURL}", content: "${commentModel.content}", createdAt: "${commentModel.createdAt}", username: "${commentModel.ownerUsername}"}) {
      returning {
        id
      }
    }
  }
  ''';
}

String deleteCommentQuery({required String commentId}){
  return '''
  mutation {
    delete_comments(where: {id: {_eq: $commentId}}){
      returning {
       id
      }
    }
  }
  ''';

}
