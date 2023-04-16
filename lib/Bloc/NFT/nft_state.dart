part of 'nft_bloc.dart';

@immutable
abstract class NftState {}

class NftInitial extends NftState {}

class NFTLoading extends NftState {}

class NFTSuccess extends NftState {
  final NFT_response model;
  NFTSuccess({required this.model});
}

class ClaimLoading extends NftState {}

class ClaimSuccess extends NftState {
  final claim_model model;
  ClaimSuccess({required this.model});
}