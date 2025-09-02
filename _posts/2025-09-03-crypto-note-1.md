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
- $x$가 주어졌을 때, $f(x)$를 계산하긴 쉽지만, $f(x)$가 주어졌을 땐 $f^{-1}(x)$를 계산하는 것은 어렵다.     
  $e.g.)$ 큰 수의 소인수분해 → $pq$ 계산은 쉽지만, $n=pq$ 일 때, $p$ 와 $q$ 를 찾는 것은 어렵다.  

    <details>
      <summary>🎯 <strong>깜짝 퀴즈</strong> 🎯</summary>
      <div style="border:2px solid #007acc; border-radius:6px; padding:8px 12px; background:#f0f8ff; margin:8px 0; width:90%; font-size:0.95em;">
       <strong>일방향 함수만 있으면 공개키 암호를 만들 수 있을까?</strong><br/>
       → <span style="color:red; font-weight:bold;">Open Problem</span><br/>
          <em>(단, 전자서명은 일방향 함수만 있어도 만들 수 있다는 것이 증명됨)</em>
      </div>
    </details>

### 2) Trapdoor One-way Function
- 공개키 암호는 *"누구나 암호화할 수 있고, 특정 비밀키로만 복호화할 수 있어야"* 한다.
- 즉, 일방향 함수에 추가로 **특별한 비밀 정보(Trapdoor Information, 일종의 열쇠 🔑)**가 주어진다면, $y$가 주어졌을 때, $f^{-1}(y)$는 쉽게 계산할 수 있다.

