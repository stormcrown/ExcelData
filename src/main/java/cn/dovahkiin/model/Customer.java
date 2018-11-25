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
 * 客户信息
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
public class Customer extends Model<Customer> {
    private static final long serialVersionUID = 2L;
	private static final String codePrex="CUS";
	public   String CreateCode(){
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
     * 客户名
     */
	private String name;
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

	private Industry industry;

	private ProductType productType;

	private VideoType videoType;

	private Date completeDate;
	private Originality originality;
	private Photographer photographer;

	private Editor editor;

	private Performer performer1;

	private Performer performer2;

	private Performer performer3;


	@TableField(exist = false)
	private Double cumulativeConsumptionByPro;
	@TableField(exist = false)
	private Integer cumulativeConsumptionRankingByProglam;

	public Customer() {
	}

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

}
