// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumApiModel _$AlbumApiModelFromJson(Map<String, dynamic> json) => AlbumApiModel(
      albumId: json['_id'] as String?,
      albumName: json['albumName'] as String,
      artistName: json['artistName'] as String,
      albumImage: json['albumImage'] as String?,
      albumImageUrl: json['albumImageUrl'] as String?,
      song: (json['song'] as List<dynamic>)
          .map((e) => SongApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumApiModelToJson(AlbumApiModel instance) =>
    <String, dynamic>{
      '_id': instance.albumId,
      'albumName': instance.albumName,
      'artistName': instance.artistName,
      'albumImage': instance.albumImage,
      'albumImageUrl': instance.albumImageUrl,
      'song': instance.song.map((e) => e.toJson()).toList(),
    };
