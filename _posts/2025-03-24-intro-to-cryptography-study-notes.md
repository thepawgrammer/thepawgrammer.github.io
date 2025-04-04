---
title: Introduction to Cryptography Lecture 01 - Study Notes
date: 2025-03-24 16:46:22 +0900
categories: [cryptography, study-notes]
tags: [crypto, cryptography, 암호학, symmetric-key, 대칭키, christof, paar, christofpaar, studynotes, thepawgrammer]
image:
  path: /assets/img/cryptography/introtocrypto/lec01/00preview.png
  alt: Introduction to Cryptography - Lecture 01 by Prof. Christof Paar
---

<div style="background: #f9f9f9; border-left: 5px solid #4a90e2; padding: 1em; margin-bottom: 2em;">
  <h3 style="margin-top: 0;">🔐 Intro to Cryptography Series</h3>
  <p style="margin-bottom: 0;">This post is part of my ongoing study series based on <strong>Prof. Christof Paar’s “Introduction to Cryptography”</strong>.</p>
  <p style="font-size: 0.9em;"><strong>By:</strong> <em>thepawgrammer</em> &nbsp;&nbsp;|&nbsp;&nbsp; <strong>Watch the course:</strong> <a href="https://youtu.be/2aHkqB2-46k" target="_blank">YouTube Link</a></p>
</div>

## 1. Classification  

### 💡 Modern Applications of Cryptography  

| Application | Description |  
|-------------|-------------|  
| **Secure Messaging** | End-to-end encryption ensures that only the sender and receiver can read the message.<br><sub style="color: gray;">종단 간 암호화는 오직 발신자와 수신자만 메시지를 읽을 수 있도록 보장합니다.</sub> |
| **Digital Signatures in Software Updates** | Ensures the integrity and authenticity of software updates.<br><sub style="color: gray;">소프트웨어 업데이트의 무결성과 진위 여부를 확인할 수 있게 해줍니다.</sub> |
| **Cryptographic Voting Protocols** | Enables secure, private, and verifiable electronic voting.<br><sub style="color: gray;">전자 투표에서 보안, 프라이버시, 검증 가능성을 제공합니다.</sub> |
| **Blockchain and Cryptocurrencies** | Uses cryptographic techniques to secure decentralized digital assets.<br><sub style="color: gray;">분산된 디지털 자산을 보호하기 위해 암호화 기술을 사용합니다.</sub> |

### 🔍 Cryptology Breakdown  

<figure>
  <img src="/assets/img/cryptography/introtocrypto/lec01/01cryptology_breakdown.jpg"
       alt="Cryptology Breakdown Diagram"
       style="max-width: 700px; width: 100%; display: block; margin: 0 auto;" />
  <figcaption style="text-align: center; font-size: 0.9rem;">Figure 1: Cryptology Breakdown Diagram</figcaption>
</figure>

---

This diagram shows the relationship between **Cryptology**, **Cryptography**, and **Cryptanalysis**.  
<sub style="color:gray;">이 도표는 암호학(Cryptology), 암호화(Cryptography), 암호 해독(Cryptanalysis)의 관계를 보여줍니다.</sub>

**Cryptology** is the broader field that includes both:  
<sub style="color:gray;">**암호학(Cryptology)**은 암호화와 암호 해독을 모두 포함하는 넓은 분야입니다.</sub>

- **Cryptography**: The science of designing secure communication systems using techniques like encryption, hashing, and digital signatures. (Think: **protectors**)  
  <sub style="color:gray;">**암호화(Cryptography)**는 암호화, 해싱, 디지털 서명 등을 이용해 안전한 통신 시스템을 설계하는 것입니다.</sub>

- **Cryptanalysis**: The science of breaking cryptographic systems, finding vulnerabilities, or recovering original messages without a key. (Think: **hackers**)  
  <sub style="color:gray;">**암호 해독(Cryptanalysis)**는 암호 시스템의 약점을 분석하거나 키 없이 원문을 복원하는 것입니다.</sub>

