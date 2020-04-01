package cn.dovahkiin.model.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class CustomerEffectDto {

    private String name;
    private String code;
    private Double basePrice;
    private Double basePay;
    private Date completeDate;
    private Date endDate;
    private Date payEndDate;
    private Double maxEffectOn;
    private Double payMaxEffectOn;
    private Double incomeRadio;
    private Double payRadio;
    private String priceLevelName;
    private String payLevelName;
    private Double sumCon ;
    private Double sumEffCon ;
    private Double sumEffPayCon ;
    private Double sumIncome;
    private Double sumPay;

    private List<DayEffectDto> data;
    public void addData(DayEffectDto dayEffectDto){
        if(data==null)data = new ArrayList<>();
        data.add(dayEffectDto);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getCompleteDate() {
        return completeDate;
    }

    public void setCompleteDate(Date completeDate) {
        this.completeDate = completeDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Double getMaxEffectOn() {
        return maxEffectOn;
    }

    public void setMaxEffectOn(Double maxEffectOn) {
        this.maxEffectOn = maxEffectOn;
    }

    public Double getIncomeRadio() {
        return incomeRadio;
    }

    public void setIncomeRadio(Double incomeRadio) {
        this.incomeRadio = incomeRadio;
    }

    public Double getSumCon() {
        return sumCon;
    }

    public void setSumCon(Double sumCon) {
        this.sumCon = sumCon;
    }

    public Double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(Double basePrice) {
        this.basePrice = basePrice;
    }

    public List<DayEffectDto> getData() {
        return data;
    }

    public void setData(List<DayEffectDto> data) {
        this.data = data;
    }

    public Double getSumIncome() {
        return sumIncome;
    }

    public void setSumIncome(Double sumIncome) {
        this.sumIncome = sumIncome;
    }

    public Double getPayRadio() {
        return payRadio;
    }

    public void setPayRadio(Double payRadio) {
        this.payRadio = payRadio;
    }

    public String getPriceLevelName() {
        return priceLevelName;
    }

    public void setPriceLevelName(String priceLevelName) {
        this.priceLevelName = priceLevelName;
    }

    public Double getSumEffCon() {
        return sumEffCon;
    }

    public void setSumEffCon(Double sumEffCon) {
        this.sumEffCon = sumEffCon;
    }

    public Double getSumEffPayCon() {
        return sumEffPayCon;
    }

    public void setSumEffPayCon(Double sumEffPayCon) {
        this.sumEffPayCon = sumEffPayCon;
    }

    public Double getSumPay() {
        return sumPay;
    }

    public void setSumPay(Double sumPay) {
        this.sumPay = sumPay;
    }

    public Double getBasePay() {
        return basePay;
    }

    public void setBasePay(Double basePay) {
        this.basePay = basePay;
    }

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

    public Date getPayEndDate() {
        return payEndDate;
    }

    public void setPayEndDate(Date payEndDate) {
        this.payEndDate = payEndDate;
    }
}
