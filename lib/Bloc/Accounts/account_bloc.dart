import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:Sol_Swap/models/balance_response.dart';
import 'package:Sol_Swap/models/largest_account_response.dart';
import 'package:Sol_Swap/models/total_supply_response.dart';
import 'package:Sol_Swap/repository/account_repo.dart';
import 'package:meta/meta.dart';
part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountRepo accountRepo;
  AccountBloc({required this.accountRepo}) : super(AccountInitial()) {
    on<AccountEvent>((event, emit) async {
      if (event is getBalanceEvent) {
        emit.call(balanceLoading());
        try {
          final BalanceResponse model =
              await accountRepo.getBalance(pubKey: event.pubkey);
          emit.call(balanceSuccess(model: model));
        } catch (e) {
          log(e.toString());
        }
      } else if (event is getLargestAccountEvent) {
        emit.call(LargestAccuntLoading());
        try {
          final largetsAccountResponse model =
              await accountRepo.getLargestAccount();
          emit.call(LargestAccountSuccess(model: model));
        } catch (e) {
          log(e.toString());
        }
      } else if (event is TotalSupplyEvent) {
        emit.call(totalSupplyLoading());
        try {
          final TotalSupplyResponse model = await accountRepo.getTotalSupply();
          emit.call(TotalSupplySuccess(model: model));
        } catch (e) {
          log(e.toString());
        }
      } 
    });
  }
}
