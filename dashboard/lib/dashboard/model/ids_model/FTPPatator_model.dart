class FTPPatatorModel {
  String? destinationPort;
  String? averagePacketSize;
  String? fwdPacketLengthMean;
  String? avgFwdSegmentSize;
  String? fwdPacketLengthStd;
  String? fwdPacketLengthMax;
  String? packetLengthStd;
  String? packetLengthVariance;
  String? maxPacketLength;
  String? totalLengthOfFwdPackets;
  String? fTPPatatorLogic;
  String? fTPPatatorProbLogic;
  String? fTPPatatorNn;
  String? fTPPatatorProbNn;
  String? fTPPatatorSgd;
  String? fTPPatatorXgb;
  double? fTPPatatorProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  FTPPatatorModel(
      {this.destinationPort,
      this.averagePacketSize,
      this.fwdPacketLengthMean,
      this.avgFwdSegmentSize,
      this.fwdPacketLengthStd,
      this.fwdPacketLengthMax,
      this.packetLengthStd,
      this.packetLengthVariance,
      this.maxPacketLength,
      this.totalLengthOfFwdPackets,
      this.fTPPatatorLogic,
      this.fTPPatatorProbLogic,
      this.fTPPatatorNn,
      this.fTPPatatorProbNn,
      this.fTPPatatorSgd,
      this.fTPPatatorXgb,
      this.fTPPatatorProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  FTPPatatorModel.fromJson(Map<String, dynamic> json) {
    destinationPort = json[' Destination Port'];
    averagePacketSize = json[' Average Packet Size'];
    fwdPacketLengthMean = json[' Fwd Packet Length Mean'];
    avgFwdSegmentSize = json[' Avg Fwd Segment Size'];
    fwdPacketLengthStd = json[' Fwd Packet Length Std'];
    fwdPacketLengthMax = json[' Fwd Packet Length Max'];
    packetLengthStd = json[' Packet Length Std'];
    packetLengthVariance = json[' Packet Length Variance'];
    maxPacketLength = json[' Max Packet Length'];
    totalLengthOfFwdPackets = json['Total Length of Fwd Packets'];
    fTPPatatorLogic = json['FTPPatator_logic'];
    fTPPatatorProbLogic = json['FTPPatator_prob_logic'];
    fTPPatatorNn = json['FTPPatator_nn'];
    fTPPatatorProbNn = json['FTPPatator_prob_nn'];
    fTPPatatorSgd = json['FTPPatator_sgd'];
    fTPPatatorXgb = json['FTPPatator_xgb'];
    fTPPatatorProbXgb = double.parse(json['FTPPatator_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Destination Port'] = destinationPort;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Fwd Packet Length Mean'] = fwdPacketLengthMean;
    data[' Avg Fwd Segment Size'] = avgFwdSegmentSize;
    data[' Fwd Packet Length Std'] = fwdPacketLengthStd;
    data[' Fwd Packet Length Max'] = fwdPacketLengthMax;
    data[' Packet Length Std'] = packetLengthStd;
    data[' Packet Length Variance'] = packetLengthVariance;
    data[' Max Packet Length'] = maxPacketLength;
    data['Total Length of Fwd Packets'] = totalLengthOfFwdPackets;
    data['FTPPatator_logic'] = fTPPatatorLogic;
    data['FTPPatator_prob_logic'] = fTPPatatorProbLogic;
    data['FTPPatator_nn'] = fTPPatatorNn;
    data['FTPPatator_prob_nn'] = fTPPatatorProbNn;
    data['FTPPatator_sgd'] = fTPPatatorSgd;
    data['FTPPatator_xgb'] = fTPPatatorXgb;
    data['FTPPatator_prob_xgb'] = fTPPatatorProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
