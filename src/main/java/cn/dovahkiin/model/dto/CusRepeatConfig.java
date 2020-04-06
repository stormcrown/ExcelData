package cn.dovahkiin.model.dto;

public class CusRepeatConfig {
    private String cusCode;
    private Double maxEffectCon;
    private Double payMaxEffectCon;
    private Double incomeRatio;
    private Double payRatio;
    private Long payLevelId;
    private String payName;
    private Long priceLevelId;
    private String priceName;
    private Long supplierId;
    private String supplierName;

    public String getCusCode() {
        return cusCode;
    }

    public void setCusCode(String cusCode) {
        this.cusCode = cusCode;
    }

    public Double getMaxEffectCon() {
        return maxEffectCon;
    }

    public void setMaxEffectCon(Double maxEffectCon) {
        this.maxEffectCon = maxEffectCon;
    }

    public Double getPayMaxEffectCon() {
        return payMaxEffectCon;
    }

    public void setPayMaxEffectCon(Double payMaxEffectCon) {
        this.payMaxEffectCon = payMaxEffectCon;
    }

    public Double getIncomeRatio() {
        return incomeRatio;
    }

    public void setIncomeRatio(Double incomeRatio) {
        this.incomeRatio = incomeRatio;
    }

    public Double getPayRatio() {
        return payRatio;
    }

    public void setPayRatio(Double payRatio) {
        this.payRatio = payRatio;
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