### 3) Diffie-Hellman 키 교환
- 두 사람이 공개된 통신로를 통해 **비밀 정보를 공유**하는 방법   
  - **초기화 (변수 생성후 공개)**   
    • 소수 $q$ ($q-1$ 이 큰 소수 약수를 가짐 - $e.g.) q=23, q-1=22=2 \times 11$)   
    • $q$ 보다 작은 자연수 $g$   
  - **과정**  
    • Alice: 개인키 $a$, 공개키 $A = g^a \pmod{q}$    
    • Bob: 개인키 $b$, 공개키 $B = g^b \pmod{q}$    
    • Eve (도청자): $g^a, g^b$에서 $a, b$ 정보를 알아내는 것은 어렵다.  
      ※ 비밀키 $a, b \in \mathbb{Z}_p \;\; (0 \leq a, b < p \;\text{ 또는 }\; -\tfrac{p}{2} \leq a, b < \tfrac{p}{2})$  
  - **공통 비밀키 생성**  
    • Alice는 $a, g^{b}$로 $g^{ab}$ 를 계산할 수 있다.  
    • Bob은 $b, g^{a}$로 $g^{ba}$ 를 계산할 수 있다.  
      ※ 단, $g^{ab} = g^{ba}$ 이 성립하려면 연산 구조가 **가환군(Commutative Group)** 이어야 한다.  

    <details>
      <summary>📌 <strong>가환군(Commutative Group) = 교환 법칙이 성립하는 군</strong></summary>
      <div style="border:2px solid #007acc; border-radius:6px; padding:8px 12px; background:#f0f8ff; margin:8px 0; width:90%; font-size:0.95em;">
        • 예제 1. $f_b \circ f_a(g) \overset{?}{=} f_a \circ f_b(g)$<br/>     
        • 예제 2. $(g^a)^b \overset{?}{=} (g^b)^a$<br/>     
        • 예제 3. $a,b$가 행렬일 때, $b(aga^{-1})b^{-1} \overset{?}{=} a(bgb^{-1})a^{-1}$<br/>    
      </div>
    </details>

  - **안전성**  
    • <span style="color:red; font-weight:bold;">Eve는 $(g, g^a, g^b)$ 만으로는 $g^{ab}$ (공통 비밀 정보)를 계산하기 어렵다.</span>  
      → 이를 **이산 로그 문제(Discrete Logarithm Problem)** 라고 한다.    

    <details>
      <summary>🔎 왜 <strong>"이산 로그 문제"</strong>가 어려운가?</summary>
      <div style="border:2px solid #007acc; border-radius:6px; padding:8px 12px; background:#f0f8ff; margin:8px 0; width:90%; font-size:0.95em;" markdown="1">
      • 만약 모듈러 $p$ 없이 **정수 지수승**이라면:  
      &nbsp;&nbsp;$g^1, g^2, g^3, \dots$ 의 값은 계속 커지고, 대략 몇 번 곱했는지 추측할 수 있음  
      &nbsp;&nbsp;*→ 여러 번 반복하면 로그 값(지수)을 조금씩 알아낼 수 있다.*  

      • 그러나 모듈러 $p$ 연산을 하면:  
      &nbsp;&nbsp;$g^a \pmod{p}$는 $0 \sim p-1$ 범위 안에서 **뒤섞여(cycle)** 나타남  
      &nbsp;&nbsp;*→ 출력 값만 보고는 $a$의 크기를 추측할 단서가 사라진다.*  

      • 따라서 $y = g^a \pmod{p}$에서 $a$를 찾는 문제는 현재로써는 **지수 시간**이 걸린다.  

      📌 **정리**  
      • 정수 로그: 크기 비교로 추측 가능 → 쉽다.  
      • 이산 로그(mod p): 값이 wrap-around 되므로 추측 불가 → 어렵다.  
      • Diffie–Hellman 키 교환의 안전성은 바로 이 **DLP의 난이도**에 기반한다.
      </div>
    </details>

    <details>
      <summary>🎯 <strong>깜짝 퀴즈</strong> 🎯</summary>
      <div style="border:2px solid #007acc; border-radius:6px; padding:8px 12px; background:#f0f8ff; margin:8px 0; width:90%; font-size:0.95em;">
       <strong>Discrete Logarithm 문제가 안전하면 Diffie-Hellman 문제는 어려울까?</strong><br/> 
       <strong>혹은 Diffie-Hellman 문제를 풀 수 있다면 Discrete Logarithm 문제도 풀릴까?</strong><br/>
       → <span style="color:red; font-weight:bold;">Difficult Problem</span><br/><br/>

      <strong>[ DL과 DH의 관계 ]</strong><br/>  
      • DL: $(g, g^a)$ 를 알 때 → $a$ 를 안다. <br/>  
      • DH: $(g, g^a, g^b)$ 를 알 때 → $g^{ab}$ 를 안다. <br/><br/>  

      - <strong>항상 성립:</strong> DL이 풀면 DH도 풀 수 있다. <br/>  
      <span style="color:red; font-weight:bold;">&nbsp;&nbsp;→ 왜냐하면 $a$나 $b$를 알면 바로 $g^{ab}$를 계산할 수 있기 때문</span><br/>

      - <strong>미해결 문제:</strong> DH가 풀면 DL도 풀 수 있다. <br/>  
      <span style="color:red; font-weight:bold;">&nbsp;&nbsp;→ 일반적으로는 아직 알려지지 않은 Open Problem</span><br/>

      - <strong>특별한 경우: $g$의 order = $p$인 경우,</strong> <br/>
      &nbsp;&nbsp; • $\mathbb{DL}_p = \mathbb{DH}_p,$ $if$ $\exists$ <em>an elliptic curve $E$ over $\mathbb{Z}_p$ $s.t.$ $|E(\mathbb{Z}_p)|$ is smooth.</em> <br/>  
      &nbsp;&nbsp;&nbsp;&nbsp; → 만약 어떤 타원곡선 $E$가 유한체 $\mathbb{Z}_p$ 위에 정의돼 있고, 그 점들의 개수 $|E(\mathbb{Z}_p)|$가 
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <em>smooth</em>하다면, <strong>DL 문제와 DH 문제가 동치</strong>라는 결과가 알려져 있다. <br/>
      <span style="color:red; font-weight:bold;">&nbsp;&nbsp;&nbsp;&nbsp; → 충족하는 것을 찾는 데 걸리는 시간 $\neq$ 다항식 시간</span><br/>

      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ※ <strong>$g$의 order(위수)</strong>란 "$g$를 계속 곱하다 보면 언젠가 처음 상태(1)로 돌아오는데, <br/>  
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;그때까지 <strong>몇 번 곱해야 돌아오는지</strong>"를 의미한다. <br/>  
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;→ 즉, <strong>사이클 길이</strong>라고 이해하면 된다. <br/>

      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ※ <strong><em>smooth</em></strong>란 큰 소수(prime number) 없이 작은 소수들만 곱한 것을 의미한다. <br/> 
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;→ 예. 840 = $2^3 \cdot 3 \cdot 5 \cdot 7$ <br/><br/>

      📌 <strong>쉽게 말하면,</strong><br/>
      - 평소엔 DL이 더 어려운 문제일 수도 있다.<br/>  
      - 하지만 특정 조건(타원곡선 위 점 개수가 smooth할 때)에서는 <br/> 
      &nbsp;&nbsp;→ DH와 DL이 사실상 같은 난이도의 문제로 수렴한다. <br/> 

      </div>
    </details>

### 4) PKC (Public-Key Cryptography) Schemes
- 1976 ~ 1979  
  • Diffie & Hellman | R.Rivest, A.Shamir, L.Adleman | Rabin scheme | Williams scheme |  
  &nbsp;&nbsp;McEliece scheme | Knapsack scheme   
