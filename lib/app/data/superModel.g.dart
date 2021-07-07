part of 'superModel.dart';

SuperModel _$SuperModelFromJson(Map<String, dynamic> json) {
  return SuperModel(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : AddPostModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SuperModelToJson(SuperModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
