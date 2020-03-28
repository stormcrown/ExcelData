package cn.dovahkiin.model.dto;

import java.util.Date;

public class DayEffectDto {
    private String code;
    private Date recoredDate;
    private Double consumptionEffect;
    private Double income;
    private Double pay=0d;

    public DayEffectDto() {
    }

    public DayEffectDto(Date recoredDate) {
        this.recoredDate = recoredDate;
        this.consumptionEffect=0d;
        this.income=0d;
        this.pay=0d;
    }

    public DayEffectDto(String code, Date recoredDate, Double income,Double pay) {
        this.code = code;
        this.recoredDate = recoredDate;
        this.income = income;
        this.pay=pay;
        if(this.income==null)this.income=0d;
        if(this.pay==null)this.pay=0d;
        this.consumptionEffect=0d;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getRecoredDate() {
        return recoredDate;
    }

    public void setRecoredDate(Date recoredDate) {
        this.recoredDate = recoredDate;
    }

    public Double getConsumptionEffect() {
        return consumptionEffect;
    }

    public void setConsumptionEffect(Double consumptionEffect) {
        this.consumptionEffect = consumptionEffect;
    }

    public Double getIncome() {
        return income;
    }

    public void setIncome(Double income) {
        this.income = income;
    }

    public Double getPay() {
        return pay;
    }

    public void setPay(Double pay) {
        this.pay = pay;
    }
}
