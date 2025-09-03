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

해당 포스트는 서울대학교 천정희 교수님의 암호론 강의를 기반으로 작성하였다. 이번 포스트에서는 공개키암호와 RSA와 관련된 강의에서 배운 내용을 요약•정리하고자 한다.

<details>
  <summary>
  <span style="font-size:1.25em; font-weight:bold;">
    1. 공개키암호 (Public-Key Cryptography)
  </span>
  </summary>
  <div markdown="1">

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

---

### 2) Trapdoor One-way Function
- 공개키 암호는 *"누구나 암호화할 수 있고, 특정 비밀키로만 복호화할 수 있어야"* 한다.
- 즉, 일방향 함수에 추가로 **특별한 비밀 정보(Trapdoor Information, 일종의 열쇠 🔑)**가 주어진다면, $y$가 주어졌을 때, $f^{-1}(y)$는 쉽게 계산할 수 있다.

---

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

---

### 4) PKC (Public-Key Cryptography) Schemes
- 1976 ~ 1984  
  - Diffie & Hellman / R.Rivest, A.Shamir, L.Adleman / Rabin scheme / Williams scheme /   
  McEliece scheme / Knapsack scheme   
- 1985 ~ Current  
  - ElGamal scheme (Diffie & Hellman을 Encryption으로 바꾼 경우)  
    <details>
      <summary>📌 <strong>Diffie–Hellman vs Ephemeral Diffie–Hellman</strong></summary>
      <div style="border:2px solid #007acc; border-radius:6px; padding:8px 12px; background:#f0f8ff; margin:8px 0; width:90%; font-size:0.95em;" markdown="1">

      **🔹 기본 Diffie–Hellman (DH)**<br/> 
      - 한 번 생성한 개인키 $a, b$를 **재사용** 가능  
      - 공개키 $A = g^a, B = g^b$도 그대로 유지  
      - 키 합의는 안전하지만, **Forward Secrecy**(순방향 보안)는 보장되지 않음  
        (만약 개인키가 유출되면 과거 통신도 모두 복호화 가능)  
        ※ Forward Secrecy: 장기 개인키가 유출되더라도, 과거의 세션 키와 통신 내용은 복호화되지 않도록 보호하는 성질  

      ---

      **🔹 Ephemeral Diffie–Hellman (Ephemeral DH, ECDHE)**  
      - *Ephemeral* = **세션마다 새로운 개인키 생성**  
      - 각 세션의 $A = g^a, B = g^b$ 가 사실상 **퍼블릭 키(public key)** 역할  
      - 세션이 끝나면 키를 버리므로, **Forward Secrecy** 보장  
        (개인키가 유출돼도 과거 세션은 안전)  
      - 실제로 HTTPS (TLS/SSL)에서 많이 사용됨  

      ---

      📌 **핵심**  
      - “Ephemeral Diffie–Hellman을 쓰면, 그때그때의 공개키$(A, B)$가  
        &nbsp;&nbsp;바로 **퍼블릭 키**로 기능한다.”
      - 즉, DH 자체가 일시적인 **공개키 암호 시스템**이 되는 셈이다.
      </div>
    </details>

    - Key Generation (KG): secret key (sk) = $b$, public key (pk) = $g^b$, ephemeral key = $r$ 
    - 암호화 (Encryption)  
    • Alice가 메시지 $m$을 보낼 때, 임의의 $r$를 선택  
      &nbsp;&nbsp;&nbsp;• 암호문 = $(g^{r}, (g^{b})^r*m)$ → $g^{rb}$는 Bob의 공개키 $g^b$와 Alice의 $r$를 조합해서 생성  
    - 복호화 (Decryption)  
    • Bob(수신자): 개인키 $b$를 사용해 $g^{rb}$ 계산  
      &nbsp;&nbsp;&nbsp;• 복호문 = $m = \dfrac{m \cdot g^{rb}}{g^{rb}}$ 로 원문 복원  
    
    <details>
      <summary>🔐 <strong>Encryption 구조</strong></summary>
      <div style="border:2px solid #007acc; border-radius:6px; padding:10px 15px; background:#f0f8ff; margin:12px 0; width:90%; font-size:0.95em;" markdown="1">

      $$
      \mathrm{Enc}_{pk}: \mathbb{Z}_p \longrightarrow G \times G
      $$  
      $$
      m \longmapsto (g^r,\; g^{rb}\cdot m)
      $$  

      • 여기서 $pk = g^b$, $b$: Bob의 개인키, $r$: Alice가 매 메시지마다 선택하는 난수  
      • ElGamal의 $G$는 “mod $p$에서의 곱셈군” $\mathbb{Z}_p^*$ 을 뜻한다
      </div>
    </details>
    
    <details>
      <summary>🎯 <strong>깜짝 퀴즈</strong> 🎯 </summary>
      <div style="border:2px solid #007acc; border-radius:6px; padding:10px 15px; background:#f0f8ff; margin:12px 0; width:90%; font-size:0.95em;" markdown="1">
      
      **Q.** ElGamal 암호화에서 sk = $b$, pk = $g^{b}$ 일 때,  
      &nbsp;&nbsp;&nbsp;&nbsp;• $$
      \mathrm{Enc}_{pk}: \mathbb{Z}_p \longrightarrow G \times G
      $$  
      &nbsp;&nbsp;&nbsp;&nbsp;• $$
      m \;\mapsto\; (g^r,\; g^{rb}\cdot m)
      $$  
      &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red; font-weight:bold;">→ 복호화하기 위해서 필요한 정보는 무엇일까?</span> 

      **A.** 바로 **Bob의 개인키 $b$** 이다.  
      &nbsp;&nbsp;&nbsp;&nbsp;$(g^r, g^{rb}\cdot m)$에서 $m$을 되찾으려면 $g^{rb}$를 알아야 하고,  
      &nbsp;&nbsp;&nbsp;&nbsp;이를 계산할 수 있는 유일한 정보가 $b$ 다.  

      → 따라서 **$b$ 가 Trapdoor (비밀 열쇠)** 역할을 한다.  

      ⚠️ 단, 그렇다 해서 **Trapdoor One-way Function** 은 아니다.  
      &nbsp;&nbsp;&nbsp;&nbsp;→ 왜냐하면 ElGamal은 항상 같은 $f(x)$를 내는 고정된 함수가 아니라,  
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**매번 임의의 $r$을 뽑아 다른 출력이 나오는 확률적 암호화 방식**이기 때문이다.  
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;즉, 수학적 함수라기보다는 **암호화 스킴 전체**에서  
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;“거꾸로 갈 수 있게 해주는 비밀키”라는 의미로 트랩도어처럼 동작한다.

      ---  
      🔑 **정리** 🔑   
      • **Trapdoor One-way Function**  
        → “일방향만 쉽다." *(단, 비밀 정보(Trapdoor)가 있으면 거꾸로도 쉽다.)*  

      • **공개키 암호 (PKC)**  
        → “누구나 공개키로 암호화는 쉽게 할 수 있지만, 복호화는 어렵다."  
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*(단, 비밀키가 있으면 복호화가 쉽다.”)*  

      ∴ 즉, 구조적으로 보면 **공개키 암호(PKC) ≈ Trapdoor One-way Function**이다.  
      → 다만 수학적으로 *정확히 동치* 라기보다는,    
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PKC가 성립하려면 **TOWF가 존재해야 한다**는 의미에서 **개념적 동치**로 본다.  

      </div>
    </details>

  - Elliptic Curve based scheme / Hidden Field Equations / Lattice Cryptography /  
  Non-abelian group Cryptography / Fully Homomorphic Encryption  