In this study series, we’ll focus on **cryptography** — understanding how secure systems are designed, rather than how they’re broken.  
<sub style="color:gray;">이 시리즈에서는 암호 해독보다는 안전한 시스템이 어떻게 설계되는지, 즉 **암호화**에 중점을 둡니다.</sub>

---

## 2. Setting Up Symmetric Cryptography  

> 🔑 **Key Takeaway:** <span style="color: #d6336c;">Never use a crypto algorithm that hasn’t been tested!</span>  
> <sub style="color: gray;">검증되지 않은 암호 알고리즘은 절대 사용하지 마세요.</sub>

Well-designed encryption must be **open and public**, so that experts can test it and verify its strength.  
<sub style="color:gray;">암호는 공개되어야 전문가들이 테스트해보고, 오랜 시간 안전성이 입증된 후에야 믿고 쓸 수 있습니다.</sub>

### 📘 Notation Guide  

| Symbol      | Meaning                            |
|-------------|------------------------------------|
| `x`         | Plaintext                          |
| `y`         | Ciphertext                         |
| `e`         | Encryption function                |
| `d`         | Decryption function                |
| `k`         | Key                                |
| `|K|`       | Key space (number of possible keys)|

<div style="display: flex; justify-content: space-between; gap: 10px; flex-wrap: wrap;">

  <div style="flex: 1; min-width: 300px;">
    <h3>🔓 Before Encryption (1) </h3>
    <img src="/assets/img/cryptography/introtocrypto/lec01/02unencrypted_message.jpg" alt="Unencrypted Message" style="width: 100%;" />
    <p style="font-size: 0.9rem;">
      Oscar can read message <code>x</code> in plain text over an insecure channel.<br>
      <sub style="color:gray;">오스카는 보안되지 않은 채널에서 평문 <code>x</code>를 그대로 읽을 수 있습니다.</sub>
    </p>
  </div>

  <div style="flex: 1; min-width: 300px;">
    <h3>🔐 After Encryption (2) </h3>
    <img src="/assets/img/cryptography/introtocrypto/lec01/03encrypted_message.jpg" alt="Encrypted Message" style="width: 100%;" />
    <p style="font-size: 0.9rem;">
      Now he only sees ciphertext <code>y</code>, and has no idea what the original message was.<br>
      <sub style="color:gray;">이제 오스카는 암호문 <code>y</code>만 볼 수 있고, 원문은 알 수 없습니다.</sub>
    </p>
  </div>

</div>

---

But wait 😱 — if the encryption algorithm is public, doesn’t that mean Oscar can also read the message?  
<sub style="color:gray;">하지만 암호화 알고리즘이 공개되어 있다면, 오스카도 메시지를 읽을 수 있는 것 아닌가요?</sub>

<div style="display: flex; justify-content: space-between; gap: 10px; flex-wrap: wrap;">

  <div style="flex: 1; min-width: 300px;">
    <h3>🔑 Shared Secret Key (1) </h3>
    <img src="/assets/img/cryptography/introtocrypto/lec01/04shared_key.jpg" alt="Shared Secret Key" style="width: 100%;" />
    <p style="font-size: 0.9rem;">
      Even if the algorithm is public, encryption stays secure thanks to a shared secret key.<br>
      <sub style="color:gray;">알고리즘이 공개되어도, 공유된 비밀 키 덕분에 암호는 여전히 안전합니다.</sub>
    </p>
    <p style="font-size: 0.9rem;">
      Alice and Bob must agree on the same key <code>k</code> through a secure channel.<br>
      <sub style="color:gray;">앨리스와 밥은 보안된 채널을 통해 같은 키 <code>k</code>를 공유해야 합니다.</sub>
    </p>
  </div>

  <div style="flex: 1; min-width: 300px;">
    <h3>🔐 Using the Shared Key (2) </h3>
    <img src="/assets/img/cryptography/introtocrypto/lec01/05howtosharekey.jpg" alt="How to Share a Key" style="width: 100%;" />
    <p style="font-size: 0.9rem;">
      Once they share the key, they can safely communicate over insecure networks.<br>
      <sub style="color:gray;">키를 공유한 이후에는, 안전하지 않은 네트워크에서도 안전한 통신이 가능합니다.</sub>
    </p>
  </div>

