package cn.dovahkiin.model.dto;

import java.io.*;
import java.math.BigDecimal;
import java.util.Date;

public class DayEffectDto implements Serializable {


    private String code;
    private Date recoredDate;
    private BigDecimal consumptionEffect=new BigDecimal(0);
    private BigDecimal payConsumptionEffect=new BigDecimal(0);
    private BigDecimal income=new BigDecimal(0);
    private BigDecimal pay=new BigDecimal(0);
    public DayEffectDto() {
    }

    public DayEffectDto(Date recoredDate) {
        this.recoredDate = recoredDate;
        this.consumptionEffect=new BigDecimal(0);
        this.payConsumptionEffect=new BigDecimal(0);
        this.income=new BigDecimal(0);
        this.pay=new BigDecimal(0);
    }

    public DayEffectDto(String code, Date recoredDate, BigDecimal income,BigDecimal pay) {
        this.code = code;
        this.recoredDate = recoredDate;
        this.income = income;
        this.pay=pay;
        if(this.income==null)this.income=new BigDecimal(0);
        if(this.pay==null)this.pay=new BigDecimal(0);
        this.consumptionEffect=new BigDecimal(0);
        this.payConsumptionEffect=new BigDecimal(0);
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

    public BigDecimal getConsumptionEffect() {
        return consumptionEffect;
    }

    public void setConsumptionEffect(BigDecimal consumptionEffect) {
        this.consumptionEffect = consumptionEffect;
    }

    public BigDecimal getPayConsumptionEffect() {
        return payConsumptionEffect;
    }

    public void setPayConsumptionEffect(BigDecimal payConsumptionEffect) {
        this.payConsumptionEffect = payConsumptionEffect;
    }

    public BigDecimal getIncome() {
        return income;
    }

    public void setIncome(BigDecimal income) {
        this.income = income;
    }

    public BigDecimal getPay() {
        return pay;
    }

    public void setPay(BigDecimal pay) {
        this.pay = pay;
    }
}
