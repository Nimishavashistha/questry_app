part of 'profileModel.dart';

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
      username: json['username'] as String,
      desc: json['desc'] as String,
      from: json['from'] as String,
      sem: json['sem'] as String,
      id: json['_id'] as String);
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'sem': instance.sem,
      'from': instance.from,
      'desc': instance.desc,
      'id': instance.id,
    };