</div>

---

### 💡 Kerckhoffs' Principle (1883)  

A cryptosystem must remain secure **even if everything is public — except the key**.  
<sub style="color:gray;">암호 시스템은 키를 제외한 모든 것이 알려져도 안전해야 합니다.</sub>

Even if Oscar knows:
- The algorithm  
- The protocol  
- The full system design  

…it doesn’t matter — **without the key, he can’t break it.**  
<sub style="color:gray;">오스카가 모든 걸 알아도, **키가 없으면 해독할 수 없습니다.**</sub>

#### 🏛️ Why It Matters  

- 🚫 Don’t rely on secrecy  
  <sub style="color:gray;">숨기는 것만으로는 보안이 되지 않습니다.</sub>
- ✅ Make it strong even if exposed  
  <sub style="color:gray;">공개되어도 안전한 구조를 만들어야 합니다.</sub>
- 🔓 Security through obscurity is fragile  
  <sub style="color:gray;">"비공개된 보안"은 쉽게 깨질 수 있습니다.</sub>

> **Build systems that stay secure even under scrutiny.**  
> <sub style="color:gray;">해커들이 들여다봐도 안전한 시스템을 설계하세요.</sub>

---

## 3. 🧩 Substitution Cipher  

This one’s a **classic** — one of the oldest ciphers in the book.  
<sub style="color:gray;">가장 오래된 고전 암호 중 하나로, 알파벳을 일정한 규칙에 따라 바꾸는 방식입니다.</sub>

- 📜 **Historical Cipher** → Works on individual **letters**  
  <sub style="color:gray;">과거 암호화 방식으로, 문자 단위로 동작합니다.</sub>
- 💡 **Main idea**: Swap each letter in the plaintext with a fixed letter from the ciphertext alphabet.  
  <sub style="color:gray;">각 평문 문자를 정해진 암호문 문자로 바꿔서 전달합니다.</sub>

### 📘 Quick Example  

| Plaintext | Ciphertext |
|-----------|------------|
| A         | l          |
| B         | d          |
| C         | w          |
| E         | Q          |

> **Q1:** What’s `e(ABBA)`?  
> **A1:** `lddl`

> **Q2:** Is this cipher secure?  
> **A2:** Nope 😬

---

### 🕵️ How Can We Break It?  

#### 1. 🔨 Brute-Force Attack (Exhaustive Key Search)  

- There are 26 letters in the alphabet → `26!` possible permutations  
  <sub style="color:gray;">알파벳 26개의 모든 조합은 `26!`개입니다.</sub>
- That’s about `2^88` — sounds huge, right?  
  <sub style="color:gray;">약 `2^88` 개로 매우 많지만,</sub>  
- **Still breakable with smarter analysis.**

#### 2. 📊 Letter Frequency Analysis  

- Same letters in plaintext → same letters in ciphertext  
  <sub style="color:gray;">같은 평문은 같은 암호문으로 바뀌므로,</sub>
- Attackers can analyze letter frequencies to guess the mapping  
  <sub style="color:gray;">문자의 출현 빈도를 분석해서 평문을 유추할 수 있습니다.</sub>

<figure>
  <img src="/assets/img/cryptography/introtocrypto/lec01/06letterfrequencyanalysis.png"
       alt="Letter Frequency Analysis"
       style="max-width: 700px; width: 100%; display: block; margin: 0 auto;" />
  <figcaption style="text-align: center; font-size: 0.9rem;">Figure 6: Letter Frequency Analysis</figcaption>
</figure>
---

So even though brute-force is tough, **smart analysis can still crack this cipher** —  
which means... it’s not really secure in the modern world.  
<sub style="color:gray;">무차별 대입 방식은 직접 하기 어렵지만, 빈도 분석으로 쉽게 깨질 수 있어서 오늘날에는 안전하지 않은 암호화 방식입니다.</sub>

---

## 4. Classification of Attacks  

When trying to break or bypass a cryptographic system, there are several categories of **attack vectors** (approaches attackers can use).  
<sub style="color:gray;">암호 시스템을 무력화하거나 우회하려는 시도는 다양한 종류의 공격 벡터(공격 방식)를 가질 수 있습니다.</sub>

