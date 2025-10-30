---
title: "Paper Deep Dive – FedRecovery"
date: 2025-08-20
slides: /files/slides/20250820 - FedRecovery.pdf
layout: talk
collection: talks
author_profile: true
---

**Summary:**  
For the lab meeting, I prepared a review of *FedRecovery: Differentially Private Machine Unlearning for Federated Learning Frameworks*. Machine unlearning aims to make models “forget” specific client data upon deletion requests. Unlike retraining-based solutions, which are often infeasible or risky in federated learning, FedRecovery introduces an efficient method to erase a client’s influence from the global model using a weighted sum of gradient residuals and differential privacy noise, without assuming convexity.  

🔑 **Research Question:**  
  - *Can we efficiently find a model that performs similarly to the retrained one?*  

⚙️ **Key Mechanism:**
  - Removes client contributions via weighted gradient residual subtraction.  
  - Adds carefully tailored Gaussian noise to guarantee indistinguishability between unlearned and retrained models.     
  - Does not require retraining-based calibration or convexity assumptions.   

📊 **Main Results:**  
  - Achieves statistical indistinguishability between unlearned and retrained models.  
  - Experimental results on real-world datasets show comparable accuracy to retrained models.  
  - Significantly more efficient than retraining-based approaches.  

⚠️ **Limitations / Open Questions:**  
  - Trade-offs in noise calibration vs. model utility.   
  - Applicability to very large-scale, complex neural networks not fully explored.  

❓ **Data Privacy Problem**
  - **Paper Assumption:** Unlearning requires the server to identify which client’s updates to remove. Local DP allows this with noisy updates, but *homomorphic encryption makes it infeasible*, since encrypted updates are indistinguishable, deletion requests lose meaning.
  - **Naive Idea:** Instead of abandoning encryption, the deletion-requesting client could *send its past updates multiplied by -1, encrypted under homomorphic encryption*. This would effectively cancel its previous contribution without revealing raw gradients, offering a potential direction for client-assisted unlearning under encryption.  

**Slides:**  
[PDF (Korean) Download](/files/slides/20250820 - FedRecovery.pdf)