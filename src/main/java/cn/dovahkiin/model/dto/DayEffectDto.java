package cn.dovahkiin.model.dto;

import java.util.Date;

public class DayEffectDto {
    private Long customerId;
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
    }

    public DayEffectDto(Long customerId, Date recoredDate, Double income,Double pay) {
        this.customerId = customerId;
        this.recoredDate = recoredDate;
        this.income = income;
        this.pay=pay;
        this.consumptionEffect=0d;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
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
