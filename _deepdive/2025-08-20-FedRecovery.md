---
title: "FedRecovery: Differentially Private Machine Unlearning for Federated Learning Frameworks"
date: 2025-08-20
permalink: /deepdive/2025/08/fedrecovery/
layout: single
collection: deepdive
use_math: true
slides: /files/slides/20250820 - FedRecovery.pdf
tags:
  - federated-learning
  - unlearning
  - differential-privacy
  - ppml
---

<!-- 배너 이미지 + 링크 -->
<a href="https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=10189868" target="_blank">
  <img src="/images/deepdives/dp/fedrecovery.png"
       alt="FedRecovery: Differentially Private Machine Unlearning for Federated Learning Frameworks"
       style="max-width:500px; width:100%; border-radius:10px; margin:20px auto; display:block;"/>
</a>

This post is based on the paper *FedRecovery: Differentially Private Machine Unlearning for Federated Learning Frameworks*.  
이 글은 *FedRecovery: Differentially Private Machine Unlearning for Federated Learning Frameworks* 논문을 기반으로 정리한 내용이다.  

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
A review of *FedRecovery*, which proposes an efficient approach to machine unlearning in federated learning without retraining.  

🔑 **Research Question:**  
- *Can we efficiently find a model that performs similarly to the retrained one?*  

⚙️ **Key Mechanism:**  
- Removes client contributions via weighted gradient residual subtraction.  
- Adds carefully calibrated Gaussian noise to ensure indistinguishability from retrained models.  
- Does not rely on convexity assumptions or retraining-based calibration.  

📊 **Main Results:**  
- Achieves statistical indistinguishability between unlearned and retrained models.  
- Maintains comparable accuracy to retraining-based methods.  
- Significantly reduces computational cost.  

⚠️ **Limitations / Open Questions:**  
- Trade-off between noise calibration and model utility.  
- Limited validation on large-scale deep models.  

❓ **Data Privacy Problem:**  
- **Paper Assumption:** The server must identify which client's updates to remove.  
  - Works under Local DP (noisy but identifiable updates)  
  - Breaks under Homomorphic Encryption (updates indistinguishable)  

- **Naive Idea:**  
  - The requesting client sends its past updates multiplied by **-1**, encrypted  
  - Cancels its contribution without revealing gradients  
  - Suggests a possible direction for *client-assisted unlearning under encryption*  

💡 **Insight:**  
FedRecovery reveals a fundamental tension between **privacy and deletability**:  
while stronger protection (e.g., encryption) hides individual contributions, it also makes precise removal difficult.

---

**Slides:**  
[PDF (Korean) Download](/files/slides/20250820 - FedRecovery.pdf)

  </div>
</details>