---
title: Lecture 01. What Is Cryptography?
date: 2025-04-07 16:26:30 +0900
author: thepawgrammer
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
| **Secure Messaging** | End-to-end encryption ensures that only the sender and receiver can read the message.<br><sub style="color: gray;">오직 발신자와 수신자만 메시지를 읽을 수 있도록 보장합니다.</sub> |
| **Digital Signatures in Software Updates** | Ensures the integrity and authenticity of software updates.<br><sub style="color: gray;">소프트웨어 업데이트가 신뢰할 수 있는 출처에서 이루어졌으며, 중간에 바뀌지 않았음을 보장합니다.</sub> |
| **Cryptographic Voting Protocols** | Enables secure, private, and verifiable electronic voting.<br><sub style="color: gray;">전자 투표는 안전하고 비공개로 이루어지며, 결과를 검증할 수 있도록 해줍니다.</sub> |
| **Blockchain and Cryptocurrencies** | Uses cryptographic techniques to secure decentralized digital assets.<br><sub style="color: gray;">암호화 기술을 사용해 분산된 디지털 자산의 안정성을 보장합니다.</sub> |

### 🔍 Cryptology Breakdown  

<figure>
  <img src="/assets/img/cryptography/introtocrypto/lec01/01cryptology_breakdown.jpg"
       alt="Cryptology Breakdown Diagram"
       style="max-width: 700px; width: 100%; display: block; margin: 0 auto;" />
  <figcaption style="text-align: center; font-size: 0.9rem;">Figure 1: Cryptology Breakdown Diagram</figcaption>
</figure>

---

This diagram shows the relationship between **Cryptology**, **Cryptography**, and **Cryptanalysis**.  
<sub style="color:gray;">이 도표는 암호학(Cryptology), 암호화(Cryptography), 그리고 암호 해독(Cryptanalysis)의 관계를 보여줍니다.</sub>

**Cryptology** is the broader field that includes both:  
<sub style="color:gray;">**암호학(Cryptology)**은 암호화와 암호 해독을 모두 포함하는 넓은 학문 분야입니다.</sub>

- **Cryptography**: The science of designing secure communication systems using techniques like encryption, hashing, and digital signatures. (Think: **protectors**)  
  <sub style="color:gray;">**암호화(Cryptography)**는 암호화, 해싱, 디지털 서명 등의 기술을 이용해 안전한 통신 시스템을 설계하는 학문입니다.</sub>

- **Cryptanalysis**: The science of breaking cryptographic systems, finding vulnerabilities, or recovering original messages without a key. (Think: **hackers**)  
  <sub style="color:gray;">**암호 해독(Cryptanalysis)**는 암호 시스템의 취약점을 분석하거나, 키 없이 원래 메시지를 복원하는 기술입니다.</sub>

In this study series, we’ll focus on **cryptography** — understanding how secure systems are designed, rather than how they’re broken.  
<sub style="color:gray;">이 시리즈에서는 암호 해독보다는 안전한 시스템이 어떻게 설계되는지를 다루는 **암호화**에 중점을 둘 예정입니다.</sub>

---

## 2. Setting Up Symmetric Cryptography  

> 🔑 **Key Takeaway:** <span style="color: #d6336c;">Never use a crypto algorithm that hasn’t been tested!</span>  
> <sub style="color: gray;">**검증되지 않은 암호 알고리즘은 절대 사용하지 마세요!**</sub>

Well-designed encryption must be **open and public**, so that experts can test it and verify its strength.  
<sub style="color:gray;">모두에게 공개되어 있는 암호가 잘 설계된 것입니다. 그래야 전문가들이 자유롭게 테스트하고 취약점이 없는지 확인할 수 있기 때문입니다.</sub>

### 📘 Notation Guide  

| Symbol      | Meaning                            |
|-------------|------------------------------------|
| `x`         | Plaintext                          |
| `y`         | Ciphertext                         |
| `e`         | Encryption function                |
| `d`         | Decryption function                |
| `k`         | Key                                |
| `|K|`       | Key space (number of possible keys)|

