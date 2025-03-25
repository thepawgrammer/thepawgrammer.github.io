---
title: Introduction to Cryptography Lecture 01 - Study Notes
date: 2025-03-24 16:46:22 +0900
categories: [cryptography, study-notes]
tags: [crypto, cryptography, symmetric-key, christof, paar, christofpaar, studynotes, thepawgrammer]
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

---

### 🔍 Cryptology Breakdown  
<sub style="color:gray;">🔍 암호학 분해도</sub>

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

<figure>
  <img src="/assets/img/cryptography/introtocrypto/lec01/01cryptology_breakdown.jpg" alt="Cryptology Breakdown Diagram" />
  <figcaption>Figure 1: Cryptology Breakdown Diagram</figcaption>
</figure>

---

## 2. Setting Up Symmetric Cryptography  
<sub style="color:gray;">대칭키 암호화를 설정하는 방법</sub>

> 🔑 **Key Takeaway:** <span style="color: #d6336c;">Never use a crypto algorithm that hasn’t been tested!</span>  
> <sub style="color: gray;">검증되지 않은 암호 알고리즘은 절대 사용하지 마세요.</sub>

Well-designed encryption must be **open and public**, so that experts can test it and verify its strength.  
<sub style="color:gray;">암호는 공개되어야 전문가들이 테스트해보고, 오랜 시간 안전성이 입증된 후에야 믿고 쓸 수 있습니다.</sub>

---

### 🔓 Before Encryption  
<sub style="color:gray;">암호화 전</sub>

<img src="/assets/img/cryptography/introtocrypto/lec01/02unencrypted_message.jpg" alt="Unencrypted Message" style="width: 100%;" />

Oscar can read message `x` in plain text over an insecure channel.  
<sub style="color:gray;">오스카는 보안되지 않은 채널에서 평문 `x`를 그대로 읽을 수 있습니다.</sub>

---

### 🔐 After Encryption  
<sub style="color:gray;">암호화 후</sub>

<img src="/assets/img/cryptography/introtocrypto/lec01/03encrypted_message.jpg" alt="Encrypted Message" style="width: 100%;" />

Now he only sees ciphertext `y`, and has no idea what the original message was.  
<sub style="color:gray;">이제 오스카는 암호문 `y`만 볼 수 있고, 원문은 알 수 없습니다.</sub>

---

But wait — if the encryption algorithm is public, doesn’t that mean Oscar can also read the message?😱
<sub style="color:gray;">하지만 암호화 알고리즘이 공개되어 있다면, 오스카도 메시지를 읽을 수 있는 것 아닌가요?</sub>

---

### 🔑 The Secret Key  
<sub style="color:gray;">비밀 키의 역할</sub>

Even if the algorithm is public, encryption stays secure thanks to a shared secret key.  
<sub style="color:gray;">알고리즘이 공개되어도, 공유된 비밀 키 덕분에 암호는 여전히 안전합니다.</sub>

<img src="/assets/img/cryptography/introtocrypto/lec01/04shared_key.jpg" alt="Shared Secret Key" style="width: 100%;" />

Alice and Bob must agree on the same key `k` through a secure channel.  
<sub style="color:gray;">앨리스와 밥은 보안된 채널을 통해 같은 키 `k`를 공유해야 합니다.</sub>

<img src="/assets/img/cryptography/introtocrypto/lec01/05howtosharekey.jpg" alt="How to Share a Key" style="width: 100%;" />

Once they share the key, they can safely communicate over insecure networks.  
<sub style="color:gray;">키를 공유한 이후에는, 안전하지 않은 네트워크에서도 안전한 통신이 가능합니다.</sub>

---

### 📘 Notation Guide 
| Symbol      | Meaning                            |
|-------------|------------------------------------|
| `x`         | Plaintext                          |
| `y`         | Ciphertext                         |
| `e`         | Encryption function                |
| `d`         | Decryption function                |
| `k`         | Key                                |
| `|K|`       | Key space (number of possible keys)|
<sub style="color:gray;">기호들은 암호 과정에서 사용되는 주요 개념입니다.</sub>

