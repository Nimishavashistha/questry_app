import 'package:json_annotation/json_annotation.dart';

part 'commentModel.g.dart';

@JsonSerializable()
class commentModel {
  String content;
  List likes;
  List dislikes;
  String userName;
  String postUserId;
  @JsonKey(name: "_id")
  String id;
  String userpic;
  String postId;

  commentModel(
      {this.content,
      this.likes,
      this.dislikes,
      this.userName,
      this.postUserId,
      this.id,
      this.userpic,
      this.postId});
  factory commentModel.fromJson(Map<String, dynamic> json) =>
      _$commentModelFromJson(json);
  Map<String, dynamic> toJson() => _$commentModelToJson(this);
}
