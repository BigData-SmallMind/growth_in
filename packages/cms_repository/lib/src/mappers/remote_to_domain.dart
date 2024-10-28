// "id": 1,
// "channel": "[\"linked\"]",
// "campaign": null,
// "content_goal": "توعوي",
// "content_type":"[\"\ق\ص\ة\"]",
// "post_content": "ddg",
// "content_image": "[\"670f6085041f9_1729060997.png\"]",
// "publication_date": "Thu Oct 10 2024 00:00:00 GMT+0300",
// "isPublished": 1,
// "company_id": 1,
// "campaign_id": null,
// "creator_id": 1,
// "client_status": "مقبول",
// "operation_status": "مقبول",
// "account_manager_status": "مقبول",
// "isApproved": 1,
// "show_red_dot_client": 0,
// "show_red_dot_operation": 1,
// "show_red_dot_manager": 1,
// "isNew": 1,
// "deleted_at": null,
// "created_at": "2024-10-16T06:43:17.000000Z",
// "updated_at": "2024-10-28T12:49:47.000000Z",
// "show_red_dot_admin": 0

import 'dart:convert';

import 'package:domain_models/domain_models.dart';
import 'package:growth_in_api/growth_in_api.dart';

extension PostRMtoDM on PostRM {
  SocialChannel channelRMtoDM(String channel) {
    switch (channel) {
      case 'snap':
        return SocialChannel.snapchat;
      case 'face':
        return SocialChannel.facebook;
      case 'insta':
        return SocialChannel.instagram;
      case 'linked':
        return SocialChannel.linkedIn;
      case 'x':
        return SocialChannel.x;
      default:
        throw Exception('Invalid channel');
    }
  }

  Post toDomainModel() {
    final channelsList =
        channel != null ? List<String>.from(jsonDecode(channel!)) : null;
    final channelsListDM =
        channelsList?.map((channel) => channelRMtoDM(channel)).toList();
    final imagesDM =
        images != null ? List<String>.from(jsonDecode(images!)) : null;
    //Thu Oct 10 2024 00:00:00 GMT+0300
    final publicationDateDM =
        DateTime.tryParse(publicationDate.replaceAll("GMT", "").trim());
    final statusDM = status == 'مقبول'
        ? PostStatus.accepted
        : status == 'جديد'
            ? PostStatus.newPost
            : status == 'تعديلات'
                ? PostStatus.editing
                : throw Exception('Invalid status');
    return Post(
      id: id,
      channels: channelsListDM,
      contentGoal: contentGoal,
      contentType: contentType,
      text: text,
      images: imagesDM,
      publicationDate: publicationDateDM,
      status: statusDM,
      shouldShowRedDot: shouldShowRedDot == 1 ? true : false,
    );
  }
}

extension PostsRMtoDM on List<PostRM> {
  List<Post> toDomainModel() {
    return map((post) => post.toDomainModel()).toList();
  }
}
