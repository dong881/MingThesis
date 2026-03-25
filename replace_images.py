import re

with open("/home/hpe/MingThesis/main.tex", "r") as f:
    text = f.read()

# For the first one: fig:three_stage
t1 = r"""  % [圖片需求]
  % 類型：流程圖或架構圖 (Flowchart or Architecture Diagram)
  % 內容細節：必須呈現 VNF 與 O-DU Low 之間的三階段閉環時間調整機制（Three-stage closed-loop timing adjustment）。
  % 1. Timing Feedback Collection (傳遞 \Delta t)
  % 2. Offset Computation (計算 f, s)
  % 3. Scheduler Adaptation (應用 (f, s))
  % 數據/標註：明確標示出 PNF, VNF 的邊界，以及各階段所傳遞的變數名稱與延遲。"""

# For fig:validation_flow
t2 = r"""  % [圖片需求]
  % 類型：實驗/驗證流程圖 (Validation workflow)
  % 內容細節：展示如何對提出的方法進行實驗驗證，涵蓋環境架構與數據收集流程。
  % 數據/標註：包含使用的模擬器或硬體測試平台 (O-RAN 測試台)、取得 jitter / throughput 數據的採集點 (Probes)，以及資料流向。"""

# For fig:result_jitter
t3 = r"""  % [圖片需求]
  % 類型：折線圖 (Line chart) 或 散佈圖 (Scatter plot)
  % 內容細節：展示隨著 Iteration 增加，Jitter 逐漸收斂與減少的趨勢。此為證明動態調整機制有效性的關鍵圖表。
  % X軸：Iteration 次數 或 經過時間 (Time, ms)
  % Y軸：Jitter 大小 (\mu s 或 ms)
  % 數據/標註：必須包含 Proposed method 與 Baseline (如固定 offset) 的曲線比較，標示收斂時間與穩態的 Jitter 變異範圍，顯示 Proposed method 能有效降低抖動。"""

# For fig:result_offset
t4 = r"""  % [圖片需求]
  % 類型：散佈圖 (Scatter plot) 結合 階梯圖 (Step plot)
  % 內容細節：展示觸發偏移量 (f, s) 如何根據量測到的延遲 (Measured delay) 進行動態對應。
  % X軸：Measured delay (\Delta t)
  % Y軸：Trigger offset (f, s) 或對應的 slot index 變化量
  % 數據/標註：標示出系統要求的遲到門檻 (Deadline) 界線，並呈現不同 Measured delay 落在哪些 Offset 的補償區間中。"""

# For fig:result_throughput
t5 = r"""  % [圖片需求]
  % 類型：長條圖 (Bar chart) 或 累積分布圖 (CDF)
  % 內容細節：比較使用 Proposed method 與 Baseline 在不同情境 (Scenarios) 下的系統吞吐量 (Throughput) 改善。
  % X軸：不同 Scenarios (例如不同的背景流量、VNF CPU 核心數、或負載條件)
  % Y軸：Throughput (Mbps 或 Gbps)
  % 數據/標註：每個長條應標示出該情境下的平均吞吐量，並附上 95% Confidence Interval 的誤差棒 (Error bar) 增加可信度。"""

# For fig:contrib1
t6 = r"""  % [圖片需求 - Contribution 1]
  % 類型：選擇合適的性能對比圖表
  % 內容細節：具體證明 Contribution 1 的宣告（例如：證實提出的演算法達到了比以往更低的延遲）。
  % 數據/標註：需包含對比數據 (例如你的方法 vs 傳統方法) 或核心機制的量化強調標註，用客觀數據支持文字描述的「Why」與「How」。"""

# For fig:contrib2
t7 = r"""  % [圖片需求 - Contribution 2]
  % 類型：選擇合適的性能對比圖表或資源使用熱力圖
  % 內容細節：具體視覺化 Contribution 2 (例如：演算法在資源調度上更有效率，降低了 CPU 使用率或封包遺失率)。
  % 數據/標註：提供量化數據，並能佐證在實驗設計上的考量。"""

# For fig:contrib3
t8 = r"""  % [圖片需求 - Contribution 3]
  % 類型：選擇合適的圖表 (例如 CDF 或 系統效能隨負載變化的趨勢圖)
  % 內容細節：具體視覺化 Contribution 3 (例如：在極端惡劣的網路環境或高負載情況下，系統依然能維持穩定的表現)。
  % 數據/標註：提供量化數據或情境對比 (最佳、一般、最差情況)，以增強信服力。"""

replacements = [t1, t2, t3, t4, t5, t6, t7, t8]

lines = text.split('\n')
img_lines_indices = [i for i, line in enumerate(lines) if "placeholder_image_" in line]

if len(img_lines_indices) == 8:
    for idx, (line_idx, rep) in enumerate(zip(img_lines_indices, replacements)):
        lines[line_idx] = rep
    
    with open("/home/hpe/MingThesis/main.tex", "w") as f:
        f.write('\n'.join(lines))
    print("Successfully replaced all 8 placeholder images with detailed comments.")
else:
    print(f"Error: Found {len(img_lines_indices)} placeholder images, expected 8.")

