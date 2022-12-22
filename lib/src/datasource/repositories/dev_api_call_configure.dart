class DevApiCallConfigure {
  DevApiCallConfigure({
    this.isRqstShowCurlInfo = true,

    this.isRspShowRequestInfo = false,
    this.isRspShowMessageInfo = false,
    this.isRspShowStatusInfo = false,
    this.isRspShowHeadersInfo = false,
    this.isRspShowBodyInfo = true,

    this.isErShowRequestInfo = false,
    this.isErShowMessageInfo = true,
    this.isErShowStatusInfo = true,
    this.isErShowHeadersInfo = true,
    this.isErShowBodyInfo = true,
  });

  bool isRqstShowCurlInfo;

  bool isRspShowRequestInfo;
  bool isRspShowMessageInfo;
  bool isRspShowStatusInfo;
  bool isRspShowHeadersInfo;
  bool isRspShowBodyInfo;

  bool isErShowRequestInfo;
  bool isErShowMessageInfo;
  bool isErShowStatusInfo;
  bool isErShowHeadersInfo;
  bool isErShowBodyInfo;

  Map<String, dynamic> toJson() {
    return {
      'is_rqst_show_curl_info': isRqstShowCurlInfo,
      'is_rsp_show_message_info': isRspShowMessageInfo,
      'is_rsp_show_status_info': isRspShowStatusInfo,
      'is_rsp_show_headers_info': isRspShowHeadersInfo,
      'is_rsp_show_body_info': isRspShowBodyInfo,
      'is_rsp_show_request_info': isRspShowRequestInfo,
      'is_er_show_message_info': isErShowMessageInfo,
      'is_er_show_status_info': isErShowStatusInfo,
      'is_er_show_headers_info': isErShowHeadersInfo,
      'is_er_show_body_info': isErShowBodyInfo,
      'is_er_show_request_info': isErShowRequestInfo,
    };
  }

  factory DevApiCallConfigure.fromJson(Map<String, dynamic> map) {
    return DevApiCallConfigure(
      isRqstShowCurlInfo: map['is_rqst_show_curl_info'] as bool,
      isRspShowMessageInfo: map['is_rsp_show_message_info'] as bool,
      isRspShowStatusInfo: map['is_rsp_show_status_info'] as bool,
      isRspShowHeadersInfo: map['is_rsp_show_headers_info'] as bool,
      isRspShowBodyInfo: map['is_rsp_show_body_info'] as bool,
      isRspShowRequestInfo: map['is_rsp_show_request_info'] as bool,
      isErShowMessageInfo: map['is_er_show_message_info'] as bool,
      isErShowStatusInfo: map['is_er_show_status_info'] as bool,
      isErShowHeadersInfo: map['is_er_show_headers_info'] as bool,
      isErShowBodyInfo: map['is_er_show_body_info'] as bool,
      isErShowRequestInfo: map['is_er_show_request_info'] as bool,
    );
  }

  DevApiCallConfigure copyWith({
    bool? isRqstShowCurlInfo,
    bool? isRspShowMessageInfo,
    bool? isRspShowStatusInfo,
    bool? isRspShowHeadersInfo,
    bool? isRspShowBodyInfo,
    bool? isRspShowRequestInfo,
    bool? isErShowMessageInfo,
    bool? isErShowStatusInfo,
    bool? isErShowHeadersInfo,
    bool? isErShowBodyInfo,
    bool? isErShowRequestInfo,
  }) {
    return DevApiCallConfigure(
      isRqstShowCurlInfo: isRqstShowCurlInfo ?? this.isRqstShowCurlInfo,
      isRspShowMessageInfo: isRspShowMessageInfo ?? this.isRspShowMessageInfo,
      isRspShowStatusInfo: isRspShowStatusInfo ?? this.isRspShowStatusInfo,
      isRspShowHeadersInfo: isRspShowHeadersInfo ?? this.isRspShowHeadersInfo,
      isRspShowBodyInfo: isRspShowBodyInfo ?? this.isRspShowBodyInfo,
      isRspShowRequestInfo: isRspShowRequestInfo ?? this.isRspShowRequestInfo,
      isErShowMessageInfo: isErShowMessageInfo ?? this.isErShowMessageInfo,
      isErShowStatusInfo: isErShowStatusInfo ?? this.isErShowStatusInfo,
      isErShowHeadersInfo: isErShowHeadersInfo ?? this.isErShowHeadersInfo,
      isErShowBodyInfo: isErShowBodyInfo ?? this.isErShowBodyInfo,
      isErShowRequestInfo: isErShowRequestInfo ?? this.isErShowRequestInfo,
    );
  }
}