---

### 💡 Kerckhoffs' Principle (1883)  
<sub style="color:gray;">케르쾨프스의 원칙</sub>

A cryptosystem must remain secure **even if everything is public — except the key**.  
<sub style="color:gray;">암호 시스템은 키를 제외한 모든 것이 알려져도 안전해야 합니다.</sub>

Even if Oscar knows:
- The algorithm  
- The protocol  
- The full system design  

…it doesn’t matter — **without the key, he can’t break it.**  
<sub style="color:gray;">오스카가 모든 걸 알아도, **키가 없으면 해독할 수 없습니다.**</sub>

---

### 🏛️ Why It Matters  
<sub style="color:gray;">왜 중요한가?</sub>

- 🚫 Don’t rely on secrecy  
  <sub style="color:gray;">숨기는 것만으로는 보안이 되지 않습니다.</sub>
- ✅ Make it strong even if exposed  
  <sub style="color:gray;">공개되어도 안전한 구조를 만들어야 합니다.</sub>
- 🔓 Security through obscurity is fragile  
  <sub style="color:gray;">"비공개 보안"은 쉽게 깨질 수 있습니다.</sub>

---

> **Build systems that stay secure even under scrutiny.**  
> <sub style="color:gray;">해커들이 들여다봐도 안전한 시스템을 설계하세요.</sub>

## 4. Classification of Attacks

When trying to break or bypass a cryptographic system, there are several categories of **attack vectors** (approaches attackers can use). These attacks are broadly classified based on the **aspect of the system they target**.

### 🧭 Overview of Cryptanalysis Categories 🧭

Here's a simple classification tree:

![Cryptanalysis Classification](assets/img/cryptography/introtocrypto/lec01/07cryptanalysis_classification.jpg)

1. **Classical Cryptanalysis**
   - **Brute-force Attacks**: Trying every possible key until the correct one is found.
   - **Analytical Attacks**: Using mathematical techniques to reduce the search space or reveal the key.

2. **Social Engineering**
   - Tricking users or system operators into revealing secrets (e.g., phishing, impersonation).

3. **Implementation Attacks**
   - Attacks that target how the algorithm is implemented, rather than the algorithm itself.
   - **Example**: **Side-Channel Analysis**

---

#### 📡 What is Side-Channel Analysis? 📡

Side-channel analysis is a powerful class of attacks that exploits **physical leaks** from a cryptographic device, rather than flaws in the algorithm.

These leaks can include:
- ⏱ **Timing Information**
- ⚡ **Power Consumption**
- 📡 **Electromagnetic Emissions**
- 🔊 **Acoustic Noise**

> Even perfectly designed algorithms like AES or RSA can be vulnerable if the hardware or software leaks side-channel data.

---

##### 🧠 Attackers Use Signal Processing Techniques 🧠

These physical signals are often **noisy** and hard to interpret directly. That’s why attackers use **signal processing** techniques to extract meaningful patterns.

##### Common Techniques:
- **Filtering**: To remove background noise.
- **Averaging**: Across multiple traces to isolate consistent behavior.
- **Differential Power Analysis (DPA)**: Statistical comparison of power usage patterns.
- **Fourier Transforms / Spectral Analysis**: Identifying hidden frequency patterns.
- **Correlation Analysis**: Matching power traces with hypothetical key values.

---

##### 🎯 Real-World Analogy 🎯

Imagine someone typing a password on a mechanical keyboard.  
Even if the password is encrypted, you could record the **sound** of the keystrokes and analyze it to guess what they typed.

## 5. Lecture Video

{% include embed/youtube.html id='2aHkqB2-46k' %}

---
## 🔚 Wrapping Up

That’s it for Lecture 01! In the next post, we’ll explore more about block ciphers and modern encryption standards. Got questions or feedback? Drop a comment below or reach out — I’d love to hear from you!

Stay encrypted 🔐  
— thepawgrammer