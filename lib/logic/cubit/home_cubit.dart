import 'package:bilheteria_panucci/models/movie.dart';
import 'package:bilheteria_panucci/services/movies_api.dart';
import 'package:bloc/bloc.dart';

// lógica de gerenciamento de estados da tela
part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
// todo bloc precisa de um estado inicial. por isso o HomeState no super
  HomeCubit() : super(HomeInitial());
  final HomeService homeService = HomeService();

  Future<void> getMovies() async {
    emit(HomeLoading());

    try {
      final movies = await homeService.fetchMovies();

      emit(HomeSuccess(movies));
    } catch (e) {
      emit(HomeError('Um error aconteceu, tente atualizar o app'));
    }
  }

  Future<void> getMoviesByGenre(String genre) async {
    emit(HomeLoading());

    try {
      final moviesbyGenre = await homeService.fetchMoviesByGenre(genre);
      emit(HomeSuccess(moviesbyGenre));
    } catch (e) {
      emit(HomeError('Ocorreu um erro ao tentar filtrar,tente novamente'));
    }
  }
}
