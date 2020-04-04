package cn.dovahkiin.model.dto;

public class CusOrgEffDto {
    private String orgName;
    private String orgCode;
    private String cusName;
    private String cusCode;
    private Double sumAllCon; // 查询区间内消耗
    private Double sumEffCon ; // 总 查询区间内 内收入有效消耗
    private Double sumEffPayCon ; // 总 查询区间内 内支出有效消耗

    private Double incomeRadio;
    private Double payRadio;

    private double income =0d ;
    private double pay =0d ;


    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getOrgCode() {
        return orgCode;
    }

    public void setOrgCode(String orgCode) {
        this.orgCode = orgCode;
    }

    public String getCusName() {
        return cusName;
    }

    public void setCusName(String cusName) {
        this.cusName = cusName;
    }

    public String getCusCode() {
        return cusCode;
    }

    public void setCusCode(String cusCode) {
        this.cusCode = cusCode;
    }

    public Double getIncomeRadio() {
        return incomeRadio;
    }

    public void setIncomeRadio(Double incomeRadio) {
        this.incomeRadio = incomeRadio;
    }

    public Double getPayRadio() {
        return payRadio;
    }

    public void setPayRadio(Double payRadio) {
        this.payRadio = payRadio;
    }

    public Double getSumAllCon() {
        return sumAllCon;
    }

    public void setSumAllCon(Double sumAllCon) {
        this.sumAllCon = sumAllCon;
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

}
