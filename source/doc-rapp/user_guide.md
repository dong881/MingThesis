# User Guide

## Dashboard Access
Once deployed, the `ming-nfapi-debugger` web interface is available at the exposed NodePort or Ingress URL (default port 5000 inside the pod).

## Running a Test

1. **Navigate to the Dashboard**: Open your browser and go to the application URL.
2. **Trigger Test**:
   - Locate the "Trigger" or "Run Test" section.
   - Select the desired configuration (Duration, Bandwidth, DL/UL).
   - Click **Start**.
3. **Monitor Progress**:
   - The status bar will update from "IDLE" to "RUNNING".
   - You can view live logs if supported or wait for the "COMPLETED" status.

## Analyzing Results

### Timeline View
Displays correlated metrics over time:
- **Throughput**: Application layer data rate (Mbps).
- **Latency**: Ping RTT (ms).
- **Events**: Critical OAI events (Cell Up, Attach).

### Detailed Charts
- **BLER Analysis**: Block Error Rate over time.
- **MCS Distribution**: Modulation and Coding Scheme usage usage.
- **HARQ Stats**: Retransmission counts and feedback timing.

## Git Synchronization
The system can automatically push results to a Git repository.
1. Ensure `git` is enabled in `values.yaml`.
2. Configure `GIT_TOKEN` and `GIT_REPO_URL`.
3. After each test, results are committed to the `rapp-result` branch (or configured branch).
