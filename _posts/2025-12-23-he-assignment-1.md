---
title: 'Homomorphic Encryption - Assignment 01'
date: 2025-12-23
# modified: 2025-12-24
use_math: true   # ← 이 줄 추가
permalink: /posts/2025/12/he-assignment-1/
tags:
  - cryptography
  - homomorphic-encryption
  - lattice-based-cryptography
---

<details>
  <summary>
  <span style="font-size:1.25em; font-weight:bold;">
    Homomorphic Encryption Problem 1
  </span>
  </summary>
  <div markdown="1">

---

### Homomorphic Encryption Problem 1
- Q. This is an exercise in manually computing CKKS encoding and decoding using very small parameters. You may refer to the attached files for study. The concrete encoding/decoding algorithms may differ slightly depending on the implementation, but please follow the approach used in the attached material. In practice, CKKS homomorphic encryption requires large-integer arithmetic and thus a programming language such as Python is essential. However, the level of computation shown below appears manageable even in Excel.

The ring used is
$$
R = \mathbb{Z}[X]/(X^N + 1).
$$

Here, $N = 4$, and the scaling factor is $\Delta = 10^4$.

The input data is
$$
z = [0.1, 0.2].
$$

Also, $M = 2N = 8$.

The $2N$-th root of unity is
$$
\zeta = \exp\left(\frac{\pi i}{4}\right).
$$

Compute the encoded value $m \in R$ obtained when encoding the vector
$$
z = [0.1, 0.2].
$$

Next, decode $m \in R$ and verify that the result is almost identical to the original vector $z$.
You must show all intermediate computation steps.

<details style="margin-left:20px;">
  <summary>📘 <b>Solution</b></summary>
  <div style="border:2px solid #007acc; border-radius:6px; padding:12px 15px; background:#f0f8ff; margin:12px 0; width:95%; font-size:0.95em;" markdown="1">

  - to be continued

  </div>
</details>

---
