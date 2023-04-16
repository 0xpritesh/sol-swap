
import 'package:Sol_Swap/models/claim_model.dart';
import 'package:Sol_Swap/models/nft.dart';
import 'package:Sol_Swap/repository/nft_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nft_event.dart';
part 'nft_state.dart';

class NftBloc extends Bloc<NftEvent, NftState> {
  NftBloc() : super(NftInitial()) {
    on<NftEvent>((event, emit) async {
      if (event is GetNFTEvent) {
        emit.call(NFTLoading());
        try {
          final NFT_response data =
              await getNFT(contractAddress: event.NFTAddress);
          emit.call(NFTSuccess(model: data));
        } catch (e) {
          print(e);
        }
      } else if (event is GetClaimEvent) {
        emit.call(ClaimLoading());
        try {
          final claim_model data =
              await claimNFT(walletAddress: event.walletAddress);
          emit.call(ClaimSuccess(model: data));
        } catch (e) {
          print(e);
        }
      }
    });
  }
}