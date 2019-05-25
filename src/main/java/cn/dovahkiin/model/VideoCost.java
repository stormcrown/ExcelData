package cn.dovahkiin.model;

//import com.baomidou.mybatisplus.enums.IdType;
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
//@TableName("video_cost")
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
     * 视频类型
     */
//	private VideoType videoType;
    /**
     * 成片日期
     */
//	@TableField("complete_date")
//	private Date completeDate;
//	private String completeDateStr;
    /**
     * 创意
     */
//	private Originality originality;
    /**
     * 摄像
     */
//	private Photographer photographer;
    /**
     * 剪辑
     */
//	private Editor editor;
    /**
     * 演员1
     */
//    private Performer performer1;
//	private Performer performer2;
//	private Performer performer3;

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

	@TableField(exist = false)
	private Double cumulativeConsumptionByPro;
	@TableField(exist = false)
	private Integer cumulativeConsumptionRankingByProglam;

	public Double getCumulativeConsumptionByPro() {
		return cumulativeConsumptionByPro;
	}

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

	public void setCumulativeConsumptionByPro(Double cumulativeConsumptionByPro) {
		this.cumulativeConsumptionByPro = cumulativeConsumptionByPro;
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

//	public VideoType getVideoType() {
//		return videoType;
//	}
//
//	public void setVideoType(VideoType videoType) {
//		this.videoType = videoType;
//	}
//
//	public Date getCompleteDate() {
//		return completeDate;
//	}
//
//	public void setCompleteDate(Date completeDate) {
//		this.completeDate = completeDate;
//	}
//
//	public Originality getOriginality() {
//		return originality;
//	}
//
//	public void setOriginality(Originality originality) {
//		this.originality = originality;
//	}
//
//	public Photographer getPhotographer() {
//		return photographer;
//	}
//
//	public void setPhotographer(Photographer photographer) {
//		this.photographer = photographer;
//	}
//
//	public Editor getEditor() {
//		return editor;
//	}
//
//	public void setEditor(Editor editor) {
//		this.editor = editor;
//	}
//
//	public Performer getPerformer1() {
//		return performer1;
//	}
//
//	public void setPerformer1(Performer performer1) {
//		this.performer1 = performer1;
//	}
//
//	public Performer getPerformer2() {
//		return performer2;
//	}
//
//	public void setPerformer2(Performer performer2) {
//		this.performer2 = performer2;
//	}
//
//	public Performer getPerformer3() {
//		return performer3;
//	}
//
//	public void setPerformer3(Performer performer3) {
//		this.performer3 = performer3;
//	}

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

//	public String getCompleteDateStr() {
//		if(completeDate!=null){
//			return StringUtils.dateToStr2(completeDate);
//		}
//		return completeDateStr;
//	}

//	public void setCompleteDateStr(String completeDateStr) {
//		this.completeDateStr = completeDateStr;
//	}

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
	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}

}