- Hard Problems for PKC 
  - Integer Factorization Problem (IFP)  
    • 큰 수 $n = pq$ 를 소인수분해하는 문제  
    • 관련: Quadratic Residuocity Problem  
  - Discrete Logarithm Problem (DLP)  
    • $y = g^x \pmod p$에서 $x$를 구하는 문제  
    • 확장: Generalized DLP (Elliptic Curve, Hyperelliptic Curve, Class Field)   
  - Linear Code Decoding  
  - Multivariate Equations  
    • 여러 변수에 대해 2차 이상의 다항식을 푸는 문제  
    • 일반형:  
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$$
      \begin{cases}
      f_{1}(x_{1}, ..., x_{n}) = a_{1} \\
      f_{2}(x_{1}, ..., x_{n}) = a_{2} \\
      \vdots \\
      f_{n}(x_{1}, ..., x_{n}) = a_{n}
      \end{cases}
      $$  
      &nbsp;&nbsp;→ 1차(선형)일 경우, 가우스 소거법으로 $O(n^3)$ 안에 풀림  
      &nbsp;&nbsp;→ 2차 이상일 경우, **NP-hard** (실질적으로 매우 어려움)  
    • 관련: Hidden Field Equations, Isomorphism of Polynomials   
  - Nonabelian Group (비가환군)  
    • Conjugacy Problem (켤레 문제): $a, b$가 주어졌을 때 $x^{-1}ax = b$인 $x$를 찾는 문제  
    • Decomposition Problem: 주어진 원소를 이루는 생성자들의 곱으로 분해하는 문제    
    ※ 다만, 행렬군에서는 다항 시간 내로 풀려서, Braid Group(꼬임군) 등 다른 구조 사용  
  - Lattice 기반 문제   
    • SVP (Shortest Vector Problem): 주어진 격자에서 가장 짧은 벡터 찾기    
    • CVP (Closest Vector Problem): 주어진 점에 가장 가까운 격자 벡터 찾기   
    • 파생 문제들:  
      • Learning with Errors (LWE): $y = Ax + e \pmod q$에서 $x$를 찾는 문제 (작은 오류 $e$ 포함)  
      • Approximate Common Divisor (ACD): 약간의 노이즈가 있는 공약수 문제  

  → 다만, 아직까지 **<span style="color:red;">NP-hard 문제를 기반으로 한 암호 스킴</span>**은 실용적으로 설계하진 못함  

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

