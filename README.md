# Live Strategy Performance - Market Neutral Statistical Arbitrage (Crypto Futures)

**Deployment Start**: 06 Aug 2025 (31 Jan 2025 - 05 Aug 2025 operated under legacy versions)\
**Strategy Type**: Market Neutral Statistical Arbitrage\
**Signal Basis**: Mean-reversion Signals with Systematic Rebalancing\
**Leverage**: Normalized to 1x for reporting purposes

The strategy is fully automated - from signal generation to execution - and operates in live production with real capital. Performance metrics are calculated net of transaction costs and slippage. All live and backtest metrics are updated automatically on a daily basis, and are published under **`metrics/`**.

---

## Recent Improvements

| Date        | Change |
|-------------|--------|
| **2025-08-06 (v5)** | **Material Model Change** - new alpha source, performance profile expected to be different from previous versions. |
| 2025-07-28 (v4) | Resolved subtle live/backtest logic mismatch that had lowered live Sharpe; live results now expected to track backtests except for funding and slippage. |
| 2025-06-21 (v3) | Incorporated tail exposure control. |
| 2025-05-15 (v2) | Stabilized model. |

*(Earlier versions kept for full transparency; v5 is the baseline.)*

---

## Model Versions

| Version | Dates | Key Notes |
|---------|-------|-----------|
| **v1** | 2025-01-31 → 2025-05-15 | Initial deployment |
| **v2** | 2025-05-15 → 2025-06-18 | Model stability enhancements |
| **v3** | 2025-06-21 → 2025-07-28 | Tail risk control |
| **v4** | 2025-07-28 → 2025-08-06 | Pipeline fix - eliminated live/backtest logic mismatch |
| **v5** | 2025-08-06 → **Present** | Material Model Change - new baseline |

---

## Performance Reporting

* **Sharpe Ratio** – annualized by √365, zero risk-free rate  
* **Net Returns** – after estimated fees & slippage  


<!---->
<!--### Versioned Metrics-->
<!---->
<!--- **v1–v3 (historical):** Shown for transparency. v2–v3 contained a live/backtest logic mismatch (model ensembling logic introduced in v2) and ran through highly volatile market regimes, produced live Sharpe well below the backtest Sharpe.-->
<!---->
<!--- **v4 (historical):** Post-fix metrics; a version that reliably mirrors the backtest. -->
<!---->
<!--- **v5 (current baseline):** These are the primary numbers to reference going forward.-->
