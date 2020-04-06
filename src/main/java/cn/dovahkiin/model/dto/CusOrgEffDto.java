package cn.dovahkiin.model.dto;

import java.util.List;
import java.util.Set;

public class CusOrgEffDto {
    private String orgName;
    private String orgCode;
    private String cusName;
    private String cusCode;
    private Double sumAllEffConInc; // 素材生命周期内，部门收入消耗 ，
    private Double sumAllEffConPay; // 素材生命周期内，部门支出消耗 ，
    private Double sumAllCon; // 查询区间内消耗
    private Double sumEffCon ; // 总 查询区间内 内收入有效消耗
    private Double sumEffPayCon ; // 总 查询区间内 内支出有效消耗

    private double income =0d ;
    private double pay =0d ;

    private boolean incomeConflict=Boolean.FALSE;
    private Set<String> incomeConflictOrgNames;
    /**有冲突就存，没冲突就直接修正*/
    private LastDayCustomerEffectDto incomeLastDay;

    private boolean payConflict=Boolean.FALSE;
    /**有冲突就存，没冲突就直接修正*/
    private LastDayCustomerEffectDto payLastDay;
    private Set<String> payConflictOrgNames;







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

    public double getIncome() {
        return income;
    }

    public void setIncome(double income) {
        this.income = income;
    }

    public double getPay() {
        return pay;
    }

    public void setPay(double pay) {
        this.pay = pay;
    }

    public Set<String> getIncomeConflictOrgNames() {
        return incomeConflictOrgNames;
    }

    public void setIncomeConflictOrgNames(Set<String> incomeConflictOrgNames) {
        this.incomeConflictOrgNames = incomeConflictOrgNames;
    }

    public Set<String> getPayConflictOrgNames() {
        return payConflictOrgNames;
    }

    public void setPayConflictOrgNames(Set<String> payConflictOrgNames) {
        this.payConflictOrgNames = payConflictOrgNames;
    }

    public Double getSumAllEffConInc() {
        return sumAllEffConInc;
    }

    public void setSumAllEffConInc(Double sumAllEffConInc) {
        this.sumAllEffConInc = sumAllEffConInc;
    }

    public Double getSumAllEffConPay() {
        return sumAllEffConPay;
    }

    public void setSumAllEffConPay(Double sumAllEffConPay) {
        this.sumAllEffConPay = sumAllEffConPay;
    }
}
