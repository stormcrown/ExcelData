package cn.dovahkiin.model.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class OrgEffDto {
    private String orgCode;
    private String orgName;
    private BigDecimal totalSumAllEffConInc; // 素材生命周期内，部门收入消耗 ，
    private BigDecimal totalSumAllEffConPay; // 素材生命周期内，部门支出消耗 ，
    private BigDecimal totalSumAllCon; // 查询区间内消耗
    private BigDecimal totalSumEffCon ; // 总 查询区间内 内收入有效消耗
    private BigDecimal totalSumEffPayCon ; // 总 查询区间内 内支出有效消耗
    private boolean incomeConflict=Boolean.FALSE;
    private boolean payConflict=Boolean.FALSE;
    private List<CusOrgEffDto> cusOrgEffDtoList;

    public void init(String orgCode,String orgName){
        this.orgCode =orgCode;
        this.orgName=orgName;
         totalSumAllEffConInc=new BigDecimal(0); // 素材生命周期内，部门收入消耗 ，
        totalSumAllEffConPay=new BigDecimal(0); // 素材生命周期内，部门支出消耗 ，
        totalSumAllCon=new BigDecimal(0); // 查询区间内消耗
        totalSumEffCon =new BigDecimal(0);// 总 查询区间内 内收入有效消耗
        totalSumEffPayCon =new BigDecimal(0); // 总 查询区间内 内支出有效消耗
    }
    public void updateData(CusOrgEffDto cusOrgEffDto){
        if(cusOrgEffDto==null)return;
        totalSumAllEffConInc=totalSumAllEffConInc.add(cusOrgEffDto.getSumAllEffConInc())  ; // 素材生命周期内，部门收入消耗 ，
        totalSumAllEffConPay=totalSumAllEffConPay.add(cusOrgEffDto.getSumAllEffConPay()); // 素材生命周期内，部门支出消耗 ，
        totalSumAllCon=totalSumAllCon.add(cusOrgEffDto.getSumAllCon()); // 查询区间内消耗
        totalSumEffCon=totalSumEffCon.add(cusOrgEffDto.getSumEffCon()); // 总 查询区间内 内收入有效消耗
        totalSumEffPayCon=totalSumEffPayCon.add(cusOrgEffDto.getSumEffPayCon()); // 总 查询区间内 内支出有效消耗
        if(cusOrgEffDtoList==null)cusOrgEffDtoList = new ArrayList<>();
        cusOrgEffDtoList.add(cusOrgEffDto);
        if(cusOrgEffDto.isIncomeConflict())incomeConflict=Boolean.TRUE;
        if(cusOrgEffDto.isPayConflict())payConflict=Boolean.TRUE;


    }

    public String getOrgCode() {
        return orgCode;
    }

    public void setOrgCode(String orgCode) {
        this.orgCode = orgCode;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public BigDecimal getTotalSumAllEffConInc() {
        return totalSumAllEffConInc;
    }

    public void setTotalSumAllEffConInc(BigDecimal totalSumAllEffConInc) {
        this.totalSumAllEffConInc = totalSumAllEffConInc;
    }

    public BigDecimal getTotalSumAllEffConPay() {
        return totalSumAllEffConPay;
    }

    public void setTotalSumAllEffConPay(BigDecimal totalSumAllEffConPay) {
        this.totalSumAllEffConPay = totalSumAllEffConPay;
    }

    public BigDecimal getTotalSumAllCon() {
        return totalSumAllCon;
    }

    public void setTotalSumAllCon(BigDecimal totalSumAllCon) {
        this.totalSumAllCon = totalSumAllCon;
    }

    public BigDecimal getTotalSumEffCon() {
        return totalSumEffCon;
    }

    public void setTotalSumEffCon(BigDecimal totalSumEffCon) {
        this.totalSumEffCon = totalSumEffCon;
    }

    public BigDecimal getTotalSumEffPayCon() {
        return totalSumEffPayCon;
    }

    public void setTotalSumEffPayCon(BigDecimal totalSumEffPayCon) {
        this.totalSumEffPayCon = totalSumEffPayCon;
    }

    public List<CusOrgEffDto> getCusOrgEffDtoList() {
        return cusOrgEffDtoList;
    }

    public void setCusOrgEffDtoList(List<CusOrgEffDto> cusOrgEffDtoList) {
        this.cusOrgEffDtoList = cusOrgEffDtoList;
    }

    public boolean isIncomeConflict() {
        return incomeConflict;
    }

    public void setIncomeConflict(boolean incomeConflict) {
        this.incomeConflict = incomeConflict;
    }

    public boolean isPayConflict() {
        return payConflict;
    }

    public void setPayConflict(boolean payConflict) {
        this.payConflict = payConflict;
    }
}
