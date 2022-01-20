import 'package:json_annotation/json_annotation.dart';

part 'addPostModel.g.dart';

@JsonSerializable()
class AddPostModel {
  String userId;
  String img;
  String desc;
  List likes;
  List dislikes;
  List noOfanswers;
  @JsonKey(name: "_id")
  String id;

  AddPostModel({
    this.userId,
    this.img,
    this.desc,
    this.likes,
    this.dislikes,
    this.noOfanswers,
    this.id,
  });
  factory AddPostModel.fromJson(Map<String, dynamic> json) =>
      _$AddPostModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddPostModelToJson(this);
}
