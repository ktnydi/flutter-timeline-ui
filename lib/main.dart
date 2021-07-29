import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timeline_ui/date_time.dart';

void main() {
  runApp(MyApp());
}

class Diary {
  final String body;
  final String? url;
  final DateTime createdAt;

  Diary({
    required this.body,
    required this.url,
    required this.createdAt,
  });
}

final data = [
  Diary(
    body: '今日はクロスバイクに乗って伊丹空港までサイクリングに行った。平日だったからか展望デッキには人が少なかった。',
    url:
        'https://images.unsplash.com/photo-1606240724602-5b21f896eae8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1601&q=80',
    createdAt: DateTime.parse('2021-06-21 09:41'),
  ),
  Diary(
    body: 'プログラミング日和だーーー',
    url: null,
    createdAt: DateTime.parse('2021-07-04 15:12'),
  ),
  Diary(
    body: '家の近所にできた新しいショッピングモールにお買い物',
    url: null,
    createdAt: DateTime.parse('2021-07-19 10:33'),
  ),
  Diary(
    body: 'ゲリラ豪雨発生中',
    url:
        'https://images.unsplash.com/photo-1513172128806-2d00531a9f20?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
    createdAt: DateTime.parse('2021-07-19 15:54'),
  ),
]..sort((i, j) => j.createdAt.compareTo(i.createdAt));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF4F5F7),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Theme.of(context).textTheme.bodyText2!.color,
              fontSize: 20,
            ),
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('Timeline'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) {
          return TimelineTile(index);
        },
        itemCount: data.length,
      ),
    );
  }
}

class TimelineTile extends StatelessWidget {
  TimelineTile(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    final current = data[index].createdAt;
    bool isNewMonth = true;

    if (index != 0) {
      final pre = data[index - 1].createdAt;
      isNewMonth = current.month != pre.month;
    }
    bool isEndMonth = false;
    if (index != data.length - 1) {
      final next = data[index + 1].createdAt;
      isEndMonth = current.month != next.month;
    }
    bool isSameDay = false;
    if (index != 0) {
      final pre = data[index - 1].createdAt;
      isSameDay = current.day == pre.day;
    }

    return Container(
      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isNewMonth)
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${data[index].createdAt.year} - ${data[index].createdAt.month}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    flex: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 32,
                          alignment: Alignment.center,
                          child: !isSameDay
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${data[index].createdAt.day}',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false,
                                          applyHeightToLastDescent: false,
                                        ),
                                      ),
                                      Text(
                                        '${data[index].createdAt.weekdayName}',
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ),
                        Expanded(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 8,
                            ),
                            child: Container(
                              width: 4,
                              decoration: BoxDecoration(
                                color: index == data.length - 1 || isEndMonth
                                    ? Colors.transparent
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  /// 日記の内容
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data[index].url != null)
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.network(
                                  data[index].url!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${data[index].body}'),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${data[index].createdAt.hour}:${data[index].createdAt.minute}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
