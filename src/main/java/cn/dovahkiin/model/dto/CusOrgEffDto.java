package cn.dovahkiin.model.dto;

import java.util.List;

public class CusOrgEffDto {
    private String orgName;
    private String orgCode;
    private String cusName;
    private String cusCode;
    private Double sumAllCon; // 查询区间内消耗
    private Double sumEffCon ; // 总 查询区间内 内收入有效消耗
    private Double sumEffPayCon ; // 总 查询区间内 内支出有效消耗

    private double income =0d ;
    private double pay =0d ;

    private boolean incomeConflict=Boolean.FALSE;
    private List<String> incomeConflictOrgNames;
    /**有冲突就存，没冲突就直接修正*/
    private LastDayCustomerEffectDto incomeLastDay;

    private boolean payConflict=Boolean.FALSE;
    /**有冲突就存，没冲突就直接修正*/
    private LastDayCustomerEffectDto payLastDay;
    private List<String> payConflictOrgNames;

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

    public boolean isIncomeConflict() {
        return incomeConflict;
    }

    public void setIncomeConflict(boolean incomeConflict) {
        this.incomeConflict = incomeConflict;
    }

    public LastDayCustomerEffectDto getIncomeLastDay() {
        return incomeLastDay;
    }

    public void setIncomeLastDay(LastDayCustomerEffectDto incomeLastDay) {
        this.incomeLastDay = incomeLastDay;
    }

    public boolean isPayConflict() {
        return payConflict;
    }

    public void setPayConflict(boolean payConflict) {
        this.payConflict = payConflict;
    }

    public LastDayCustomerEffectDto getPayLastDay() {
        return payLastDay;
    }

    public void setPayLastDay(LastDayCustomerEffectDto payLastDay) {
        this.payLastDay = payLastDay;
    }

    public List<String> getIncomeConflictOrgNames() {
        return incomeConflictOrgNames;
    }

    public void setIncomeConflictOrgNames(List<String> incomeConflictOrgNames) {
        this.incomeConflictOrgNames = incomeConflictOrgNames;
    }

    public List<String> getPayConflictOrgNames() {
        return payConflictOrgNames;
    }

    public void setPayConflictOrgNames(List<String> payConflictOrgNames) {
        this.payConflictOrgNames = payConflictOrgNames;
    }
}
