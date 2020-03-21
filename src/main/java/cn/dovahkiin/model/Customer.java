package cn.dovahkiin.model;

import cn.dovahkiin.commons.utils.JsonUtils;
import cn.dovahkiin.commons.utils.StringUtils;
import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.activerecord.Model;
import java.io.Serializable;

/**
 * <p>
 * 素材信息
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
public class Customer extends Model<Customer> {
    private static final long serialVersionUID = 2L;
	private static final String codePrex="CUS";
	public synchronized String CreateCode(){
		StringBuffer newCode= new StringBuffer()
				.append(codePrex)
				.append(StringUtils.getDateCode())
				.append(this.hashCode())
				;
		if(this.code==null)this.code=newCode.toString();
		return newCode.toString();
	}
    /**
     * 主键id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 素材名
     */
	private String name;

	private TrueCustomer trueCustomer;
    /**
     * 客户编码
     */
	private String code;
    /**
     * 更新时间
     */
	@TableField("update_time")
	private Date updateTime;
    /**
     * 创建时间
     */
	@TableField("create_time")
	private Date createTime;
    /**
     * 是否删除
     */
	@TableField("delete_flag")
	private Integer deleteFlag;
	/**
	 * 最大有效消耗
	 */
	@TableField("max_effect_con")
	private Double maxEffectCon;
	/**
	 * 收入比率 ， 收入 =  固定价格 + 有效消耗 * 收入比率
	 */
	@TableField("income_ratio")
	private Double inComeRatio;
	@TableField("pay_ratio")
	private Double payRatio;

	private Industry industry;

	private ProductType productType;

	private VideoType videoType;

	private Date completeDate;
	private String completeDateStr;

	private Originality originality;
	private Photographer photographer;

	private Editor editor;

	private Performer performer1;

	private Performer performer2;

	private Performer performer3;

	private Supplier supplier;

	private VideoVersion videoVersion;

	private PriceLevel priceLevel;

	@TableField(exist = false)
	private Double cumulativeConsumptionByPro;
	@TableField(exist = false)
	private Integer cumulativeConsumptionRankingByProglam;

	public Customer() { }

	public Customer(String name, String code, Date createTime, Integer deleteFlag) {
		this.name = name;
		this.code = code;
		this.createTime = createTime;
		this.deleteFlag = deleteFlag;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public TrueCustomer getTrueCustomer() {
		return trueCustomer;
	}

	public void setTrueCustomer(TrueCustomer trueCustomer) {
		this.trueCustomer = trueCustomer;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public Industry getIndustry() {
		return industry;
	}

	public void setIndustry(Industry industry) {
		this.industry = industry;
	}

	public ProductType getProductType() {
		return productType;
	}

	public void setProductType(ProductType productType) {
		this.productType = productType;
	}

	public VideoType getVideoType() {
		return videoType;
	}

	public void setVideoType(VideoType videoType) {
		this.videoType = videoType;
	}

	public Date getCompleteDate() {
		return completeDate;
	}

	public void setCompleteDate(Date completeDate) {
		this.completeDate = completeDate;
	}

	public Photographer getPhotographer() {
		return photographer;
	}

	public void setPhotographer(Photographer photographer) {
		this.photographer = photographer;
	}

	public Editor getEditor() {
		return editor;
	}

	public void setEditor(Editor editor) {
		this.editor = editor;
	}

	public Performer getPerformer1() {
		return performer1;
	}

	public void setPerformer1(Performer performer1) {
		this.performer1 = performer1;
	}

	public Performer getPerformer2() {
		return performer2;
	}

	public void setPerformer2(Performer performer2) {
		this.performer2 = performer2;
	}

	public Performer getPerformer3() {
		return performer3;
	}

	public void setPerformer3(Performer performer3) {
		this.performer3 = performer3;
	}

	public Double getCumulativeConsumptionByPro() {
		return cumulativeConsumptionByPro;
	}

	public void setCumulativeConsumptionByPro(Double cumulativeConsumptionByPro) {
		this.cumulativeConsumptionByPro = cumulativeConsumptionByPro;
	}

	public Integer getCumulativeConsumptionRankingByProglam() {
		return cumulativeConsumptionRankingByProglam;
	}

	public void setCumulativeConsumptionRankingByProglam(Integer cumulativeConsumptionRankingByProglam) {
		this.cumulativeConsumptionRankingByProglam = cumulativeConsumptionRankingByProglam;
	}

	public Originality getOriginality() {
		return originality;
	}

	public void setOriginality(Originality originality) {
		this.originality = originality;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
	/**  注意 */
	public String getCompleteDateStr() {
		if(completeDate!=null){
			return StringUtils.dateToStr2(completeDate);
		}
		return completeDateStr;
	}

	public void setCompleteDateStr(String completeDateStr) {
		this.completeDateStr = completeDateStr;
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public VideoVersion getVideoVersion() {
		return videoVersion;
	}

	public void setVideoVersion(VideoVersion videoVersion) {
		this.videoVersion = videoVersion;
	}

	public Double getMaxEffectCon() {
		return maxEffectCon;
	}

	public void setMaxEffectCon(Double maxEffectCon) {
		this.maxEffectCon = maxEffectCon;
	}

	public Double getInComeRatio() {
		return inComeRatio;
	}

	public void setInComeRatio(Double inComeRatio) {
		this.inComeRatio = inComeRatio;
	}

	public PriceLevel getPriceLevel() {
		return priceLevel;
	}

	public void setPriceLevel(PriceLevel priceLevel) {
		this.priceLevel = priceLevel;
	}

	public Double getPayRatio() {
		return payRatio;
	}

	public void setPayRatio(Double payRatio) {
		this.payRatio = payRatio;
	}
}
