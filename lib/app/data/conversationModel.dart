import 'package:json_annotation/json_annotation.dart';
part 'conversationModel.g.dart';

@JsonSerializable()
class ConversationModel {
  List members;
  @JsonKey(name: "_id")
  String id;
  ConversationModel({this.members, this.id});

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}
