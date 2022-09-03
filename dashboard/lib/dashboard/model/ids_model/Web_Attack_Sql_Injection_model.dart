class WebAttackSqlInjectionModel {
  String? initWinBytesBackward;
  String? destinationPort;
  String? bwdPacketLengthStd;
  String? avgFwdSegmentSize;
  String? flowBytesS;
  String? initWinBytesForward;
  String? bwdIATMin;
  String? flowIATMean;
  String? bwdPacketsS;
  String? flowPacketsS;
  String? webAttackSqlInjectionLogic;
  String? webAttackSqlInjectionProbLogic;
  String? webAttackSqlInjectionNn;
  String? webAttackSqlInjectionProbNn;
  String? webAttackSqlInjectionSgd;
  String? webAttackSqlInjectionXgb;
  double? webAttackSqlInjectionProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  WebAttackSqlInjectionModel(
      {this.initWinBytesBackward,
      this.destinationPort,
      this.bwdPacketLengthStd,
      this.avgFwdSegmentSize,
      this.flowBytesS,
      this.initWinBytesForward,
      this.bwdIATMin,
      this.flowIATMean,
      this.bwdPacketsS,
      this.flowPacketsS,
      this.webAttackSqlInjectionLogic,
      this.webAttackSqlInjectionProbLogic,
      this.webAttackSqlInjectionNn,
      this.webAttackSqlInjectionProbNn,
      this.webAttackSqlInjectionSgd,
      this.webAttackSqlInjectionXgb,
      this.webAttackSqlInjectionProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  WebAttackSqlInjectionModel.fromJson(Map<String, dynamic> json) {
    initWinBytesBackward = json[' Init_Win_bytes_backward'];
    destinationPort = json[' Destination Port'];
    bwdPacketLengthStd = json[' Bwd Packet Length Std'];
    avgFwdSegmentSize = json[' Avg Fwd Segment Size'];
    flowBytesS = json['Flow Bytes/s'];
    initWinBytesForward = json['Init_Win_bytes_forward'];
    bwdIATMin = json[' Bwd IAT Min'];
    flowIATMean = json[' Flow IAT Mean'];
    bwdPacketsS = json[' Bwd Packets/s'];
    flowPacketsS = json[' Flow Packets/s'];
    webAttackSqlInjectionLogic = json['Web_Attack_Sql_Injection_logic'];
    webAttackSqlInjectionProbLogic =
        json['Web_Attack_Sql_Injection_prob_logic'];
    webAttackSqlInjectionNn = json['Web_Attack_Sql_Injection_nn'];
    webAttackSqlInjectionProbNn = json['Web_Attack_Sql_Injection_prob_nn'];
    webAttackSqlInjectionSgd = json['Web_Attack_Sql_Injection_sgd'];
    webAttackSqlInjectionXgb = json['Web_Attack_Sql_Injection_xgb'];
    webAttackSqlInjectionProbXgb = double.parse(json['Web_Attack_Sql_Injection_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Init_Win_bytes_backward'] = initWinBytesBackward;
    data[' Destination Port'] = destinationPort;
    data[' Bwd Packet Length Std'] = bwdPacketLengthStd;
    data[' Avg Fwd Segment Size'] = avgFwdSegmentSize;
    data['Flow Bytes/s'] = flowBytesS;
    data['Init_Win_bytes_forward'] = initWinBytesForward;
    data[' Bwd IAT Min'] = bwdIATMin;
    data[' Flow IAT Mean'] = flowIATMean;
    data[' Bwd Packets/s'] = bwdPacketsS;
    data[' Flow Packets/s'] = flowPacketsS;
    data['Web_Attack_Sql_Injection_logic'] = webAttackSqlInjectionLogic;
    data['Web_Attack_Sql_Injection_prob_logic'] =
        webAttackSqlInjectionProbLogic;
    data['Web_Attack_Sql_Injection_nn'] = webAttackSqlInjectionNn;
    data['Web_Attack_Sql_Injection_prob_nn'] = webAttackSqlInjectionProbNn;
    data['Web_Attack_Sql_Injection_sgd'] = webAttackSqlInjectionSgd;
    data['Web_Attack_Sql_Injection_xgb'] = webAttackSqlInjectionXgb;
    data['Web_Attack_Sql_Injection_prob_xgb'] = webAttackSqlInjectionProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
