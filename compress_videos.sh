#!/bin/bash
# Compress and copy video assets from the slides figures directory.
# Target: 768px wide, H.264 CRF 30, stripped audio for visual-only clips.
# Audio-containing clips (speech, who-is-talking, audio intensity) keep audio.

SRC="/Users/mbyosef/code/iclora_paper_experiments/external_tasks/figures/slides"
DST="/Users/mbyosef/code/AVControl/static/videos"

VISUAL_VIDEOS=(
  # Method
  pipeline_video.mp4
  # Spatially-aligned
  depth_cond_1.mp4 depth_out_1.mp4
  pose_cond_1.mp4 pose_out_1.mp4
  canny_cond_1.mp4 canny_out_1.mp4
  # Strength sweep
  strength_depth_condition.mp4
  strength_0.0.mp4 strength_0.25.mp4 strength_0.5.mp4 strength_1.0.mp4
  # Inpainting
  inpaint_cond_1.mp4 inpaint_out_1.mp4
  inpaint_cond_2.mp4 inpaint_out_2.mp4
  # Outpainting
  outpaint_cond_1.mp4 outpaint_out_1.mp4
  outpaint_cond_2.mp4 outpaint_out_2.mp4
  # Local edit
  local_edit_cond_1.mp4 local_edit_out_1.mp4
  local_edit_cond_2.mp4 local_edit_out_2.mp4
  # Detailing
  detailing_cond_1.mp4 detailing_out_1.mp4
  detailing_cond_1_crop.mp4 detailing_out_1_crop.mp4
  # Camera from image
  camera_image_condition.mp4 camera_image_output.mp4
  camera_image_condition_2.mp4 camera_image_output_2.mp4
  # Camera from video
  camera_video_source.mp4 camera_video_condition.mp4 camera_video_output.mp4
  train.mp4 ltxv-ic-lora-stack_00004_condition.mp4 ltxv-ic-lora-stack_00004_output.mp4
  # Camera diverse
  camera_v2v_diverse_source.mp4
  camera_v2v_diverse_cond_00015.mp4 camera_v2v_diverse_out_00015.mp4
  camera_v2v_diverse_cond_00016.mp4 camera_v2v_diverse_out_00016.mp4
  camera_v2v_diverse_cond_00018.mp4 camera_v2v_diverse_out_00018.mp4
  # Sparse tracks
  tracks_cond_3.mp4 tracks_out_3.mp4
  tracks_condition.mp4 tracks_output.mp4
  # Cut-on-action
  cut_input_2.mp4 cut_out_4.mp4
  cut_input.mp4 cut_out_1.mp4 cut_out_2.mp4 cut_out_3.mp4
  # Comparisons
  comp_depth_control_1.mp4 comp_depth_ours_1.mp4 comp_depth_vace_1.mp4
  comp_depth_control_2.mp4 comp_depth_ours_2.mp4 comp_depth_vace_2.mp4
  comp_pose_control_1.mp4 comp_pose_ours_1.mp4 comp_pose_vace_1.mp4
  comp_pose_control_2.mp4 comp_pose_ours_2.mp4 comp_pose_vace_2.mp4
  # Highlight teaser
  depth_condition.mp4 depth_output.mp4
  tracks_cond_2.mp4 tracks_out_2.mp4
)

AUDIO_VIDEOS=(
  audio_intensity_output.mp4
  audio_intensity_waveform.mp4
  speech_ambient_condition.mp4 speech_ambient_output.mp4
  whoistalking_cond_1.mp4 whoistalking_out_1.mp4
  whoistalking_cond_2.mp4 whoistalking_out_2.mp4
)

TOTAL=$(( ${#VISUAL_VIDEOS[@]} + ${#AUDIO_VIDEOS[@]} ))
COUNT=0

for f in "${VISUAL_VIDEOS[@]}"; do
  COUNT=$((COUNT + 1))
  if [ -f "$DST/$f" ]; then
    echo "[$COUNT/$TOTAL] SKIP (exists): $f"
    continue
  fi
  if [ ! -f "$SRC/$f" ]; then
    echo "[$COUNT/$TOTAL] MISSING: $f"
    continue
  fi
  echo "[$COUNT/$TOTAL] Compressing (no audio): $f"
  ffmpeg -y -i "$SRC/$f" \
    -vf "scale='min(768,iw)':-2" \
    -c:v libx264 -crf 30 -preset medium -pix_fmt yuv420p \
    -an -movflags +faststart \
    "$DST/$f" 2>/dev/null
done

for f in "${AUDIO_VIDEOS[@]}"; do
  COUNT=$((COUNT + 1))
  if [ -f "$DST/$f" ]; then
    echo "[$COUNT/$TOTAL] SKIP (exists): $f"
    continue
  fi
  if [ ! -f "$SRC/$f" ]; then
    echo "[$COUNT/$TOTAL] MISSING: $f"
    continue
  fi
  echo "[$COUNT/$TOTAL] Compressing (with audio): $f"
  ffmpeg -y -i "$SRC/$f" \
    -vf "scale='min(768,iw)':-2" \
    -c:v libx264 -crf 30 -preset medium -pix_fmt yuv420p \
    -c:a aac -b:a 96k -movflags +faststart \
    "$DST/$f" 2>/dev/null
done

echo ""
echo "Done. Output size:"
du -sh "$DST"
