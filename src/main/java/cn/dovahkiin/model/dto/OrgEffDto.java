package cn.dovahkiin.model.dto;

import java.util.ArrayList;
import java.util.List;

public class OrgEffDto {
    private String orgCode;
    private String orgName;
    private Double totalSumAllEffConInc; // 素材生命周期内，部门收入消耗 ，
    private Double totalSumAllEffConPay; // 素材生命周期内，部门支出消耗 ，
    private Double totalSumAllCon; // 查询区间内消耗
    private Double totalSumEffCon ; // 总 查询区间内 内收入有效消耗
    private Double totalSumEffPayCon ; // 总 查询区间内 内支出有效消耗
    private boolean incomeConflict=Boolean.FALSE;
    private boolean payConflict=Boolean.FALSE;
    private List<CusOrgEffDto> cusOrgEffDtoList;

    public void init(String orgCode,String orgName){
        this.orgCode =orgCode;
        this.orgName=orgName;
         totalSumAllEffConInc=0d; // 素材生命周期内，部门收入消耗 ，
        totalSumAllEffConPay=0d; // 素材生命周期内，部门支出消耗 ，
        totalSumAllCon=0d; // 查询区间内消耗
        totalSumEffCon =0d; // 总 查询区间内 内收入有效消耗
        totalSumEffPayCon =0d; // 总 查询区间内 内支出有效消耗
    }
    public void updateData(CusOrgEffDto cusOrgEffDto){
        if(cusOrgEffDto==null)return;
        totalSumAllEffConInc+=cusOrgEffDto.getSumAllEffConInc(); // 素材生命周期内，部门收入消耗 ，
        totalSumAllEffConPay+=cusOrgEffDto.getSumAllEffConPay(); // 素材生命周期内，部门支出消耗 ，
        totalSumAllCon+=cusOrgEffDto.getSumAllCon(); // 查询区间内消耗
        totalSumEffCon +=cusOrgEffDto.getSumEffCon(); // 总 查询区间内 内收入有效消耗
        totalSumEffPayCon +=cusOrgEffDto.getSumEffPayCon(); // 总 查询区间内 内支出有效消耗
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

    public Double getTotalSumAllEffConInc() {
        return totalSumAllEffConInc;
    }

    public void setTotalSumAllEffConInc(Double totalSumAllEffConInc) {
        this.totalSumAllEffConInc = totalSumAllEffConInc;
    }

    public Double getTotalSumAllEffConPay() {
        return totalSumAllEffConPay;
    }

    public void setTotalSumAllEffConPay(Double totalSumAllEffConPay) {
        this.totalSumAllEffConPay = totalSumAllEffConPay;
    }

    public Double getTotalSumAllCon() {
        return totalSumAllCon;
    }

    public void setTotalSumAllCon(Double totalSumAllCon) {
        this.totalSumAllCon = totalSumAllCon;
    }

    public Double getTotalSumEffCon() {
        return totalSumEffCon;
    }

    public void setTotalSumEffCon(Double totalSumEffCon) {
        this.totalSumEffCon = totalSumEffCon;
    }

    public Double getTotalSumEffPayCon() {
        return totalSumEffPayCon;
    }

    public void setTotalSumEffPayCon(Double totalSumEffPayCon) {
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