### 🧩 Encryption Process Overview  
The following visuals illustrate how symmetric encryption protects your message, even over insecure channels.  
<sub style="color:gray;">아래 그림들은 대칭키 암호가 메시지를 어떻게 보호하는지 보여줍니다. 보안되지 않은 네트워크에서도 안전하게 통신할 수 있는 과정을 시각적으로 설명해 줍니다.</sub>

<div style="display: flex; justify-content: space-between; gap: 10px; flex-wrap: wrap;">

  <div style="flex: 1; min-width: 300px;">
    <h4>🔓 Before Encryption (1) </h4>
    <img src="/assets/img/cryptography/introtocrypto/lec01/02unencrypted_message.jpg" alt="Unencrypted Message" style="width: 100%;" />
    <p style="font-size: 0.9rem;">
      Oscar can read message <code>x</code> in plain text over an insecure channel.<br>
      <sub style="color:gray;">오스카는 보안되지 않은 채널에서 암호화되지 않은 메시지 <code>x</code>를 그대로 읽을 수 있습니다.</sub>
    </p>
  </div>

  <div style="flex: 1; min-width: 300px;">
    <h4>🔐 After Encryption (2) </h4>
    <img src="/assets/img/cryptography/introtocrypto/lec01/03encrypted_message.jpg" alt="Encrypted Message" style="width: 100%;" />
    <p style="font-size: 0.9rem;">
      Now he only sees ciphertext <code>y</code>, and has no idea what the original message was.<br>
      <sub style="color:gray;">이제 오스카는 암호화된 메시지 <code>y</code>만 볼 수 있고, 원래 메시지가 무엇이었는지는 알 수 없습니다.</sub>
    </p>
  </div>

</div>

---

But wait 😱 — if the encryption algorithm is public, doesn’t that mean Oscar can also read the message?  
<sub style="color:gray;">엇! 암호화 알고리즘이 공개되어 있다면, 오스카도 메시지를 읽을 수 있는 거 아닌가요?</sub>

<div style="display: flex; justify-content: space-between; gap: 10px; flex-wrap: wrap;">

  <div style="flex: 1; min-width: 300px;">
    <h4>🔑 Shared Secret Key (1) </h4>
    <img src="/assets/img/cryptography/introtocrypto/lec01/04shared_key.jpg" alt="Shared Secret Key" style="width: 100%;" />
    <p style="font-size: 0.9rem;">
      Even if the algorithm is public, encryption stays secure thanks to a shared secret key.<br>
      <sub style="color:gray;">알고리즘이 공개되어 있어도, **공유된 비밀 키** 덕분에 암호는 여전히 안전합니다.</sub>
    </p>
    <p style="font-size: 0.9rem;">
      Alice and Bob must agree on the same key <code>k</code> through a secure channel.<br>
      <sub style="color:gray;">앨리스와 밥은 보안된 채널을 통해 같은 키 <code>k</code>를 미리 공유해야 합니다.</sub>
    </p>
  </div>

  <div style="flex: 1; min-width: 300px;">
    <h4>🔐 Using the Shared Key (2) </h4>
    <img src="/assets/img/cryptography/introtocrypto/lec01/05howtosharekey.jpg" alt="How to Share a Key" style="width: 100%;" />
    <p style="font-size: 0.9rem;">
      Once they share the key, they can safely communicate over insecure networks.<br>
      <sub style="color:gray;">키를 미리 공유해두면, 설령 네트워크가 안전하지 않더라도 메시지는 보호받을 수 있습니다.</sub>
    </p>
  </div>

</div>

---

### 💡 Kerckhoffs' Principle (1883)  

A cryptosystem must remain secure **even if everything is public — except the key**.  
<sub style="color:gray;">암호 시스템은 **키만 비밀로 유지된다면**, 나머지 모든 정보가 공개되어도 안전해야 합니다.</sub>

Even if Oscar knows:
- The algorithm  
- The protocol  
- The full system design  

…it doesn’t matter — **without the key, he can’t break it.**  
<sub style="color:gray;">오스카가 모든 걸 알아도, **키가 없으면 절대 해독할 수 없습니다.**</sub>

#### 🏛️ Why It Matters  

