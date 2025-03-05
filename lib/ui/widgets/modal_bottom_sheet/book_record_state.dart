import 'package:flutter/material.dart';

import 'doing_record_state_tab.dart';
import 'done_record_state_tab.dart';
import 'stop_record_state_tab.dart';
import 'wish_record_state_tab.dart';

class BookRecordState extends StatefulWidget {
  int index;
  String bookId;
  String bookTitle;
  int bookPage;

  BookRecordState({
    required this.bookId,
    required this.bookTitle,
    required this.bookPage,
    required this.index,
  });

  @override
  _BookRecordStateState createState() => _BookRecordStateState();
}

class _BookRecordStateState extends State<BookRecordState>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: widget.index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min, // 최소 크기로 설정
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300], // 비활성화 탭의 기본 배경색
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          // padding: const EdgeInsets.all(4),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: !isDarkMode ? Colors.white : Colors.black87, // 선택된 탭의 배경색
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            // 인디케이터 크기 조정
            // indicatorPadding:
            //     EdgeInsets.symmetric(horizontal: 8, vertical: 4), // 인디케이터 여백 설정
            labelColor:
                !isDarkMode ? const Color(0xFF4D77B2) : Colors.grey[400],
            // 선택된 탭 텍스트 색상
            unselectedLabelColor: Colors.black38,
            // 비활성화된 탭 텍스트 색상
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: '끝맺은 책'),
              Tab(text: '여정 중인 책'),
              Tab(text: '기다리는 책'),
              Tab(text: '잠든 책'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: DoneRecordStateTab(bookId: widget.bookId),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: DoingRecordStateTab(
                  bookId: widget.bookId,
                  bookPage: widget.bookPage,
                  bookTitle: widget.bookTitle,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: WishRecordStateTab(
                  bookId: widget.bookId,
                  bookPage: widget.bookPage,
                  bookTitle: widget.bookTitle,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: StopRecordStateTab(
                    bookId: widget.bookId, bookPage: widget.bookPage),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
