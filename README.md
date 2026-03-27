# AVControl: Efficient Framework for Training Audio-Visual Controls

[![Project Page](https://img.shields.io/badge/🌐_Project_Page-blue)](https://matanby.github.io/AVControl/)
[![arXiv](https://img.shields.io/badge/arXiv-2603.24793-b31b1b)](https://arxiv.org/abs/2603.24793)
[![YouTube](https://img.shields.io/badge/Video-YouTube-red)](https://www.youtube.com/watch?v=f8D2CwF6BIY)
[![Code](https://img.shields.io/badge/Code-GitHub-black)](https://github.com/Lightricks/LTX-2/tree/main/packages/ltx-trainer)

**Matan Ben-Yosef\*, Tavi Halperin\*, Naomi Ken Korem, Mohammad Salama, Harel Cain, Asaf Joseph, Anthony Chen, Urska Jelercic, Ofir Bibi**

**[Lightricks](https://ltx.io/)**

*\* Equal contribution*

---

[![AVControl Demo](https://img.youtube.com/vi/f8D2CwF6BIY/maxresdefault.jpg)](https://www.youtube.com/watch?v=f8D2CwF6BIY)

---

AVControl is a lightweight, extendable framework built on [LTX-2](https://ltx.io/model/ltx-2) for training diverse audio-visual controls using LoRA adapters on a parallel canvas. Each control modality is trained independently — no architectural changes, no new layers — just a small dataset and a short training run.

### 🎛️ Supported Modalities (13+)

- **Spatially-aligned controls** — depth, pose, edges
- **Camera trajectory** — from a single image or existing video, with intrinsics
- **Sparse motion tracking** — point trajectories
- **Video editing** — inpainting, outpainting, mask-free local edit, detailing
- **Audio-visual** — audio intensity control, speech-to-ambient, who-is-talking

### 📖 Citation

```bibtex
@article{benyosef2026avcontrol,
  title     = {AVControl: Efficient Framework for Training Audio-Visual Controls},
  author    = {Ben-Yosef, Matan and Halperin, Tavi and Ken Korem, Naomi and Salama, Mohammad and Cain, Harel and Joseph, Asaf and Chen, Anthony and Jelercic, Urska and Bibi, Ofir},
  journal   = {arXiv preprint arXiv:2603.24793},
  year      = {2026},
}
```
