package cn.dovahkiin.model.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CustomerEffectDto {
    private String name;
    private String code;
    private String supplierName;
    private String supplierCode;
    private BigDecimal basePrice;
    private BigDecimal basePay;
    private Date completeDate;
    private Date incomeConfigEndDate;
    private Date payConfigEndDate;
    private Date incomeEndDate;
    private Date payEndDate;
    private BigDecimal incMaxEffectOn;
    private BigDecimal payMaxEffectOn;
    private BigDecimal incomeRadio;
    private BigDecimal payRadio;
    private String priceLevelName;
    private String payLevelName;
    /**生命周期内的消耗，如果超了对应的消耗，那么肯定是提前结束了，需要知道哪一天超了   */
    private BigDecimal sumAllEffConInc;  // 收入总生命周期内消耗 ，
    private BigDecimal sumAllEffConPay;  // 支出总生命周期内消耗 ，
    private BigDecimal sumAllCon; // 查询区间内消耗
    private boolean incomeOverflow=Boolean.FALSE;
    private BigDecimal sumEffCon ; // 总 查询区间内 内收入有效消耗
    private BigDecimal lastDayIncomeOver =new BigDecimal(0) ; // 最后一天收入消耗溢出
    private boolean payOverflow=Boolean.FALSE;
    private BigDecimal sumEffPayCon ; // 总 查询区间内 内支出有效消耗
    private BigDecimal lastDayPayOver =new BigDecimal(0) ; // 最后一天支出消耗溢出
    private BigDecimal sumIncome;
    private BigDecimal sumPay;

    private List<DayEffectDto> data; // 素材的每日消耗

    public void addData(DayEffectDto dayEffectDto){
        if(data==null)data = new ArrayList<>();
        data.add(dayEffectDto);
    }

    private List<CusOrgEffDto> cusOrgEffDtos;



    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Date getIncomeConfigEndDate() { return incomeConfigEndDate; }
    public void setIncomeConfigEndDate(Date incomeConfigEndDate) { this.incomeConfigEndDate = incomeConfigEndDate; }
    public Date getPayConfigEndDate() { return payConfigEndDate; }
    public void setPayConfigEndDate(Date payConfigEndDate) { this.payConfigEndDate = payConfigEndDate; }
    public Date getCompleteDate() { return completeDate; }
    public void setCompleteDate(Date completeDate) { this.completeDate = completeDate; }
    public Date getIncomeEndDate() { return incomeEndDate; }
    public void setIncomeEndDate(Date incomeEndDate) { this.incomeEndDate = incomeEndDate; }
    public BigDecimal getIncMaxEffectOn() { return incMaxEffectOn; }
    public void setIncMaxEffectOn(BigDecimal incMaxEffectOn) { this.incMaxEffectOn = incMaxEffectOn; }
    public BigDecimal getIncomeRadio() { return incomeRadio; }
    public void setIncomeRadio(BigDecimal incomeRadio) { this.incomeRadio = incomeRadio; }
    public BigDecimal getSumAllEffConInc() { return sumAllEffConInc; }
    public void setSumAllEffConInc(BigDecimal sumAllEffConInc) { this.sumAllEffConInc = sumAllEffConInc; }
    public BigDecimal getSumAllEffConPay() { return sumAllEffConPay; }
    public void setSumAllEffConPay(BigDecimal sumAllEffConPay) { this.sumAllEffConPay = sumAllEffConPay; }
    public BigDecimal getBasePrice() { return basePrice; }
    public void setBasePrice(BigDecimal basePrice) { this.basePrice = basePrice; }
    public List<DayEffectDto> getData() { return data; }
    public void setData(List<DayEffectDto> data) { this.data = data; }
    public BigDecimal getSumIncome() { return sumIncome; }
    public void setSumIncome(BigDecimal sumIncome) { this.sumIncome = sumIncome; }
    public BigDecimal getPayRadio() { return payRadio; }
    public void setPayRadio(BigDecimal payRadio) { this.payRadio = payRadio; }
    public String getPriceLevelName() { return priceLevelName; }
    public void setPriceLevelName(String priceLevelName) { this.priceLevelName = priceLevelName; }
    public BigDecimal getSumEffCon() { return sumEffCon; }
    public void setSumEffCon(BigDecimal sumEffCon) { this.sumEffCon = sumEffCon; }
    public BigDecimal getSumEffPayCon() { return sumEffPayCon; }
    public void setSumEffPayCon(BigDecimal sumEffPayCon) { this.sumEffPayCon = sumEffPayCon; }
    public BigDecimal getSumPay() { return sumPay; }
    public void setSumPay(BigDecimal sumPay) { this.sumPay = sumPay; }
    public BigDecimal getBasePay() { return basePay; }
    public void setBasePay(BigDecimal basePay) { this.basePay = basePay; }
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

    public BigDecimal getPayMaxEffectOn() {
        return payMaxEffectOn;
    }

    public void setPayMaxEffectOn(BigDecimal payMaxEffectOn) {
        this.payMaxEffectOn = payMaxEffectOn;
    }

    public BigDecimal getSumAllCon() {
        return sumAllCon;
    }

    public void setSumAllCon(BigDecimal sumAllCon) {
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

    public BigDecimal getLastDayIncomeOver() {
        return lastDayIncomeOver;
    }

    public void setLastDayIncomeOver(BigDecimal lastDayIncomeOver) {
        this.lastDayIncomeOver = lastDayIncomeOver;
    }

    public BigDecimal getLastDayPayOver() {
        return lastDayPayOver;
    }

    public void setLastDayPayOver(BigDecimal lastDayPayOver) {
        this.lastDayPayOver = lastDayPayOver;
    }


}
