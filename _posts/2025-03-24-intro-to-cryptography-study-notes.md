---
title: Introduction to Cryptography Lecture 01 - Study Notes
date: 2025-03-24 16:46:22 +0900
categories: [cryptography, study-notes]
tags: [crypto, cryptography, symmetric, christof, paar, christofpaar, studynotes, thepawgrammer]
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

| Name                         | Type         | Notes                                                                 |
|------------------------------|--------------|-----------------------------------------------------------------------|
| GNU PG                       | Software     | Open-source implementation of OpenPGP for encrypting files/emails     |
| TruCrypt                     | Software     | Disk encryption tool for securing data at rest                        |
| Secure Shell (SSH)           | Network      | Secure remote login and command execution over unsecured networks     |
| (plug-in) for Thunderbird    | Email        | Add-on for encrypting emails using PGP or S/MIME                      |
| S-MIME email encryption      | Email        | Standard for public key encryption and signing of MIME data           |
| Cell phone                   | Mobile       | Uses encryption for voice, messages, and data protection              |
| HDCP multimedia protection   | Media        | Encrypts digital video/audio to prevent unauthorized copying          |
| Bank cards                   | Finance      | Embedded cryptographic chips for secure payment and authentication    |
| VPN                          | Network      | Encrypts internet traffic for secure and private communication        |
| ePassport                    | Identity     | Stores encrypted biometric data using public key infrastructure (PKI) |
| Online banking               | Web          | Uses TLS/SSL and other crypto protocols for secure transactions       |
| iPod                         | Consumer     | Some models use DRM and encryption for content protection             |
| Kindle                       | Consumer     | Uses DRM and encrypted storage for ebook protection                   |

---

### 🔍 Cryptology Breakdown 🔍

This diagram shows the relationship between **Cryptology**, **Cryptography**, and **Cryptanalysis**.

**Cryptology** is the broader field that includes both:
- **Cryptography**: The science of designing secure communication systems using techniques like encryption, hashing, and digital signatures. (Think: **protectors**)
- **Cryptanalysis**: The science of breaking cryptographic systems, finding vulnerabilities, or recovering original messages without a key. (Think: **hackers**)

In this study series, we’ll focus on **cryptography** — understanding how secure systems are designed, rather than how they’re broken.

<figure>
  <img src="/assets/img/cryptography/introtocrypto/lec01/01cryptology_breakdown.jpg" alt="Cryptology Breakdown Diagram" />
  <figcaption>Figure 1: Cryptology Breakdown Diagram</figcaption>
</figure>

---

## 2. Setting Up Symmetric Cryptography

Here’s one big takeaway from the lecture:

“NEVER USE A CRYPTO ALGORITHM THAT HASN’T BEEN TESTED!”

Even if someone thinks their encryption method is bulletproof, there could still be hidden flaws. That’s why it’s super important for encryption algorithms to be **open and public** — so other experts can poke at them, try to break them, and make sure they actually hold up. If it survives all that, then we can start to trust it.

<div style="display: flex; justify-content: space-between; gap: 10px; flex-wrap: wrap;">
  <div style="flex: 1; min-width: 300px;">
    <h4>🚫 Unencrypted Message</h4>
    <img src="/assets/img/cryptography/introtocrypto/lec01/02unencrypted_message.jpg" alt="Unencrypted Message" style="width: 100%;" />
    <p style="font-size: 0.9rem;">Oscar can read the message <code>x</code> as plain as day on the insecure channel.</p>
  </div>
  
  <div style="flex: 1; min-width: 300px;">
    <h4>🔐 Encrypted Message</h4>
    <img src="/assets/img/cryptography/introtocrypto/lec01/03encrypted_message.jpg" alt="Encrypted Message" style="width: 100%;" />
    <p style="font-size: 0.9rem;">Now Oscar only sees the ciphertext <code>y</code> and has no clue what the original message <code>x</code> was.</p>
  </div>
</div>

But wait — if everyone knows how the encryption works, how do we actually keep things secure?

That’s where keys come into play.

Alice and Bob both use a shared secret key 🔑. This key is the magic ingredient added to both the encryption and decryption process. So even if Oscar knows the algorithm, he’s out of luck — because without the key, he still can’t read the message.

![Alice and Bob Share a Secret Key](/assets/img/cryptography/introtocrypto/lec01/04shared_key.jpg)

In symmetric cryptography, Alice and Bob need to agree on a secret key k — and they have to do it over a secure channel first. Once they both know the key, they can send encrypted messages (aka y) back and forth over insecure networks, and Oscar still won’t be able to figure out a thing without that key.

![How Alice and Bob Share the Key](/assets/img/cryptography/introtocrypto/lec01/05howtosharekey.jpg)

### 📘 Quick Notation Guide 📘

| Symbol      | Meaning                                    |
|-------------|--------------------------------------------|
| `x`         | Plaintext                                  |
| `y`         | Ciphertext                                 |
| `e`         | Encryption function                        |
| `d`         | Decryption function                        |
| `k`         | Key                                        |
| `|𝓚|` or `|K|` | Key space (number of possible keys)        |

### 💡 Kerckhoffs' Principle [1883] 💡
A cryptosystem should be secure even if the attacker (Oscar) KNOWS ALL THE DETAILS about the system, with the exception of the secret key.

> 🔍 **Sounds kinda backwards, right?** 🔍
> Yep — Kerckhoffs’ Principle is totally **counterintuitive**, but it’s a game-changer.

#### 🧠 What It Really Means 🧠

Even if Oscar knows:

- The algorithm  
- The protocols  
- The system structure  

…it *still* shouldn’t matter — **as long as he doesn’t know the key**, he can’t break it.

---

#### 🏛️ Why It Matters 🏛️

This idea is one of the **core principles of modern cryptography**. It teaches us:

- 🚫 **Don’t rely on secrecy alone** — hiding your algorithm isn’t real security.  
- ✅ **Make your system strong enough** that even if everyone knows how it works, it’s still secure without the key.  
- 🔓 **Security through obscurity** is fragile and not dependable.

---

So remember:  
**Don't hide your algorithm — build one that’s strong enough to stand the test of time, analysis, and even attackers like Oscar.**
    
## 3. Substitution Cipher

This one’s a **classic** — one of the oldest ciphers in the book.

- 📜 **Historical Cipher** → Works on individual **letters**
- 💡 **Main idea**: Swap each letter in the plaintext with a fixed letter from the ciphertext alphabet.

---

### 📘 Quick Example

| Plaintext | Ciphertext |
|-----------|------------|
| A         | l          |
| B         | d          |
| C         | w          |
| E         | Q          |

- **Q1:** What’s `e(ABBA)`?  
  **A1:** `lddl`  
- **Q2:** Is this cipher secure?  
  **A2:** Nope 😬

---

### 🕵️ How Can We Break It?

#### 1. 🔨 Brute-Force Attack (aka Exhaustive Key Search)

- There are 26 letters in the alphabet, so the total number of possible key combinations is:  
  `26 × 25 × 24 × ... × 1 = 26!`  
  That’s roughly `2^88` — which is **huge**.
- So yeah, brute-forcing this would take **forever**... in theory.

#### 2. 📊 Letter Frequency Analysis

- Here’s the catch: **same letters in plaintext get replaced with the same letters in ciphertext**.
- That makes it vulnerable to **frequency analysis**, where attackers look at how often letters appear and use that to guess the original text.

![Letter Frequency Analysis](assets/img/cryptography/introtocrypto/lec01/06letterfrequencyanalysis.png)

So even though brute-force is tough, smart analysis can still crack this cipher — which means... **it’s not really secure** in the modern world.

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