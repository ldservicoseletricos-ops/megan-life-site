class BrainContext {
  const BrainContext({
    this.mediaActive = false,
    this.voiceCaptureActive = false,
    this.screenOn = true,
    this.extra = const {},
  });

  final bool mediaActive;
  final bool voiceCaptureActive;
  final bool screenOn;
  final Map<String, dynamic> extra;

  Map<String, dynamic> toJson() => {
        'mediaActive': mediaActive,
        'voiceCaptureActive': voiceCaptureActive,
        'screenOn': screenOn,
        'extra': extra,
      };
}
