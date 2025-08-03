// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongApiModel _$SongApiModelFromJson(Map<String, dynamic> json) => SongApiModel(
      songId: json['_id'] as String?,
      songName: json['songName'] as String,
      artistName: json['artistName'] as String,
      songImage: json['songImage'] as String?,
      songImageUrl: json['songImageUrl'] as String?,
      audioFile: json['audioFile'] as String?,
      audioUrl: json['audioUrl'] as String?,
      albumName: json['albumName'] as String?,
      originalImageFileName: json['originalImageFileName'] as String?,
      originalAudioFileName: json['originalAudioFileName'] as String?,
    );

Map<String, dynamic> _$SongApiModelToJson(SongApiModel instance) =>
    <String, dynamic>{
      '_id': instance.songId,
      'songName': instance.songName,
      'artistName': instance.artistName,
      'songImage': instance.songImage,
      'songImageUrl': instance.songImageUrl,
      'audioFile': instance.audioFile,
      'audioUrl': instance.audioUrl,
      'albumName': instance.albumName,
      'originalImageFileName': instance.originalImageFileName,
      'originalAudioFileName': instance.originalAudioFileName,
    };
