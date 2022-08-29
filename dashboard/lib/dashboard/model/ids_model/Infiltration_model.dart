class InfiltrationModel {
  String? totalLengthOfFwdPackets;
  String? fwdPacketLengthMean;
  String? subflowFwdBytes;
  String? fwdPacketLengthStd;
  String? avgFwdSegmentSize;
  String? activeMin;
  String? fwdPacketLengthMax;
  String? activeMean;
  String? destinationPort;
  String? actDataPktFwd;
  String? infiltration;
  String? infiltrationProb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  InfiltrationModel(
      {this.totalLengthOfFwdPackets,
      this.fwdPacketLengthMean,
      this.subflowFwdBytes,
      this.fwdPacketLengthStd,
      this.avgFwdSegmentSize,
      this.activeMin,
      this.fwdPacketLengthMax,
      this.activeMean,
      this.destinationPort,
      this.actDataPktFwd,
      this.infiltration,
      this.infiltrationProb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  InfiltrationModel.fromJson(Map<String, dynamic> json) {
    totalLengthOfFwdPackets = json['Total Length of Fwd Packets'];
    fwdPacketLengthMean = json[' Fwd Packet Length Mean'];
    subflowFwdBytes = json[' Subflow Fwd Bytes'];
    fwdPacketLengthStd = json[' Fwd Packet Length Std'];
    avgFwdSegmentSize = json[' Avg Fwd Segment Size'];
    activeMin = json[' Active Min'];
    fwdPacketLengthMax = json[' Fwd Packet Length Max'];
    activeMean = json['Active Mean'];
    destinationPort = json[' Destination Port'];
    actDataPktFwd = json[' act_data_pkt_fwd'];
    infiltration = json['Infiltration'];
    infiltrationProb = json['Infiltration_prob'];
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Total Length of Fwd Packets'] = totalLengthOfFwdPackets;
    data[' Fwd Packet Length Mean'] = fwdPacketLengthMean;
    data[' Subflow Fwd Bytes'] = subflowFwdBytes;
    data[' Fwd Packet Length Std'] = fwdPacketLengthStd;
    data[' Avg Fwd Segment Size'] = avgFwdSegmentSize;
    data[' Active Min'] = activeMin;
    data[' Fwd Packet Length Max'] = fwdPacketLengthMax;
    data['Active Mean'] = activeMean;
    data[' Destination Port'] = destinationPort;
    data[' act_data_pkt_fwd'] = actDataPktFwd;
    data['Infiltration'] = infiltration;
    data['Infiltration_prob'] = infiltrationProb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