- 🚫 Don’t rely on secrecy  
  <sub style="color:gray;">단순히 숨긴다고 보안이 되는 건 아닙니다.</sub>

- ✅ Make it strong even if exposed  
  <sub style="color:gray;">공개되더라도 안전한 구조여야 합니다.</sub>

- 🔓 Security through obscurity is fragile  
  <sub style="color:gray;">숨기는 방식에 의존한 보안은 쉽게 무너질 수 있습니다.</sub>

> **Build systems that stay secure even under scrutiny.**  
> <sub style="color:gray;">해커가 내부 모두를 알더라도 절대 뚫을 수 없는 안전한 시스템을 설계해야 합니다.</sub>

---

## 3. Substitution Cipher  

This one’s a **classic** — one of the oldest ciphers in the book.  
<sub style="color:gray;">가장 오래되고 유명한 고전 암호 중 하나로, 알파벳을 일정한 규칙에 따라 바꾸는 방식입니다.</sub>

- 📜 **Historical Cipher** → Works on individual **letters**  
  <sub style="color:gray;">과거에 사용되던 암호 방식으로, **문자 하나하나 단위로 작동합니다.**</sub>
- 💡 **Main idea**: Swap each letter in the plaintext with a fixed letter from the ciphertext alphabet.  
  <sub style="color:gray;">암호화 전 메시지의 각 문자를 **정해진 규칙에 따라 다른 문자로 바꿔서** 전달하는 방식입니다.</sub>

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
  <sub style="color:gray;">알파벳 26개로 만들 수 있는 모든 조합은 `26!`개입니다.</sub>
- That’s about `2^88` — sounds huge, right?  
  <sub style="color:gray;">무려 약 `2^88` 가지 경우의 수로 매우 많습니다만,</sub>  
- **Still breakable with smarter analysis.**  
  <sub style="color:gray;">그래도 똑똑한 분석 기법을 쓰면 깰 수 있습니다.</sub>

#### 2. 📊 Letter Frequency Analysis  

- Same letters in plaintext → same letters in ciphertext  
  <sub style="color:gray;">같은 글자가 암호화 전 메시지에서 반복되면, 암호화된 메시지에서도 일정한 규칙이 드러납니다.</sub>

- Attackers can analyze letter frequencies to guess the mapping  
  <sub style="color:gray;">해커는 글자의 빈도를 분석해 암호화 전 메시지를 유추할 수 있습니다.</sub>

<figure>
  <img src="/assets/img/cryptography/introtocrypto/lec01/06letterfrequencyanalysis.png"
       alt="Letter Frequency Analysis"
       style="max-width: 700px; width: 100%; display: block; margin: 0 auto;" />
  <figcaption style="text-align: center; font-size: 0.9rem;">Figure 6: Letter Frequency Analysis</figcaption>
</figure>
---

So even though brute-force is tough, **smart analysis can still crack this cipher** —  
which means... it’s not really secure in the modern world.  
<sub style="color:gray;">무차별 대입은 **현실적으로 시도하기 어렵지만**,  
빈도 분석으로는 생각보다 쉽게 해독이 가능하기 때문에, 이 방식은 현대에는 더 이상 안전하지 않습니다.</sub>

---

## 4. Classification of Attacks  

When trying to break or bypass a cryptographic system, there are several categories of **attack vectors** (approaches attackers can use).  
<sub style="color:gray;">암호 시스템을 깨거나 우회하려는 시도에는 여러 가지 **공격 벡터(공격 방식)**가 있습니다.</sub>

> 🛡️ **What’s an attack vector?**  
> An **attack vector** is the path or method an attacker uses to exploit a vulnerability in a system — in cryptography, it usually means **what kind of information the attacker has access to**.  
> <sub style="color:gray;">공격 벡터란 공격자가 시스템의 약점을 노릴 때 사용하는 **접근 경로** 또는 **공격 방식**을 의미합니다.  
> 암호학에서는 보통 공격자가 어떤 정보를 가지고 있는지를 기준으로 나뉩니다.</sub>

These attacks are classified based on **what part of the system** they target.  
<sub style="color:gray;">이러한 공격들은 시스템의 어느 부분을 노리느냐에 따라 분류됩니다.</sub>


