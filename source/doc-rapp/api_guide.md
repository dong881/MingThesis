# REST API Guide

The debugger exposes a REST API on port `5000` (mapped to NodePort `30002` in typical deployments).

## Base URL
`http://<pod-ip>:5000`

## Endpoints

### 1. Trigger Test
**POST** `/trigger`

Starts a new test execution.

**Payload (JSON):**
```json
{
    "suffix": "test_name_label",
    "mode": "run",             // "run", "analyze", "extract", "compare"
    "cpu": true,               // Enable CPU profiling (perf)
    "script_mode": "split",    // "split", "single"
    "duration": 60,            // Duration in seconds
    "iperf_dl_udp": [100],     // List of DL UDP target bitrates (Mbps)
    "iperf_ul_udp": [],        // List of UL UDP target bitrates
    "iperf_dl_tcp": [],
    "iperf_ul_tcp": []
}
```

**Response:**
```json
{
    "status": "accepted",
    "message": "Test execution started",
    "suffix": "test_name_label",
    "eta": 75
}
```

### 2. Stop Test
**POST** `/api/stop`

Gracefully stops the currently running test. It attempts to kill the traffic generators and ensuring the radio environment is shut down cleanly.

**Response:**
```json
{
    "status": "accepted",
    "message": "Test stopped successfully",
    "dataset_name": "nfapi-0101-1200-test_name_label"
}
```

### 3. Manual Git Sync
**POST** `/api/sync`

Triggers a "Force Sync" operation, pushing any pending local results to the configured remote Git repository.

**Response:**
```json
{
    "status": "accepted",
    "message": "Git Sync Started"
}
```

### 4. Get Status
**GET** `/api/status`

Returns the current status of the implementation (Idle, Running, Completed, etc.) and progress info.

**Response:**
```json
{
    "state": "RUNNING",
    "message": "Running iperf test...",
    "progress": 50,
    "eta": 1234567890
}
```

### 5. Get Background Tasks
**GET** `/api/background_tasks`

Returns a list of active background threads/tasks (like log syncing, test execution).
