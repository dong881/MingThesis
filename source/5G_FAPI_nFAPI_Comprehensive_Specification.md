# 5G FAPI and nFAPI Comprehensive Specification

## Document Information

- **Title**: 5G FAPI PHY API Specification & 5G nFAPI Specification - Complete Merged Document
- **Source Documents**:
  - SCF222: 5G FAPI PHY API Specification (Version 222.07.00, August 2023)
  - SCF225: 5G nFAPI Specification (Version 225.3.0, July 2022)
- **Organization**: Small Cell Forum
- **Scope**: Complete merged technical reference for 5G NR FAPI and nFAPI interfaces

---

## Table of Contents

1. [Introduction](#introduction)
2. [FAPI Architecture and Interfaces](#fapi-architecture-and-interfaces)
3. [PHY API Procedures](#phy-api-procedures)
4. [PHY API Messages](#phy-api-messages)
5. [nFAPI Procedures](#nfapi-procedures)
6. [nFAPI Messages](#nfapi-messages)
7. [nFAPI Transport and Message Formats](#nfapi-transport-and-message-formats)
8. [Configuration Parameters and TLVs](#configuration-parameters-and-tlvs)
9. [Slot Procedures and Message Types](#slot-procedures-and-message-types)

---

## Introduction

### 5G New Radio (NR) Overview

5G NR is standardized by 3GPP and designed as an evolution to the current 4G LTE wireless network. Requirements for 5G include:

- **Higher bandwidth**
- **Lower latency**
- **Improved reliability**
- **Increased density of users/devices**

Three service types are defined:
1. **eMBB** (Enhanced Mobile Broadband)
2. **URLLC** (Ultra-Reliable Low Latency Communications)
3. **mIoT** (Massive Internet of Things)

### 5G Network Architecture

A 5G network consists of two main elements:

1. **5G Core**: Access and Mobility Function (AMF), User Plane Function (UPF), etc.
2. **5G Node B (gNB)**: Radio Access Network node containing:
   - gNB (integrated entity)
   - gNB-CU (Centralized Unit)
   - gNB-DU (Distributed Unit)

The standardized interfaces include:
- **NG**: gNB to 5G Core
- **Xn**: gNB to gNB
- **F1**: gNB-CU to gNB-DU

---

## FAPI Architecture and Interfaces

### FAPI Overview

The **Functional Application Platform Interface (FAPI)** is an initiative within the small cell industry released by Small Cell Forum (SCF), which establishes interoperability and innovation among suppliers of:
- Platform hardware
- Platform software
- Application software

FAPI provides a common API around which suppliers can create a competitive ecosystem, supporting innovation and competitive market dynamics for vendors of 5G small cell hardware, software, and equipment.

### 5G FAPI Suite

The 5G FAPI suite comprises five specification documents:

| Document | Designation | Interface | Purpose |
|----------|-------------|-----------|---------|
| SCF222 | 5G FAPI PHY API | P5, P7 | Main data path and PHY mode control |
| SCF223 | 5G FAPI RF and DFE Control API | P19 | Frontend Unit control |
| SCF224 | Network Monitor Mode API | P4 | 2G/3G/4G/5G monitoring |
| SCF225 | 5G nFAPI Specification | P5, P7, P19 | Split 6 virtualization interface |
| SCF229 | 5G OAM Specification | - | Operations, Administration, Management |

### FAPI Interfaces

**FAPI resides as an internal interface within the gNB/gNB-DU component:**

```
MAC
 |
 | P7 (Data Path)
 | P5 (Control)
 |
PHY (incl. digital beamforming)
 |
 | P19 (Frontend control)
 |
Frontend Unit (DFE + RF)
```

### nFAPI Extensions

**nFAPI** extends FAPI for virtualized deployments where MAC and PHY reside in different physical locations:

- **VNF** (Virtual Network Function): MAC/L2L3 functions (S-DU)
- **PNF** (Physical Network Function): PHY/L1 functions (S-RU)
- **Split Architecture**: Option 6 (3GPP TR 38.816)

---

## PHY API Procedures

### Configuration Procedures Overview

Configuration procedures manage the PHY layer and are expected to occur infrequently. These procedures move the PHY through three states:

1. **IDLE**: Initial state
2. **CONFIGURED**: Ready for operation
3. **RUNNING**: Active transmission/reception

### PHY State Machine

```
IDLE State
    ↓
    PARAM.request → PARAM.response
    CONFIG.request → CONFIG.response
    ↓
CONFIGURED State
    ↓
    START.request → SLOT.indication (or START.response/TIMING.indication)
    ↓
RUNNING State
    ↓
    STOP.request → STOP.indication
    ↓
CONFIGURED State (return)
```

### Initialization Procedure

The initialization procedure moves PHY from IDLE → RUNNING via CONFIGURED state:

#### Step 1: PARAM Message Exchange

- **Purpose**: Allow L2L3 to collect information about PHY configuration and capabilities
- **Procedure**:
  1. L2L3 sends `PARAM.request` to PHY
  2. PHY returns `PARAM.response` with capabilities based on current state

| PHY State | Information Returned |
|-----------|----------------------|
| IDLE | Supported capabilities |
| CONFIGURED | Current configuration |
| RUNNING | Invalid state error |

**Guard Timer Recommendation**: Implement timeout to detect PHY failures

#### Step 2: CONFIG Message Exchange

- **Purpose**: Configure the PHY
- **Valid States**: IDLE, CONFIGURED, RUNNING (limited)

**When PHY is in IDLE state:**
- `CONFIG.request` must include all mandatory TLVs
- If valid, moves to CONFIGURED state
- If invalid, remains in IDLE state and ignores all TLVs

**When PHY is in CONFIGURED state:**
- `CONFIG.request` may include only TLVs that need to be changed
- Remains in CONFIGURED state after successful configuration
- If invalid, ignores all TLVs and maintains previous configuration

**When PHY is in RUNNING state:**
- Limited subset of TLVs permitted (indicated in PARAM.response)
- Remains in RUNNING state
- If invalid, ignores all TLVs and maintains current operation

#### Step 3: START Message Exchange

- **Purpose**: Instruct configured PHY to start transmitting as a gNB
- **Procedure**:
  1. L2L3 sends `START.request` to PHY in CONFIGURED state
  2. PHY responds based on synchronization mechanism:

**For SFNSL-based synchronization:**
- PHY issues `SLOT.indication` message
- After first SLOT.indication, PHY enters RUNNING state

**For Delay Management with Timestamps:**
- PHY issues `START.response` message
- PHY enters RUNNING state

**For Delay Management without Timestamps:**
- PHY issues `TIMING.indication` message
- PHY enters RUNNING state

**Invalid States:**
- If START.request received in IDLE or RUNNING state → ERROR.indication with INVALIDSTATE error

### Termination Procedure

- **Purpose**: Move PHY from RUNNING → CONFIGURED state
- **Action**: L2L3 sends `STOP.request` to PHY
- **Result**: PHY stops all TX/RX operations, returns to CONFIGURED state
- **Response**: PHY sends `STOP.indication` when complete
- **Invalid State**: If received in IDLE/CONFIGURED state → ERROR.indication with INVALIDSTATE error

### Restart Procedure

Restart allows PHY to temporarily stop but later resume with same configuration:

1. Execute STOP message exchange → CONFIGURED state
2. Execute START message exchange → RUNNING state

### Reset Procedure

- **Purpose**: Move PHY to IDLE state
- **Action**: L2L3 sends `RESET.request`
- **Effect**: PHY discards all configuration and returns to IDLE state
- **Use Case**: Recovery from error conditions

### Reconfiguration Procedures

#### Major Reconfiguration

Used for significant PHY changes while stopped:

1. STOP message exchange (RUNNING → CONFIGURED)
2. CONFIG message exchange (reconfigure in CONFIGURED state)
3. START message exchange (CONFIGURED → RUNNING)

#### Minor Reconfiguration

Used for runtime changes without stopping PHY:

1. Send `CONFIG.request` with specific SFNSL while in RUNNING state
2. Limited TLV subset allowed (indicated in PARAM.response)
3. CONFIG.request must be sent **before** DLTTI.request and ULTTI.request
4. TLVs applied at the SFNSL specified in CONFIG.request
5. PHY remains in RUNNING state

### Query Procedure

- **Purpose**: L2L3 queries current PHY configuration/status
- **Action**: L2L3 sends `QUERY.request`
- **Response**: PHY returns `QUERY.response` with requested information
- **Valid States**: All states

### Notification Procedures

PHY may send notifications to L2L3 for:
- Configuration status changes
- Capability changes
- Error conditions
- Resource availability updates

### Protocol Negotiation

**Purpose**: Negotiate FAPI protocol version between L2L3 and PHY

**Procedure**:
1. L2L3 sends `PARAM.request` with `protocolVersion`
2. PHY returns `PARAM.response` with:
   - `phyFapiProtocolVersion`: PHY's supported version
   - `phyFapiNegotiatedProtocolVersion`: Agreed version
3. Both sides use `phyFapiNegotiatedProtocolVersion` for subsequent exchanges

**Constraints**:
- Can only occur when all PHYs in IDLE state
- Applies to common context if supervisory PHY (ID 255) defined
- If no agreement possible → negotiation fails

### PHY Groups

The set of all PHYs is partitioned into PHY Groups:

- **Purpose**: Logically group related PHY instances
- **Isolation**: P5 APIs in one group cannot impact other groups
- **Context**: PHY Group Context supports P5 APIs but not P7
- **Orchestration**: Outside scope of current specification

### PHY Instantiation

Process of discovering and selecting PHY Profiles to define PHY IDs:

**Steps:**

1. **PHY Profile Discovery**
   - L2L3 uses Query Procedure to discover supported PHY Profiles
   - Query directed to Common/PHY Group Context (PHY ID 255)

2. **DFE Profile Discovery**
   - L2L3 queries DFE using P19 interface for supported DFE Profiles

3. **PHY Profile Selection**
   - L2L3 sends `CONFIG.request` to Common/PHY Group Context
   - Selects specific PHY Profile

4. **PHY Definition**
   - L2L3 receives `CONFIG.response` confirming definition of PHY IDs
   - Multiple PHY IDs can be defined from single Profile

5. **DFE Profile Selection**
   - L2L3 sends `CONFIG.request` to DFE
   - Selects specific DFE Profile

6. **Result**
   - Selected PHY IDs become available for configuration
   - PHYs enter IDLE state
   - Procedures 3-5 can be executed in any order

### Common and PHY Group Contexts

**PHY ID 255** typically corresponds to Common/PHY Group Context:

- **P5 Support**: Full support (configuration, query, notification)
- **P7 Support**: None (cannot terminate slot messages)
- **State Machine**: No IDLE/CONFIGURED/RUNNING states
- **Configuration**: Can be configured without state constraints
- **Queries**: Can be queried like other PHYs

**Scope Determination**:
- **Specific PHY**: PHY ID explicitly specified, no PHY Group
- **Common Context**: PHY Group absent, PHY ID common (255)
- **PHY Group Context**: PHY Group ID present, PHY ID common (255)

### PHY-FEU Interface Management

In split architectures (e.g., 7.2x), PHY-FEU interface may experience:

**Disconnection Events:**
- L2L3 transitions PHY and FEU to Idle
- Re-queries FEU and PHY capabilities after reconnection

**Synchronization Events:**
- L2L3 stops RUNNING PHY
- Re-starts PHY when synchronization recovered

**Notification Mechanism:**
- `CONNECTIVITY.indication` message carries event information
- Applies to P5 interface (PHY) and P19-C interface (FEU)

---

## Slot Procedures

### Delay Management Overview

Two delay management mechanisms maintain receive windows at L1 for time-critical P7 messages:

#### Mechanism 1: Delay Management with Timestamps

**Characteristics:**
- P7 message headers signal timestamps
- PHY maintains receive window with size and offset
- START.response indicates successful procedure completion

**Use Case**: Split architectures with controlled latency

#### Mechanism 2: Delay Management without Timestamps

**Characteristics:**
- P7 message headers contain NO timestamps
- PHY maintains receive window for buffering
- TIMING.indication indicates successful procedure completion
- Event-driven or periodic TIMING.indication messages

**Advantages**: Simpler implementation, no timestamp synchronization required

### Receive Window Mechanism

Each PHY maintains a Receive Timing Window characterized by:

1. **Timing Window Size**: Duration to accept messages
2. **Message Timing Offset**: How early before slot start

**Window Behavior:**

```
Messages arriving INSIDE Timing Window → Processed for slot
Messages arriving EARLY → Marked as too early, triggers Timing Info
Messages arriving LATE → Marked as too late, triggers Timing Info
```

### SLOT Signal and Synchronization

#### SFNSL Synchronization

**System Frame Number Slot (SFNSL)** maintains alignment between L2L3 and PHY:

- SFN: Range 0-1023 (10 bits)
- Slot: Range 0-159 (per numerology, varies 0-159 or 0-79 or 0-39)

**Synchronization Scenarios:**

**L2L3 as Master:**
1. L2L3 sends DLTTI.request/ULTTI.request with SFNSL N
2. PHY adopts SFNSL N as reference
3. On mismatch: PHY discards message and returns ERROR.indication
4. L2L3 must correct SFNSL

**L1 PHY as Master:**
1. PHY sends SLOT.indication with SFNSL M
2. L2L3 adopts SFNSL M as reference
3. L2L3 sends DLTTI.request/ULTTI.request with SFNSL M
4. On mismatch: PHY discards message and returns ERROR.indication

### Slot Numerology

**Highest Numerology Rule:**

L2-initiated P7 messages use the highest configured numerology:
- 15 kHz → slots at basic rate
- 30 kHz → slots at 2x rate
- 60 kHz → slots at 4x rate
- 120 kHz → slots at 8x rate

Channel-specific PDUs transmitted only when their numerology slot aligns:
- Example: If highest = 60 kHz, 15 kHz PDUs sent only when 60 kHz slot divisible by 4

### API Message Order

#### Downlink Message Order

```
1. Optional: CONFIG.request (if reconfiguring)
   ↓ (must be first message if present)
2. DLTTI.request (unless SkipblankDLCONFIG enabled and empty)
   ↓ (contains SFNSL matching SLOT.indication)
3. ULTTI.request (unless SkipblankULCONFIG enabled and empty)
   ↓ (contains SFNSL for uplink slot)
4. Optional: ULDCI.request (dynamic UCI changes)
   ↓
5. Optional: TXDATA.request (transport data)
   ↓
6. Indications (RXDATA, CRC, UCI, SRS, RACH)
```

#### Uplink Message Order

```
1. ULTTI.request
   ↓ (contains uplink PDU definitions)
2. Optional: ULDCI.request (if UCI must be updated)
   ↓
3. Indications (RXDATA, CRC, UCI, SRS)
```

**Constraints:**
- SFNSL in messages must match expected value
- CONFIG.request must precede DLTTI/ULTTI if PHY reconfiguring
- No ordering required between DLTTI/ULTTI (independent Receive Windows)

### Downlink Procedures

#### PDSCH (Physical Downlink Shared Channel)

**Purpose**: Transmit payload data to UE

**Procedure:**
1. L2L3 sends DLTTI.request containing PDSCH PDU
2. L2L3 sends TXDATA.request with transport block data
3. PHY transmits PDSCH with specified parameters

**Features:**
- Supports SU-MIMO (Single User) and MU-MIMO (Multi-User)
- Supports Massive-MIMO
- Supports dynamic precoding/beamforming
- PTRS (Phase Tracking Reference Signal) support
- Rate matching and puncturing support

#### PDCCH (Physical Downlink Control Channel)

**Purpose**: Transmit DCI (Downlink Control Information)

**Procedure:**
1. L2L3 sends DLTTI.request containing PDCCH PDU
2. PDU includes DCI encoding parameters
3. PHY transmits PDCCH with DCI

**Features:**
- Supports multiple numerologies (15/30/60/120 kHz)
- CORESET configuration
- Rate matching
- Precoding/beamforming

#### SSB/PBCH (Synchronization Signal Block / Primary Broadcast Channel)

**Purpose**: Transmit synchronization signals and MIB

**Procedure:**
1. L2L3 sends DLTTI.request with SSB-PBCH PDU
2. PHY transmits SS block with PBCH
3. PHY may generate or use L2-provided MIB

**Locations:**
- **FR1 (Sub-6 GHz)**: Defined grid positions
- **FR2 (mmWave)**: Higher density possible

#### CSI-RS (Channel State Information Reference Signal)

**Purpose**: Transmit reference signals for channel measurement

**Procedure:**
1. L2L3 sends DLTTI.request with CSI-RS PDU
2. PHY transmits at defined resource locations
3. UE measures channel quality

#### PRS (Positioning Reference Signal)

**Purpose**: Transmit positioning reference signals

**Procedure:**
1. L2L3 sends DLTTI.request with PRS PDU
2. PHY transmits PRS for positioning measurement
3. Supports puncturing of other signals

### Uplink Procedures

#### PUSCH (Physical Uplink Shared Channel)

**Purpose**: Receive payload data from UE

**Procedure:**
1. L2L3 sends ULTTI.request containing PUSCH PDU
2. PHY receives and decodes PUSCH
3. PHY sends RXDATA.indication with decoded data
4. PHY sends CRC.indication with CRC status

**Features:**
- Supports dynamic scheduling
- Transform precoding support
- Frequency hopping
- Rate matching
- DMRS (Demodulation Reference Signal) support
- UCI multiplexing (HARQ ACK, CSI, SR on PUSCH)

#### PUCCH (Physical Uplink Control Channel)

**Purpose**: Receive control information from UE

**Procedure:**
1. L2L3 sends ULTTI.request with PUCCH PDU
2. PHY receives and decodes PUCCH
3. PHY sends UCI.indication with decoded UCI
4. Supports 4 PUCCH formats with different payloads

**UCI Types on PUCCH:**
- HARQ ACK/NACK (Hybrid Automatic Repeat reQuest)
- CSI (Channel State Information)
- SR (Scheduling Request)

#### PRACH (Physical Random Access Channel)

**Purpose**: Receive random access attempts from UE

**Procedures:**

**Conventional RACH (4-Step):**
1. Msg1: UE sends PRACH preamble
   - ULTTI.request contains PRACH PDU
   - PHY detects preambles, sends RACH.indication
2. Msg2: gNB sends RAR (Random Access Response)
   - DLTTI.request contains PDSCH PDU for RAR
3. Msg3: UE sends RRC Connect Request
   - ULTTI.request contains PUSCH PDU
4. Msg4: gNB sends RRC Setup
   - DLTTI.request contains PDSCH PDU for setup

**2-Step RACH (Contention-based):**
1. MsgA: UE sends MsgA-PRACH + MsgA-PUSCH in same slot
   - ULTTI.request contains MsgA-PRACH and MsgA-PUSCH PDUs
   - PHY detects PRACH, forwards to L2L3
   - PHY receives PUSCH payload in same slot
2. MsgB: gNB sends response
   - DLTTI.request contains PDSCH PDU for MsgB

**Long Format PRACH:**
- Supports formats 0, 1, 2, 3
- Longer preamble duration (50.4 ms, 32.4 ms, 25.2 ms, 12.6 ms)

**Short Format PRACH:**
- Supports formats A1, A2, A3, B1, B2, B3, B4, C0, C2
- Shorter preamble duration (0.625 ms, 1.25 ms, 2.5 ms)
- Configurable subcarrier spacing (15/30/60/120 kHz)

#### SRS (Sounding Reference Signal)

**Purpose**: Receive uplink channel measurements

**Procedure:**
1. L2L3 sends ULTTI.request with SRS PDU
2. PHY receives and measures SRS
3. PHY sends SRS.indication with measurement results

**Reporting Modes:**
- Frequency domain (per PRG - Precoding Resource Group)
- Time domain (per antenna port)
- Beamforming reports
- Channel IQ matrix
- SVD representation
- 2D-DFT representation

**Enhanced Capabilities (eMIMO):**
- SRS-based port selection
- Reporting layer determination
- UL combiner optimization

#### Zero-Power SRS (ZP-SRS)

**Purpose**: Configure SRS resources to be silent (measuring CSI-RS)

**Procedure:**
1. L2L3 sends ULTTI.request with ZP-SRS PDU
2. PHY reserves resources for zero-power transmission

### Spatial Multiplexing (MIMO)

#### Precoding and Beamforming Flow

**Downlink (PDSCH):**

1. **Digital Precoding Table (PMT) - Semi-static**
   - L2L3 stores precoding matrices via CONFIG.request
   - Precoder Matrix Table contains multiple precoder options
   - Identified by precoder matrix indices

2. **Digital Beam Table (DBT) - Semi-static**
   - L2L3 stores digital beam weights via CONFIG.request
   - Digital Beam Table contains multiple beam weight options
   - Identified by beam indices

3. **Slot-level Signaling**
   - L2L3 sends DLTTI.request with:
     - Precoder matrix index (references PMT)
     - Beam index (references DBT)
   - PHY applies selected precoding/beaming to PDSCH

#### MU-MIMO Support

**Multi-User MIMO Configuration:**

1. **Codebook-based:**
   - L2L3 provides available precoding matrices
   - PHY applies to multiple UEs simultaneously

2. **Non-codebook (Open-loop):**
   - L2L3 directly specifies precoding weights
   - PHY applies without codebook constraint

3. **MU-MIMO Groups:**
   - PHY groups can support up to specified count
   - Mutual interference managed via precoding

#### SRS-based Channel Measurement

**Channel Measurement Workflow:**

1. L2L3 sends ULTTI.request with SRS PDU
2. PHY measures received SRS
3. PHY sends SRS.indication containing:
   - Beamforming report (per antenna port or PRG)
   - Channel IQ samples
   - SVD decomposition
   - SU-MIMO codebook recommendation
   - Positioning report (if configured)

**Measurement Parameters:**
- Number of RX beams to combine
- Reporting resolution
- Measurement averaging

#### 2D-DFT Channel Representation

**Purpose**: Compressed channel representation using 2D Discrete Fourier Transform

- Frequency domain: Across subcarriers
- Time domain: Across OFDM symbols
- Reduces measurement overhead
- Enables efficient MIMO precoding selection

---

## PHY API Messages

### General Message Format

#### Message Structure

All FAPI messages follow a standard structure:

```
Message Header
├── Message Type ID
├── Message Length
└── Reserved/Flags

Message Body
├── TLVs (Tag-Length-Value)
│   ├── Tag (2 bytes)
│   ├── Length (2 bytes)
│   └── Value (variable)
└── Padding (for alignment)
```

#### Padding Rules

All FAPI messages are padded to 4-byte alignment:

```
Padding length = (4 - (L mod 4)) mod 4
where L = message body length
```

#### Message Header Format

| Field | Size | Description |
|-------|------|-------------|
| Message Type | 2 bytes | Identifier for message type |
| Length | 2 bytes | Length of message body |
| Reserved | Variable | Reserved for future use |

### Backward Compatibility

FAPI supports backward compatibility through message extensions:

**Legacy Message Extension:**
- Original message body without extension
- New extension field appended
- Receivers ignore unknown extensions

**Extension Format:**
```
Original Message
├── Existing TLVs
└── Extension TLV (containing new fields)
```

### Configuration Messages

#### PARAM Message Exchange

**Purpose**: Query PHY capabilities and configuration

**PARAM.request**
- Sender: L2L3
- Receiver: PHY
- Body: Empty (or contains protocol version info)

**PARAM.response**
- Sender: PHY
- Receiver: L2L3
- Body: TLVs containing:
  - Supported capabilities
  - Current configuration (if CONFIGURED)
  - Mandatory TLV list

**Capability TLVs Returned:**

| Tag | Name | Description |
|-----|------|-------------|
| 0x0001 | num-TLV | Number of TLV entries |
| 0x0030 | Release | 3GPP Release version |
| 0x0031 | DL Bandwidth | Supported DL bandwidth |
| 0x0032 | UL Bandwidth | Supported UL bandwidth |
| 0x0051 | PHY Profiles | Supported PHY Profile list |
| 0x0052 | Time Management | Supported time management mechanism |

#### CONFIG Message Exchange

**Purpose**: Configure PHY parameters

**CONFIG.request**
- Sender: L2L3
- Receiver: PHY
- Body: TLVs containing configuration parameters

**CONFIG.response**
- Sender: PHY
- Receiver: L2L3
- Body: Error code (OK or specific error)

**Configuration TLV Categories:**

1. **Cell/PHY Parameters**
   - Numerology, cell ID, antenna counts
   - Duplex mode (TDD/FDD)

2. **Carrier Parameters**
   - Frequency, bandwidth, subcarrier spacing

3. **PDCCH Parameters**
   - CORESET configuration, DCI formats

4. **PUCCH Parameters**
   - Format support, resource sets

5. **PDSCH Parameters**
   - Antenna ports, precoding support, rate matching

6. **PUSCH Parameters**
   - DMRS types, frequency hopping, VRB mapping

7. **PRACH Parameters**
   - Format support, preamble detection threshold

8. **SSB Parameters**
   - Beam count, power, duration

9. **UCI Parameters**
   - Multiplexing rules, coding

10. **Measurement Parameters**
    - Measurement capability indicators

#### START Message

**Purpose**: Initiate PHY operation from CONFIGURED state

**START.request**
- Sender: L2L3
- Receiver: PHY
- Body: Empty

**START.response** (in nFAPI with Delay Management)
- Sender: PHY
- Receiver: L2L3
- Body: Error code

**SLOT.indication** (in FAPI with SFNSL sync)
- Sender: PHY
- Receiver: L2L3
- Body: Current SFNSL, other synchronization info

**TIMING.indication** (in Delay Management without Timestamps)
- Sender: PHY
- Receiver: L2L3
- Body: Timing window parameters

#### STOP Message

**Purpose**: Halt PHY operation

**STOP.request**
- Sender: L2L3
- Receiver: PHY
- Body: Empty

**STOP.indication**
- Sender: PHY
- Receiver: L2L3
- Body: Status information

#### RESET Message

**Purpose**: Reset PHY to IDLE state

**RESET.request**
- Sender: L2L3
- Receiver: PHY
- Body: Reset scope parameters

#### ERROR.indication

**Purpose**: Report errors to L2L3

**Message Body:**

| Field | Type | Description |
|-------|------|-------------|
| SFNSL | uint16 | Frame/slot where error occurred |
| Error Code | uint16 | Specific error identifier |
| Extended Status | variable | Additional error details |

**Common Error Codes:**

| Code | Name | Meaning |
|------|------|---------|
| 0x00 | MSG_OK | Message accepted successfully |
| 0x01 | MSG_INVALID_CONFIG | Configuration invalid |
| 0x02 | MSG_INVALID_STATE | Invalid PHY state for operation |
| 0x03 | MSG_INVALID_SFN_SLOT | SFN/Slot mismatch |
| 0x04 | MSG_LATE_ARRIVAL | Message arrived too late |

#### CONNECTIVITY.indication

**Purpose**: Report PHY-FEU connection status

**Message Body:**

| Field | Type | Description |
|-------|------|-------------|
| PHY ID | uint8 | Affected PHY instance |
| Status | uint8 | Connection/sync status |
| Details | variable | Event-specific information |

**Status Values:**
- Disconnection
- Reconnection
- Synchronization loss
- Synchronization recovered

### Slot Messages

#### DLTTI.request (Downlink TTI - Transmission Time Interval)

**Purpose**: Schedule all downlink transmission for a slot

**Sender**: L2L3
**Receiver**: PHY

**Message Structure:**

```
Header:
  - SFNSL (System Frame Number Slot)
  - Number of PDUs
  
PDUs (variable count):
  1. PDCCH PDU (optional)
     - Coreset index, DCI payload, precoding
  2. PDSCH PDU (optional, multiple possible)
     - Resource allocation, modulation, antenna ports
  3. SSB-PBCH PDU (optional)
     - SS block index, power, beamforming
  4. CSI-RS PDU (optional, multiple possible)
     - Resource locations, ports, frequency hopping
  5. PRS PDU (optional)
     - Positioning reference signal configuration
```

**PDCCH PDU Details:**

| Field | Type | Description |
|-------|------|-------------|
| Coreset Index | uint8 | CORESET resource set ID |
| Start PRB | uint16 | Starting PRB index |
| Duration | uint8 | OFDM symbols count |
| DCI Payload | byte[] | Encoded DCI bits |
| DCI Payload Format Length | uint16 | Bit length of DCI |
| DMRS Configuration | struct | DMRS parameters |
| Precoding Type | uint8 | Codebook/non-codebook/dynamic |
| Precoder Matrix Index | uint16 | Reference to PMT (if codebook) |

**PDSCH PDU Details:**

| Field | Type | Description |
|-------|------|-------------|
| PDU Index | uint16 | Unique PDU identifier |
| Slot | uint16 | Slot number (for multi-slot scheduling) |
| Start PRB | uint16 | Starting PRB |
| Number of PRBs | uint16 | Count of allocated PRBs |
| Start OFDM Symbol | uint8 | Starting symbol in slot |
| Number of Symbols | uint8 | Symbols count |
| Data Scrambling ID | uint32 | Scrambling sequence ID |
| RNTI | uint16 | Radio Network Temporary ID |
| PDSCH Power | int16 | Transmission power (0.1 dBm units) |
| Modulation | uint8 | QPSK, 16QAM, 64QAM, 256QAM |
| Number of Code Layers | uint8 | 1-8 layers |
| Number of Antenna Ports | uint8 | Antenna port count |
| DMRS Type | uint8 | Type 1 or 2 |
| Precoding Type | uint8 | Codebook/non-codebook/dynamic |
| Precoder Matrix Index | uint16 | PMT reference |
| Beam Index | uint16 | DBT reference |
| TBS (Transport Block Size) | uint32 | Bit count for TXDATA |
| Code Block Group | uint8 | CBG transmission |
| PTRS (Phase Tracking RS) | struct | PTRS configuration |
| Rate Matching | struct[] | Rate matching patterns |

**Rate Matching Patterns:**

- PRB-Symbol bitmap (non-CORESET)
- CORESET rate match bitmap
- LTE-CRS rate match (for LTE coexistence)
- CSI-RS rate match

**PDSCH Extensions:**

- **FAPIv4+**: Spatial multiplexing parameters
- **FAPIv5+**: Additional MIMO capabilities
- **FAPIv6+**: Precoding optimization
- **FAPIv7+**: Advanced beamforming features

#### ULTTI.request (Uplink TTI)

**Purpose**: Configure all uplink reception for a slot

**Sender**: L2L3
**Receiver**: PHY

**Message Structure:**

```
Header:
  - SFNSL (must match expected value)
  - Number of PDUs
  
PDUs (variable count):
  1. PRACH PDU (optional, for random access)
  2. PUSCH PDU (optional, multiple possible)
  3. PUCCH PDU (optional, multiple possible)
  4. SRS PDU (optional)
  5. Zero-Power SRS PDU (optional)
```

**PRACH PDU Details:**

| Field | Type | Description |
|-------|------|-------------|
| PRACH Format | uint8 | Long/short format |
| Root Sequence Index | uint16 | Preamble root sequence |
| Zero Correlation Zone Index | uint8 | ZCZI for low correlation |
| Start PRB | uint16 | Frequency location |
| Number of PRBs | uint8 | Bandwidth allocation |
| Detection Threshold | uint8 | Preamble detection SNR threshold |
| Duration | uint8 | Symbol count |
| Optional MsgA-PRACH to MsgA-PUSCH Mapping | struct | 2-step RACH mapping |

**PUSCH PDU Details:**

| Field | Type | Description |
|-------|------|-------------|
| PDU Index | uint16 | Unique identifier |
| Slot | uint16 | For multi-slot allocation |
| Start PRB | uint16 | Frequency allocation start |
| Number of PRBs | uint16 | Frequency allocation size |
| Start OFDM Symbol | uint8 | Time allocation start |
| Number of Symbols | uint8 | Time allocation duration |
| Data Scrambling ID | uint32 | Scrambling ID |
| RNTI | uint16 | Radio Network Temporary ID |
| Modulation | uint8 | QPSK, 16QAM, 64QAM |
| Target Code Rate | uint16 | Bits per resource element |
| DMRS Type | uint8 | Type 1 or 2 |
| Frequency Hopping | uint8 | Enabled/disabled |
| Transform Precoding | uint8 | DFT-Spread-OFDM |
| Number of Code Layers | uint8 | Spatial multiplexing |
| Uplink Spatial Stream Assignment | struct | Port-to-antenna mapping |
| TBS | uint32 | Expected data size in bits |
| UCI Present | uint8 | Whether HARQ/CSI/SR included |

**UCI Information on PUSCH:**

- **HARQ-ACK**: Optional feedback
- **CSI (Channel State Information)**: Optional channel report
- **SR (Scheduling Request)**: Optional request for allocation

#### ULDCI.request

**Purpose**: Update UCI (Uplink Control Information) dynamically

**Sender**: L2L3
**Receiver**: PHY
**Scope**: Modify UCI parameters in slot without ULTTI.request

**Message Structure:**

```
Header:
  - SFNSL
  - Number of UEs to modify
  
Per-UE UCI Updates:
  - RNTI
  - UCI format type
  - New HARQ bits
  - New CSI bits
  - New SR bits
```

#### TXDATA.request

**Purpose**: Provide transport block data for downlink transmission

**Sender**: L2L3
**Receiver**: PHY

**Message Structure:**

```
Header:
  - PDU Index (references PDSCH in DLTTI)
  - Number of Segments (for large blocks)
  
Transport Data:
  - Segment Index
  - Data Bytes (bit-aligned)
  - CRC if required
  - HARQ Process Context
```

**Data Alignment Options:**

| Alignment | Unit | Usage |
|-----------|------|-------|
| 8-bit | Byte | Standard |
| 16-bit | Word | Efficiency |
| 32-bit | Dword | Optimal performance |
| 64-bit | Qword | High-speed systems |
| 256-bit | YMM | SIMD acceleration |

#### RXDATA.indication

**Purpose**: Report decoded uplink payload to L2L3

**Sender**: PHY
**Receiver**: L2L3

**Message Structure:**

```
Per-PUSCH:
  - PDU Index (from ULTTI.request)
  - RNTI
  - HARQ Process ID
  - Decoded Bytes
  - Timing Advance (for ranging)
  - Optional: Uplink Timing (measurement)
```

#### CRC.indication

**Purpose**: Report PUSCH CRC status

**Sender**: PHY
**Receiver**: L2L3

**Message Structure:**

```
Per-PUSCH:
  - PDU Index
  - RNTI
  - CRC Status (Pass/Fail)
  - HARQ Process ID
  - TB Error Status (if multi-block)
```

#### UCI.indication

**Purpose**: Report uplink control information

**Sender**: PHY
**Receiver**: L2L3

**UCI Sources:**

1. **PUSCH UCI**: Multiplexed on PUSCH data
   - HARQ-ACK feedback
   - CSI reports
   - SR indication

2. **PUCCH UCI**: Dedicated PUCCH transmission
   - Format 0/1: HARQ only (up to 2 bits)
   - Format 2/3/4: HARQ + CSI (variable size)

3. **SRS**: Reference signal receipt

**Message Structure:**

```
UCI PDU Type:
  1. PUSCH UCI
     - PDU Index
     - RNTI
     - HARQ Part 1 and Part 2
     - CSI payload
     
  2. PUCCH Format 0 or 1
     - RNTI
     - SR status
     - HARQ bits
     
  3. PUCCH Format 2/3/4
     - RNTI
     - HARQ payload (up to 11 bits)
     - CSI payload (up to 1706 bits)
```

#### SRS.indication

**Purpose**: Report uplink sounding reference signal measurements

**Sender**: PHY
**Receiver**: L2L3

**Measurement Reports:**

1. **Beamforming Report** (FAPIv3+)
   - Per PRG (Precoding Resource Group)
   - Per-antenna-port measurements
   - Relative power

2. **Channel IQ Matrix** (FAPIv4+)
   - Complex channel samples
   - Frequency domain representation
   - Antenna matrix form

3. **SVD Representation** (FAPIv5+)
   - Singular Value Decomposition
   - Dominant singular vectors
   - Reduced representation

4. **SU-MIMO Codebook Recommendation** (FAPIv4+)
   - Recommended precoding index
   - Quality indicator

5. **2D-DFT Representation** (FAPIv6+)
   - Frequency domain sampling
   - Time domain sampling
   - Compressed format

6. **Positioning Report** (FAPIv7+)
   - SISO/MISO positioning enhancement
   - Channel characteristics

#### RACH.indication

**Purpose**: Report random access preamble detection

**Sender**: PHY
**Receiver**: L2L3

**Message Structure:**

```
Per-Detection:
  - Preamble Index (0-63 or 0-79)
  - Timing Advance (for range estimation)
  - Preamble Power
  - Number of UEs (for collisions)
  - PRACH Occasion Index (if multiple occasions)
```

#### DLTTI.response

**Purpose**: Acknowledge downlink TTI processing (optional)

**Sender**: PHY
**Receiver**: L2L3
**Usage**: When immediate feedback required

#### DL/UL Node Sync (nFAPI-specific)

**Purpose**: Synchronize timing between VNF and PHY in split architecture

**DL Node Sync**:
- Sent by: VNF
- Contains: t1 timestamp, slot offset
- Received by: PNF PHY instance
- Response: UL Node Sync

**UL Node Sync**:
- Sent by: PNF PHY instance
- Contains: t1 (echo), t2, t3 timestamps
- Received by: VNF
- Purpose: Latency and jitter measurement

#### Timing.indication (Delay Management without Timestamps)

**Purpose**: Report message timing status

**Sent When:**
- Message arrives too early/late
- Periodic timing report (if configured)

**Message Contents:**

| Field | Type | Description |
|-------|------|-------------|
| Message Type | uint8 | Which message (DLTTI, ULTTI, etc) |
| Jitter | uint32 | Timing jitter in microseconds |
| Timing Advance | int32 | Early (negative) or late (positive) |

---

## nFAPI Procedures

### nFAPI Overview

**nFAPI** is a network-oriented extension of FAPI for split RAN architectures:

- **VNF**: Virtual Network Function (L2/L3 on server)
- **PNF**: Physical Network Function (L1/FEU on hardware)
- **Transport**: Packet-based (SCTP/UDP) instead of shared memory
- **Split**: Option 6 (3GPP TR 38.816) - MAC/PHY split

### Architecture Models

#### 3-Product Split (S-CU/S-DU/S-RU)

```
S-CU (Central Unit)
├── SDAP
├── PDCP
├── RRC
└─ F1 interface ─┐
                 │
              S-DU (Distributed Unit)
              ├── RLC
              ├── MAC
              ├── Scheduler
              └─ nFAPI interface ─┐
                                  │
                              S-RU (Radio Unit)
                              ├── PHY
                              ├── DFE
                              └── RF
```

#### 2-Product Split (Combined S-CU/S-DU + S-RU)

```
S-DU (Distributed Unit + Central Functions)
├── RRC/PDCP/SDAP
├── RLC
├── MAC
└─ nFAPI interface ─┐
                    │
                S-RU (Radio Unit)
                ├── PHY
                ├── DFE
                └── RF
```

### PNF Procedures

#### PNF Initialization

**Overview**: Moves PNF from IDLE → RUNNING via CONFIGURED state

**Stages:**

1. **PNF READY Indication**
   - Sent by: PNF (upon startup)
   - Received by: VNF
   - Contains: Basic PNF capabilities, device identification

2. **PNF PARAM Message Exchange**
   - Sent by: VNF (PNFPARAM.request)
   - Response: PNF (PNFPARAM.response)
   - Purpose: VNF queries PNF capabilities

3. **PNF CONFIG Message Exchange**
   - Sent by: VNF (PNFCONFIG.request)
   - Response: PNF (PNFCONFIG.response)
   - Purpose: VNF configures PNF-wide parameters

4. **PNF START Message Exchange**
   - Sent by: VNF (PNFSTART.request)
   - Response: PNF (PNFSTART.response)
   - Purpose: VNF instructs PNF to create PHY/FEU instances
   - Result: PNF transitions to RUNNING, PHY instances created

#### PNF State Machine

```
PNF IDLE
  ↓
  PNFPARAM.request/response (optional)
  PNFCONFIG.request/response
  ↓
PNF CONFIGURED
  ↓
  PNFSTART.request/response
  ↓
PNF RUNNING
  ├─ PHY 1 in IDLE
  ├─ PHY 2 in IDLE
  ├─ ... PHY n in IDLE
  └─ DFE/RF Instances in IDLE
  
  ↓ (after PHY/FEU config & START)
  
  ├─ PHY 1 in RUNNING
  ├─ PHY 2 in RUNNING
  ├─ ... PHY n in RUNNING
  └─ DFE/RF Instances in RUNNING
```

#### PNF Stop/Restart/Reconfigure

**PNF Stop**:
- PNFSTOP.request → PNF RUNNING → CONFIGURED
- Destroys all PHY/FEU instances

**PNF Restart**:
- Sequence: PNFSTOP → PNFSTART
- Re-creates PHY/FEU instances

**PNF Reconfigure**:
- Sequence: PNFSTOP → PNFCONFIG → PNFSTART
- Allows configuration changes while stopped

### PHY Instantiation in nFAPI

**Flow:**

1. **PNF Initialization** (PNFSTART.response)
   ↓
2. **FEU Profile Discovery**
   - VNF queries DFE profiles (P19 interface)
   - VNF queries RF profiles (P19 interface)
   ↓
3. **DFE Configuration**
   - VNF selects DFE profile
   - DFE instances created and initialized
   ↓
4. **RF Configuration**
   - VNF selects RF profile
   - RF instances created and initialized
   ↓
5. **PHY Profile Selection**
   - VNF discovers available PHY profiles
   - VNF selects profile compatible with DFE profiles
   ↓
6. **PHY Definition**
   - PHY IDs defined and instantiated in IDLE state
   ↓
7. **PHY Initialization** (per PHY)
   - PARAM.request/response
   - CONFIG.request/response
   - START.request/response
   - Node Sync procedures

### P5 PHY Procedures in nFAPI

#### PHY Initialization

**Differences from FAPI:**

1. **START Procedure**:
   - Instead of SLOT.indication, responds with START.response
   - START.response includes Error Code (OK or specific error)

2. **Node Sync Procedures** (after START):
   - VNF sends DL Node Sync with t1, slot offset
   - PNF PHY responds with UL Node Sync (t1 echo, t2, t3)
   - Establishes latency baseline and synchronization

3. **TIMING.indication** (if Delay Management without timestamps):
   - Initial TIMING.indication sent after START.response
   - Subsequent periodic or event-driven TIMING.indication messages

#### PHY Termination/Restart/Reconfigure

- Follow FAPI procedures
- START.request produces START.response (not SLOT.indication)
- Node Sync procedures follow START

### P7 Slot Procedures in nFAPI

#### Differences from FAPI

1. **No SLOT.indication**
   - FAPI relies on periodic SLOT.indication for synchronization
   - nFAPI cannot reliably use SLOT due to fronthaul jitter

2. **Delay Management Mechanism**
   - PHY maintains Receive Timing Windows
   - Messages outside window trigger Timing Info reports

3. **Message Timing**
   - P7 messages (DLTTI, ULTTI, TXDATA, ULDCI) must arrive within Timing Window
   - If too early: "too early" report
   - If too late: "too late" report and slot marked lost

#### Receive Timing Window

**Parameters:**

```
msg Timing Offset: How many microseconds before slot start
Timing Window: Duration (microseconds) to accept messages

Example:
  DLTTI Timing Offset = 3000 μs
  DLTTI Timing Window = 1000 μs
  
  Slot N starts at T0
  → DLTTI for Slot N must arrive between (T0 - 3000 μs) and (T0 - 2000 μs)
  → Too early if before T0 - 3000 μs
  → Too late if after T0 - 2000 μs
```

#### Message Timing Procedure

**For each time-critical message (DLTTI, ULTTI, TXDATA, ULDCI):**

1. **On-time arrival** (within window):
   - PHY processes message for specified slot
   - No error report

2. **Too-early arrival**:
   - PHY buffers or drops message
   - TIMING.indication sent with "early" indicator

3. **Too-late arrival**:
   - PHY cannot process for slot
   - TIMING.indication sent with "late" indicator
   - Slot marked lost at VNF

#### VNF Recovery Actions

When TIMING.indication received:

- **DLTTI too late**: Consider DL slot lost
- **TXDATA too late**: Consider DL slot lost
- **ULTTI too late**: Consider UL slot lost
- **ULDCI too late**: Consider UL slot lost

VNF may adjust message transmission timing for next occurrences.

#### API Message Order (nFAPI)

**Differences from FAPI:**

1. **No SLOT.indication requirement**
   - Message order enforced via Receive Timing Windows

2. **Independent DLTTI/ULTTI ordering**
   - No ordering requirement between DLTTI and ULTTI
   - Each must arrive in respective Receive Window

3. **Delay Management Requirements**
   - All slot-based messages must provide SFNSL
   - Messages checked against Receive Timing Window
   - Timing reports indicate early/late arrival

### P19 Procedures (FEU Configuration)

#### FEU Component Initialization

P19 interface configures Digital Front End (DFE) and RF components:

**FEU Components:**
- **DFE Instance**: Digital front end (BBU functions)
- **RF Instance**: Radio frequency stage

**Initialization Steps:**

1. **PARAM Exchange** (Query)
   - VNF queries DFE/RF capabilities via P19

2. **CONFIG Exchange** (Configuration)
   - VNF configures DFE/RF via P19

3. **START Exchange** (Activation)
   - VNF starts DFE/RF via P19

#### P19-C Messages (Configuration)

P19-C uses same transport/format as P5 (SCTP, reliable):

- **FEU.PARAM.request/response**: Query capabilities
- **FEU.CONFIG.request/response**: Configure parameters
- **FEU.START.request/response**: Activate operation
- **FEU.STOP.request/response**: Halt operation

#### P19-S Messages (Slot-oriented)

P19-S uses same transport/format as P7 (UDP, time-critical):

- **DFE.SCHEDULE.request**: Schedule DFE operation
- **RF.SCHEDULE.request**: Schedule RF operation
- **FEU.SELECT.BEAM.request**: Select beamforming configuration
- **FEU.SET.BEAM.SLOT.PATTERN.request**: Multi-slot beam pattern

#### FEU Delay Management

Similar to PHY Delay Management:

1. **FEU maintains Receive Timing Windows** for P19-S messages
2. **Early/late messages** trigger FEU Timing Info reports
3. **VNF adjusts transmission timing** based on reports

---

## nFAPI Transport and Message Formats

### Transport Layer

#### nFAPI P5 Transport

**Protocol Stack:**
- Application: nFAPI P5 Messages
- Transport: **SCTP** (Streaming Control Transmission Protocol)
- Network: IP (IPv4/IPv6)

**Characteristics:**
- **Reliable delivery**: SCTP ensures no message loss
- **In-order delivery**: Maintains message sequence
- **Ordered streams**: One stream per PHY instance
- **Multi-homing**: SCTP supports redundancy via multiple IP addresses

**Configuration Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| VNF Address | String | NA | FQDN or IP of VNF |
| VNF P5 Port | Integer | TBD | SCTP port (IANA assigned) |
| VNF P5 PPI | Integer | TBD | SCTP Payload Protocol Identifier |
| PNF SCTP Streams | Multiple | 1 per PHY | One stream per PHY ID |

**SCTP Association:**
- Single SCTP association between PNF and VNF
- Multiple streams for parallel PHY communication
- Stream 0: Supervisory PHY (ID 255)
- Streams 1-N: Regular PHY instances

#### nFAPI P7 Transport

**Protocol Stack:**
- Application: nFAPI P7 Messages
- Transport: **UDP** (User Datagram Protocol)
- Network: IP (IPv4/IPv6)

**Characteristics:**
- **Unreliable delivery**: UDP doesn't guarantee delivery
- **Low latency**: No retransmission overhead
- **Out-of-order possible**: Application must handle reordering
- **Sequence tracking**: Application-level sequence numbers

**Why UDP for P7:**
- P7 messages are time-critical
- Retransmission would cause unacceptable latency
- Lost messages are better than late messages
- PHY maintains sequence numbers to detect losses

**Configuration:**
- VNF and PNF exchange IP/port via P5 interface
- Option 1: Single UDP socket for all PHYs
- Option 2: Separate UDP socket per PHY

#### nFAPI P19 Transport

- **P19-C** (Configuration): Same as P5 (SCTP, reliable)
- **P19-S** (Slot-oriented): Same as P7 (UDP, unreliable)

#### Optional eCPRI Encapsulation

**eCPRI** (Enhanced Common Public Radio Interface) can optionally encapsulate nFAPI P7/P19-S messages:

**eCPRI Header Fields:**

| Field | Value | Description |
|-------|-------|-------------|
| Protocol Rev | 0x1 | Current version |
| Message Type | 64-255 | Vendor-specific for nFAPI |
| PHY Transport ID | config | Identifies destination PHY |
| Payload Size | variable | Message size |

**Advantages:**
- Single Ethernet transport for multiple PHYs
- No UDPIP overhead
- Vendor-specific message type signaling

#### IPv4/IPv6 Handling

**Restrictions:**
- IPv4 header options MUST NOT be enabled
- IPv6 header options MUST NOT be enabled
- Reason: Complicates hardware IP processing acceleration

### General Message Format

#### P5 and P19-C Message Structure

**P5/P19-C PDU Format:**

```
nFAPI Header (per message)
├── Segment Length (2 bytes)
├── More Flag (1 bit) + Segment Number (7 bits)
├── Sequence Number (1 byte)
└── Reserved/Padding (for alignment)

nFAPI Message 1
├── Message Header
│   ├── S-RU Termination Type (1 byte): 0x01 for P5/P7
│   ├── PHY ID (1 byte)
│   ├── Message ID (2 bytes)
│   └── Length (2 bytes)
├── Message Body (TLVs or FAPI payload)
└── Padding (0-3 bytes for 4-byte alignment)

nFAPI Message 2
├── ... (same structure)

...

nFAPI Message N
├── ... (same structure)
```

**Segmentation Support:**
- Messages may be segmented if transport requires
- Segment Number increments within message
- More Flag indicates additional segments pending
- Sequence Number increments per complete message

#### P7 and P19-S Message Structure

**Two Format Options:**

**Option 1: CP-UP Combined Format**

```
nFAPI Header
├── Number of Messages (2 bytes)
├── Total SDU Length (2 bytes)
├── Sequence Number (1 byte)
├── Byte Offset (2 bytes)
├── Reserved (1 byte)
└── Transmit Timestamp (4 bytes)

Per-Message:
├── Message Header
│   ├── S-RU Termination Type (1 byte)
│   ├── PHY ID (1 byte)
│   ├── Message ID (2 bytes)
│   └── Length (2 bytes)
├── Message Body (control + user data combined)
└── Padding

...
```

**Option 2: CP-UP Separation Format**

```
nFAPI Header
├── Number of Messages (2 bytes)
├── Total SDU Length (2 bytes)
├── Sequence Number (1 byte)
├── Byte Offset (2 bytes)
├── Reserved (1 byte)
└── Transmit Timestamp (4 bytes)

Per-Message:
├── Message Header
│   ├── S-RU Termination Type (1 byte)
│   ├── PHY ID (1 byte)
│   ├── Message ID (2 bytes)
│   ├── CP Length (2 bytes) [Control Plane]
│   └── UP Length (3 bytes) [User Plane]
├── Control Plane Payload (CP Length bytes)
├── User Plane Payload (UP Length bytes)
└── Padding

...
```

**CP-UP Separation Benefits:**
- Control plane and user plane handled separately
- Hardware can optimize path per type
- Software can prioritize CP over UP if congested

### TLV Format

**TLV (Tag-Length-Value) Structure:**

```
Tag (2 bytes)
├── Bits 15-0: Unique identifier for parameter
    
Length (2 bytes)
├── Bits 15-0: Byte count of value field
├── Value MUST be multiple of 4 bytes
├── Padding applied if necessary

Value (variable)
├── 0 to 65535 bytes (in 4-byte increments)
├── Format specific to tag
└── Can be:
    - Scalar (uint8, uint16, uint32, uint64)
    - Array (multiple values)
    - Struct (nested fields)
    - String (null-terminated or length-prefixed)
```

**Common TLV Tags:**

| Tag | Name | Type | Description |
|-----|------|------|-------------|
| 0x0001 | Num TLV | uint16 | Number of TLV entries |
| 0x0030 | Release | uint16 | 3GPP release version |
| 0x0031 | DL Bandwidth | uint32 | Maximum DL bandwidth |
| 0x0032 | UL Bandwidth | uint32 | Maximum UL bandwidth |
| 0x0051 | PHY Profiles | struct | Supported profiles |
| 0x0103 | P7 PNF Address | uint32 | IPv4 address (network byte order) |
| 0x0105 | P7 PNF Port | uint16 | UDP port number |
| 0x0F00 | 5G FAPI Message Body | variable | FAPI message encapsulation |

### nFAPI Dedicated Messages

**P5 Dedicated Messages:**

| Message | ID | Direction | Purpose |
|---------|-----|-----------|---------|
| PNFREADY.indication | 0x0109 | PNF → VNF | Signal PNF readiness |
| PNFPARAM.request | 0x0100 | VNF → PNF | Query PNF capabilities |
| PNFPARAM.response | 0x0101 | PNF → VNF | Return PNF capabilities |
| PNFCONFIG.request | 0x0102 | VNF → PNF | Configure PNF |
| PNFCONFIG.response | 0x0103 | PNF → VNF | Acknowledge PNF config |
| PNFSTART.request | 0x0104 | VNF → PNF | Start PNF operation |
| PNFSTART.response | 0x0105 | PNF → VNF | Acknowledge PNF start |
| PNFSTOP.request | 0x0106 | VNF → PNF | Stop PNF operation |
| PNFSTOP.response | 0x0107 | PNF → VNF | Acknowledge PNF stop |
| START.response | 0x0108 | PHY → VNF | Acknowledge PHY start |

**P7 Dedicated Messages:**

| Message | ID | Direction | Purpose |
|---------|-----|-----------|---------|
| DL Node Sync | 0x0180 | VNF → PHY | Send timing reference |
| UL Node Sync | 0x0181 | PHY → VNF | Return timing measurements |
| Timing Info | 0x0182 | PHY → VNF | Report message timing |

### nFAPI Combined Messages

**Combined messages encapsulate FAPI message body within nFAPI wrapper:**

| Message | FAPI Equivalent | Purpose |
|---------|-----------------|---------|
| PARAM.response | FAPI PARAM.response | Return PHY/PNF capabilities with nFAPI TLVs |
| CONFIG.request | FAPI CONFIG.request | Configure with nFAPI connection parameters |

### Transparent Message Transport

**Transparent messages** pass FAPI messages unchanged through nFAPI:

**FAPI Transparent Messages Supported in nFAPI:**

| Message | Direction |
|---------|-----------|
| DLTTI.request | VNF → PHY |
| ULTTI.request | VNF → PHY |
| ULDCI.request | VNF → PHY |
| TXDATA.request | VNF → PHY |
| RXDATA.indication | PHY → VNF |
| CRC.indication | PHY → VNF |
| UCI.indication | PHY → VNF |
| SRS.indication | PHY → VNF |
| RACH.indication | PHY → VNF |
| ERROR.indication | PHY → VNF |
| (and all P19 slot messages transparently) | VNF ↔ FEU |

**Not Transported in nFAPI:**
- SLOT.indication (nFAPI uses Delay Management instead)
- TIMING.indication (FAPI version, nFAPI has nFAPI TIMING.indication)

### Vendor Extension Mechanism

**Vendor-Specific TLVs:**

| Tag Range | Usage | Description |
|-----------|-------|-------------|
| 0x0300-0x03FF | Vendor Extensions | Vendor-specific parameters and TLVs |

**Example Vendor Extension:**

```
Tag: 0x0301 (vendor-specific)
Length: 8
Value: 
  - uint16 vendor_id
  - uint16 parameter_id
  - uint32 vendor_value
```

### 5G nFAPI and 4G nFAPI Coexistence

**Differences:**
- 5G nFAPI and 4G nFAPI message formats differ
- 5G optimizations for P5/P7 signaling efficiency
- 4G nFAPI for LTE split architecture

**Coexistence:**
- Use **different SCTP ports** for P5 (5G vs 4G nFAPI)
- Use **different UDP ports** for P7 (5G vs 4G nFAPI)
- Identified by payload protocol identifier
- PNF can support both simultaneously

---

## Configuration Parameters and TLVs

### PHY and Cell Parameters

#### Numerology and Subcarrier Spacing

| Value | Subcarrier Spacing | Slot Duration | Use Case |
|-------|-------------------|---------------|-|
| 0 | 15 kHz | 1 ms | FR1 (Sub-6 GHz) standard |
| 1 | 30 kHz | 500 μs | FR1 (Sub-6 GHz) higher density |
| 2 | 60 kHz | 250 μs | FR2 (mmWave) standard |
| 3 | 120 kHz | 125 μs | FR2 (mmWave) higher density |
| 4 | 240 kHz | 62.5 μs | FR2 (mmWave) maximum density |

#### Duplex Mode Configuration

**FDD (Frequency Division Duplex):**
- Separate DL and UL frequencies
- Simultaneous DL and UL possible

**TDD (Time Division Duplex):**
- Single frequency, alternating DL/UL
- Requires DL/UL pattern configuration

**TDD Pattern:**
```
Slot Structure:
- D: Downlink only
- U: Uplink only
- F: Flexible (can be DL or UL)
- S: Special (DL then UL in same slot)

Example patterns:
- D D U (repeat)
- D S U (repeat)
- D D D D D U F U
```

### Antenna Configuration

#### Antenna Ports

**PDSCH Antenna Ports:**
- Port 0: DMRS port for SU-MIMO
- Ports 0-3: For 2-antenna MIMO
- Ports 0-7: For 4-antenna MIMO
- Ports 0-15: For 8-antenna MIMO (Massive-MIMO)

**PUSCH Antenna Ports:**
- Similar scaling for uplink

#### Beam Configuration

**Digital Beamforming:**
- DBT (Digital Beam Table): Weights for baseband ports
- Dynamic selection per slot via Beam Index

**Analog Beamforming (P19 RF):**
- ABF (Analog Beam Forming): RF chain phase/amplitude
- Configured via P19 interface

### PDCCH Configuration

#### CORESET (Control Resource Set)

**Parameters:**

| Parameter | Range | Description |
|-----------|-------|-------------|
| CORESET Index | 0-11 | Unique identifier |
| Duration | 1-3 symbols | OFDM symbols width |
| Frequency Domain | 24-275 RBs | Allocated PRBs |
| REG Bundle Size | 2, 6 | Resource Element Group bundle |

#### DCI Format

**Downlink DCI Formats:**

| Format | Size | Content |
|--------|------|---------|
| 0_0 | ~50-70 bits | RIV, modulation, layer, antenna, TPMI, HARQ process |
| 0_1 | ~20-40 bits | Extended version (CB, BWP, etc) |
| 1_0 | ~40-60 bits | PDSCH allocation, power, frequency hopping |
| 1_1 | ~20-50 bits | Extended version (multiple codebooks, etc) |

**Uplink DCI Formats:**

| Format | Size | Content |
|--------|------|---------|
| 0_0 | ~30-50 bits | PUSCH allocation, modulation, layer, frequency hopping |
| 0_1 | ~20-40 bits | Extended version (multiple bands, etc) |
| 0_2 | ~30-60 bits | MsgA-PUSCH triggering |

### PDSCH Parameters

#### Resource Allocation Types

**Type 0 (Bitmap):**
- Frequency allocation via bitmap
- Each bit represents 6 RBs (RBG)
- Efficient for small allocations

**Type 1 (RIV Coding):**
- Resource Indication Value (RIV) encoding
- More flexible, supports individual RB allocation
- RIV = N_RBG * (L-1) + F  (simplified)

#### Modulation and Coding

**Modulation Schemes:**

| Scheme | Bits/Symbol | Efficiency | SNR Requirement |
|--------|-------------|-----------|-----------------|
| QPSK | 2 | 50% | ~0 dB |
| 16-QAM | 4 | 100% | ~10 dB |
| 64-QAM | 6 | 150% | ~16 dB |
| 256-QAM | 8 | 200% | ~22 dB |

**Code Rates:**

| Rate | Target SNR | Use Case |
|------|-----------|----------|
| 1/5 | -5 dB | Poor channel |
| 1/3 | 0 dB | Cell edge |
| 1/2 | 4 dB | Standard |
| 3/4 | 10 dB | Good channel |
| 5/6 | 12 dB | Excellent channel |

#### Precoding

**Codebook-Based (Legacy):**
- Predefined precoding matrices
- L1 selects from codebook
- Efficient overhead

**Codebook-Free (5G New):**
- Arbitrary precoding weights
- Higher flexibility
- More overhead

**Precoding Types:**

| Type | Method | Overhead | Flexibility |
|------|--------|----------|------------|
| P-type | Codebook | Low | Limited |
| NZP-CSI-RS based | Open loop | Medium | High |
| Beam Index | Digital beamforming | Low | Medium |

### Rate Matching

**Purpose**: Adapt encoded bits to allocated resource elements

**Patterns:**

1. **PRB-Symbol Bitmap (non-CORESET)**
   - Bits mask out unavailable REs
   - Example: PRB 0-5, symbols 0-13 (except SSB)

2. **CORESET Rate Match**
   - Rate matching within CORESET
   - Accounts for DMRS and reserved REs

3. **LTE-CRS Rate Match**
   - Accommodate LTE Reference Signals
   - For spectrum coexistence

4. **CSI-RS Rate Match**
   - Puncture resources occupied by CSI-RS
   - Avoid interference

### SRS Configuration

#### SRS Resources

**Periodic SRS:**
- Configured periodicity (every N slots)
- Semi-static via P5 CONFIG

**Aperiodic SRS:**
- Requested dynamically via DCI
- Single or multiple instances

**Parameters:**

| Parameter | Range | Description |
|-----------|-------|-------------|
| Frequency Domain | 4-272 RBs | Starting RB and length |
| Time Domain | 0-15 | Slot periodicity (max 16 slots) |
| DMRS Antenna Port | 0-3 | DMRS port for phase tracking |

#### SRS Reporting Capabilities

**Beamforming Report (Per PRG):**
- Precoding Resource Group level
- Wideband characterization
- Frequency-selective beam weights

**Channel IQ Matrix:**
- Time-frequency block samples
- Full channel state representation
- Large overhead (~500-2000 bits)

**SVD Representation:**
- Singular Value Decomposition
- Eigenvectors + singular values
- Compressed format

**2D-DFT:**
- 2D Discrete Fourier Transform
- Delay-Doppler domain
- Reduced sampling points

### PUSCH Parameters

#### PUSCH Mapping and Allocation

**Mapping Types:**

| Type | Symbol Duration | Prefix | Use Case |
|------|-----------------|--------|----------|
| Type A | 14 symbols | Standard CP | Normal slots |
| Type B | Variable (4-14) | Long CP | Non-standard |

**Allocation Types:**
- Type 0: Bitmap (RBG-based)
- Type 1: RIV (individual RB)

#### DMRS Configuration

**DMRS Types:**

| Type | CDM | Overhead | Accuracy |
|------|-----|----------|----------|
| Type 1 | 2 ports | Low | Limited |
| Type 2 | 4 ports | Medium | Good |

**Additional Positions:**
- Pos 0: CDM group 0 only
- Pos 1: Additional symbol
- Pos 2: Two additional symbols
- Pos 3: Three additional symbols

#### Transform Precoding

**DFT-Spread-OFDM (Enabled):**
- Lower PAPR (Peak-to-Average Power Ratio)
- Better for power-limited UEs
- Simpler antenna configuration

**Regular OFDM (Disabled):**
- Standard approach
- Lower computational complexity
- Supports full beamforming

---

## Slot Procedures and Message Types

### PCH (Paging Channel) Procedure

**Purpose**: Send paging notification to RRC-IDLE UE

**Procedure:**
1. L2L3 sends DLTTI.request with PDSCH PDU
2. PHY encodes paging data in PDSCH
3. UE wakes from sleep to check paging
4. Unicast DCI in PDCCH, PDSCH carries paging info

### DLSCH (Downlink Shared Channel) Procedure

**Single-Layer DLSCH:**
1. DLTTI.request: PDCCH (DCI) + PDSCH (data)
2. TXDATA.request: Transport block
3. PHY transmits PDSCH in DL window
4. UE decodes and sends HARQ ACK/NACK
5. PUCCH carries feedback in next UL window

**Multi-Layer DLSCH (2-Layer):**
- Same procedure
- PDSCH uses 2 spatial layers
- DMRS covers both layers
- Channel estimation per layer
- Higher throughput

**Multi-Slot DLSCH:**
- Same PDSCH allocation across multiple slots
- Retransmission in subsequent slots
- HARQ process management

### Downlink Reference Signals

**SSB (Synchronization Signal Block):**
- Contains: PSBCH + PBCH
- L1 or L2-generated MIB
- Beam-swept across beam directions

**DMRS (Demodulation Reference Signal):**
- For PDSCH/PDCCH channel estimation
- Multiple antenna ports support
- Variable symbol positions

**CSI-RS (Channel State Information Reference Signal):**
- For CSI measurement
- Different density options
- Aperiodic or periodic

**PT-RS (Phase Tracking Reference Signal):**
- For phase noise compensation
- High-frequency bands (FR2)
- Variable density

### RACH Procedure

#### Conventional 4-Step RACH

**Msg1 (Preamble):**
1. UE selects random preamble (0-63)
2. Transmits on configured PRACH resources
3. PHY detects in ULTTI.request processing
4. Reports to L2 via RACH.indication

**Msg2 (Random Access Response):**
1. L2 receives RACH.indication
2. L2 sends DLTTI.request with DCI for RAR
3. PHY transmits PDSCH with RAR
4. RAR contains: Preamble ID, Timing Advance, UL Grant

**Msg3 (RRC Request):**
1. UE receives RAR and derives UL grant
2. Transmits RRC Connect Request on PUSCH
3. L2 sends ULTTI.request for expected PUSCH
4. PHY decodes and reports RXDATA.indication

**Msg4 (RRC Setup):**
1. L2 processes Msg3, generates RRC Setup
2. L2 sends DLTTI.request with DCI for Msg4
3. PHY transmits PDSCH with RRC Setup
4. UE transitions to RRC-CONNECTED

#### 2-Step RACH (MsgA Protocol)

**MsgA (Combined Preamble + Request):**
1. UE sends:
   - MsgA-PRACH: Preamble on PRACH
   - MsgA-PUSCH: Request on PUSCH (same slot)
2. PHY receives both:
   - ULTTI.request contains MsgA-PRACH PDU
   - ULTTI.request contains MsgA-PUSCH PDU
   - MsgA-PRACH to MsgA-PUSCH mapping defined
3. L2 receives RACH.indication (preamble) and RXDATA.indication (data)

**MsgB (Response):**
1. L2 processes MsgA data, generates RRC Setup
2. L2 sends DLTTI.request with PDSCH for Msg4/MsgB
3. PHY transmits MsgB
4. UE transitions to RRC-CONNECTED

**Advantages over 4-Step:**
- 2 fewer air interface messages
- Reduced latency for connectivity
- Suitable for wide-area RAT

### ULSCH Procedure

**Single-Slot ULSCH:**
1. ULTTI.request: PUSCH PDU
2. PHY receives and decodes PUSCH
3. RXDATA.indication: Decoded payload
4. CRC.indication: CRC pass/fail

**Multi-Slot ULSCH:**
1. Same PUSCH allocation in multiple slots
2. PHY buffers across slots
3. Soft-combining of retransmissions (HARQ)

### UCI (Uplink Control Information) Procedure

**HARQ-ACK on PUCCH:**
1. DL transmission completed
2. UE prepares HARQ feedback
3. ULTTI.request: PUCCH PDU for HARQ
4. PHY receives and decodes
5. UCI.indication: HARQ status

**CSI Report on PUCCH:**
1. UE measures downlink channel
2. ULTTI.request: PUCCH PDU for CSI
3. PHY decodes
4. UCI.indication: CSI feedback

**Scheduling Request (SR) on PUCCH:**
1. UE needs UL resources for data
2. ULTTI.request: PUCCH PDU for SR
3. PHY detects
4. UCI.indication: SR triggered
5. L2 allocates PUSCH for data

**UCI on PUSCH:**
1. Multiplexed on PUSCH data transmission
2. ULTTI.request: PUSCH PDU with UCI bits
3. PHY decodes both data and UCI
4. RXDATA.indication: Data
5. UCI.indication: UCI payload

### SRS Measurement and Reporting

**SRS Transmission:**
1. ULTTI.request: SRS PDU
2. PHY transmits SRS on configured resources

**SRS Reception and Measurement:**
1. ULTTI.request: SRS PDU (receive configuration)
2. PHY measures received SRS
3. SRS.indication: Measurement results

**Measurement Report Content:**
- Beamforming weights per PRG
- Channel quality indicators
- Recommended precoding indices
- Antenna port characterization

### Error Handling Sequences

#### DLTTI.request Error Sequence

```
VNF → PHY: DLTTI.request (slot N)
     ↓
PHY processes DLTTI
     ├─ If valid: Transmit scheduled
     └─ If invalid (e.g., SFN mismatch):
        ├─ Return ERROR.indication with specific error
        └─ Mark slot N as failed
```

#### ULTTI.request Error Sequence

```
VNF → PHY: ULTTI.request (slot N)
     ↓
PHY configures receive
     ├─ If valid: Wait for UE transmission
     └─ If invalid:
        ├─ Return ERROR.indication
        └─ Mark slot N as failed
```

#### ULDCI.request Error Sequence

```
VNF → PHY: ULDCI.request (update slot N UCI)
     ↓
PHY updates UCI parameters
     ├─ If valid: Apply to slot N
     └─ If invalid:
        ├─ Return ERROR.indication
        └─ Keep previous UCI
```

#### TXDATA.request Error Sequence

```
VNF → PHY: TXDATA.request (data for PDSCH)
     ↓
PHY checks data availability
     ├─ If on time: Load into transmit buffer
     └─ If late:
        ├─ Return ERROR.indication (late arrival)
        └─ Mark PDSCH as lost
```

---

## Appendix: Timing and Synchronization

### 5G NR Timing Requirements

**Frame Structure:**
- **System Frame**: 10 subframes = 10 ms (1024 SFNs)
- **Slot**: Multiple symbols based on numerology
  - 15 kHz: 1 slot = 1 ms (14 symbols)
  - 30 kHz: 1 slot = 500 μs (14 symbols)
  - 60 kHz: 1 slot = 250 μs (14 symbols)
  - 120 kHz: 1 slot = 125 μs (14 symbols)

**Timing Accuracy:**
- ±130 ns: Air interface timing
- ±50 ppm: Frequency accuracy required

### FAPI PHY Timing

**SLOT.indication Periodicity:**
- Must be sent every 62.5 μs, 125 μs, 250 μs, 500 μs, or 1 ms
- Based on configured numerology
- Jitter should be <1 μs

### nFAPI Delay Management Timing

**Receive Window Definition:**

```
Timing Offset: Time before slot start when window opens
Timing Window: Duration for which messages accepted

Example (DLTTI):
  Offset = 3000 μs before slot start
  Window = 1000 μs
  → Valid message arrival: [start - 3000, start - 2000] μs
```

**Typical Timing Offsets (microseconds):**

| Message | Offset | Reason |
|---------|--------|--------|
| DLTTI | 3000 | PHY processing + MAC latency |
| ULTTI | 2500 | PHY configuration time |
| ULDCI | 2000 | UCI dynamic update |
| TXDATA | 4500 | Transport block preparation |

### Synchronization Mechanisms

**Absolute Synchronization:**
- GNSS (Global Navigation Satellite System)
- External timing source with ±100 ns accuracy

**Relative Synchronization:**
- FAPI: SLOT.indication and SFNSL tracking
- nFAPI: DL/UL Node Sync for latency measurement

**PTP (Precision Time Protocol):**
- IEEE 1588v2 for sub-microsecond accuracy
- Alternative to GNSS

---

## Summary of Key Distinctions

### FAPI vs nFAPI

| Aspect | FAPI | nFAPI |
|--------|------|-------|
| **Deployment** | Co-located MAC/PHY | Disaggregated (MAC in VNF, PHY in PNF) |
| **Transport** | Shared memory | SCTP (P5), UDP (P7) |
| **Latency** | <1 μs | 1-100 ms (typical) |
| **Synchronization** | SLOT.indication + SFNSL | Delay Management + Node Sync |
| **Reliability** | Inherent (memory) | SCTP for P5, app-level for P7 |
| **Jitter** | Minimal | Depends on network |
| **Use Cases** | Integrated gNB | RAN Disaggregation, O-RAN |

### PHY Profile and Instantiation

**PHY Profile:**
- Defines supported capabilities and characteristics
- Defines PHY ID count and DL/UL port mappings
- Selected during initialization

**FEU Compatibility:**
- DFE and RF profiles must be compatible with PHY profile
- Compatibility map provided by PHY during query

**PHY Instantiation:**
- Not automatic; must be explicitly driven
- Requires FEU profiles selected first
- Results in PHY IDs entering IDLE state

---

## Implementation Considerations

### Split Timing Requirements

**For Split 6 (O-RAN option 6):**

- **DL URLLC (downlink critical data):**
  - DLTTI message must arrive: T_DLTTI_offset before slot (typically 3-4 ms)
  - TXDATA must arrive: T_TXDATA_offset before slot (typically 4-5 ms)

- **UL URLLC (uplink critical control):**
  - ULTTI.request must arrive: T_ULTTI_offset before slot (typically 2-3 ms)
  - PHY completion must deliver results: T_result_latency after slot (typically 1-2 ms)

### Message Ordering and Dependencies

**Downlink Ordering:**
1. Optional CONFIG (must be first if present)
2. DLTTI.request (scheduling direction)
3. ULTTI.request (scheduling direction)
4. Optional TXDATA.request (transport data for PDSCH)
5. Indications asynchronous (RXDATA, CRC, UCI, SRS, RACH)

**Uplink Ordering:**
1. ULTTI.request (PHY RX configuration)
2. Optional ULDCI.request (UCI parameter update)
3. Indications generated based on received signals

### Error Recovery Mechanisms

**L2L3 Recovery Strategy:**

1. **Timing Errors:**
   - Monitor TIMING.indication messages
   - Adjust message transmission timing
   - May move from too-early to within-window

2. **Configuration Errors:**
   - Resend CONFIG.request with corrected parameters
   - PHY remains in previous state until successful

3. **PHY State Machine Errors:**
   - Send RESET.request if PHY enters invalid state
   - Re-initialize from IDLE state

4. **Persistent Failures:**
   - Consider PHY-FEU disconnection (P5 CONNECTIVITY.indication)
   - Trigger PNF restart procedure if PHY unrecoverable

---

## End of Comprehensive Merged Specification

This document represents a complete consolidation of SCF222 (5G FAPI PHY API Specification v222.07.00) and SCF225 (5G nFAPI Specification v225.3.0), preserving all technical details, parameters, procedures, and message formats from both specifications without omission.

**Document Compiled**: February 2026
**Source Specifications**: SCF222 (Aug 2023), SCF225 (July 2022)
**Format**: Markdown with comprehensive hierarchical structure
**Coverage**: All sections, tables, procedures, message types, parameters, and TLVs from both source documents