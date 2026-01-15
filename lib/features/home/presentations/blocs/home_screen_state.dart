part of 'home_screen_cubit.dart';

class HomeScreenState extends Equatable {
  final List<Journal> journals;
  final Journal? todayJournal;
  final Journal? yesterdayJournal;

  const HomeScreenState({
    required this.journals,
    required this.todayJournal,
    required this.yesterdayJournal,
  });

  @override
  List<Object?> get props => [journals, todayJournal, yesterdayJournal];
}
