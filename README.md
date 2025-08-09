# Quantitative Strategy – Live Performance Tracking


This repository tracks a market-neutral statistical-arbitrage strategy deployed live in cryptocurrency futures since **31 Jan 2025**. The model uses residuals for daily portfolio construction.
All live and back-test metrics refresh automatically and are published under **`metrics/`**.

---

## Recent Improvements

| Date        | Change |
|-------------|--------|
| **2025-08-06 (v5)** | **Material Model Change** - model expected to perform significantly differently from previous versions. |
| 2025-07-28 (v4) | Pipeline fix – removed a subtle live/back-test logic mismatch that had lowered live Sharpe; live results now expected to track backtests except for funding and slippage. |
| 2025-06-21 (v3) | Added dynamic position caps to curb tail exposure. |
| 2025-05-15 (v2) | Stabilized model outputs to reduce stochastic noise. |

*(Earlier versions kept for full transparency; v5 is the baseline.)*

---

## Model Versions

| Version | Dates | Key Notes |
|---------|-------|-----------|
| **v1** | 2025-01-31 → 2025-05-15 | Initial deployment |
| **v2** | 2025-05-15 → 2025-06-18 | Output-stability enhancements |
| **v3** | 2025-06-21 → 2025-07-28 | Dynamic position capping |
| **v4** | 2025-07-28 → 2025-08-06 | Pipeline fix — first version expected to align closely with backtests |
| **v5** | 2025-08-06 → **Present** | Material Model Change |

---

## Performance Reporting

* **Sharpe Ratio** – annualized by √365, zero risk-free rate  
* **Net Returns** – after estimated fees & slippage  
* **Leverage Normalization** – all metrics shown on a 1x baseline

### Versioned Metrics

- **v1–v3 (historical):** Shown for transparency. v2–v3 contained a live/backtest logic mismatch (model ensembling logic introduced in v2) and ran through highly volatile market regimes, produced live Sharpe well below the backtest Sharpe.

- **v4 (historical):** Post-fix metrics; a version that reliably mirrors the back-test. 

- **v5 (current baseline):** These are the primary numbers to reference going forward.
