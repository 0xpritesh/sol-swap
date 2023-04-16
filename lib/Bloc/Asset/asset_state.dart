part of 'asset_bloc.dart';

@immutable
abstract class AssetState {}

class AssetInitial extends AssetState {}



class AssetMarketLoading extends AssetState {}

class AssetMarketSuccess extends AssetState {
  final AssetPriceResponse model;
  AssetMarketSuccess({required this.model});
}

class AllAssetsLoading extends AssetState {}

class AllAssetsSuccess extends AssetState {
  final AllAssets model;
  AllAssetsSuccess({required this.model});
}


class requestAirdropLoading extends AssetState {}

class RequestAirdropSuccess extends AssetState {
  final AirDropResponse model;
  RequestAirdropSuccess({required this.model});
}