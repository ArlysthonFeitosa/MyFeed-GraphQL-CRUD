import 'package:flutter/material.dart';
import 'package:myfeed/app/models/post_model.dart';
import 'package:myfeed/pages/comments/comments_args.dart';
import 'package:myfeed/utils/components/user_header_component.dart';

class PostComponent extends StatelessWidget {
  const PostComponent({
    required this.postModel,
    Key? key,
  }) : super(key: key);

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          UserHeaderComponent(
            username: postModel.ownerUsername,
            avatar: postModel.ownerAvatarURL,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(postModel.content),
            ),
          ),
          const Divider(
            height: 3,
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/comments',
                    arguments: CommentsPageArgs(postModel: postModel),
                  );
                },
                child: const Text(
                  'View Comments',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