- 1985 ~ Current  
  • ElGamal scheme (Diffie & Hellman을 Encryption으로 바꾼 경우)  
  • Elliptic Curve based scheme | Hidden Field Equations | Lattice Cryptography |  
  &nbsp;&nbsp;Non-abelian group Cryptography | Fully Homomorphic Encryption  

<details>
  <summary>📚 <strong>참고 자료 모아보기</strong></summary>
  <div markdown="1">

  <h3> 1) 공개키 암호가 생겨난 이유 </h3>
  - **대칭키 암호(Symmetric Cryptosystem)의 한계**    
    • 모든 통신 쌍이 서로 다른 비밀키를 공유해야 안전함    
    • 참가자 수가 $n$일 때 필요한 키 개수는 조합으로 계산됨: $\binom{n}{2} = \frac{n(n-1)}{2}$.   
    • 예: $n = 100 → 4,950$개의 키 필요    
    • 규모가 커질수록 키 관리가 폭발적으로 어려워짐    

  - **발명 동기**  
    • “비밀키를 미리 공유하지 않고도 안전하게 통신할 수 없을까?” → **Diffie & Hellman**의 아이디어    
    • 여기서 나온 개념이 바로 **공개키 암호(PKC)**    

  - **공개키 암호의 혁신**  
    • 공개키: 누구나 알 수 있음 → 암호화에 사용    
    • 비밀키: 당사자만 알고 있음 → 복호화에 사용    
    • 따라서 키를 미리 비밀리에 나눌 필요 없음 → 키 관리 문제 해결    

  <h3> 2) Merkle’s Puzzle (1974) </h3>
  - 최초로 “공개키 개념”을 제안한 시도    
  - Ralph Merkle, UC Berkeley 컴퓨터 보안 수업(1974) 제안    
  - 논문: *Secure Communication over Insecure Channels* (CACM, 1978)    

  - **Merkle Puzzle 아이디어**  
    • 많은 퍼즐 중 하나를 선택해 해결 → 두 당사자만 공유하는 비밀키 획득    
    • 공격자는 퍼즐을 전부 풀어야 하므로 비용이 급격히 증가    
    • 다만 차이가 “1000배 수준(다항시간 내에 해결 가능)”이라 실제 보안성은 부족    

  - 📌 교훈:  
    • **퍼즐 수를 늘리면 안전성은 기하급수적으로 증가**    
    • 이 아이디어가 이후 Diffie–Hellman 키 교환으로 발전    

  <h3> 3) 복잡도 (Complexity) </h3>  
  암호학은 결국 **“쉽게 할 수 있는 연산과, 되돌리기 어려운 연산의 차이”**에 의존한다.    

  - **연산 복잡도별 분류**   
    • *Linear*: Addition, Subtraction   
    • *Quadratic*: Multiplication, Euclidean Algorithm, Modular Operations    
    • *Cubic*: Exponentiation, Matrix Multiplication, Gaussian Elimination    
    • *Exponential*: Factorization, TSP, Subset Sum, Lattice Problems    

  - 📌 암호학적 핵심:   
    • **앞으로 계산은 쉽다 (다항 시간)**   
    • **거꾸로 풀기는 어렵다 (지수 시간)**   
    • RSA: 곱셈은 빠름, 소인수분해는 어렵다   
    • 격자 기반 암호: Lattice 문제의 난이도 활용   

  - **P vs NP**  
    • **P**: 다항 시간(Polynomial time) 안에 풀 수 있는 문제    
    • **NP**: 답이 맞는지 *검증*은 다항 시간 안에 가능(Non-deterministic Polynomial)     
    • **P ⊆ NP**, NP-complete = NP ∩ NP-hard    
    • 만약 **P = NP**라면, 현재 암호 시스템 대부분이 무너짐 (소인수분해, 이산 로그 등도 다항 시간에 풀리게 됨)    
    • 아직까지 전 세계적으로 해결되지 않은 **컴퓨터 과학 최대 난제** 중 하나.   

  - 대표적인 어려운 문제들    
    • **TSP (Traveling Salesman Problem)**    
      도시 목록과 거리 정보가 주어졌을 때, 모든 도시를 정확히 한 번 방문하는 가장 짧은 경로를 찾는 문제    

    • **SSP (Subset Sum Problem)**    
      정수 집합이 주어졌을 때, 어떤 부분집합의 합이 정확히 0이 되는지 묻는 문제    

    • **Integer Factorization**    
      큰 수 \(n = pq\)를 소인수분해하는 문제 (RSA 안전성의 기반)    

  </div>
</details>


## 2. RSA