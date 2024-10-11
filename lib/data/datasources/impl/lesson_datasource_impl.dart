import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_book_app/core/failures/firestore_failure.dart';
import 'package:note_book_app/data/datasources/lesson_datasource.dart';
import 'package:note_book_app/data/models/lesson_model.dart';

class LessonDatasourceImpl implements LessonDatasource {
  final FirebaseFirestore firebaseFirestore;

  const LessonDatasourceImpl({required this.firebaseFirestore});

  @override
  Future<List<LessonModel>> getAllLessonsByLevelId(
      {required String levelId}) async {
    try {
      final queryResult = await firebaseFirestore
          .collection('lessons')
          .where('levelId', isEqualTo: levelId)
          .orderBy('lesson')
          .get();
      final lessons = queryResult.docs
          .map((lesson) => LessonModel.fromJson({
                'id': lesson.id,
                'lesson': lesson.data()['lesson'],
                'createdAt': lesson.data()['createdAt'],
                'levelId': lesson.data()['levelId'],
              }))
          .toList();
      return lessons;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(
          message: "Có lỗi xảy ra khi truy cập bài học theo JLPT");
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<LessonModel> getLessonById({required String id}) async {
    try {
      final lesson =
          await firebaseFirestore.collection('lessons').doc(id).get();
      return LessonModel.fromJson({
        'id': lesson.id,
        'lesson': lesson.data()!['lesson'],
        'createdAt': lesson.data()!['createdAt'],
        'levelId': lesson.data()!['levelId'],
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: "Có lỗi xảy ra khi truy cập bài học");
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<int> deleteLessonsByLevelId({required String levelId}) async {
    try {
      final queryResult = await firebaseFirestore
          .collection('lessons')
          .where('levelId', isEqualTo: levelId)
          .get();
      for (final lesson in queryResult.docs) {
        await lesson.reference.delete();
      }

      return queryResult.docs.length;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(
          message: "Có lỗi xảy ra khi xóa các bài học khi xoá JLPT");
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<LessonModel> createLessonByLevelId(
      {required String levelId, required String lesson}) async {
    try {
      final lessonRef = await firebaseFirestore.collection('lessons').add({
        'lesson': lesson,
        'createdAt': Timestamp.now(),
        'levelId': levelId,
      });
      final lessonDoc = await lessonRef.get();
      return LessonModel.fromJson({
        'id': lessonDoc.id,
        'lesson': lessonDoc.data()!['lesson'],
        'createdAt': lessonDoc.data()!['createdAt'],
        'levelId': lessonDoc.data()!['levelId'],
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: "Có lỗi xảy ra khi tạo bài học");
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<LessonModel> updateLessonById(
      {required String id, required String lesson}) async {
    try {
      await firebaseFirestore.collection('lessons').doc(id).update({
        'lesson': lesson,
      });
      final lessonDoc =
          await firebaseFirestore.collection('lessons').doc(id).get();
      return LessonModel.fromJson({
        'id': lessonDoc.id,
        'lesson': lessonDoc.data()!['lesson'],
        'createdAt': lessonDoc.data()!['createdAt'],
        'levelId': lessonDoc.data()!['levelId'],
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: "Có lỗi xảy ra khi cập nhật bài học");
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<LessonModel> deleteLessonById({required String id}) async {
    try {
      final querySnapShot = firebaseFirestore.collection('lessons').doc(id);
      final lessonDoc = await querySnapShot.get();
      await querySnapShot.delete();
      return LessonModel.fromJson({
        'id': lessonDoc.id,
        'lesson': lessonDoc.data()!['lesson'],
        'createdAt': lessonDoc.data()!['createdAt'],
        'levelId': lessonDoc.data()!['levelId'],
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirestoreFailure(message: "Có lỗi xảy ra khi xóa bài học");
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
