---
title: 'Public-Key Cryptography and RSA'
date: 2025-09-03
permalink: /posts/2025/09/crypto-note-1/
tags:
  - public-key
  - RSA
  - cryptography
---

<!-- 배너 이미지 + 링크 -->
<a href="https://etl.snu.ac.kr/courses/67ac1cbf62137e66b0296b17" target="_blank">
  <img src="/images/explorations/crypto-cheon.png" alt="서울대학교 천정희 교수님의 암호론 강의" style="width:100%; border-radius:10px; margin-bottom:20px;"/>
</a>

해당 포스트는 서울대학교 천정희 교수님의 암호론 강의를 기반으로 작성하였다. 이번 포스트에서는 공개키암호와 RSA와 관련된 강의를 수강 후 요약•정리하고자 한다.

1. 공개키암호 (Public-Key Cryptography)
------
1) One-way Function
- x가 주어졌을 때, f(x)를 계산하긴 쉽지만, f(x)가 주어졌을 땐 f<sup>-1</sup>(x)를 계산하긴 어렵다.

<div style="border:2px solid #007acc; border-radius:6px; padding:8px 12px; background:#f0f8ff; margin:8px 0; width:80%; font-size:0.95em;">
  <strong>🎯 깜짝 퀴즈 🎯 일방향 함수만 있으면 공개키 암호를 만들 수 있을까?</strong>
  → <span style="color:red; font-weight:bold;">Open Problem</span><br/>
  <em>단, 전자서명은 일방향 함수만 있어도 만들 수 있다는 것이 증명됨.</em>
</div>

2) Trapdoor One-way Function
  - x가 주어졌을 때, f(x)를 계산하긴 쉽지만, f(x)가 주어졌을 땐 f<sup>-1</sup>(x)를 계산하긴 어렵다.
    단, 특정 정보(Trapdoor Information)이 주어졌을 때, y가 주어졌을 때, f<sup>-1</sup>(y)는 계산하긴 쉽다.



2. RSA
------