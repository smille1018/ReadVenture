/// File: attendance_service.dart
/// Purpose: 사용자의 출석 상태를 Firestore에 등록 및 업데이트하는 서비스 함수 제공
/// Author: 박민준
/// Created: 2025-02-03
/// Last Modified: 2025-02-03 by 박민준

import 'package:cloud_firestore/cloud_firestore.dart';

/// 오늘 날짜에 해당하는 출석 기록을 Firestore에 등록/업데이트하는 함수
Future<void> markTodayAttendanceAsChecked(String userId) async {
  final now = DateTime.now();
  // 연도, 월, 일을 포함한 문자열 (예: "2025-2-3")
  final dateStr = "${now.year}-${now.month}-${now.day}";

  final attendanceRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('attendance')
      .doc(dateStr);

  final docSnapshot = await attendanceRef.get();

  if (!docSnapshot.exists) {
    await attendanceRef.set({
      'date': dateStr,
      'timestamp': Timestamp.fromDate(now), // 타임스탬프 필드 추가
      'status': 'completed',
      'xp': 10,
    });
  } else {
    final data = docSnapshot.data();
    if (data != null && data['status'] != 'completed') {
      await attendanceRef.update({
        'status': 'completed',
      });
    }
  }
}

