import 'dart:io';

import 'package:flutter/material.dart';

class WriteToFile{
  File outputFile = File("");
  String appDir;

  WriteToFile(this.appDir, String filePath){
    String fullPath = appDir + filePath;
    print("File Path: " + fullPath);
    outputFile = File(fullPath);
  }

  Future<bool> doesFileExist(File fileInQuestion) async {
    if(await outputFile.exists() == true) {
      return true;
    }

    return false;
  }

  Future<File> createFile(File file) async{
    return await file.create(recursive: true);
  }

  void writeString(String stringToWrite) async {
    await outputFile.writeAsString(stringToWrite);
  }


}