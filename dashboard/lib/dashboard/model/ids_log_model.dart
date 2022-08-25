class IDSLogModel {
  String? destinationPort;
  String? flowDuration;
  String? totalFwdPackets;
  String? totalBackwardPackets;
  String? totalLengthOfFwdPackets;
  String? totalLengthOfBwdPackets;
  String? fwdPacketLengthMax;
  String? fwdPacketLengthMin;
  String? fwdPacketLengthMean;
  String? fwdPacketLengthStd;
  String? bwdPacketLengthMax;
  String? bwdPacketLengthMin;
  String? bwdPacketLengthMean;
  String? bwdPacketLengthStd;
  String? flowBytesS;
  String? flowPacketsS;
  String? flowIATMean;
  String? flowIATStd;
  String? flowIATMax;
  String? flowIATMin;
  String? fwdIATTotal;
  String? fwdIATMean;
  String? fwdIATStd;
  String? fwdIATMax;
  String? fwdIATMin;
  String? bwdIATTotal;
  String? bwdIATMean;
  String? bwdIATStd;
  String? bwdIATMax;
  String? bwdIATMin;
  String? fwdPSHFlags;
  String? bwdPSHFlags;
  String? fwdURGFlags;
  String? bwdURGFlags;
  String? fwdHeaderLength;
  String? bwdHeaderLength;
  String? fwdPacketsS;
  String? bwdPacketsS;
  String? minPacketLength;
  String? maxPacketLength;
  String? packetLengthMean;
  String? packetLengthStd;
  String? packetLengthVariance;
  String? fINFlagCount;
  String? sYNFlagCount;
  String? rSTFlagCount;
  String? pSHFlagCount;
  String? aCKFlagCount;
  String? uRGFlagCount;
  String? cWEFlagCount;
  String? eCEFlagCount;
  String? downUpRatio;
  String? averagePacketSize;
  String? avgFwdSegmentSize;
  String? avgBwdSegmentSize;
  String? fwdHeaderLength1;
  String? fwdAvgBytesBulk;
  String? fwdAvgPacketsBulk;
  String? fwdAvgBulkRate;
  String? bwdAvgBytesBulk;
  String? bwdAvgPacketsBulk;
  String? bwdAvgBulkRate;
  String? subflowFwdPackets;
  String? subflowFwdBytes;
  String? subflowBwdPackets;
  String? subflowBwdBytes;
  String? initWinBytesForward;
  String? initWinBytesBackward;
  String? actDataPktFwd;
  String? minSegSizeForward;
  String? activeMean;
  String? activeStd;
  String? activeMax;
  String? activeMin;
  String? idleMean;
  String? idleStd;
  String? idleMax;
  String? idleMin;
  String? fTPPatator;
  String? fTPPatatorProb;
  String? sSHPatator;
  String? sSHPatatorProb;
  String? doSSlowhttptest;
  String? doSSlowhttptestProb;
  String? doSHulk;
  String? doSHulkProb;
  String? doSGoldenEye;
  String? doSGoldenEyeProb;
  String? heartbleed;
  String? heartbleedProb;
  String? webAttackBruteForce;
  String? webAttackBruteForceProb;
  String? webAttackXSSBenign;
  String? webAttackXSSBenignProb;
  String? webAttackSqlInjection;
  String? webAttackSqlInjectionProb;
  String? infiltration;
  String? infiltrationProb;
  String? bot;
  String? botProb;
  String? portScan;
  String? portScanProb;
  String? dfDDoSBenign;
  String? dfDDoSBenignProb;
  String? dfWebAttack;
  String? dfWebAttackProb;

  IDSLogModel(
      {this.destinationPort,
      this.flowDuration,
      this.totalFwdPackets,
      this.totalBackwardPackets,
      this.totalLengthOfFwdPackets,
      this.totalLengthOfBwdPackets,
      this.fwdPacketLengthMax,
      this.fwdPacketLengthMin,
      this.fwdPacketLengthMean,
      this.fwdPacketLengthStd,
      this.bwdPacketLengthMax,
      this.bwdPacketLengthMin,
      this.bwdPacketLengthMean,
      this.bwdPacketLengthStd,
      this.flowBytesS,
      this.flowPacketsS,
      this.flowIATMean,
      this.flowIATStd,
      this.flowIATMax,
      this.flowIATMin,
      this.fwdIATTotal,
      this.fwdIATMean,
      this.fwdIATStd,
      this.fwdIATMax,
      this.fwdIATMin,
      this.bwdIATTotal,
      this.bwdIATMean,
      this.bwdIATStd,
      this.bwdIATMax,
      this.bwdIATMin,
      this.fwdPSHFlags,
      this.bwdPSHFlags,
      this.fwdURGFlags,
      this.bwdURGFlags,
      this.fwdHeaderLength,
      this.bwdHeaderLength,
      this.fwdPacketsS,
      this.bwdPacketsS,
      this.minPacketLength,
      this.maxPacketLength,
      this.packetLengthMean,
      this.packetLengthStd,
      this.packetLengthVariance,
      this.fINFlagCount,
      this.sYNFlagCount,
      this.rSTFlagCount,
      this.pSHFlagCount,
      this.aCKFlagCount,
      this.uRGFlagCount,
      this.cWEFlagCount,
      this.eCEFlagCount,
      this.downUpRatio,
      this.averagePacketSize,
      this.avgFwdSegmentSize,
      this.avgBwdSegmentSize,
      this.fwdHeaderLength1,
      this.fwdAvgBytesBulk,
      this.fwdAvgPacketsBulk,
      this.fwdAvgBulkRate,
      this.bwdAvgBytesBulk,
      this.bwdAvgPacketsBulk,
      this.bwdAvgBulkRate,
      this.subflowFwdPackets,
      this.subflowFwdBytes,
      this.subflowBwdPackets,
      this.subflowBwdBytes,
      this.initWinBytesForward,
      this.initWinBytesBackward,
      this.actDataPktFwd,
      this.minSegSizeForward,
      this.activeMean,
      this.activeStd,
      this.activeMax,
      this.activeMin,
      this.idleMean,
      this.idleStd,
      this.idleMax,
      this.idleMin,
      this.fTPPatator,
      this.fTPPatatorProb,
      this.sSHPatator,
      this.sSHPatatorProb,
      this.doSSlowhttptest,
      this.doSSlowhttptestProb,
      this.doSHulk,
      this.doSHulkProb,
      this.doSGoldenEye,
      this.doSGoldenEyeProb,
      this.heartbleed,
      this.heartbleedProb,
      this.webAttackBruteForce,
      this.webAttackBruteForceProb,
      this.webAttackXSSBenign,
      this.webAttackXSSBenignProb,
      this.webAttackSqlInjection,
      this.webAttackSqlInjectionProb,
      this.infiltration,
      this.infiltrationProb,
      this.bot,
      this.botProb,
      this.portScan,
      this.portScanProb,
      this.dfDDoSBenign,
      this.dfDDoSBenignProb,
      this.dfWebAttack,
      this.dfWebAttackProb});

  IDSLogModel.fromJson(Map<String, dynamic> json) {
    destinationPort = json[' Destination Port'];
    flowDuration = json[' Flow Duration'];
    totalFwdPackets = json[' Total Fwd Packets'];
    totalBackwardPackets = json[' Total Backward Packets'];
    totalLengthOfFwdPackets = json['Total Length of Fwd Packets'];
    totalLengthOfBwdPackets = json[' Total Length of Bwd Packets'];
    fwdPacketLengthMax = json[' Fwd Packet Length Max'];
    fwdPacketLengthMin = json[' Fwd Packet Length Min'];
    fwdPacketLengthMean = json[' Fwd Packet Length Mean'];
    fwdPacketLengthStd = json[' Fwd Packet Length Std'];
    bwdPacketLengthMax = json['Bwd Packet Length Max'];
    bwdPacketLengthMin = json[' Bwd Packet Length Min'];
    bwdPacketLengthMean = json[' Bwd Packet Length Mean'];
    bwdPacketLengthStd = json[' Bwd Packet Length Std'];
    flowBytesS = json['Flow Bytes/s'];
    flowPacketsS = json[' Flow Packets/s'];
    flowIATMean = json[' Flow IAT Mean'];
    flowIATStd = json[' Flow IAT Std'];
    flowIATMax = json[' Flow IAT Max'];
    flowIATMin = json[' Flow IAT Min'];
    fwdIATTotal = json['Fwd IAT Total'];
    fwdIATMean = json[' Fwd IAT Mean'];
    fwdIATStd = json[' Fwd IAT Std'];
    fwdIATMax = json[' Fwd IAT Max'];
    fwdIATMin = json[' Fwd IAT Min'];
    bwdIATTotal = json['Bwd IAT Total'];
    bwdIATMean = json[' Bwd IAT Mean'];
    bwdIATStd = json[' Bwd IAT Std'];
    bwdIATMax = json[' Bwd IAT Max'];
    bwdIATMin = json[' Bwd IAT Min'];
    fwdPSHFlags = json['Fwd PSH Flags'];
    bwdPSHFlags = json[' Bwd PSH Flags'];
    fwdURGFlags = json[' Fwd URG Flags'];
    bwdURGFlags = json[' Bwd URG Flags'];
    fwdHeaderLength = json[' Fwd Header Length'];
    bwdHeaderLength = json[' Bwd Header Length'];
    fwdPacketsS = json['Fwd Packets/s'];
    bwdPacketsS = json[' Bwd Packets/s'];
    minPacketLength = json[' Min Packet Length'];
    maxPacketLength = json[' Max Packet Length'];
    packetLengthMean = json[' Packet Length Mean'];
    packetLengthStd = json[' Packet Length Std'];
    packetLengthVariance = json[' Packet Length Variance'];
    fINFlagCount = json['FIN Flag Count'];
    sYNFlagCount = json[' SYN Flag Count'];
    rSTFlagCount = json[' RST Flag Count'];
    pSHFlagCount = json[' PSH Flag Count'];
    aCKFlagCount = json[' ACK Flag Count'];
    uRGFlagCount = json[' URG Flag Count'];
    cWEFlagCount = json[' CWE Flag Count'];
    eCEFlagCount = json[' ECE Flag Count'];
    downUpRatio = json[' Down/Up Ratio'];
    averagePacketSize = json[' Average Packet Size'];
    avgFwdSegmentSize = json[' Avg Fwd Segment Size'];
    avgBwdSegmentSize = json[' Avg Bwd Segment Size'];
    fwdHeaderLength1 = json[' Fwd Header Length.1'];
    fwdAvgBytesBulk = json['Fwd Avg Bytes/Bulk'];
    fwdAvgPacketsBulk = json[' Fwd Avg Packets/Bulk'];
    fwdAvgBulkRate = json[' Fwd Avg Bulk Rate'];
    bwdAvgBytesBulk = json[' Bwd Avg Bytes/Bulk'];
    bwdAvgPacketsBulk = json[' Bwd Avg Packets/Bulk'];
    bwdAvgBulkRate = json['Bwd Avg Bulk Rate'];
    subflowFwdPackets = json['Subflow Fwd Packets'];
    subflowFwdBytes = json[' Subflow Fwd Bytes'];
    subflowBwdPackets = json[' Subflow Bwd Packets'];
    subflowBwdBytes = json[' Subflow Bwd Bytes'];
    initWinBytesForward = json['Init_Win_bytes_forward'];
    initWinBytesBackward = json[' Init_Win_bytes_backward'];
    actDataPktFwd = json[' act_data_pkt_fwd'];
    minSegSizeForward = json[' min_seg_size_forward'];
    activeMean = json['Active Mean'];
    activeStd = json[' Active Std'];
    activeMax = json[' Active Max'];
    activeMin = json[' Active Min'];
    idleMean = json['Idle Mean'];
    idleStd = json[' Idle Std'];
    idleMax = json[' Idle Max'];
    idleMin = json[' Idle Min'];
    fTPPatator = json['FTPPatator'];
    fTPPatatorProb = json['FTPPatator_prob'];
    sSHPatator = json['SSHPatator'];
    sSHPatatorProb = json['SSHPatator_prob'];
    doSSlowhttptest = json['DoS_Slowhttptest'];
    doSSlowhttptestProb = json['DoS_Slowhttptest_prob'];
    doSHulk = json['DoS_Hulk'];
    doSHulkProb = json['DoS_Hulk_prob'];
    doSGoldenEye = json['DoS_GoldenEye'];
    doSGoldenEyeProb = json['DoS_GoldenEye_prob'];
    heartbleed = json['Heartbleed'];
    heartbleedProb = json['Heartbleed_prob'];
    webAttackBruteForce = json['Web_Attack_Brute_Force'];
    webAttackBruteForceProb = json['Web_Attack_Brute_Force_prob'];
    webAttackXSSBenign = json['Web_Attack_XSS_benign'];
    webAttackXSSBenignProb = json['Web_Attack_XSS_benign_prob'];
    webAttackSqlInjection = json['Web_Attack_Sql_Injection'];
    webAttackSqlInjectionProb = json['Web_Attack_Sql_Injection_prob'];
    infiltration = json['Infiltration'];
    infiltrationProb = json['Infiltration_prob'];
    bot = json['Bot'];
    botProb = json['Bot_prob'];
    portScan = json['PortScan'];
    portScanProb = json['PortScan_prob'];
    dfDDoSBenign = json['df_DDoS_benign'];
    dfDDoSBenignProb = json['df_DDoS_benign_prob'];
    dfWebAttack = json['df_Web_Attack'];
    dfWebAttackProb = json['df_Web_Attack_prob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[' Destination Port'] = destinationPort;
    data[' Flow Duration'] = flowDuration;
    data[' Total Fwd Packets'] = totalFwdPackets;
    data[' Total Backward Packets'] = totalBackwardPackets;
    data['Total Length of Fwd Packets'] = totalLengthOfFwdPackets;
    data[' Total Length of Bwd Packets'] = totalLengthOfBwdPackets;
    data[' Fwd Packet Length Max'] = fwdPacketLengthMax;
    data[' Fwd Packet Length Min'] = fwdPacketLengthMin;
    data[' Fwd Packet Length Mean'] = fwdPacketLengthMean;
    data[' Fwd Packet Length Std'] = fwdPacketLengthStd;
    data['Bwd Packet Length Max'] = bwdPacketLengthMax;
    data[' Bwd Packet Length Min'] = bwdPacketLengthMin;
    data[' Bwd Packet Length Mean'] = bwdPacketLengthMean;
    data[' Bwd Packet Length Std'] = bwdPacketLengthStd;
    data['Flow Bytes/s'] = flowBytesS;
    data[' Flow Packets/s'] = flowPacketsS;
    data[' Flow IAT Mean'] = flowIATMean;
    data[' Flow IAT Std'] = flowIATStd;
    data[' Flow IAT Max'] = flowIATMax;
    data[' Flow IAT Min'] = flowIATMin;
    data['Fwd IAT Total'] = fwdIATTotal;
    data[' Fwd IAT Mean'] = fwdIATMean;
    data[' Fwd IAT Std'] = fwdIATStd;
    data[' Fwd IAT Max'] = fwdIATMax;
    data[' Fwd IAT Min'] = fwdIATMin;
    data['Bwd IAT Total'] = bwdIATTotal;
    data[' Bwd IAT Mean'] = bwdIATMean;
    data[' Bwd IAT Std'] = bwdIATStd;
    data[' Bwd IAT Max'] = bwdIATMax;
    data[' Bwd IAT Min'] = bwdIATMin;
    data['Fwd PSH Flags'] = fwdPSHFlags;
    data[' Bwd PSH Flags'] = bwdPSHFlags;
    data[' Fwd URG Flags'] = fwdURGFlags;
    data[' Bwd URG Flags'] = bwdURGFlags;
    data[' Fwd Header Length'] = fwdHeaderLength;
    data[' Bwd Header Length'] = bwdHeaderLength;
    data['Fwd Packets/s'] = fwdPacketsS;
    data[' Bwd Packets/s'] = bwdPacketsS;
    data[' Min Packet Length'] = minPacketLength;
    data[' Max Packet Length'] = maxPacketLength;
    data[' Packet Length Mean'] = packetLengthMean;
    data[' Packet Length Std'] = packetLengthStd;
    data[' Packet Length Variance'] = packetLengthVariance;
    data['FIN Flag Count'] = fINFlagCount;
    data[' SYN Flag Count'] = sYNFlagCount;
    data[' RST Flag Count'] = rSTFlagCount;
    data[' PSH Flag Count'] = pSHFlagCount;
    data[' ACK Flag Count'] = aCKFlagCount;
    data[' URG Flag Count'] = uRGFlagCount;
    data[' CWE Flag Count'] = cWEFlagCount;
    data[' ECE Flag Count'] = eCEFlagCount;
    data[' Down/Up Ratio'] = downUpRatio;
    data[' Average Packet Size'] = averagePacketSize;
    data[' Avg Fwd Segment Size'] = avgFwdSegmentSize;
    data[' Avg Bwd Segment Size'] = avgBwdSegmentSize;
    data[' Fwd Header Length.1'] = fwdHeaderLength1;
    data['Fwd Avg Bytes/Bulk'] = fwdAvgBytesBulk;
    data[' Fwd Avg Packets/Bulk'] = fwdAvgPacketsBulk;
    data[' Fwd Avg Bulk Rate'] = fwdAvgBulkRate;
    data[' Bwd Avg Bytes/Bulk'] = bwdAvgBytesBulk;
    data[' Bwd Avg Packets/Bulk'] = bwdAvgPacketsBulk;
    data['Bwd Avg Bulk Rate'] = bwdAvgBulkRate;
    data['Subflow Fwd Packets'] = subflowFwdPackets;
    data[' Subflow Fwd Bytes'] = subflowFwdBytes;
    data[' Subflow Bwd Packets'] = subflowBwdPackets;
    data[' Subflow Bwd Bytes'] = subflowBwdBytes;
    data['Init_Win_bytes_forward'] = initWinBytesForward;
    data[' Init_Win_bytes_backward'] = initWinBytesBackward;
    data[' act_data_pkt_fwd'] = actDataPktFwd;
    data[' min_seg_size_forward'] = minSegSizeForward;
    data['Active Mean'] = activeMean;
    data[' Active Std'] = activeStd;
    data[' Active Max'] = activeMax;
    data[' Active Min'] = activeMin;
    data['Idle Mean'] = idleMean;
    data[' Idle Std'] = idleStd;
    data[' Idle Max'] = idleMax;
    data[' Idle Min'] = idleMin;
    data['FTPPatator'] = fTPPatator;
    data['FTPPatator_prob'] = fTPPatatorProb;
    data['SSHPatator'] = sSHPatator;
    data['SSHPatator_prob'] = sSHPatatorProb;
    data['DoS_Slowhttptest'] = doSSlowhttptest;
    data['DoS_Slowhttptest_prob'] = doSSlowhttptestProb;
    data['DoS_Hulk'] = doSHulk;
    data['DoS_Hulk_prob'] = doSHulkProb;
    data['DoS_GoldenEye'] = doSGoldenEye;
    data['DoS_GoldenEye_prob'] = doSGoldenEyeProb;
    data['Heartbleed'] = heartbleed;
    data['Heartbleed_prob'] = heartbleedProb;
    data['Web_Attack_Brute_Force'] = webAttackBruteForce;
    data['Web_Attack_Brute_Force_prob'] = webAttackBruteForceProb;
    data['Web_Attack_XSS_benign'] = webAttackXSSBenign;
    data['Web_Attack_XSS_benign_prob'] = webAttackXSSBenignProb;
    data['Web_Attack_Sql_Injection'] = webAttackSqlInjection;
    data['Web_Attack_Sql_Injection_prob'] = webAttackSqlInjectionProb;
    data['Infiltration'] = infiltration;
    data['Infiltration_prob'] = infiltrationProb;
    data['Bot'] = bot;
    data['Bot_prob'] = botProb;
    data['PortScan'] = portScan;
    data['PortScan_prob'] = portScanProb;
    data['df_DDoS_benign'] = dfDDoSBenign;
    data['df_DDoS_benign_prob'] = dfDDoSBenignProb;
    data['df_Web_Attack'] = dfWebAttack;
    data['df_Web_Attack_prob'] = dfWebAttackProb;
    return data;
  }
}
