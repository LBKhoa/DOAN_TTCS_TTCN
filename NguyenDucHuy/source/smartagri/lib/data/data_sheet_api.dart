import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'dataSendField.dart';

import 'datasetField.dart';

class DataSheetApi{

  static const _credentials= r'''
  {
  "type": "service_account",
  "project_id": "gsheetdatn",
  "private_key_id": "15703c5b5cea92932a8125787e3b2db23c74bce2",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDNhSDhkuF0GThp\nCQArtGRaPYL0sOroNexonT5b0B+5+Q9A7zpGkCUtGXqZLVTxYzPNQgFszZWNItpB\nfkDSJEgI2jCbcAIONPUvJigVu4/50ojN2fJg2/1qrebmZ2blSk0b/E6k9YiYa6jF\npHR6K2v1RUqeky+nyqIHEq6mOEpIjVNEZD/b3DY/GPPRIkVAo0bFVWZI9rZgwRAA\nP9OXsGWf1P4ckG6zjLg6ntmebVFrY+TO8EzKjDWRvOBA2cf1AGPAPSIYkeX54oFT\ntBlmEpqLubuZUewKY8bkGKIG/njrhodOCCy3+aa3j4PqB6UR97M7HHDqMtsYpSK2\nclRrtAzLAgMBAAECggEAYC6wv8Ds0FfJRabXtJx85pqpAfkWRsyNsjv85h0V7AQ6\ndko/PKzTKTMmZC+J9FpX8PS2FAR2vBGWkVYT4gTmzXXHj8cwvxNbt9AkrF8WN3Wn\nXqdkPp5WECoIyMWVqzNFuRYwfBUI80RXPQAFHvPZV3UxQdtiTyWPBL5ijBoF8cOT\nghod7Cq618VqI6MSx885iel6c/JAXNWWD0nZkzeHw5F5WIZ8Z/IWQTqP098RJSH5\new/WzG1Scpjc7XgqoBvLvesxYBO4b2YUMTYVsMZjdP2QepftkqgegZQ6kY0Qeo42\nNR5h8NVgRyurHPP3TJQ2KNaf+SWV095scVviSYIxyQKBgQDn1b48XKhRUzDP1FCI\n5S55cSdW94LuXkiXg43HxvSkCtX8wnjRmcBDSriS4sfu1c6plJvwmKTW4b5TGPK8\nZA2hxHR8P3jIMKAL8rRgvPwdekQUenDfYQR5IDWxkNsxhsMirHax0YFwVsqw3ofI\nZQpiusniZ3UnblAHY/hDQRaATwKBgQDi8TOW2sSxF87Z2iuq2vWnmdDbrqln6fth\nXjBy68JM1AtxR8w8VaG0HlvFhfYWtAnyHGVSWh3u1bGMmAfUfADF5GOAL4sk2tMz\nfPDws3htGRAtwC7Y38c+Qncw8xLPifeC86TvhI+Omxh9ItPitsNxBxj7q4jmsWZj\n2Ra8j8OwxQKBgQCHM7P559+Rbf6tdZhx/ZYY5NCYe0g0U2/qTKJGu9S4Rkl9Wryz\nIANsOwthPjhzJOWdKDm5GowndQdV1trY21DH4pY8T5fUx+bOkQB42j39wuwpNS7W\nVvIQ4aPuphfuzjTG5+Vg1lmyditG8sAlMifYZC6Qht1f3Yl2heqm7jJ9KQKBgEmk\nwfv7JAbf1fUl8jOweDUaGgef50NcT4HqQciZLuUljk0FYoZVt3Kuw1MWxKPbarrR\nciPGMJ53Y/VexHO0hb+x/IP1aa7c/9peegVyB+tHTdO64Ljp7UsL4IfW6UzF1bb9\n/5DmMHuzYsAA1EdmzYdZKUdKA9Pwz2wpX1JzSKqNAoGBAOAHcq2yrKMU2objHexo\nsj3M2wmuPq844azKHyfZ4a8xUNjYbjgvF9ZWaQKbecScfE/aaigzeTM6PI0pL7Qp\nmIPPsmWVCBxhaVS6+JzsXBPwa/wLycgdvad1ng4DfHBa86wJy9AO/btOO7ifs46O\nG1A0b/LiVBOlx02QZmbZc4ey\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheetdatn@gsheetdatn.iam.gserviceaccount.com",
  "client_id": "113200493630067433920",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheetdatn%40gsheetdatn.iam.gserviceaccount.com"
  }
  ''';

  static const _spreadsheetId='1KsE0-DmUPqbbJKJVLwpHzm3BNssRZH7Enmvi6OkVF7k';

  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  static Worksheet? _sendSheet;

  // ignore: non_constant_identifier_names
  static Future init(String Title) async{
    try{
      final  spreedsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet= await _getWorkSheet(spreedsheet, title: Title);

      final firstRow = DataSetFields.getFields();

      _userSheet!.values.insertRow(1, firstRow);
    }catch (e){
      // ignore: avoid_print
      print("init error: $e");
    }
  }

  // ignore: non_constant_identifier_names
  static Future initSend(String Title) async{
    try{
      final  spreedsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _sendSheet= await _getWorkSheet(spreedsheet, title: Title);

      final firstRow = DataSendSetFields.getSendFields();

      _sendSheet!.values.insertRow(1, firstRow);
    }catch (e){
      // ignore: avoid_print
      print("init error: $e");
    }
  }

  static Future <Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet,{
        required String title
      }) async{
    try{
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future <List<DataSet>> getAll() async{
    try{
      if (_userSheet == null ) return <DataSet>[];

      final users= await _userSheet!.values.map.allRows();
      return users == null? <DataSet>[] : users.map(DataSet.fromJson).toList();
    }catch(error){
      return <DataSet>[];
    }
  }

  static Future <DataSet?> getLastRow() async{
    if (_userSheet == null ) return null;

    final json = await _userSheet!.values.map.lastRow();
    return json == null ? null :  DataSet.fromJson(json);
  }

  static Future<DataSet?> getById(String id) async{
    if (_userSheet == null ) return null;

    final json = await _userSheet!.values.map.rowByKey(id,fromColumn: 1);
    return json==null ? null :  DataSet.fromJson(json);
  }


  static Future<DataSet?> getByIdAndLength(int id, int length) async{
    if (_userSheet == null ) return null;

    final json = await _userSheet!.values.map.rowByKey(id,fromColumn: 1);
    return json==null ? null :  DataSet.fromJson(json);
  }

  static Future insert(List<Map<String, dynamic>> rowList) async{
    try {
      if (_userSheet == null ) return ;
    _userSheet!.values.map.appendRows(rowList);
    }catch (error ){
      print(error);
    }
  }

  //--------------------SEND----------------------------
  static Future <DataSendSet?> getLastRowSend() async{
    if (_sendSheet == null ) return null;

    final json = await _sendSheet!.values.map.lastRow();
    return json == null ? null :  DataSendSet.fromJson(json);
  }

  static Future insertSend(List<Map<String, dynamic>> rowList) async{
    if (_sendSheet == null ) return ;
    _sendSheet!.values.map.appendRows(rowList);
  }
}