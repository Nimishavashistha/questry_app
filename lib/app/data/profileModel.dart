import 'package:json_annotation/json_annotation.dart';
part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  String username;
  String sem;
  String from;
  String desc;
  @JsonKey(name: "_id")
  String id;
  ProfileModel({this.username, this.sem, this.from, this.desc, this.id});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
