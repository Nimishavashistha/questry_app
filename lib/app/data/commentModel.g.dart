part of 'commentModel.dart';

commentModel _$commentModelFromJson(Map<String, dynamic> json) {
  return commentModel(
    content: json['content'] as String,
    likes: json['likes'] as List,
    dislikes: json['dislikes'] as List,
    userName: json['userName'] as String,
    postUserId: json['postUserId'] as String,
    id: json['_id'] as String,
    userpic: json['userpic'] as String,
    postId: json['postId'] as String,
  );
}

Map<String, dynamic> _$commentModelToJson(commentModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'userName': instance.userName,
      'postUserId': instance.postUserId,
      '_id': instance.id,
      'userpic': instance.userpic,
      'postId': instance.postId,
    };
