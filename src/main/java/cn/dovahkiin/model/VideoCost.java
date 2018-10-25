package cn.dovahkiin.model;

//import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;
//import com.baomidou.mybatisplus.annotations.TableId;
//import com.baomidou.mybatisplus.annotations.TableField;
//import com.baomidou.mybatisplus.activerecord.Model;
//import com.baomidou.mybatisplus.annotations.TableName;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;

/**
 * <p>
 * 视频成片消耗
 * </p>
 *
 * @author lzt
 * @since 2018-10-15
 */
//@TableName("video_cost")
public class VideoCost  implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
//	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 更新时间
     */
//	@TableField("update_time")
	private Date updateTime;
    /**
     * 创建时间
     */
//	@TableField("create_time")
	private Date createTime;
    /**
     * 是否删除
     */
//	@TableField("delete_flag")
	private Integer deleteFlag;
    /**
     * 数据日期
     */

//	@TableField("recored_date")
	private Date recoredDate;
    /**
     * 业务部
     */
//	@TableField("business_department")
	private String businessDepartment;
    /**
     * 产品类型
     */
//	@TableField("product_type")
	private String productType;
    /**
     * 客户名
     */
//	@TableField("customer_name")
	private String customerName;
    /**
     * 行业
     */
	private String industry;
    /**
     * 需求部门
     */
//	@TableField("demand_sector")
	private String demandSector;
    /**
     * 优化师
     */
	private String optimizer;
    /**
     * 视频类型
     */
//	@TableField("video_type")
	private String videoType;
    /**
     * 成片日期
     */
//	@TableField("complete_date")
	private Date completeDate;
    /**
     * 创意
     */
	private String originality;
    /**
     * 摄像
     */
	private String photographer;
    /**
     * 剪辑
     */
	private String editor;
    /**
     * 演员1
     */
	private String performer1;
    /**
     * 演员2
     */
	private String performer2;
    /**
     * 演员3
     */
	private String performer3;
    /**
     * 当日消耗
     */
	private Double consumption;
    /**
     * 累计消耗
     */
//	@TableField("cumulative_consumption")
	private Double cumulativeConsumption;
    /**
     * 消耗累积排名
     */
//	@TableField("cumulative_consumption_ranking")
	private Integer cumulativeConsumptionRanking;

	public VideoCost() {
	}

	public VideoCost(Date updateTime, Date createTime, Integer deleteFlag, Date recoredDate) {
		this.updateTime = updateTime;
		this.createTime = createTime;
		this.deleteFlag = deleteFlag;
		this.recoredDate = recoredDate;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Integer deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public Date getRecoredDate() {
		return recoredDate;
	}

	public void setRecoredDate(Date recoredDate) {
		this.recoredDate = recoredDate;
	}

	public String getBusinessDepartment() {
		return businessDepartment;
	}

	public void setBusinessDepartment(String businessDepartment) {
		this.businessDepartment = businessDepartment;
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}

	public String getDemandSector() {
		return demandSector;
	}

	public void setDemandSector(String demandSector) {
		this.demandSector = demandSector;
	}

	public String getOptimizer() {
		return optimizer;
	}

	public void setOptimizer(String optimizer) {
		this.optimizer = optimizer;
	}

	public String getVideoType() {
		return videoType;
	}

	public void setVideoType(String videoType) {
		this.videoType = videoType;
	}

	public Date getCompleteDate() {
		return completeDate;
	}

	public void setCompleteDate(Date completeDate) {
		this.completeDate = completeDate;
	}

	public String getOriginality() {
		return originality;
	}

	public void setOriginality(String originality) {
		this.originality = originality;
	}

	public String getPhotographer() {
		return photographer;
	}

	public void setPhotographer(String photographer) {
		this.photographer = photographer;
	}

	public String getEditor() {
		return editor;
	}

	public void setEditor(String editor) {
		this.editor = editor;
	}

	public String getPerformer1() {
		return performer1;
	}

	public void setPerformer1(String performer1) {
		this.performer1 = performer1;
	}

	public String getPerformer2() {
		return performer2;
	}

	public void setPerformer2(String performer2) {
		this.performer2 = performer2;
	}

	public String getPerformer3() {
		return performer3;
	}

	public void setPerformer3(String performer3) {
		this.performer3 = performer3;
	}

	public Double getConsumption() {
		return consumption;
	}

	public void setConsumption(Double consumption) {
		this.consumption = consumption;
	}

	public Double getCumulativeConsumption() {
		return cumulativeConsumption;
	}

	public void setCumulativeConsumption(Double cumulativeConsumption) {
		this.cumulativeConsumption = cumulativeConsumption;
	}

	public Integer getCumulativeConsumptionRanking() {
		return cumulativeConsumptionRanking;
	}

	public void setCumulativeConsumptionRanking(Integer cumulativeConsumptionRanking) {
		this.cumulativeConsumptionRanking = cumulativeConsumptionRanking;
	}

//	@Override
//	protected Serializable pkVal() {
//		return this.id;
//	}

	@Override
	public String toString() {
		return "VideoCost{" +
				"id=" + id +
				", updateTime=" + updateTime +
				", createTime=" + createTime +
				", deleteFlag=" + deleteFlag +
				", recoredDate=" + recoredDate +
				", businessDepartment='" + businessDepartment + '\'' +
				", productType='" + productType + '\'' +
				", customerName='" + customerName + '\'' +
				", industry='" + industry + '\'' +
				", demandSector='" + demandSector + '\'' +
				", optimizer='" + optimizer + '\'' +
				", videoType='" + videoType + '\'' +
				", completeDate=" + completeDate +
				", originality='" + originality + '\'' +
				", photographer='" + photographer + '\'' +
				", editor='" + editor + '\'' +
				", performer1='" + performer1 + '\'' +
				", performer2='" + performer2 + '\'' +
				", performer3='" + performer3 + '\'' +
				", consumption='" + consumption + '\'' +
				", cumulativeConsumption='" + cumulativeConsumption + '\'' +
				", cumulativeConsumptionRanking='" + cumulativeConsumptionRanking + '\'' +
				'}';
	}
}
