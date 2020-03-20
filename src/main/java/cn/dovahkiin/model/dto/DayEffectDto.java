package cn.dovahkiin.model.dto;

import java.util.Date;

public class DayEffectDto {
    private Long customerId;
    private Date recoredDate;
    private Double consumptionEffect;

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
}