### 🧭 Overview of Cryptanalysis Categories  

<figure>
  <img src="/assets/img/cryptography/introtocrypto/lec01/07cryptanalysis_classification.jpg"
       alt="Cryptanalysis Classification"
       style="max-width: 700px; width: 100%; display: block; margin: 0 auto;" />
  <figcaption style="text-align: center; font-size: 0.9rem;">Figure 7: Cryptanalysis Classification</figcaption>
</figure>

#### 1. 🔐 Classical Cryptanalysis  

- **Brute-force Attacks**: Trying every possible key until the correct one is found.  
  <sub style="color:gray;">가능한 모든 키를 하나씩 시도해서 정답을 찾는 **무차별 대입 공격**입니다.</sub>

- **Analytical Attacks**: Using mathematical techniques to reduce the search space or reveal the key.  
  <sub style="color:gray;">수학적인 기법을 사용해 탐색 범위를 줄이거나, 키를 직접 찾아내는 **분석 기반 공격**입니다.</sub>


#### 2. 🎭 Social Engineering  

Tricking users or system operators into revealing secrets (e.g., phishing, impersonation).  
<sub style="color:gray;">사용자나 시스템 운영자를 속여 **비밀 정보를 유출하도록 유도하는 공격 기법**입니다. (예: 피싱, 사칭 등)</sub>


#### 3. 🧪 Implementation Attacks  

Attacks that target how the algorithm is implemented, rather than the algorithm itself.  
<sub style="color:gray;">알고리즘 자체가 아니라, **그 알고리즘이 실제로 구현되고 실행되는 방식의 약점**을 노리는 공격입니다.</sub>

Even if an algorithm is mathematically secure, the way it runs on a device can leak unintended information.  
<sub style="color:gray;">수학적으로 안전한 알고리즘이라도, 기기에서 실행되는 과정에서 **예상치 못한 정보가 유출**될 수 있습니다.</sub>


##### 🔍 Common Types of Implementation Attacks  

- **Side-Channel Attack**: Exploits information like power consumption, electromagnetic radiation, or sound during computation.  
  <sub style="color:gray;">암호 연산 중 발생하는 전력 소비, 전자기파, 소리 같은 **부수적인 정보를 분석해** 공격하는 방식입니다.</sub>

- **Timing Attack**: Measures how long operations take and infers internal data from slight timing differences.  
  <sub style="color:gray;">암호 연산에 걸리는 **미세한 시간 차이를 측정해**, 내부 데이터를 추론하는 공격입니다.</sub>

- **Fault Injection Attack**: Induces faults in hardware (e.g., voltage spikes, lasers) to observe incorrect outputs and reveal secrets.  
  <sub style="color:gray;">전압 변화, 레이저 등으로 장치에 **일부러 오류를 일으켜**, 잘못된 출력을 분석해 정보를 알아내는 공격입니다.</sub>

- **Cache Attack**: Monitors CPU cache access patterns to deduce sensitive information.  
  <sub style="color:gray;">CPU 캐시 접근 패턴을 추적해, 암호 키 같은 **민감한 정보를 유추하는 공격**입니다.</sub>

> 💬 **Implementation attacks target the "how", not the "what".**  
> <sub style="color:gray;">‘무엇’이 아닌, **‘어떻게 작동하는지’를 노리는 공격입니다.</sub>

---

## 5. Lecture Video

{% include embed/youtube.html id='2aHkqB2-46k' %}

---

## 6. 🔚 Wrapping Up  

That’s it for Lecture 01! In the next post, we’ll explore **modular arithmetic** and **classical ciphers** used in early cryptography.  
<sub style="color:gray;">1강은 여기까지예요! 다음 글에서는 초기 암호에서 사용된 모듈러 연산과 고전 암호 기법들을 함께 살펴볼 거예요.</sub>

Got questions or feedback? Drop a comment below or reach out — I’d love to hear from you!  
<sub style="color:gray;">질문이나 피드백이 있다면 댓글로 남겨주세요.</sub>

Stay encrypted 🔐  
— thepawgrammer  