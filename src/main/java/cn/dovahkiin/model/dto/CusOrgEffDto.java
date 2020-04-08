package cn.dovahkiin.model.dto;

import java.math.BigDecimal;
import java.util.List;
import java.util.Set;

public class CusOrgEffDto {
    private String orgName;
    private String orgCode;
    private String cusName;
    private String cusCode;
    private BigDecimal sumAllEffConInc; // 素材生命周期内，部门收入消耗 ，
    private BigDecimal sumAllEffConPay; // 素材生命周期内，部门支出消耗 ，
    private BigDecimal sumAllCon; // 查询区间内消耗
    private BigDecimal sumEffCon ; // 总 查询区间内 内收入有效消耗
    private BigDecimal sumEffPayCon ; // 总 查询区间内 内支出有效消耗

    private BigDecimal income = new BigDecimal(0) ;
    private BigDecimal pay =new BigDecimal(0) ;

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

    public BigDecimal getSumAllCon() {
        return sumAllCon;
    }

    public void setSumAllCon(BigDecimal sumAllCon) {
        this.sumAllCon = sumAllCon;
    }

    public BigDecimal getSumEffCon() {
        return sumEffCon;
    }

    public void setSumEffCon(BigDecimal sumEffCon) {
        this.sumEffCon = sumEffCon;
    }

    public BigDecimal getSumEffPayCon() {
        return sumEffPayCon;
    }

    public void setSumEffPayCon(BigDecimal sumEffPayCon) {
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

    public BigDecimal getSumAllEffConInc() {
        return sumAllEffConInc;
    }

    public void setSumAllEffConInc(BigDecimal sumAllEffConInc) {
        this.sumAllEffConInc = sumAllEffConInc;
    }

    public BigDecimal getSumAllEffConPay() {
        return sumAllEffConPay;
    }

    public void setSumAllEffConPay(BigDecimal sumAllEffConPay) {
        this.sumAllEffConPay = sumAllEffConPay;
    }
}
