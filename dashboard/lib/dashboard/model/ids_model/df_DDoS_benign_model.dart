class DDoSBenignModel {
  String? bwdPacketLengthMean;
  String? packetLengthVariance;
  String? packetLengthStd;
  String? bwdPacketLengthStd;
  String? avgBwdSegmentSize;
  String? actDataPktFwd;
  String? subflowFwdPackets;
  String? fwdIATStd;
  String? averagePacketSize;
  String? fwdPacketLengthMean;
  String? dfDDoSBenign;
  String? dfDDoSBenignProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  DDoSBenignModel(
      {this.bwdPacketLengthMean,
      this.packetLengthVariance,
      this.packetLengthStd,
      this.bwdPacketLengthStd,
      this.avgBwdSegmentSize,
      this.actDataPktFwd,
      this.subflowFwdPackets,
      this.fwdIATStd,
      this.averagePacketSize,
      this.fwdPacketLengthMean,
      this.dfDDoSBenign,
      this.dfDDoSBenignProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  DDoSBenignModel.fromJson(Map<String, dynamic> json) {
    bwdPacketLengthMean = json[' Bwd Packet Length Mean'];
    packetLengthVariance = json[' Packet Length Variance'];
    packetLengthStd = json[' Packet Length Std'];
    bwdPacketLengthStd = json[' Bwd Packet Length Std'];
    avgBwdSegmentSize = json[' Avg Bwd Segment Size'];
    actDataPktFwd = json[' act_data_pkt_fwd'];
    subflowFwdPackets = json['Subflow Fwd Packets'];
    fwdIATStd = json[' Fwd IAT Std'];
    averagePacketSize = json[' Average Packet Size'];
    fwdPacketLengthMean = json[' Fwd Packet Length Mean'];
    dfDDoSBenign = json['df_DDoS_benign'];
    dfDDoSBenignProb = json['df_DDoS_benign_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Bwd Packet Length Mean'] = bwdPacketLengthMean;
    data[' Packet Length Variance'] = packetLengthVariance;
    data[' Packet Length Std'] = packetLengthStd;
    data[' Bwd Packet Length Std'] = bwdPacketLengthStd;
    data[' Avg Bwd Segment Size'] = avgBwdSegmentSize;
    data[' act_data_pkt_fwd'] = actDataPktFwd;
    data['Subflow Fwd Packets'] = subflowFwdPackets;
    data[' Fwd IAT Std'] = fwdIATStd;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Fwd Packet Length Mean'] = fwdPacketLengthMean;
    data['df_DDoS_benign'] = dfDDoSBenign;
    data['df_DDoS_benign_prob'] = dfDDoSBenignProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
