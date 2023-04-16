import 'dart:developer';
import 'package:Sol_Swap/models/air_drop_response.dart';
import 'package:Sol_Swap/models/all_assets.dart';
import 'package:Sol_Swap/models/asset_chart.dart';
import 'package:Sol_Swap/repository/account_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  AccountRepo assetRepo;
  AssetBloc({required this.assetRepo}) : super(AssetInitial()) {
    on<AssetEvent>((event, emit) async {
      if (event is getAssetMarketEvent) {
        emit.call(AssetMarketLoading());
        try {
          final AssetPriceResponse model =
              await assetRepo.getChart(coinName: event.coinname);
          emit.call(AssetMarketSuccess(model: model));
        } catch (e) {
          print(e);
        }
      } else if (event is GetAllAssets) {
        emit.call(AllAssetsLoading());
        try {
          final AllAssets model = await assetRepo.getAllAssets();
          emit.call(AllAssetsSuccess(model: model));
        } catch (e) {}
      } else if (event is RequestAirDropEvent) {
        emit.call(requestAirdropLoading());
        try {
          final AirDropResponse model =
              await assetRepo.requestAirDrop(pubKey: event.pubKey);
          emit.call(RequestAirdropSuccess(model: model));
        } catch (e) {
          log(e.toString());
        }
      }
    });
  }
}
