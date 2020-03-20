package cn.dovahkiin.model.dto;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class CustomerEffectDto {
    private Long id;
    private String name;
    private Double basePrice;
    private Date completeDate;
    private Date endDate;
    private Double maxEffectOn;
    private Double incomeRadio;
    private Double sumCon ;

    private List<DayEffectDto> data;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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
}
