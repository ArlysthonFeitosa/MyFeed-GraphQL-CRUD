// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostModel {
  final String postId;
  final String ownerUsername;
  final String ownerAvatarURL;
  final String content;

  PostModel({
    required this.postId,
    required this.ownerUsername,
    required this.ownerAvatarURL,
    required this.content,
  });

  Map<String, dynamic> toMap() {

    return <String, dynamic>{
      'postId': postId,
      'ownerUsername': ownerUsername,
      'ownerAvatar': ownerAvatarURL,
      'content': content,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    

    return PostModel(
      postId: map['id'].toString(),
      ownerUsername: map['ownerUsername'] as String,
      ownerAvatarURL: map['ownerAvatar'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PostModel copyWith({
    String? postId,
    String? ownerUsername,
    String? ownerAvatarURL,
    String? content,
  }) {
    return PostModel(
      postId: postId ?? this.ownerUsername,
      ownerUsername: ownerUsername ?? this.ownerUsername,
      ownerAvatarURL: ownerAvatarURL ?? this.ownerAvatarURL,
      content: content ?? this.content,
    );
  }

  @override
  String toString() {
    return 'PostModel(ownerUsername: $ownerUsername, ownerAvatarURL: $ownerAvatarURL, content: $content)';
  }
}
