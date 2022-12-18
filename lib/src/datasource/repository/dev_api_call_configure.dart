/// is_rqst_show_curl_info : true
/// is_rsp_show_headers_info : true
/// is_rsp_show_body_info : true
/// is_rsp_show_request_info : true
/// is_er_show_headers_info : true
/// is_er_show_body_info : true
/// is_er_show_request_info : true

class DevApiCallConfigure {
  DevApiCallConfigure({
    this.isRqstShowCurlInfo = true,
    this.isRspShowHeadersInfo = true,
    this.isRspShowBodyInfo = true,
    this.isRspShowRequestInfo = true,
    this.isErShowHeadersInfo = true,
    this.isErShowBodyInfo = true,
    this.isErShowRequestInfo = true,
  });

  DevApiCallConfigure.fromJson(dynamic json) {
    isRqstShowCurlInfo = json['is_rqst_show_curl_info'] ?? true;
    isRspShowHeadersInfo = json['is_rsp_show_headers_info'] ?? true;
    isRspShowBodyInfo = json['is_rsp_show_body_info'] ?? true;
    isRspShowRequestInfo = json['is_rsp_show_request_info'] ?? true;
    isErShowHeadersInfo = json['is_er_show_headers_info'] ?? true;
    isErShowBodyInfo = json['is_er_show_body_info'] ?? true;
    isErShowRequestInfo = json['is_er_show_request_info'] ?? true;
  }
  bool isRqstShowCurlInfo = true;
  bool isRspShowHeadersInfo = true;
  bool isRspShowBodyInfo = true;
  bool isRspShowRequestInfo = true;
  bool isErShowHeadersInfo = true;
  bool isErShowBodyInfo = true;
  bool isErShowRequestInfo = true;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_rqst_show_curl_info'] = isRqstShowCurlInfo;
    map['is_rsp_show_headers_info'] = isRspShowHeadersInfo;
    map['is_rsp_show_body_info'] = isRspShowBodyInfo;
    map['is_rsp_show_request_info'] = isRspShowRequestInfo;
    map['is_er_show_headers_info'] = isErShowHeadersInfo;
    map['is_er_show_body_info'] = isErShowBodyInfo;
    map['is_er_show_request_info'] = isErShowRequestInfo;
    return map;
  }
}
