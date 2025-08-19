---
title: "Paper Deep Dive – MaskCRYPT"
date: 2025-08-06
slides: /files/slides/20250806 - MaskCRYPT.pdf
layout: talk
collection: talks
author_profile: true
---

**요약:**  
이번 랩 미팅에서는 *MaskCRYPT: Selective Homomorphic Encryption for Federated Learning* 논문을 리뷰했습니다.  

- **핵심 Research Question:** 모델의 모든 weight을 암호화해야 하는가?  
  → 답: 일부 weight만 선택적으로 암호화해도 강력한 방어 가능  

- **핵심 Mechanism:** *Selective Homomorphic Encryption*  
  - 클라이언트는 암호화할 weight index 우선순위 리스트를 계산  
  - 서버가 interleave + 중복 제거해 공통 마스크(Mask Consensus) 생성  
  - 선택된 weight만 암호화, 나머지는 평문 전송  

- **주요 성과:**  
  - 단 **1% weight만 암호화**해도 Membership Inference / Reconstruction 공격 방어  
  - 모델 정확도 유지 + 통신량 최대 **4.15배 감소**  
  - Wall-clock time도 개선  

- **한계점:**  
  - 모든 클라가 서로의 공개키를 공유해야 함 (키 관리 부담)  
  - 복호화 결과를 서버에 재전송해야 함 (통신 오버헤드)  
  - Mask Consensus 생성 방식의 정당성 보장 어려움  

**발표 자료:**  
[PDF 다운로드](/files/slides/20250806 - MaskCRYPT.pdf)