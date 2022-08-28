class WebAttackModel {
  String? fwdIATMin;
  String? initWinBytesBackward;
  String? packetLengthMean;
  String? flowBytesS;
  String? fwdPacketLengthMean;
  String? initWinBytesForward;
  String? avgFwdSegmentSize;
  String? fwdHeaderLength;
  String? subflowFwdBytes;
  String? maxPacketLength;
  String? dfWebAttack;
  String? dfWebAttackProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  WebAttackModel(
      {this.fwdIATMin,
      this.initWinBytesBackward,
      this.packetLengthMean,
      this.flowBytesS,
      this.fwdPacketLengthMean,
      this.initWinBytesForward,
      this.avgFwdSegmentSize,
      this.fwdHeaderLength,
      this.subflowFwdBytes,
      this.maxPacketLength,
      this.dfWebAttack,
      this.dfWebAttackProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  WebAttackModel.fromJson(Map<String, dynamic> json) {
    fwdIATMin = json[' Fwd IAT Min'];
    initWinBytesBackward = json[' Init_Win_bytes_backward'];
    packetLengthMean = json[' Packet Length Mean'];
    flowBytesS = json['Flow Bytes/s'];
    fwdPacketLengthMean = json[' Fwd Packet Length Mean'];
    initWinBytesForward = json['Init_Win_bytes_forward'];
    avgFwdSegmentSize = json[' Avg Fwd Segment Size'];
    fwdHeaderLength = json[' Fwd Header Length'];
    subflowFwdBytes = json[' Subflow Fwd Bytes'];
    maxPacketLength = json[' Max Packet Length'];
    dfWebAttack = json['df_Web_Attack'];
    dfWebAttackProb = json['df_Web_Attack_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Fwd IAT Min'] = fwdIATMin;
    data[' Init_Win_bytes_backward'] = initWinBytesBackward;
    data[' Packet Length Mean'] = packetLengthMean;
    data['Flow Bytes/s'] = flowBytesS;
    data[' Fwd Packet Length Mean'] = fwdPacketLengthMean;
    data['Init_Win_bytes_forward'] = initWinBytesForward;
    data[' Avg Fwd Segment Size'] = avgFwdSegmentSize;
    data[' Fwd Header Length'] = fwdHeaderLength;
    data[' Subflow Fwd Bytes'] = subflowFwdBytes;
    data[' Max Packet Length'] = maxPacketLength;
    data['df_Web_Attack'] = dfWebAttack;
    data['df_Web_Attack_prob'] = dfWebAttackProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
