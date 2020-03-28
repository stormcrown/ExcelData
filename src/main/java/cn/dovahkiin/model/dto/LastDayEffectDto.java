package cn.dovahkiin.model.dto;

import java.util.Date;

public class LastDayEffectDto {
    private String  code;
    private Date recoredDate;
    private Double maxEffectOn;
    private Double sumCon;

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
