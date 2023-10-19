import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  final inputC = TextEditingController();
  final resultC = TextEditingController();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
// TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
//打印当前状态
    print("object");
    getClipboardContents();
  }

  getClipboardContents() async {
    ///使用异步调用获取返回值
    var clipboardData = await Clipboard.getData(Clipboard.kTextPlain);

    var text = clipboardData?.text ?? "";
    if (text.isEmpty) {
      return;
    }
    ClipboardData data = ClipboardData(text: "");
    Clipboard.setData(data);
    print(text);
   parseText(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("123"),
      ),
      body: Column(
        children: [
          if (kIsWeb)
            TextField(
              controller: inputC,
              maxLines: 3,
              onChanged: (text) {
                if (text.isEmpty) {
                  return;
                }
                parseText(text);
              },
            ),
          TextField(
            controller: resultC,
            maxLines: 3,
          ),
        ],
      ),
    );
  }


  parseText(String text) {
    try {
      var we = Welcome.fromJson(json.decode(text));

      resultC.text = "";

      for (int i = 0; i < we.data.length; i++) {
        var que = we.data[i];
        if (i == 5) {
          resultC.text = "${resultC.text}\n";
        }
        resultC.text = "${resultC.text}   ${que.getAns()}";
      }
      inputC.text = "";
    } catch (e) {
      resultC.text = "";
      inputC.text = "";
    }
  }
}

class Welcome {
  bool flag;
  int code;
  String message;
  List<Datum> data;

  Welcome({
    required this.flag,
    required this.code,
    required this.message,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        flag: json["flag"],
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String pkId;
  int questionBankType;
  String? questionBankBindCar;
  String questionDescribe;
  int answerDuration;
  dynamic questionAnswer;
  String questionAnswerEncrypt;
  dynamic questionImages;
  int questionType;
  int questionSort;
  List<QuestionOption> questionOptions;
  dynamic createTime;

  Datum({
    required this.pkId,
    required this.questionBankType,
    required this.questionBankBindCar,
    required this.questionDescribe,
    required this.answerDuration,
    required this.questionAnswer,
    required this.questionAnswerEncrypt,
    required this.questionImages,
    required this.questionType,
    required this.questionSort,
    required this.questionOptions,
    required this.createTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        pkId: json["pkId"],
        questionBankType: json["questionBankType"],
        questionBankBindCar: json["questionBankBindCar"],
        questionDescribe: json["questionDescribe"],
        answerDuration: json["answerDuration"],
        questionAnswer: json["questionAnswer"],
        questionAnswerEncrypt: json["questionAnswerEncrypt"],
        questionImages: json["questionImages"],
        questionType: json["questionType"],
        questionSort: json["questionSort"],
        questionOptions: List<QuestionOption>.from(
            json["questionOptions"].map((x) => QuestionOption.fromJson(x))),
        createTime: json["createTime"],
      );

  Map<String, dynamic> toJson() => {
        "pkId": pkId,
        "questionBankType": questionBankType,
        "questionBankBindCar": questionBankBindCar,
        "questionDescribe": questionDescribe,
        "answerDuration": answerDuration,
        "questionAnswer": questionAnswer,
        "questionAnswerEncrypt": questionAnswerEncrypt,
        "questionImages": questionImages,
        "questionType": questionType,
        "questionSort": questionSort,
        "questionOptions":
            List<dynamic>.from(questionOptions.map((x) => x.toJson())),
        "createTime": createTime,
      };

  String getAns() {
    var dic = {
      "pu8r2bsDEtGCz+dbJawT4g==": "A",
      "89eOp9L4QGL4bcE1T6/7iw==": "B",
      "UGTMS0yqbk2tIoKuf6SnJA==": "C",
      "kkr/9eWn+dNI+SRM8561ag==": "D",
      "euSYMNLldEx714nuqOA7sQ==": "AB",
      "LKU5hTv1fns+wFpSs5ACnQ==": "AC",
      "PgIiw4/3WdqfPEEIOv8drw==": "AD",
      "MicENlH+kx1ULI+KNRLMVA==": "BC",
      "vSLXLduuzPRrTepNjeHgtg==": "BD",
      "1qvFoAu2e410whqLj8zmkw==":"CD",
      "a1CtBeOUyORadJbIt311KQ==": "ABC",
      "LMydc3z5cjf7jUzwgskpYA==": "ABD",
      "PysETy2COW8WxD8kbqyq+g==": "ACD",
      "wHQmfdli3dAXvPNVJHK0Mw==": "BCD",
      "/pRw2pc1Ifx4AIWmglSBfQ==": "ABCD",
    };

    return dic[questionAnswerEncrypt] ?? "异常";
  }
}

class QuestionOption {
  OptionKey optionKey;
  String optionValue;

  QuestionOption({
    required this.optionKey,
    required this.optionValue,
  });

  factory QuestionOption.fromJson(Map<String, dynamic> json) => QuestionOption(
        optionKey: optionKeyValues.map[json["optionKey"]]!,
        optionValue: json["optionValue"],
      );

  Map<String, dynamic> toJson() => {
        "optionKey": optionKeyValues.reverse[optionKey],
        "optionValue": optionValue,
      };
}

enum OptionKey { A, B, C, D }

final optionKeyValues = EnumValues(
    {"A": OptionKey.A, "B": OptionKey.B, "C": OptionKey.C, "D": OptionKey.D});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
