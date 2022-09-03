class PortScanModel {
  String? totalLengthOfFwdPackets;
  String? fwdPacketLengthMax;
  String? fwdPacketLengthMean;
  String? bwdPacketsS;
  String? subflowFwdBytes;
  String? pSHFlagCount;
  String? averagePacketSize;
  String? avgFwdSegmentSize;
  String? packetLengthStd;
  String? bwdPacketLengthMin;
  String? portScanLogic;
  String? portScanProbLogic;
  String? portScanNn;
  String? portScanProbNn;
  String? portScanSgd;
  String? portScanXgb;
  double? portScanProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  PortScanModel(
      {this.totalLengthOfFwdPackets,
      this.fwdPacketLengthMax,
      this.fwdPacketLengthMean,
      this.bwdPacketsS,
      this.subflowFwdBytes,
      this.pSHFlagCount,
      this.averagePacketSize,
      this.avgFwdSegmentSize,
      this.packetLengthStd,
      this.bwdPacketLengthMin,
      this.portScanLogic,
      this.portScanProbLogic,
      this.portScanNn,
      this.portScanProbNn,
      this.portScanSgd,
      this.portScanXgb,
      this.portScanProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  PortScanModel.fromJson(Map<String, dynamic> json) {
    totalLengthOfFwdPackets = json['Total Length of Fwd Packets'];
    fwdPacketLengthMax = json[' Fwd Packet Length Max'];
    fwdPacketLengthMean = json[' Fwd Packet Length Mean'];
    bwdPacketsS = json[' Bwd Packets/s'];
    subflowFwdBytes = json[' Subflow Fwd Bytes'];
    pSHFlagCount = json[' PSH Flag Count'];
    averagePacketSize = json[' Average Packet Size'];
    avgFwdSegmentSize = json[' Avg Fwd Segment Size'];
    packetLengthStd = json[' Packet Length Std'];
    bwdPacketLengthMin = json[' Bwd Packet Length Min'];
    portScanLogic = json['PortScan_logic'];
    portScanProbLogic = json['PortScan_prob_logic'];
    portScanNn = json['PortScan_nn'];
    portScanProbNn = json['PortScan_prob_nn'];
    portScanSgd = json['PortScan_sgd'];
    portScanXgb = json['PortScan_xgb'];
    portScanProbXgb = double.parse(json['PortScan_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Total Length of Fwd Packets'] = totalLengthOfFwdPackets;
    data[' Fwd Packet Length Max'] = fwdPacketLengthMax;
    data[' Fwd Packet Length Mean'] = fwdPacketLengthMean;
    data[' Bwd Packets/s'] = bwdPacketsS;
    data[' Subflow Fwd Bytes'] = subflowFwdBytes;
    data[' PSH Flag Count'] = pSHFlagCount;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Avg Fwd Segment Size'] = avgFwdSegmentSize;
    data[' Packet Length Std'] = packetLengthStd;
    data[' Bwd Packet Length Min'] = bwdPacketLengthMin;
    data['PortScan_logic'] = portScanLogic;
    data['PortScan_prob_logic'] = portScanProbLogic;
    data['PortScan_nn'] = portScanNn;
    data['PortScan_prob_nn'] = portScanProbNn;
    data['PortScan_sgd'] = portScanSgd;
    data['PortScan_xgb'] = portScanXgb;
    data['PortScan_prob_xgb'] = portScanProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
