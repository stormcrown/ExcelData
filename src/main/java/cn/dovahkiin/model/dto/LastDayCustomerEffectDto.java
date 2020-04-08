package cn.dovahkiin.model.dto;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Set;

public class LastDayCustomerEffectDto {
    private String orgName;
    private String orgCode;
    private String cusName;
    private String cusCode;
    private BigDecimal sumCon; // 查询区间内消耗
    private Date recordDate;
    private Set<String> conflictOrgNames;


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

    public BigDecimal getSumCon() {
        return sumCon;
    }

    public void setSumCon(BigDecimal sumCon) {
        this.sumCon = sumCon;
    }

    public Date getRecordDate() {
        return recordDate;
    }

    public void setRecordDate(Date recordDate) {
        this.recordDate = recordDate;
    }

    public Set<String> getConflictOrgNames() {
        return conflictOrgNames;
    }

    public void setConflictOrgNames(Set<String> conflictOrgNames) {
        this.conflictOrgNames = conflictOrgNames;
    }
}
