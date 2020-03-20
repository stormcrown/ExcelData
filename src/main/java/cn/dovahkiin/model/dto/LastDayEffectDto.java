package cn.dovahkiin.model.dto;

import java.util.Date;

public class LastDayEffectDto {
    private Long customerId;
    private Date recoredDate;
    private Double maxEffectOn;
    private Double sumCon;


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

    public Double getMaxEffectOn() {
        return maxEffectOn;
    }

    public void setMaxEffectOn(Double maxEffectOn) {
        this.maxEffectOn = maxEffectOn;
    }

    public Double getSumCon() {
        return sumCon;
    }

    public void setSumCon(Double sumCon) {
        this.sumCon = sumCon;
    }
}