---

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

---

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

  </div>
</details>

---

<details>
  <summary>
  <span style="font-size:1.25em; font-weight:bold;">
    2. RSA (Rivest-Shamir-Adleman)
  </span>
  </summary>
<div markdown="1">  

### 1) Prime
<details style="margin-left:20px;">
  <summary>📘 <strong>Prime (소수)와 Euclid의 정리</strong></summary>
  <div style="border:2px solid #007acc; border-radius:6px; padding:12px 15px; background:#f0f8ff; margin:12px 0; width:95%; font-size:0.95em;" markdown="1">

  <h3>- Prime (소수) 기본 개념 </h3>  
  - **소수 정의**  
    $p \geq 2$ 인 정수 $p$가 소수일 경우,
    $$
    a \mid p \;\Rightarrow\; a = \pm 1 \;\;\text{또는}\; \pm p
    $$ 를 만족  
    → 즉, 약수가 1과 자기 자신밖에 없음  

  - **Irreducible (기약원)**  
    $p = ab$ 를 인수분해했을 때, $a$ 또는 $b$ 중 하나가 단위원(unit, 즉 $\pm 1$) 일 때,  
    $p$ 를 **기약원**이라고 함 → *정수에선 기약원 = 소수라고 생각하면 됨*   

  ---

  <h3>- Euclid의 정리 </h3>  
  - **Euclid’s Lemma**  
    $$
    p \mid ab \;\;\Rightarrow\;\; p \mid a \;\;\text{또는}\;\; p \mid b
    $$  
    → 소수의 중요한 성질! (소수는 약간 “쪼갤 수 없는 블록”이라는 뜻)  

  - **예시**  
    • $p=5$, $ab = 20 = 4 \times 5$: $5 \mid (4 \times 5) \;\Rightarrow\; 5 \mid 5$ ✅  
    • $p=7$, $ab = 21 = 3 \times 7$: $7 \mid (3 \times 7) \;\Rightarrow\; 7 \mid 7$ ✅  
    • $p=6$, $ab = 6 = 2 \times 3$: $6 \mid (2 \times 3)$ 이지만 $6 \nmid 2$, $6 \nmid 3$ ❌ (합성수이므로 성립 ❌)  

  - **무한 소수 정리 (Euclid)**  
    • "소수는 무한히 많다."  
    &nbsp;&nbsp;→ 만약 소수가 유한 개만 있다면, 그 소수들을 모두 곱한 뒤 +1을 하면 새로운 소수가 나타나  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;모순이 생긴다.  

  </div>