These attacks are classified based on **what part of the system** they target.  
<sub style="color:gray;">이러한 공격은 시스템의 어느 부분을 겨냥하느냐에 따라 분류됩니다.</sub>


### 🧭 Overview of Cryptanalysis Categories  

<figure>
  <img src="/assets/img/cryptography/introtocrypto/lec01/07cryptanalysis_classification.jpg"
       alt="Cryptanalysis Classification"
       style="max-width: 700px; width: 100%; display: block; margin: 0 auto;" />
  <figcaption style="text-align: center; font-size: 0.9rem;">Figure 7: Cryptanalysis Classification</figcaption>
</figure>

#### 1. 🔐 Classical Cryptanalysis  

- **Brute-force Attacks**: Trying every possible key until the correct one is found.  
  <sub style="color:gray;">가능한 모든 키를 시도해 정답을 찾는 무차별 대입 공격</sub>

- **Analytical Attacks**: Using mathematical techniques to reduce the search space or reveal the key.  
  <sub style="color:gray;">수학적인 방법으로 키를 찾아내거나 탐색 범위를 줄이는 분석 기반 공격</sub>


#### 2. 🎭 Social Engineering  

Tricking users or system operators into revealing secrets (e.g., phishing, impersonation).  
<sub style="color:gray;">사용자나 운영자를 속여 비밀 정보를 빼내는 기법 (예: 피싱, 사칭 등)</sub>


#### 3. 🧪 Implementation Attacks  

Attacks that target how the algorithm is implemented, rather than the algorithm itself.  
<sub style="color:gray;">알고리즘 자체가 아니라, 실제로 그것이 실행되는 방식에서 생기는 약점을 노립니다.</sub>

Even if an algorithm is mathematically secure, the way it runs on a device can leak unintended information.  
<sub style="color:gray;">수학적으로 안전한 알고리즘도, 기계에서 실행될 때 정보가 새어 나갈 수 있습니다.</sub>


##### 🔍 Common Types of Implementation Attacks  

- **Side-Channel Attack**: Exploits information like power consumption, electromagnetic radiation, or sound during computation.  
  <sub style="color:gray;">암호 연산 중 발생하는 전력 소비, 전자기파, 소리 등 부수적인 정보를 분석하는 공격입니다.</sub>

- **Timing Attack**: Measures how long operations take and infers internal data from slight timing differences.  
  <sub style="color:gray;">암호 연산에 걸리는 시간 차이를 측정해, 내부 데이터를 추론하는 공격입니다.</sub>

- **Fault Injection Attack**: Induces faults in hardware (e.g., voltage spikes, lasers) to observe incorrect outputs and reveal secrets.  
  <sub style="color:gray;">전압 변화, 레이저 등의 물리적 충격으로 장치에 오류를 발생시켜 정보를 추출하는 공격입니다.</sub>

- **Cache Attack**: Monitors CPU cache access patterns to deduce sensitive information.  
  <sub style="color:gray;">CPU 캐시 접근 패턴을 분석해, 암호 키 등의 민감한 정보를 추론합니다.</sub>

> 💬 **Implementation attacks target the "how", not the "what".**  
> <sub style="color:gray;">‘무엇을’이 아닌 ‘어떻게 동작하는지’를 노리는 공격입니다.</sub>

---

## 5. Lecture Video

{% include embed/youtube.html id='2aHkqB2-46k' %}

---

## 6. 🔚 Wrapping Up  

That’s it for Lecture 01! In the next post, we’ll explore **modular arithmetic** and **classical ciphers** used in early cryptography.  
<sub style="color:gray;">1강은 여기까지입니다! 다음 글에서는 모듈러 연산과 고전 암호 기법들에 대해 살펴볼 거예요.</sub>

Got questions or feedback? Drop a comment below or reach out — I’d love to hear from you!  
<sub style="color:gray;">질문이나 피드백이 있다면 댓글이나 메시지 주세요. 꼭 읽고 답변할게요!</sub>

Stay encrypted 🔐  
— thepawgrammer  