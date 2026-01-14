enum RequestStatus {
  initial,
  loading,
  loadingMore,
  success,
  error,
  refreshing,
}

extension BoolRequestStatus on RequestStatus {
  bool get isInitial => this == RequestStatus.initial;
  bool get isLoading => this == RequestStatus.loading;
  bool get isLoadingMore => this == RequestStatus.loadingMore;
  bool get isSuccess => this == RequestStatus.success;
  bool get isError => this == RequestStatus.error;
  bool get isRefreshing => this == RequestStatus.refreshing;
}