</details>

- **Prime Number Theorem (소수 정리)**  
  - $\pi(x)$ = $x$ 이하의 소수 개수  
  - 정리:
    $$
    \lim_{x \to \infty} \pi(x) / (\frac{x}{\ln x}) = 1
    $$
    → $x$ 이하 소수의 개수는 대략 $\dfrac{x}{\ln x}$  

  - 해석: "임의의 $x$ 근처의 수가 소수일 확률" ≈ $\dfrac{1}{\ln x}$  
    - 여기서 $\ln$은 자연로그 (밑 = $e$ ), 정확히는 **$\dfrac{1}{(\text{자리수}) \cdot \ln 10}$**  
    - 직관적으로 "10자리 수면 약 $\frac{1}{10}$, 100자리 수면 약 $\frac{1}{100}$ 확률" 

  - 예시  
    - $x = 10$ → 확률 $\frac{1}{\ln 10} \approx \frac{1}{2.3}$  
    - $x = 10^{10}$ (10자리) → 확률 $\frac{1}{(10 \ln 10)} \approx \frac{1}{23}$  
    - $x = 10^{100}$ (100자리) → 확률 $\frac{1}{(100 \ln 10)} \approx \frac{1}{230}$  
    - $x = 3^{100}$ (약 $10^{47.7}$ 크기의 수, 48자리 수 정도):
    $$
    \frac{1}{\ln(3^{100})} = \frac{1}{100 \ln 3} \approx \frac{1}{110}
    $$  
    → 따라서 $3^{100}$가 소수일 확률은 약 $\frac{1}{110}$  
  
  - 일반 소수 정리의 오차항  
    - $$
      \pi(x) = \frac{x}{\ln x} + O\left(\frac{x}{\ln^2 x}\right)
      $$  
      → 즉, 실제 소수 개수는 $\dfrac{x}{\ln x}$에 가깝지만, 그 차이는 대략 $\dfrac{x}{\ln^2 x}$ 정도 크기  

- **Riemann Hypothesis (리만 가설)**  
  - 오차 항의 정밀도에 관한 주장  
  - $ \lvert \pi(x) - \mathrm{li}(x) \rvert < x^{\frac{1}{2}} \ln x $, where $\mathrm{li}(x) := \int_2^x \frac{1}{\ln t} dt = \frac{x}{\ln x}+O(\frac{1}{\ln ^{2}t})$   
  - 비교
    - 일반 소수 정리: 오차항 $O\left(\tfrac{x}{\ln^2 x}\right)$  
    - 리만 가설: 오차항 $O\left(x^{\frac{1}{2}}\ln x\right)$ (훨씬 더 작음)  
  - 예시 : $x = e^{100}$ 일 때,
    - 일반 소수 정리 오차:
      $$
      \frac{e^{100}}{(\ln e^{100})^2} = \frac{e^{100}}{100^2}
      $$  
    - 리만 가설 오차:
      $$
      (e^{100})^{\frac{1}{2}} \cdot \ln(e^{100}) = e^{50} \cdot 100
      $$  
    → RH가 참이라면, 오차가 $ \frac{e^{100}}{100^2} $ 에서 $ e^{50}\cdot 100 $ 으로, 약 $ \frac{e^{50}}{100^{3}} \approx 3\cdot 10^{15} $ 배 대폭 줄어듦