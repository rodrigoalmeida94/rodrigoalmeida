---
title: "Reachy Mini meets DGX Spark: a robot that never phones home"
date: 2026-11-17T10:00:00+01:00
draft: false
tags: ["robotics", "sovereign-ai", "local-llm", "reachy-mini", "dgx-spark"]
categories: []
# The blog section is hidden (see posts/_index.md); this post opts back in so it can be linked from the CV page.
_build:
  render: always
  list: never
description: "Running a fully local voice and vision assistant on a Reachy Mini robot, powered by a DGX Spark on my desk. No cloud, no API keys."
---

I have a new desk mate: a small robot that talks, sees and moves, and doesn't depend on any cloud service.

<video controls playsinline muted loop preload="metadata" poster="/reachy-spark-local-poster.jpg" style="display:block; width:100%; max-width:360px; margin:1.5em auto; border-radius:8px;">
  <source src="/reachy-spark-local.mp4" type="video/mp4">
  Your browser can't play this video. <a href="/reachy-spark-local.mp4">Download it here</a>.
</video>

On the left is a [Reachy Mini](https://huggingface.co/docs/reachy_mini). On the right is an NVIDIA DGX Spark (Dell's GB10 version). Everything the robot hears, sees and says is processed on that box, a few centimetres away.

<!--more-->

## The idea

NVIDIA and Hugging Face showed this pairing at CES in [*NVIDIA brings agents to life with DGX Spark and Reachy Mini*](https://huggingface.co/blog/nvidia-reachy-mini). Open models run on the Spark, Reachy Mini acts as the body, and you keep control of the models, prompts, tools and robot actions. Their default setup still relies on remote endpoints and a hosted TTS, so I went one step further and made it fully local.

## The stack

The voice loop runs on Hugging Face's [speech-to-speech](https://github.com/huggingface/speech-to-speech) pipeline, served on the Spark:

```text
microphone on the robot
 └─▶ VAD   detect speech
 └─▶ STT   transcribe
 └─▶ LLM   generate a reply
 └─▶ TTS   synthesise speech
speaker on the robot, plus head and antenna motion
```

What makes this work well:

- **Every stage is open and swappable.** A different STT, LLM or TTS can be dropped in without touching the rest of the pipeline.
- **It speaks the OpenAI Realtime protocol.** The [Reachy Mini conversation app](https://github.com/pollen-robotics/reachy_mini_conversation_app) only needs its endpoint pointed at the Spark instead of a hosted service.
- **Vision is local too.** Camera frames are processed by a vision model on the Spark, so the robot can describe what it sees without any image leaving the room.
- **The Spark has headroom.** With 128 GB of unified memory, models that would normally be accessed through an API stay loaded locally.

My version is a German–English conversation partner, which is useful for practising German in Berlin. It is also patient with *Akkusativ* and *Dativ* mistakes.

## Why it matters: sovereign AI

"Sovereign AI" is often discussed at the level of countries and policy. In practice it comes down to owning the whole stack:

- **Data.** Voice and camera data from an office is sensitive, and here it never leaves the room.
- **Models.** Open weights stored locally. They cannot be deprecated or changed by a provider.
- **Availability.** The system keeps working through network outages, API downtime or changes in a provider's terms.
- **Cost.** No per-token billing.
- **Transparency.** Every prompt, tool and motor command can be inspected and changed.

For research institutes, hospitals, schools, or any organisation in Europe that cares about where its data is processed, open models on local hardware are a practical way to get there.

## What's next

Reachy Mini is the first step. The same approach, open models on hardware I control, should carry over to robots that move:

- **Micro ducks.** Small bipedal robots that walk using learned locomotion policies. The plan is to train and run those policies locally and connect them to the language and vision layer.
- **Unitree G3.** A full-size humanoid. Same principle: perception, language and control policies on local compute, with the robot confirming before it takes physical actions.
- **More tools for Reachy,** such as answering weather questions with a local AI weather model.

---

This is part of my work on AI and robotics at Fraunhofer HHI. See my [CV](/) for more.
