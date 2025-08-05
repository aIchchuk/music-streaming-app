import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class SongDTO {
  final String songName;
  final String artistName;
  final String? albumName;
  final File? songImageFile;
  final File? audioFile;

  SongDTO({
    required this.songName,
    required this.artistName,
    this.albumName,
    this.songImageFile,
    this.audioFile,
  });
}
