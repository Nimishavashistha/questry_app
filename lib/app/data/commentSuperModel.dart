import 'package:json_annotation/json_annotation.dart';
import 'package:questry/app/data/commentModel.dart';
part 'commentSuperModel.g.dart';

@JsonSerializable()
class CommentSuperModel {
  List<commentModel> data;
  CommentSuperModel({this.data});
  factory CommentSuperModel.fromJson(Map<String, dynamic> json) =>
      _$SuperModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelToJson(this);
}
