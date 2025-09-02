---
title: 'Public-Key Cryptography and RSA'
date: 2025-09-03
use_math: true   # ← 이 줄 추가
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

### 1) One-way Function
- x가 주어졌을 때, f(x)를 계산하긴 쉽지만, f(x)가 주어졌을 땐 f<sup>-1</sup>(x)를 계산하는 것은 어렵다.
  e.g.) 큰 수의 소인수분해 → pq계산은 쉽지만, n=pq일 때, p와 q를 찾는 것은 어렵다.

<div style="border:2px solid #007acc; border-radius:6px; padding:8px 12px; background:#f0f8ff; margin:8px 0; width:80%; font-size:0.95em;">
  <strong>🎯 깜짝 퀴즈 🎯 일방향 함수만 있으면 공개키 암호를 만들 수 있을까?</strong><br/>
  → <span style="color:red; font-weight:bold;">Open Problem</span><br/>
  <em>(단, 전자서명은 일방향 함수만 있어도 만들 수 있다는 것이 증명됨)</em>
</div>

### 2) Trapdoor One-way Function
- x가 주어졌을 때, f(x)를 계산하긴 쉽지만, f(x)가 주어졌을 땐 f<sup>-1</sup>(x)를 계산하는 것은 어렵다.  
- 그러나 **특별한 비밀 정보(Trapdoor Information, 일종의 열쇠🔑)**만 있다면, y가 주어졌을 때, f<sup>-1</sup>(y)는 쉽게 계산할 수 있다.

### 3) Diffie-Hellman 키 교환
- 두 사람이 공개된 통신로를 통해 **비밀 정보를 공유**하는 방법

**초기화** (변수 생성후 공개):
- 소수 q (q-1이 큰 소수 약수를 가짐)
- q보다 작은 자연수 g  

**과정**:
- Alice: 개인키 $a$, 공개키 $A = g^a \pmod{q}$
- Bob: 개인키 b, 공개키 B = g<sup>b</sup>
- Eve(도청자): g<sup>a</sup>, g<sup>b</sup>에서 a, b 정보를 알아내는 것은 어렵다.
- Alice와 Bob의 공통 비밀정보: g<sup>ab</sup> = g<sup>ba</sup>
      단, g<sup>ab</sup> = g<sup>ba</sup>이기 위해선 가환군일 때만 같다.
      < 가환군 >
      교환 법칙이 성립하는 군
      e.g.1) f<sub>b</sub> ◦ f<sub>a</sub>(g) _?_ f<sub>a</sub> ◦ f<sub>b</sub>(g)
      e.g.2) (g<sup>a</sup>)<sup>b</sup> _?_ (g<sup>b</sup>)<sup>a</sup>
      e.g.3) a, b가 Matrix일 때, b(aga<sup>-1</sup>)b<sup>-1</sup> _?_ a(bgb<sup>-1</sup>)a<sup>-1</sup>

  - 안전성: g<sup>ab</sup>를 (g, g<sup>a</sup>, g<sup>b</sup>)만으로 계산하기 어렵다.



2. RSA
------