package cn.dovahkiin.model.dto;

import java.math.BigDecimal;
import java.util.Date;

public class LastDayEffectDto {
    private String  code;
    private Date recoredDate;
    private BigDecimal sumCon;

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

    public BigDecimal getSumCon() {
        return sumCon;
    }

    public void setSumCon(BigDecimal sumCon) {
        this.sumCon = sumCon;
    }
}
