# Idea 001: NR NFAPI 延遲管理對 TCP 亂序與端到端重組的影響

**建立時間:** 2026-03-25
**相關論文章節 (預估):** 系統評估 / 延遲分析 / 通訊協議分析 / 端到端效能測試

## 🗣️ 使用者真實想法 (User's Core Thought) 
> **[權重：極高 - 代表真實語氣與核心邏輯]**

我提出一個假設是 NR NFAPI 的 delay managemnet 根據 timing info 動態調整 trigger scheduler 的機制能夠帶來更及時的 scheduler 判斷機制，取用最新鮮的資料去判斷，最晚傳送封包但是不會超過 deadline 避免掉包。

且這樣造成的效果會在 End to End 中被放大，尤其是 Ping 封包的 ICMP 或是 TCP 這種需要 ACK 的傳輸協議，因為這些封包被要求須要確保維持順序才能從 buffer 中釋出。如果因為過早排程採用不新鮮的 HARQ 重傳清單的話，就會造成抵達的封包亂序，造成接收端需要更久的時間才能將資料組起來並發送 TCP or ICMP ACK 回來。

但是教授要求我拿出數據證明我的論點，這些 buffer 亂序的情況是發生在 UE 接收端，我無法 print log in gNB，我應該怎麼提出具有說服力的證據？

---

## 🤖 AI 佐證與研究 (Agent's Supporting Evidence)
> **[權重：參考與佐證 - 用於擴充數據與實驗設計]**

針對無法在 gNB 抓取 Log 的限制，採用**「黑箱測試法」**，透過觀察 UE 端的輸出特徵反推 gNB 的行為，以證明「亂序 (Out-of-Order)」與「重組等待」的發生。以下是數據獲取與論證策略：

1. **獲取 TCP 序列號與到達時間的相關性 (核心證據)**：
   - 透過 UE 端的 Wireshark 或 tcpdump 觀察 **TCP Analysis**。
   - 尋找 "TCP Previous segment not seized" 或 "TCP Out-Of-Order" 指標。
   - 計算 "Reordering Window Time" (遺失片段與後續片段到達的時間差變異數)，確認是否與 NFAPI Timing 抖動週期吻合。

2. **分析延遲的分佈函數 (CDF of Latency)**：
   - 亂序會導致封包在 RLC Buffer 中排隊，使得延遲分佈出現「雙峰現象」或「長尾效應」。
   - 對比「固定機制」與「動態機制」的 P95 或 P99 尾端延遲，預期動態機制顯著較低。

3. **利用 iPerf3 提取調度抖動數據**：
   - 開啟 `-e` 參數。不新鮮的資料排程會使傳輸具有 Burstiness，反映在接收端的 Jitter 增加。動態機制應能降低抖動。

4. **交叉驗證：ICMP 與 TCP 差異性對比**：
   - **ICMP (Ping)**：獨立傳輸，對亂序不敏感。
   - **TCP**：需按序交付，高度依賴 RLC Reordering Delay。
   - 若 NFAPI 波動大時，TCP 延遲增幅遠大於 Ping 延遲增幅，即證明調度決策錯誤 (舊資料) 導致的亂序重組是 E2E 效能下降主因。

**給教授的最終論證邏輯結構：** 
(1) 理論模型 (BSR 延遲導致分配失誤) $\rightarrow$ (2) UE 觀測 (Wireshark TCP OOO 現象) $\rightarrow$ (3) 統計證明 (CDF Variance 縮小)。

---

## 🔗 關聯性 (Related Ideas)
- *（此為資料庫的起始基礎點，探討了 Delay Management 與 MAC Scheduler 到 RLC/TCP 亂序的因果關係。未來的實驗數據或架構設計理念應回鏈至此篇。）*
