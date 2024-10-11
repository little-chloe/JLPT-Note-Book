import 'package:note_book_app/data/models/word_model.dart';

abstract class WordDatasource {
  Future<List<WordModel>> getAllWordsByLevelId({
    required String levelId,
    required int pageSize,
    required int pageNumber,
  });

  Future<List<WordModel>> getAllWordsByLevelIdAndLessonId({
    required String lessonId,
    required String levelId,
    required int pageSize,
    required int pageNumber,
  });

  Future<WordModel> createWordByLevelIdAndLessonId({
    required String levelId,
    required String lessonId,
    required String word,
    required String meaning,
    required String kanjiForm,
  });

  Future<WordModel> updateWordById({
    required String id,
    required String word,
    required String meaning,
    required String kanjiForm,
  });

  Future<WordModel> deleteWordById({required String id});

  Future<int> deleteWordByLevelId({required String levelId});

  Future<int> deleteWordByLessonId({required String lessonId});
}
