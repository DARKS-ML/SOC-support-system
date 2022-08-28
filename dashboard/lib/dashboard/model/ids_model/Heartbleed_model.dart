class HeartbleedModel {
  String? totalBackwardPackets;
  String? subflowFwdBytes;
  String? totalLengthOfFwdPackets;
  String? actDataPktFwd;
  String? maxPacketLength;
  String? bwdPacketLengthMean;
  String? subflowBwdBytes;
  String? totalLengthOfBwdPackets;
  String? fwdHeaderLength;
  String? subflowFwdPackets;
  String? heartbleed;
  String? heartbleedProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  HeartbleedModel(
      {this.totalBackwardPackets,
      this.subflowFwdBytes,
      this.totalLengthOfFwdPackets,
      this.actDataPktFwd,
      this.maxPacketLength,
      this.bwdPacketLengthMean,
      this.subflowBwdBytes,
      this.totalLengthOfBwdPackets,
      this.fwdHeaderLength,
      this.subflowFwdPackets,
      this.heartbleed,
      this.heartbleedProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  HeartbleedModel.fromJson(Map<String, dynamic> json) {
    totalBackwardPackets = json[' Total Backward Packets'];
    subflowFwdBytes = json[' Subflow Fwd Bytes'];
    totalLengthOfFwdPackets = json['Total Length of Fwd Packets'];
    actDataPktFwd = json[' act_data_pkt_fwd'];
    maxPacketLength = json[' Max Packet Length'];
    bwdPacketLengthMean = json[' Bwd Packet Length Mean'];
    subflowBwdBytes = json[' Subflow Bwd Bytes'];
    totalLengthOfBwdPackets = json[' Total Length of Bwd Packets'];
    fwdHeaderLength = json[' Fwd Header Length'];
    subflowFwdPackets = json['Subflow Fwd Packets'];
    heartbleed = json['Heartbleed'];
    heartbleedProb = json['Heartbleed_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Total Backward Packets'] = totalBackwardPackets;
    data[' Subflow Fwd Bytes'] = subflowFwdBytes;
    data['Total Length of Fwd Packets'] = totalLengthOfFwdPackets;
    data[' act_data_pkt_fwd'] = actDataPktFwd;
    data[' Max Packet Length'] = maxPacketLength;
    data[' Bwd Packet Length Mean'] = bwdPacketLengthMean;
    data[' Subflow Bwd Bytes'] = subflowBwdBytes;
    data[' Total Length of Bwd Packets'] = totalLengthOfBwdPackets;
    data[' Fwd Header Length'] = fwdHeaderLength;
    data['Subflow Fwd Packets'] = subflowFwdPackets;
    data['Heartbleed'] = heartbleed;
    data['Heartbleed_prob'] = heartbleedProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
