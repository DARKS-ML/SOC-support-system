class SSHPatatorModel {
  String? destinationPort;
  String? initWinBytesBackward;
  String? flowBytesS;
  String? totalBackwardPackets;
  String? bwdHeaderLength;
  String? subflowBwdPackets;
  String? packetLengthMean;
  String? actDataPktFwd;
  String? initWinBytesForward;
  String? fwdHeaderLength;
  String? sSHPatatorLogic;
  String? sSHPatatorProbLogic;
  String? sSHPatatorNn;
  String? sSHPatatorProbNn;
  String? sSHPatatorSgd;
  String? sSHPatatorXgb;
  double? sSHPatatorProbXgb;
  String? sourceIP;
  String? destinationIP;
  String? protocol;
  String? timestamp;

  SSHPatatorModel(
      {this.destinationPort,
      this.initWinBytesBackward,
      this.flowBytesS,
      this.totalBackwardPackets,
      this.bwdHeaderLength,
      this.subflowBwdPackets,
      this.packetLengthMean,
      this.actDataPktFwd,
      this.initWinBytesForward,
      this.fwdHeaderLength,
      this.sSHPatatorLogic,
      this.sSHPatatorProbLogic,
      this.sSHPatatorNn,
      this.sSHPatatorProbNn,
      this.sSHPatatorSgd,
      this.sSHPatatorXgb,
      this.sSHPatatorProbXgb,
      this.sourceIP,
      this.destinationIP,
      this.protocol,
      this.timestamp});

  SSHPatatorModel.fromJson(Map<String, dynamic> json) {
    destinationPort = json[' Destination Port'];
    initWinBytesBackward = json[' Init_Win_bytes_backward'];
    flowBytesS = json['Flow Bytes/s'];
    totalBackwardPackets = json[' Total Backward Packets'];
    bwdHeaderLength = json[' Bwd Header Length'];
    subflowBwdPackets = json[' Subflow Bwd Packets'];
    packetLengthMean = json[' Packet Length Mean'];
    actDataPktFwd = json[' act_data_pkt_fwd'];
    initWinBytesForward = json['Init_Win_bytes_forward'];
    fwdHeaderLength = json[' Fwd Header Length'];
    sSHPatatorLogic = json['SSHPatator_logic'];
    sSHPatatorProbLogic = json['SSHPatator_prob_logic'];
    sSHPatatorNn = json['SSHPatator_nn'];
    sSHPatatorProbNn = json['SSHPatator_prob_nn'];
    sSHPatatorSgd = json['SSHPatator_sgd'];
    sSHPatatorXgb = json['SSHPatator_xgb'];
    sSHPatatorProbXgb = double.parse(json['SSHPatator_prob_xgb']);
    sourceIP = json['Source IP'];
    destinationIP = json['Destination IP'];
    protocol = json['Protocol'];
    timestamp = json['Timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Destination Port'] = destinationPort;
    data[' Init_Win_bytes_backward'] = initWinBytesBackward;
    data['Flow Bytes/s'] = flowBytesS;
    data[' Total Backward Packets'] = totalBackwardPackets;
    data[' Bwd Header Length'] = bwdHeaderLength;
    data[' Subflow Bwd Packets'] = subflowBwdPackets;
    data[' Packet Length Mean'] = packetLengthMean;
    data[' act_data_pkt_fwd'] = actDataPktFwd;
    data['Init_Win_bytes_forward'] = initWinBytesForward;
    data[' Fwd Header Length'] = fwdHeaderLength;
    data['SSHPatator_logic'] = sSHPatatorLogic;
    data['SSHPatator_prob_logic'] = sSHPatatorProbLogic;
    data['SSHPatator_nn'] = sSHPatatorNn;
    data['SSHPatator_prob_nn'] = sSHPatatorProbNn;
    data['SSHPatator_sgd'] = sSHPatatorSgd;
    data['SSHPatator_xgb'] = sSHPatatorXgb;
    data['SSHPatator_prob_xgb'] = sSHPatatorProbXgb;
    data['Source IP'] = sourceIP;
    data['Destination IP'] = destinationIP;
    data['Protocol'] = protocol;
    data['Timestamp'] = timestamp;
    return data;
  }
}
