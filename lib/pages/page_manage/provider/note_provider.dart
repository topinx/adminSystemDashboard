/// 笔记搜索条件
class NoteSearchParam {
  String input = "";

  String timeBegin = "";

  String timeEnd = "";

  /// 审核状态 0-未审核 1-通过 2-未通过 3-违规
  int? auditedStatus;

  /// 偏好 1-男性 2-女性 3-综合
  int? tendency;

  /// 推荐状态 0-不推荐 1-推荐
  int? recommendedStatus;

  /// 可见范围 0-私密 1-公开 2-好友可见
  int? status;

  /// 笔记类型 1-图文 2-视频
  int? noteType;

  NoteSearchParam({
    this.input = "",
    this.timeBegin = "",
    this.timeEnd = "",
    this.auditedStatus,
    this.tendency,
    this.recommendedStatus,
    this.status,
    this.noteType,
  });

  NoteSearchParam copyWith({
    String? input,
    String? timeBegin,
    String? timeEnd,
    int? auditedStatus,
    int? tendency,
    int? recommendedStatus,
    int? status,
    int? noteType,
  }) {
    return NoteSearchParam(
      input: input ?? this.input,
      timeBegin: timeBegin ?? this.timeBegin,
      timeEnd: timeEnd ?? this.timeEnd,
      auditedStatus: auditedStatus ?? this.auditedStatus,
      tendency: tendency ?? this.tendency,
      recommendedStatus: recommendedStatus ?? this.recommendedStatus,
      status: status ?? this.status,
      noteType: noteType ?? this.noteType,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteSearchParam &&
          runtimeType == other.runtimeType &&
          input == other.input &&
          timeBegin == other.timeBegin &&
          timeEnd == other.timeEnd &&
          auditedStatus == other.auditedStatus &&
          tendency == other.tendency &&
          recommendedStatus == other.recommendedStatus &&
          status == other.status &&
          noteType == other.noteType;

  @override
  int get hashCode => Object.hash(input, timeBegin, timeEnd, auditedStatus,
      tendency, recommendedStatus, status, noteType);
}
