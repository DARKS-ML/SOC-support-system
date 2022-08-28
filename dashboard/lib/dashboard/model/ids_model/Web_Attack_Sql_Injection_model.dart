class WebAttackSqlInjectionModel {
  String? initWinBytesBackward;
  String? destinationPort;
  String? flowBytesS;
  String? fwdPacketLengthStd;
  String? flowDuration;
  String? bwdPacketLengthStd;
  String? initWinBytesForward;
  String? fwdPacketLengthMax;
  String? avgFwdSegmentSize;
  String? bwdIATMin;
  String? webAttackSqlInjection;
  String? webAttackSqlInjectionProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  WebAttackSqlInjectionModel(
      {this.initWinBytesBackward,
      this.destinationPort,
      this.flowBytesS,
      this.fwdPacketLengthStd,
      this.flowDuration,
      this.bwdPacketLengthStd,
      this.initWinBytesForward,
      this.fwdPacketLengthMax,
      this.avgFwdSegmentSize,
      this.bwdIATMin,
      this.webAttackSqlInjection,
      this.webAttackSqlInjectionProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  WebAttackSqlInjectionModel.fromJson(Map<String, dynamic> json) {
    initWinBytesBackward = json[' Init_Win_bytes_backward'];
    destinationPort = json[' Destination Port'];
    flowBytesS = json['Flow Bytes/s'];
    fwdPacketLengthStd = json[' Fwd Packet Length Std'];
    flowDuration = json[' Flow Duration'];
    bwdPacketLengthStd = json[' Bwd Packet Length Std'];
    initWinBytesForward = json['Init_Win_bytes_forward'];
    fwdPacketLengthMax = json[' Fwd Packet Length Max'];
    avgFwdSegmentSize = json[' Avg Fwd Segment Size'];
    bwdIATMin = json[' Bwd IAT Min'];
    webAttackSqlInjection = json['Web_Attack_Sql_Injection'];
    webAttackSqlInjectionProb = json['Web_Attack_Sql_Injection_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Init_Win_bytes_backward'] = initWinBytesBackward;
    data[' Destination Port'] = destinationPort;
    data['Flow Bytes/s'] = flowBytesS;
    data[' Fwd Packet Length Std'] = fwdPacketLengthStd;
    data[' Flow Duration'] = flowDuration;
    data[' Bwd Packet Length Std'] = bwdPacketLengthStd;
    data['Init_Win_bytes_forward'] = initWinBytesForward;
    data[' Fwd Packet Length Max'] = fwdPacketLengthMax;
    data[' Avg Fwd Segment Size'] = avgFwdSegmentSize;
    data[' Bwd IAT Min'] = bwdIATMin;
    data['Web_Attack_Sql_Injection'] = webAttackSqlInjection;
    data['Web_Attack_Sql_Injection_prob'] = webAttackSqlInjectionProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
