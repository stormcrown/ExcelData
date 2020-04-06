package cn.dovahkiin.model.dto;

import java.util.List;
/**通过整理数据取得所有的数据并返回
 * */
public class EffectCountDto {
    /** 原始数据 */
    private List<CustomerEffectDto> allPrimaryData;
    /**每日总和*/
    private List<DayEffectDto> totalDailSumCon;
    private Double totalSumAllEffConInc; // 生命周期内总消耗
    private Double totalSumAllEffConPay; // 生命周期内总消耗
    private Double tatalSumAllCon; // 查询期限内总消耗
    /**收入总有效消耗求和*/
    private Double totalSumCon;
    private Double totalSumPayCon;
    /**总素材数量*/
    private int totalCus;
    /**总收入求和*/
    private Double totalSumIncome;
    private Double totalSumPay;
    public EffectCountDto() {
    }
    public EffectCountDto(List<CustomerEffectDto> allPrimaryData, List<DayEffectDto> totalDailSumCon, Double totalSumAllEffConInc,Double totalSumAllEffConPay, Double tatalSumAllCon, Double totalSumCon, Double totalSumPayCon, int totalCus, Double totalSumIncome, Double totalSumPay) {
        this.allPrimaryData = allPrimaryData;
        this.totalDailSumCon = totalDailSumCon;
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

    public Double getTotalSumCon() {
        return totalSumCon;
    }

    public void setTotalSumCon(Double totalSumCon) {
        this.totalSumCon = totalSumCon;
    }

    public int getTotalCus() {
        return totalCus;
    }

    public void setTotalCus(int totalCus) {
        this.totalCus = totalCus;
    }

    public Double getTotalSumIncome() {
        return totalSumIncome;
    }

    public void setTotalSumIncome(Double totalSumIncome) {
        this.totalSumIncome = totalSumIncome;
    }

    public Double getTotalSumPay() {
        return totalSumPay;
    }

    public void setTotalSumPay(Double totalSumPay) {
        this.totalSumPay = totalSumPay;
    }

    public Double getTotalSumPayCon() {
        return totalSumPayCon;
    }

    public void setTotalSumPayCon(Double totalSumPayCon) {
        this.totalSumPayCon = totalSumPayCon;
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

    public Double getTatalSumAllCon() {
        return tatalSumAllCon;
    }

    public void setTatalSumAllCon(Double tatalSumAllCon) {
        this.tatalSumAllCon = tatalSumAllCon;
    }
}
