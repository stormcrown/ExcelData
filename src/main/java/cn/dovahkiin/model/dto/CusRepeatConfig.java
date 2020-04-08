package cn.dovahkiin.model.dto;

import java.math.BigDecimal;

public class CusRepeatConfig {
    private String cusCode;
    private BigDecimal maxEffectCon;
    private BigDecimal payMaxEffectCon;
    private BigDecimal incomeRatio;
    private BigDecimal payRatio;
    private Long payLevelId;
    private String payName;
    private Long priceLevelId;
    private String priceName;
    private Long supplierId;
    private String supplierName;


    public BigDecimal getMaxEffectCon() {
        return maxEffectCon;
    }

    public void setMaxEffectCon(BigDecimal maxEffectCon) {
        this.maxEffectCon = maxEffectCon;
    }

    public BigDecimal getPayMaxEffectCon() {
        return payMaxEffectCon;
    }

    public void setPayMaxEffectCon(BigDecimal payMaxEffectCon) {
        this.payMaxEffectCon = payMaxEffectCon;
    }

    public BigDecimal getIncomeRatio() {
        return incomeRatio;
    }

    public void setIncomeRatio(BigDecimal incomeRatio) {
        this.incomeRatio = incomeRatio;
    }

    public BigDecimal getPayRatio() {
        return payRatio;
    }

    public void setPayRatio(BigDecimal payRatio) {
        this.payRatio = payRatio;
    }

    public String getCusCode() {
        return cusCode;
    }

    public void setCusCode(String cusCode) {
        this.cusCode = cusCode;
    }
    public Long getPayLevelId() {
        return payLevelId;
    }

    public void setPayLevelId(Long payLevelId) {
        this.payLevelId = payLevelId;
    }

    public String getPayName() {
        return payName;
    }

    public void setPayName(String payName) {
        this.payName = payName;
    }

    public Long getPriceLevelId() {
        return priceLevelId;
    }

    public void setPriceLevelId(Long priceLevelId) {
        this.priceLevelId = priceLevelId;
    }

    public String getPriceName() {
        return priceName;
    }

    public void setPriceName(String priceName) {
        this.priceName = priceName;
    }

    public Long getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Long supplierId) {
        this.supplierId = supplierId;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
}
