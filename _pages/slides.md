---
title: "Slides"
layout: archive
permalink: /slides/
author_profile: true
---

{% include base_path %}

{% for item in site.slides reversed %}
  {% include archive-single.html %}
{% endfor %}
