# ArgaBeacon
---

An open-source, decentralized, and off-grid emergency communication infrastructure designed for extreme blank-spot terrains, powered by **Meshtastic** and optimized under the **Previx Ecosystem**.

---

## 📌 Overview

**ArgaBeacon** is a low-power, long-range hardware and software ecosystem built to solve the critical infrastructure gap in mountaineering safety and disaster mitigation across the Indonesian archipelago. By utilizing a decentralized **Mesh Network (LoRa)** topology, ArgaBeacon establishes a fully autonomous, self-healing communication grid that operates entirely independent of cellular networks, internet connectivity, or traditional power grids.

Derived from the robust framework of the open-source **Meshtastic** protocol, ArgaBeacon has been heavily re-engineered, customized, and optimized to run seamlessly within the **Previx Ecosystem** for enhanced resource management, kernel-level efficiency, and rapid emergency deployment.

---

## 🛠 Core Architecture & Infrastructure

The ecosystem consists of two primary hardware nodes interacting dynamically over the field:

### 1. Arga-Station (Static Node)
*   **Deployment:** Fixed at strategic high-altitude checkpoints, ridges, and intersection paths.
*   **Power:** Fully autonomous, ultra-low-power draw coupled with a miniaturized solar harvesting system (Solar-Powered).
*   **Role:** Acts as a rugged, weatherproof routing backbone ($multi-hop\ routing$) to relay emergency packets across vast topographical barriers.

### 2. Arga-Tag / Wearable (Mobile Node)
*   **Deployment:** Carried directly by mountaineers, field guides, or search-and-rescue (SAR) personnel.
*   **Hardware:** Integrated high-precision GNSS/GPS modules and low-latency kinematic sensors (Accelerometer/Gyroscope).
*   **Role:** Monitors user telemetry and acts as the primary data origin point.

---

## ⚡ The Autonomous Beacon Mechanism

The core innovation of ArgaBeacon lies in its logic-driven **"Suar Teriak" (Autonomous Beacon)** routine. When a mobile node detects a critical safety anomaly—such as a high-G free-fall event (indicating a fall into a ravine) or a manual hardware SOS trigger:

```
[Normal Mode: Idle/Telemetry] 
              │
              ▼ (Free-Fall Event / Manual SOS Trigger)
[Autonomous Beacon Mode Activated]
              │
              ▼ (Preempts Network Bandwidth)
[Broadcasts High-Priority Telemetry Packet] ───> (Multi-hop Mesh Relay via Arga-Stations) ───> [Basecamp / SAR HQ]
```

---

The broadcasted emergency packet overrides standard mesh traffic and continuously transmits:
*   High-precision geographic coordinates (Lat, Long, Alt).
*   Cryptographic Unique Identifier (UID) of the user.
*   Precise timestamp of the incident.
*   Localized hardware visual/audio signaling for close-range search optimization.

---

## 🚀 Previx Ecosystem Optimization

While the underlying network architecture inherits the reliable routing of **Meshtastic**, ArgaBeacon is fine-tuned and integrated directly under the **Previx Ecosystem** umbrella to bridge the gap between low-level hardware and high-level field management:

*   **Hardware-Level Power Efficiency:** Custom power-state scheduling tailored to squeeze maximum battery life out of mobile nodes during prolonged search-and-rescue windows.
*   **Seamless Interface Integration:** Native compatibility with Previx-based monitoring endpoints, allowing basecamps to map incoming telemetry packets into actionable, low-latency spatial data without relying on proprietary maps.
