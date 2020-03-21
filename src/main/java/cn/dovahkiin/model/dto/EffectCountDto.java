package cn.dovahkiin.model.dto;

import java.util.List;
/**通过整理数据取得所有的数据并返回
 * */
public class EffectCountDto {
    /** 原始数据 */
    private List<CustomerEffectDto> allPrimaryData;
    /**每日总和*/
    private List<DayEffectDto> totalDailSumCon;
    /**总有效消耗求和*/
    private Double totalSumCon;
    /**总素材数量*/
    private int totalCus;
    /**总收入求和*/
    private Double totalSumIncome;
    private Double totalSumPay;


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
}
