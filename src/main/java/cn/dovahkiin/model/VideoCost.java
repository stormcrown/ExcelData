package cn.dovahkiin.model;

//import com.baomidou.mybatisplus.enums.IdType;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
//import com.baomidou.mybatisplus.annotations.TableId;
//import com.baomidou.mybatisplus.annotations.TableField;
//import com.baomidou.mybatisplus.activerecord.Model;
//import com.baomidou.mybatisplus.annotations.TableName;
import cn.dovahkiin.commons.utils.JsonUtils;
import cn.dovahkiin.commons.utils.StringUtils;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 * 视频成片消耗
 * </p>
 *
 * @author lzt
 * @since 2018-10-15
 */
@TableName("video_cost")
public class VideoCost  extends Model<VideoCost> {

    private static final long serialVersionUID = 2L;
	@Override
	protected Serializable pkVal() {
		return this.id;
	}


    /**
     * 主键id
     */
//	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 更新时间
     */
	@TableField("update_time")
	private Date updateTime;
	@TableField("updated_by")
	private Long updatedBy;
    /**
     * 创建时间
     */
	@TableField("create_time")
	private Date createTime;
	@TableField("created_by")
	private Long createdBy;
    /**
     * 是否删除
     */
	@TableField("delete_flag")
	private Integer deleteFlag;
    /**
     * 消耗日期
     */

	@TableField("recored_date")
	private Date recoredDate;

	private String recoredDateStr;
    /**
     * 业务部
     */
	private Organization businessDepartment;
    /**
     * 产品类型
     */

//	private ProductType productType;
    /**
     * 客户名
     */
	private Customer customer;
    /**
     * 行业
     */
//	private Industry industry;
    /**
     * 需求部门
     */
	private Organization demandSector;
    /**
     * 优化师
     */
	private Optimizer optimizer;

    /**
     * 当日消耗
     */
	private BigDecimal consumption;
    /**
     * 累计消耗
     */
//	@TableField("cumulative_consumption")
	private BigDecimal cumulativeConsumption;
    /**
     * 消耗累积排名
     */
//	@TableField("cumulative_consumption_ranking")
	private Integer cumulativeConsumptionRanking;

	@TableField(exist = false)
	private BigDecimal cumulativeConsumptionByPro;
	@TableField(exist = false)
	private Integer cumulativeConsumptionRankingByProglam;


	public Integer getCumulativeConsumptionRankingByProglam() {
		return cumulativeConsumptionRankingByProglam;
	}

	public Long getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(Long updatedBy) {
		this.updatedBy = updatedBy;
	}

	public Long getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Long createdBy) {
		this.createdBy = createdBy;
	}


	public void setCumulativeConsumptionRankingByProglam(Integer cumulativeConsumptionRankingByProglam) {
		this.cumulativeConsumptionRankingByProglam = cumulativeConsumptionRankingByProglam;
	}

	public VideoCost() {
	}

	public VideoCost(Long updatedBy, Date updateTime,Long createdBy ,Date createTime, Integer deleteFlag, Date recoredDate) {
		this.updatedBy = updatedBy;
		this.createdBy = createdBy;
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

	public Organization getBusinessDepartment() {
		return businessDepartment;
	}

	public void setBusinessDepartment(Organization businessDepartment) {
		this.businessDepartment = businessDepartment;
	}

//	public ProductType getProductType() {
//		return productType;
//	}
//
//	public void setProductType(ProductType productType) {
//		this.productType = productType;
//	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
//
//	public Industry getIndustry() {
//		return industry;
//	}
//
//	public void setIndustry(Industry industry) {
//		this.industry = industry;
//	}

	public Organization getDemandSector() {
		return demandSector;
	}

	public void setDemandSector(Organization demandSector) {
		this.demandSector = demandSector;
	}

	public Optimizer getOptimizer() {
		return optimizer;
	}

	public void setOptimizer(Optimizer optimizer) {
		this.optimizer = optimizer;
	}



	public Integer getCumulativeConsumptionRanking() {
		return cumulativeConsumptionRanking;
	}

	public String getRecoredDateStr() {
		if(recoredDate!=null){
			return StringUtils.dateToStr2(recoredDate);
		}
		return recoredDateStr;
	}

	public void setRecoredDateStr(String recoredDateStr) {
		this.recoredDateStr = recoredDateStr;
	}

	public void setCumulativeConsumptionRanking(Integer cumulativeConsumptionRanking) {
		this.cumulativeConsumptionRanking = cumulativeConsumptionRanking;
	}

	public BigDecimal getConsumption() {
		return consumption;
	}

	public void setConsumption(BigDecimal consumption) {
		this.consumption = consumption;
	}

	public BigDecimal getCumulativeConsumption() {
		return cumulativeConsumption;
	}

	public void setCumulativeConsumption(BigDecimal cumulativeConsumption) {
		this.cumulativeConsumption = cumulativeConsumption;
	}

	public BigDecimal getCumulativeConsumptionByPro() {
		return cumulativeConsumptionByPro;
	}

	public void setCumulativeConsumptionByPro(BigDecimal cumulativeConsumptionByPro) {
		this.cumulativeConsumptionByPro = cumulativeConsumptionByPro;
	}

	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}

}
