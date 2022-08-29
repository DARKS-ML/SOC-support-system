class WebAttackXSSbenignModel {
  String? fwdIATMin;
  String? fwdPacketLengthMean;
  String? flowBytesS;
  String? maxPacketLength;
  String? totalLengthOfFwdPackets;
  String? fwdIATStd;
  String? averagePacketSize;
  String? avgFwdSegmentSize;
  String? flowIATMean;
  String? flowPacketsS;
  String? webAttackXSSBenign;
  String? webAttackXSSBenignProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  WebAttackXSSbenignModel(
      {this.fwdIATMin,
      this.fwdPacketLengthMean,
      this.flowBytesS,
      this.maxPacketLength,
      this.totalLengthOfFwdPackets,
      this.fwdIATStd,
      this.averagePacketSize,
      this.avgFwdSegmentSize,
      this.flowIATMean,
      this.flowPacketsS,
      this.webAttackXSSBenign,
      this.webAttackXSSBenignProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  WebAttackXSSbenignModel.fromJson(Map<String, dynamic> json) {
    fwdIATMin = json[' Fwd IAT Min'];
    fwdPacketLengthMean = json[' Fwd Packet Length Mean'];
    flowBytesS = json['Flow Bytes/s'];
    maxPacketLength = json[' Max Packet Length'];
    totalLengthOfFwdPackets = json['Total Length of Fwd Packets'];
    fwdIATStd = json[' Fwd IAT Std'];
    averagePacketSize = json[' Average Packet Size'];
    avgFwdSegmentSize = json[' Avg Fwd Segment Size'];
    flowIATMean = json[' Flow IAT Mean'];
    flowPacketsS = json[' Flow Packets/s'];
    webAttackXSSBenign = json['Web_Attack_XSS_benign'];
    webAttackXSSBenignProb = json['Web_Attack_XSS_benign_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Fwd IAT Min'] = fwdIATMin;
    data[' Fwd Packet Length Mean'] = fwdPacketLengthMean;
    data['Flow Bytes/s'] = flowBytesS;
    data[' Max Packet Length'] = maxPacketLength;
    data['Total Length of Fwd Packets'] = totalLengthOfFwdPackets;
    data[' Fwd IAT Std'] = fwdIATStd;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Avg Fwd Segment Size'] = avgFwdSegmentSize;
    data[' Flow IAT Mean'] = flowIATMean;
    data[' Flow Packets/s'] = flowPacketsS;
    data['Web_Attack_XSS_benign'] = webAttackXSSBenign;
    data['Web_Attack_XSS_benign_prob'] = webAttackXSSBenignProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
