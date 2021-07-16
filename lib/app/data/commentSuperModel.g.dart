part of 'commentSuperModel.dart';

CommentSuperModel _$SuperModelFromJson(Map<String, dynamic> json) {
  return CommentSuperModel(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : commentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SuperModelToJson(CommentSuperModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
