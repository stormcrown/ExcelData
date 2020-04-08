package cn.dovahkiin.model.dto;

import java.math.BigDecimal;
import java.util.List;
/**通过整理数据取得所有的数据并返回
 * */
public class EffectCountDto {
    /** 原始数据 */
    private List<CustomerEffectDto> allPrimaryData;
    /**每日总和*/
    private List<DayEffectDto> totalDailSumCon;
    private List<OrgEffDto> orgEffDtos;

    private BigDecimal totalSumAllEffConInc; // 生命周期内总消耗
    private BigDecimal totalSumAllEffConPay; // 生命周期内总消耗
    private BigDecimal tatalSumAllCon; // 查询期限内总消耗
    /**收入总有效消耗求和*/
    private BigDecimal totalSumCon;
    private BigDecimal totalSumPayCon;
    /**总素材数量*/
    private int totalCus;
    /**总收入求和*/
    private BigDecimal totalSumIncome;
    private BigDecimal totalSumPay;
    public EffectCountDto() {
    }
    public EffectCountDto(List<CustomerEffectDto> allPrimaryData, List<DayEffectDto> totalDailSumCon, List<OrgEffDto> orgEffDtos, BigDecimal totalSumAllEffConInc,BigDecimal totalSumAllEffConPay, BigDecimal tatalSumAllCon, BigDecimal totalSumCon, BigDecimal totalSumPayCon, int totalCus, BigDecimal totalSumIncome, BigDecimal totalSumPay) {
        this.allPrimaryData = allPrimaryData;
        this.totalDailSumCon = totalDailSumCon;
        this.orgEffDtos = orgEffDtos;
        this.totalSumAllEffConInc = totalSumAllEffConInc;
        this.totalSumAllEffConPay = totalSumAllEffConPay;
        this.tatalSumAllCon = tatalSumAllCon;
        this.totalSumCon = totalSumCon;
        this.totalSumPayCon = totalSumPayCon;
        this.totalCus = totalCus;
        this.totalSumIncome = totalSumIncome;
        this.totalSumPay = totalSumPay;
    }

    public List<CustomerEffectDto> getAllPrimaryData() {
        return allPrimaryData;
    }

    public void setAllPrimaryData(List<CustomerEffectDto> allPrimaryData) {
        this.allPrimaryData = allPrimaryData;
    }

    public List<DayEffectDto> getTotalDailSumCon() {
        return totalDailSumCon;
    }

    public void setTotalDailSumCon(List<DayEffectDto> totalDailSumCon) {
        this.totalDailSumCon = totalDailSumCon;
    }

    public BigDecimal getTotalSumCon() {
        return totalSumCon;
    }

    public void setTotalSumCon(BigDecimal totalSumCon) {
        this.totalSumCon = totalSumCon;
    }

    public int getTotalCus() {
        return totalCus;
    }

    public void setTotalCus(int totalCus) {
        this.totalCus = totalCus;
    }

    public BigDecimal getTotalSumIncome() {
        return totalSumIncome;
    }

    public void setTotalSumIncome(BigDecimal totalSumIncome) {
        this.totalSumIncome = totalSumIncome;
    }

    public BigDecimal getTotalSumPay() {
        return totalSumPay;
    }

    public void setTotalSumPay(BigDecimal totalSumPay) {
        this.totalSumPay = totalSumPay;
    }

    public BigDecimal getTotalSumPayCon() {
        return totalSumPayCon;
    }

    public void setTotalSumPayCon(BigDecimal totalSumPayCon) {
        this.totalSumPayCon = totalSumPayCon;
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

    public BigDecimal getTatalSumAllCon() {
        return tatalSumAllCon;
    }

    public void setTatalSumAllCon(BigDecimal tatalSumAllCon) {
        this.tatalSumAllCon = tatalSumAllCon;
    }

    public List<OrgEffDto> getOrgEffDtos() {
        return orgEffDtos;
    }

    public void setOrgEffDtos(List<OrgEffDto> orgEffDtos) {
        this.orgEffDtos = orgEffDtos;
    }
}
