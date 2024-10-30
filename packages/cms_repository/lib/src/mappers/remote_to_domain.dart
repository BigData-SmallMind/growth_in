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
import 'package:intl/intl.dart';

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
    final channelRM = channel == null ? null : jsonDecode(channel!);
    final channelsList = channelRM is List
        ? channelRM.map((channel) => channelRMtoDM(channel)).toList()
        : [channelRMtoDM(channelRM)];

    final imagesRM = images == null ? null : jsonDecode(images!);
    final imagesUrls = imagesRM is List
        ? imagesRM
            .map((image) => '${UrlBuilder.imageDownloadUrl}/$image')
            .toList()
        : [imagesRM as String];

    DateFormat format = DateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z");

    final publicationDateDM =
        format.tryParse(publicationDate..replaceFirst('GMT', '').trim()) ??
            DateTime.now();
    final statusDM = status == 'مقبول'
        ? PostStatus.accepted
        : status == 'جديد'
            ? PostStatus.newPost
            : status == 'تعديلات'
                ? PostStatus.editing
                : throw Exception('Invalid status');
    final contentTypeRM = contentType == null ? null : jsonDecode(contentType!);

    final contentTypes = contentTypeRM is List
        ? contentTypeRM.map((type) => (type).toString()).toList()
        : [contentTypeRM as String];

    int hour = publicationDateDM.hour % 12; // Convert to 12-hour format
    hour = hour == 0 ? 12 : hour; // Handle midnight case
    int minute = publicationDateDM.minute;
    String period = publicationDateDM.hour >= 12 ? 'PM' : 'AM';
    final hourDM =
        '${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute} $period';
    return Post(
      id: id,
      channels: channelsList,
      contentGoal: contentGoal,
      contentType: contentTypes,
      text: text,
      images: imagesUrls,
      publicationDate: publicationDateDM,
      status: statusDM,
      shouldShowRedDot: shouldShowRedDot == 1 ? true : false,
      hour: hourDM,
      isApproved: isApproved == 1 ? true : false,
    );
  }
}

extension PostsRMtoDM on List<PostRM> {
  List<Post> toDomainModel() {
    return map((post) => post.toDomainModel()).toList();
  }
}

extension PostVersionRMtoDM on PostVersionRM {
  PostVersion toDomainModel() {
    return PostVersion(
      id: id,
      postId: postId,
      isSelected: isSelected == 1 ? true : false,
      username: username,
      dateSubmitted: DateTime.parse(dateSubmitted),
    );
  }
}

extension PostVersionDetailsRMtoDM on List<PostVersionRM> {
  List<PostVersion> toDomainModel() {
    return map((postVersion) => postVersion.toDomainModel()).toList();
  }
}

extension CampaignRMtoDM on CampaignRM {
  Campaign toDomainModel() {
    return Campaign(
      id: id,
      name: name,
      contentGoal: contentGoal,
      summary: summary,
      postCount: postCount,
    );
  }
}

extension CampaignsRMtoDM on List<CampaignRM> {
  List<Campaign> toDomainModel() {
    return map((campaign) => campaign.toDomainModel()).toList();
  }
}
