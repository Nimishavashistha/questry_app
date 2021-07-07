import 'package:json_annotation/json_annotation.dart';
import 'package:questry/app/data/addpostModel.dart';
part 'superModel.g.dart';

@JsonSerializable()
class SuperModel {
  List<AddPostModel> data;
  SuperModel({this.data});
  factory SuperModel.fromJson(Map<String, dynamic> json) =>
      _$SuperModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelToJson(this);
}
