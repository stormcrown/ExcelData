package cn.dovahkiin.model.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CustomerEffectDto {
    private String name;
    private String code;
    private String supplierName;
    private String supplierCode;
    private Double basePrice;
    private Double basePay;
    private Date completeDate;
    private Date endDate;
    private Date incomeEndDate;
    private Date payEndDate;
    private Double maxEffectOn;
    private Double payMaxEffectOn;
    private Double incomeRadio;
    private Double payRadio;
    private String priceLevelName;
    private String payLevelName;
    /**生命周期内的消耗，如果超了对应的消耗，那么肯定是提前结束了，需要知道哪一天超了   */
    private Double sumAllEffCon;  // 总生命周期内消耗 ，
    private Double sumAllCon; // 查询区间内消耗
    private boolean incomeOverflow=Boolean.FALSE;
    private Double sumEffCon ; // 总 查询区间内 内收入有效消耗
    private Double lastDayIncomeOver =0d ; // 最后一天收入消耗溢出
    private boolean payOverflow=Boolean.FALSE;
    private Double sumEffPayCon ; // 总 查询区间内 内支出有效消耗
    private Double lastDayPayOver =0d ; // 最后一天支出消耗溢出
    private Double sumIncome;
    private Double sumPay;

    private List<DayEffectDto> data; // 素材的每日消耗

    public void addData(DayEffectDto dayEffectDto){
        if(data==null)data = new ArrayList<>();
        data.add(dayEffectDto);
    }

    private List<CusOrgEffDto> cusOrgEffDtos;

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }
    public Date getCompleteDate() { return completeDate; }
    public void setCompleteDate(Date completeDate) { this.completeDate = completeDate; }
    public Date getIncomeEndDate() { return incomeEndDate; }
    public void setIncomeEndDate(Date incomeEndDate) { this.incomeEndDate = incomeEndDate; }
    public Double getMaxEffectOn() { return maxEffectOn; }
    public void setMaxEffectOn(Double maxEffectOn) { this.maxEffectOn = maxEffectOn; }
    public Double getIncomeRadio() { return incomeRadio; }
    public void setIncomeRadio(Double incomeRadio) { this.incomeRadio = incomeRadio; }
    public Double getSumAllEffCon() { return sumAllEffCon; }
    public void setSumAllEffCon(Double sumAllEffCon) { this.sumAllEffCon = sumAllEffCon; }
    public Double getBasePrice() { return basePrice; }
    public void setBasePrice(Double basePrice) { this.basePrice = basePrice; }
    public List<DayEffectDto> getData() { return data; }
    public void setData(List<DayEffectDto> data) { this.data = data; }
    public Double getSumIncome() { return sumIncome; }
    public void setSumIncome(Double sumIncome) { this.sumIncome = sumIncome; }
    public Double getPayRadio() { return payRadio; }
    public void setPayRadio(Double payRadio) { this.payRadio = payRadio; }
    public String getPriceLevelName() { return priceLevelName; }
    public void setPriceLevelName(String priceLevelName) { this.priceLevelName = priceLevelName; }
    public Double getSumEffCon() { return sumEffCon; }
    public void setSumEffCon(Double sumEffCon) { this.sumEffCon = sumEffCon; }
    public Double getSumEffPayCon() { return sumEffPayCon; }
    public void setSumEffPayCon(Double sumEffPayCon) { this.sumEffPayCon = sumEffPayCon; }
    public Double getSumPay() { return sumPay; }
    public void setSumPay(Double sumPay) { this.sumPay = sumPay; }
    public Double getBasePay() { return basePay; }
    public void setBasePay(Double basePay) { this.basePay = basePay; }
    public String getPayLevelName() {
        return payLevelName;
    }

    public void setPayLevelName(String payLevelName) {
        this.payLevelName = payLevelName;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Double getPayMaxEffectOn() {
        return payMaxEffectOn;
    }

    public void setPayMaxEffectOn(Double payMaxEffectOn) {
        this.payMaxEffectOn = payMaxEffectOn;
    }

    public Double getSumAllCon() {
        return sumAllCon;
    }

    public void setSumAllCon(Double sumAllCon) {
        this.sumAllCon = sumAllCon;
    }

    public Date getPayEndDate() {
        return payEndDate;
    }

    public void setPayEndDate(Date payEndDate) {
        this.payEndDate = payEndDate;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getSupplierCode() {
        return supplierCode;
    }

    public void setSupplierCode(String supplierCode) {
        this.supplierCode = supplierCode;
    }

    public List<CusOrgEffDto> getCusOrgEffDtos() {
        return cusOrgEffDtos;
    }

    public void setCusOrgEffDtos(List<CusOrgEffDto> cusOrgEffDtos) {
        this.cusOrgEffDtos = cusOrgEffDtos;
    }

    public boolean isIncomeOverflow() {
        return incomeOverflow;
    }

    public void setIncomeOverflow(boolean incomeOverflow) {
        this.incomeOverflow = incomeOverflow;
    }

    public boolean isPayOverflow() {
        return payOverflow;
    }

    public void setPayOverflow(boolean payOverflow) {
        this.payOverflow = payOverflow;
    }

    public Double getLastDayIncomeOver() {
        return lastDayIncomeOver;
    }

    public void setLastDayIncomeOver(Double lastDayIncomeOver) {
        this.lastDayIncomeOver = lastDayIncomeOver;
    }

    public Double getLastDayPayOver() {
        return lastDayPayOver;
    }

    public void setLastDayPayOver(Double lastDayPayOver) {
        this.lastDayPayOver = lastDayPayOver;
    }
}
