---
title: "Paper Deep Dive – MaskCRYPT"
date: 2025-08-06
slides: /files/slides/20250806 - MaskCRYPT.pdf
layout: talk
collection: talks
author_profile: true
---

**Summary:**  
In this lab meeting, I reviewed *MaskCRYPT: Federated Learning With Selective Homomorphic Encryption* for Federated Learning. While federated learning protects data from direct leakage, exposing model weights can still lead to serious privacy risks such as membership inference attacks. MASKCRYPT addresses this challenge by selectively encrypting only a small fraction of model updates, striking a balance between security and efficiency under homomorphic encryption.  

🔑 **Research Question:** 
- *Do we have to encrypt all the model weights?*  

⚙️ **Key Mechanism:** *Selective Homomorphic Encryption*  
  - Gradient-guided priority list to identify which weights to encrypt.  
  - Clients generate individual masks, which are then aggregated on the server to form a final Mask Consensus shared with all clients.   
  - Encrypt only selected weights, while the rest are transmitted as plaintext averages.  

📊 **Main Results:**  
  - Encrypting as little as 1% of weights effectively defends against membership inference and reconstruction attacks.    
  - Reduced communication overhead by up to 4.15× compared with encrypting all model updates.  
  - Improved wall-clock training time.  
  - Maintained accuracy comparable to non-encrypted training.  

⚠️ **Limitations:**  
  - Clients must exchange local priority lists, introducing overhead.  
  - Correctness and fairness of the Mask Consensus mechanism must be guaranteed.  
  - Evaluated only on moderate-sized models/datasets.  

**Slides:**  
[PDF (Korean) Download](/files/slides/20250806 - MaskCRYPT.pdf)