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

## 1. 공개키암호 (Public-Key Cryptography)
### 1) One-way Function
- x가 주어졌을 때, \(f(x)\)를 계산하긴 쉽지만, \(f(x)\)가 주어졌을 땐 \(f^{-1}(x)\)를 계산하는 것은 어렵다.  
  e.g.) 큰 수의 소인수분해 → pq계산은 쉽지만, \(n=pq\)일 때, p와 q를 찾는 것은 어렵다.  

    <details>
      <summary>🎯 깜짝 퀴즈 보기</summary>
      <div style="border:2px solid #007acc; border-radius:6px; padding:8px 12px; background:#f0f8ff; margin:8px 0; width:90%; font-size:0.95em;">
       <strong>일방향 함수만 있으면 공개키 암호를 만들 수 있을까?</strong><br/>
       → <span style="color:red; font-weight:bold;">Open Problem</span><br/>
          <em>(단, 전자서명은 일방향 함수만 있어도 만들 수 있다는 것이 증명됨)</em>
      </div>
    </details>

### 2) Trapdoor One-way Function
- x가 주어졌을 때, f(x)를 계산하긴 쉽지만, f(x)가 주어졌을 땐 f<sup>-1</sup>(x)를 계산하는 것은 어렵다.  
- 그러나 **특별한 비밀 정보(Trapdoor Information, 일종의 열쇠🔑)**만 있다면, y가 주어졌을 때, f<sup>-1</sup>(y)는 쉽게 계산할 수 있다.

### 3) Diffie-Hellman 키 교환
- 두 사람이 공개된 통신로를 통해 **비밀 정보를 공유**하는 방법
  - **초기화 (변수 생성후 공개)**
    • 소수 q (q-1이 큰 소수 약수를 가짐)
    • q보다 작은 자연수 g  
  - **과정**:
    • Alice: 개인키 $a$, 공개키 $A = g^a \pmod{q}$
    • Bob: 개인키 b, 공개키 B = g<sup>b</sup>
    • Eve(도청자): g<sup>a</sup>, g<sup>b</sup>에서 a, b 정보를 알아내는 것은 어렵다.

**공통 비밀키 생성**:
- Alice와 Bob은 각각 g<sup>ab</sup>, g<sup>ba</sup>를 계산한다.
- 단, g<sup>ab</sup> = g<sup>ba</sup>이 성립하려면 연산 구조가 **가환군(Commutative Group)** 이어야 한다.

📌 가환군(Commutative Group) = 교환 법칙이 성립하는 군  
- e.g.1) f<sub>b</sub> ◦ f<sub>a</sub>(g) __?__ f<sub>a</sub> ◦ f<sub>b</sub>(g)
- e.g.2) (g<sup>a</sup>)<sup>b</sup> __?__ (g<sup>b</sup>)<sup>a</sup>
- e.g.3) a, b가 Matrix일 때, b(aga<sup>-1</sup>)b<sup>-1</sup> __?__ a(bgb<sup>-1</sup>)a<sup>-1</sup>

**안전성**: 
- (g, g<sup>a</sup>, g<sup>b</sup>)만으로는 g<sup>ab</sup>를 계산하기 어렵다.
- 이를 **이산 로그 문제(Discrete Logarithm Problem)** 라고 한다.  


<details>
  <summary>📚 참고 자료 모아보기</summary>
  
  ### 1) 공개키 암호가 생겨난 이유 💡
  - **대칭키 암호(Symmetric Cryptosystem)의 한계**  
    • 모든 통신 쌍이 서로 다른 비밀키를 공유해야 안전함  
    • 참가자 수가 n일 때 필요한 키 개수는 조합으로 계산됨: $\binom{n}{2} = \frac{n(n-1)}{2}$  
    • 예: n = 100 → 4,950개의 키 필요  
    • 규모가 커질수록 키 관리가 폭발적으로 어려워짐  

  - **발명 동기**  
    • “비밀키를 미리 공유하지 않고도 안전하게 통신할 수 없을까?”  
    • → **Diffie & Hellman (1976)**의 아이디어  
    • 여기서 나온 개념이 바로 공개키 암호(PKC)  

  - **공개키 암호의 혁신**  
    • 공개키: 누구나 알 수 있음 → 암호화에 사용  
    • 개인키: 당사자만 알고 있음 → 복호화에 사용  
    • 따라서 키를 미리 비밀리에 나눌 필요 없음 → 키 관리 문제 해결  

  ### 2) Merkle’s Puzzle (1974)
  - 최초로 “공개키 개념”을 제안한 시도  
  - Ralph Merkle, UC Berkeley 컴퓨터 보안 수업(1974) 제안  
  - 논문: *Secure Communication over Insecure Channels* (CACM, 1978)  

  **Merkle Puzzle 아이디어**  
  - 많은 퍼즐 중 하나를 선택해 해결 → 두 당사자만 공유하는 비밀키 획득  
  - 공격자는 퍼즐을 전부 풀어야 하므로 비용이 급격히 증가  
  - 다만 차이가 “1000배 수준(다항시간 내에 해결 가능)”이라 실제 보안성은 부족  

  📌 교훈:  
  - **퍼즐 수를 늘리면 안전성은 기하급수적으로 증가**  
  - 이 아이디어가 이후 Diffie–Hellman 키 교환으로 발전  

  ### 3) 복잡도 (Complexity)
  암호학은 결국 **“쉽게 할 수 있는 연산과, 되돌리기 어려운 연산의 차이”**에 의존한다.  

  - **연산 복잡도별 분류**
    • *Linear*: Addition, Subtraction  
    • *Quadratic*: Multiplication, Euclidean Algorithm, Modular Operations  
    • *Cubic*: Exponentiation, Matrix Multiplication, Gaussian Elimination  
    • *Exponential*: Factorization, TSP, Subset Sum, Lattice Problems  

  📌 암호학적 핵심:  
  - **앞으로 계산은 쉽다 (다항 시간)**  
  - **거꾸로 풀기는 어렵다 (지수 시간)**  
  - RSA: 곱셈은 빠름, 소인수분해는 어렵다  
  - 격자 기반 암호: Lattice 문제의 난이도 활용

  #### 🧩 P vs NP
  - **P**: 다항 시간(Polynomial time) 안에 풀 수 있는 문제  
  - **NP**: 답이 맞는지 *검증*은 다항 시간 안에 가능(Non-deterministic Polynomial)  
  - **P ⊆ NP**, NP-complete = NP ∩ NP-hard  
  - 만약 **P = NP**라면, 현재 암호 시스템 대부분이 무너짐 (소인수분해, 이산 로그 등도 다항 시간에 풀리게 됨)  
  - 아직까지 전 세계적으로 해결되지 않은 **컴퓨터 과학 최대 난제** 중 하나. 

  #### 🧩 대표적인 어려운 문제들
  - **TSP (Traveling Salesman Problem)**  
    도시 목록과 거리 정보가 주어졌을 때, 모든 도시를 정확히 한 번 방문하는 가장 짧은 경로를 찾는 문제  

  - **SSP (Subset Sum Problem)**  
    정수 집합이 주어졌을 때, 어떤 부분집합의 합이 정확히 0이 되는지 묻는 문제  

  - **Integer Factorization**  
    큰 수 \(n = pq\)를 소인수분해하는 문제 (RSA 안전성의 기반)  

</details>


## 2. RSA