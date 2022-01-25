part of 'conversationModel.dart';

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) {
  return ConversationModel(
    members: json['members'] as List,
    id: json['_id'] as String,
  );
}

Map<String, dynamic> _$ConversationModelToJson(ConversationModel instance) =>
    <String, dynamic>{
      'members': instance.members,
      'id': instance.id,
    };
