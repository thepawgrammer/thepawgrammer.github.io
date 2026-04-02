---
title: "MaskCRYPT: Federated Learning With Selective Homomorphic Encryption"
date: 2025-08-06
permalink: /deepdive/2025/08/maskcrypt/
layout: single
collection: deepdive
use_math: true
slides: /files/slides/20250806 - MaskCRYPT.pdf
tags:
  - federated-learning
  - homomorphic-encryption
  - ppml
---

<!-- 배너 이미지 + 링크 -->
<a href="https://ieeexplore.ieee.org/document/10506637" target="_blank">
  <img src="/images/deepdives/he/maskcrypt.png"
       alt="MaskCRYPT: Federated Learning With Selective Homomorphic Encryption"
       style="max-width:500px; width:100%; border-radius:10px; margin:20px auto; display:block;"/>
</a>

This post is based on the paper *MaskCRYPT: Federated Learning With Selective Homomorphic Encryption*.  
이 글은 *MaskCRYPT: Federated Learning With Selective Homomorphic Encryption* 논문을 기반으로 정리한 내용이다.  

<!--more-->

<details open>
  <summary>
  <span style="font-size:1.25em; font-weight:bold;">
    Overview
  </span>
  </summary>
  <div markdown="1">

---

**Summary:**  
A review of *MaskCRYPT*, which proposes selective homomorphic encryption to balance privacy and efficiency in federated learning.

🔑 **Research Question:**  
- *Do we need to encrypt all model weights to ensure privacy?*

⚙️ **Key Mechanism: Selective Homomorphic Encryption**  
- Uses gradient-based importance to identify which parameters should be encrypted  
- Each client generates a local mask based on importance scores  
- The server aggregates these into a global **Mask Consensus**  
- Only selected parameters are encrypted, while others are aggregated in plaintext  

📊 **Main Results:**  
- Encrypting as little as **1% of parameters** can defend against membership inference and reconstruction attacks  
- Reduces communication overhead by up to **4.15×**  
- Improves wall-clock training time  
- Maintains accuracy comparable to non-encrypted training  

⚠️ **Limitations / Open Questions:**  
- Requires communication of local importance scores  
- Fairness and correctness of Mask Consensus must be ensured  
- Evaluated only on moderate-scale models and datasets  

💡 **Insight:**  
MaskCRYPT suggests that **full encryption may be unnecessary** in practical federated learning systems, and that selectively protecting sensitive components can provide a better trade-off between security and efficiency.

---

**Slides:**  
[PDF (Korean) Download](/files/slides/20250806 - MaskCRYPT.pdf)

  </div>
</details>