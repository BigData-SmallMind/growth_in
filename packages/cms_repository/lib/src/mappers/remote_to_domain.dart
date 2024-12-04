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
      case 'tiktok':
        return SocialChannel.tiktok;
      default:
        throw Exception('Invalid channel');
    }
  }

  Post toDomainModel() {
    final channelsList =
        channel?.map((channel) => channelRMtoDM(channel)).toList();

    final imagesUrls = images
        ?.map((image) => '${UrlBuilder.imageDownloadUrl}/$image')
        .toList();

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

    // final contentTypes = contentType?.map((type) => (type).toString()).toList();

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
      contentType: contentType,
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
