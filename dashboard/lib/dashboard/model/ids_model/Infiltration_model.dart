class InfiltrationModel {
  String? subflowFwdBytes;
  String? totalLengthOfFwdPackets;
  String? fwdPacketLengthMean;
  String? activeMin;
  String? actDataPktFwd;
  String? activeMean;
  String? flowIATMax;
  String? avgFwdSegmentSize;
  String? destinationPort;
  String? idleStd;
  String? infiltrationLogic;
  String? infiltrationProbLogic;
  String? infiltrationNn;
  String? infiltrationProbNn;
  String? infiltrationSgd;
  String? infiltrationXgb;
  double? infiltrationProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  InfiltrationModel(
      {this.subflowFwdBytes,
      this.totalLengthOfFwdPackets,
      this.fwdPacketLengthMean,
      this.activeMin,
      this.actDataPktFwd,
      this.activeMean,
      this.flowIATMax,
      this.avgFwdSegmentSize,
      this.destinationPort,
      this.idleStd,
      this.infiltrationLogic,
      this.infiltrationProbLogic,
      this.infiltrationNn,
      this.infiltrationProbNn,
      this.infiltrationSgd,
      this.infiltrationXgb,
      this.infiltrationProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  InfiltrationModel.fromJson(Map<String, dynamic> json) {
    subflowFwdBytes = json[' Subflow Fwd Bytes'];
    totalLengthOfFwdPackets = json['Total Length of Fwd Packets'];
    fwdPacketLengthMean = json[' Fwd Packet Length Mean'];
    activeMin = json[' Active Min'];
    actDataPktFwd = json[' act_data_pkt_fwd'];
    activeMean = json['Active Mean'];
    flowIATMax = json[' Flow IAT Max'];
    avgFwdSegmentSize = json[' Avg Fwd Segment Size'];
    destinationPort = json[' Destination Port'];
    idleStd = json[' Idle Std'];
    infiltrationLogic = json['Infiltration_logic'];
    infiltrationProbLogic = json['Infiltration_prob_logic'];
    infiltrationNn = json['Infiltration_nn'];
    infiltrationProbNn = json['Infiltration_prob_nn'];
    infiltrationSgd = json['Infiltration_sgd'];
    infiltrationXgb = json['Infiltration_xgb'];
    infiltrationProbXgb = double.parse(json['Infiltration_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Subflow Fwd Bytes'] = subflowFwdBytes;
    data['Total Length of Fwd Packets'] = totalLengthOfFwdPackets;
    data[' Fwd Packet Length Mean'] = fwdPacketLengthMean;
    data[' Active Min'] = activeMin;
    data[' act_data_pkt_fwd'] = actDataPktFwd;
    data['Active Mean'] = activeMean;
    data[' Flow IAT Max'] = flowIATMax;
    data[' Avg Fwd Segment Size'] = avgFwdSegmentSize;
    data[' Destination Port'] = destinationPort;
    data[' Idle Std'] = idleStd;
    data['Infiltration_logic'] = infiltrationLogic;
    data['Infiltration_prob_logic'] = infiltrationProbLogic;
    data['Infiltration_nn'] = infiltrationNn;
    data['Infiltration_prob_nn'] = infiltrationProbNn;
    data['Infiltration_sgd'] = infiltrationSgd;
    data['Infiltration_xgb'] = infiltrationXgb;
    data['Infiltration_prob_xgb'] = infiltrationProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
