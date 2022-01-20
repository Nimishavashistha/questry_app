part of 'addpostModel.dart';

AddPostModel _$AddPostModelFromJson(Map<String, dynamic> json) {
  return AddPostModel(
      userId: json['userId'] as String,
      img: json['img'] as String,
      desc: json['desc'] as String,
      likes: json['likes'] as List,
      dislikes: json['dislikes'] as List,
      noOfanswers: json['noOfanswers'] as List,
      id: json['_id'] as String);
}

Map<String, dynamic> _$AddPostModelToJson(AddPostModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'img': instance.img,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'noOfanswers': instance.noOfanswers,
      'desc': instance.desc,
      '_id': instance.id,
    };
